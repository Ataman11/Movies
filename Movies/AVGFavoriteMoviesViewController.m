//
//  AVGFavoriteMoviesViewController.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGFavoriteMoviesViewController.h"
#import "AVGMovieCollectionViewCell.h"
#import "AVGMoviesDataController.h"
#import "AVGMovieDetailViewController.h"
#import "AVGEmptyStateView.h"

static NSString * const kCellIdentifier = @"Cell";
static CGFloat const kCellHeight = 190.0;

@interface AVGFavoriteMoviesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableSet *changedIndexPaths;
@property (nonatomic, weak) AVGEmptyStateView *emptyStateView;
@property (nonatomic, strong) NSBlockOperation *blockOperation;
@property (nonatomic, assign) BOOL shouldReloadCollectionView;
@end

@implementation AVGFavoriteMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.changedIndexPaths = [NSMutableSet set];
    self.shouldReloadCollectionView = NO;
    [self.collectionView registerClass:[AVGMovieCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];

    [self setupFetchResultsController];
    
    self.title = NSLocalizedString(@"Favorites", @"Favorites view title");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     id<NSFetchedResultsSectionInfo>sectionInfo = self.fetchedResultsController.sections[0];
    if (sectionInfo.numberOfObjects == 0) {
        [self showEmptyStateView];
    } else {
        [self closeEmptyStateView];
    }
}

#pragma mark - Helper Methods

- (void)showEmptyStateView {
    if (self.emptyStateView) {
        [self closeEmptyStateView];
    }
    
    AVGEmptyStateView *emptyStateView = [AVGEmptyStateView viewWithTitle:NSLocalizedString(@"No Favorites Yet", @"Empty state view title") message:NSLocalizedString(@"To add favorites go to search\nand find movies you like.", @"Empty state view message")];
    [emptyStateView showInView:self.view];
    self.emptyStateView = emptyStateView;
}

- (void)closeEmptyStateView {
    [self.emptyStateView close];
    self.emptyStateView = nil;
}

- (void)setupFetchResultsController {
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[AVGMovie entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"favorite = %@", @(YES)];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"trackName" ascending:YES]];

    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AVGMoviesDataController sharedInstance].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    
    if (self.fetchedResultsController.sections.count > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
        rowCount = sectionInfo.numberOfObjects;
    }
    
    return rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AVGMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    AVGMovie *movie = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureWithMovie:movie];
    
    [cell.contentView setNeedsLayout];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    AVGMovie *movie = [self.fetchedResultsController objectAtIndexPath:indexPath];
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

#pragma mark - NSFetchedResultsControllerDelegate

//taken from https://gist.github.com/iwasrobbed/5528897

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    self.shouldReloadCollectionView = NO;
    self.blockOperation = [[NSBlockOperation alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    __weak UICollectionView *collectionView = self.collectionView;
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    __weak UICollectionView *collectionView = self.collectionView;
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            if ([self.collectionView numberOfSections] > 0) {
                if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                    self.shouldReloadCollectionView = YES;
                } else {
                    [self.blockOperation addExecutionBlock:^{
                        [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
                    }];
                }
            } else {
                self.shouldReloadCollectionView = YES;
            }
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                self.shouldReloadCollectionView = YES;
            } else {
                [self.blockOperation addExecutionBlock:^{
                    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                }];
            }
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
    if (self.shouldReloadCollectionView) {
        [self.collectionView reloadData];
    } else {
        [self.collectionView performBatchUpdates:^{
            [self.blockOperation start];
        } completion:nil];
    }
}

@end
