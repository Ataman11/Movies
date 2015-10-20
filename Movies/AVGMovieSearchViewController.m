//
//  AVGMovieSearchViewController.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieSearchViewController.h"
#import "AVGItunesAPI.h"
#import "AVGMovieCollectionViewCell.h"
#import "AVGMovie.h"
#import "AVGEmptyStateView.h"
#import "AVGMovieDetailViewController.h"

static NSString * const kCellIdentifier = @"Cell";
static CGFloat const kCellHeight = 190.0;

@interface AVGMovieSearchViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSArray *movies;
@property (nonatomic, weak) AVGEmptyStateView *emptyStateView;

@end

@implementation AVGMovieSearchViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[AVGMovieCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self setupSearchBar];
    [self showInitialView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionView.collectionViewLayout invalidateLayout];
    } completion:nil];
}

#pragma mark - Helper Methods

- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44.0)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.placeholder = NSLocalizedString(@"Search", @"Search bar placeholder text");
    searchBar.delegate = self;
    
    self.navigationItem.titleView = searchBar;
    
    self.searchBar = searchBar;
}

- (void)scrolToTop {
    if (self.movies.firstObject) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    self.movies = nil;
    [self.collectionView reloadData];
    [self showInitialView];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    [self updateSearchResultsForSearchTerm:searchBar.text];
}

- (void)updateSearchResultsForSearchTerm:(NSString *)searchTerm {
    if (searchTerm.length > 0) {
        [self.activityIndicator startAnimating];
        self.view.userInteractionEnabled = NO;
        [AVGItunesAPI getMoviesForSearchTerm:searchTerm completion:^(NSArray *movies, NSError *error) {
            self.movies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.view.userInteractionEnabled = YES;
                [self.collectionView reloadData];
                [self scrolToTop];
            });
            
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showGenericErrorAlert];
                });
            } else if (!movies.firstObject || !movies) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showNoResultsView];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self closeEmptyStateView];
                });
            }
        }];
    }
}

- (void)showInitialView {
    if (self.emptyStateView) {
        [self closeEmptyStateView];
    }
    
    AVGEmptyStateView *emptyStateView = [AVGEmptyStateView viewWithTitle:NSLocalizedString(@"Make a Search", @"Search view empty state title") message:NSLocalizedString(@"Please enter a search term above\nto search for a movie.", @"Search view empty state message")];
    [emptyStateView showInView:self.view];
    self.emptyStateView = emptyStateView;
}

- (void)showNoResultsView {
    if (self.emptyStateView) {
        [self closeEmptyStateView];
    }
    
    AVGEmptyStateView *emptyStateView = [AVGEmptyStateView viewWithTitle:NSLocalizedString(@"No Results", @"Search view no results view title") message:NSLocalizedString(@"Search returned no results.\nPlease try different search.", @"Search view no results view message")];
    [emptyStateView showInView:self.view];
    self.emptyStateView = emptyStateView;
}

- (void)closeEmptyStateView {
    [self.emptyStateView close];
    self.emptyStateView = nil;
}

- (void)showGenericErrorAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Oops", @"Search view error alert title") message:NSLocalizedString(@"Something went wrong. Please try again later.", @"Search view error alert message") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"Search view error alert button title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AVGMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    AVGMovie *movie = self.movies[indexPath.row];
    [cell configureWithMovie:movie];
    
    [cell.contentView setNeedsLayout];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    AVGMovie *movie = self.movies[indexPath.row];
    AVGMovieDetailViewController *detailViewController = [AVGMovieDetailViewController newDetailViewControllerWithMovie:movie];
    [self.navigationController showViewController:detailViewController sender:self.navigationController];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size;
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        size = CGSizeMake(CGRectGetWidth(self.collectionView.frame) - 20, kCellHeight);
    } else {
        size = CGSizeMake(floorf(CGRectGetWidth(self.collectionView.frame) / 2) - 15, kCellHeight);
    }
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

@end
