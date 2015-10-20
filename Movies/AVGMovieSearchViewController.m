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

static NSString * const kCellIdentifier = @"Cell";
static CGFloat const kCellHeight = 190.0;

@interface AVGMovieSearchViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSArray *movies;

@end

@implementation AVGMovieSearchViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[AVGMovieCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionView.collectionViewLayout invalidateLayout];
    } completion:nil];
}

#pragma mark - Helper Methods

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
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    [self updateSearchResultsForSearchTerm:searchBar.text];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
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
        }];
        
    }
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
