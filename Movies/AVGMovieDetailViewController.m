//
//  AVGMovieDetailViewController.m
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieDetailViewController.h"
#import "AVGMovieInfoTableViewCell.h"
#import "AVGMoviePlayerTableViewCell.h"

typedef NS_ENUM(NSUInteger, AVGMovieDetailRowType) {
    AVGMovieDetailRowTypeInfo,
    AVGMovieDetailRowTypePlayer,
    AVGMovieDetailRowTypeCount
};

static NSString * const kInfoCellReuseIdentifier = @"InfoCell";
static NSString * const kPlayerCellReuseIdentifier = @"PlayerCell";

@interface AVGMovieDetailViewController () <UITableViewDelegate, UITableViewDataSource, AVGMoviePlayerTableViewCellDelegate>

@property (nonatomic, strong) AVGMovie *movie;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AVGMovieDetailViewController

#pragma mark - View Lifecycle

+ (instancetype)newDetailViewControllerWithMovie:(AVGMovie *)movie {
    AVGMovieDetailViewController *detailViewController = [[AVGMovieDetailViewController alloc] initWithNibName:NSStringFromClass([AVGMovieDetailViewController class]) bundle:nil];
    detailViewController.movie = movie;
    
    return detailViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setuptableView];
    [self updateFavoriteButton];
    self.title = @"Movie Detail";
}

- (void)setuptableView {
    [self.tableView registerClass:[AVGMovieInfoTableViewCell class] forCellReuseIdentifier:kInfoCellReuseIdentifier];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([AVGMoviePlayerTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kPlayerCellReuseIdentifier];
    self.tableView.tableFooterView = [UIView new];
}

- (void)updateFavoriteButton {
    UIImage *image = self.movie.isFavorite ? [UIImage imageNamed:@"like_tab_icon_filled"] : [UIImage imageNamed:@"like_tab_icon"];
    UIBarButtonItem *favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(favoriteButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = favoriteButtonItem;
}

#pragma makr - Helper Methods

- (void)favoriteButtonTapped:(id)sender {
    self.movie.favorite = !self.movie.isFavorite;
    //TODO: update core data
    
    [self updateFavoriteButton];
    
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self rowHeightForIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self rowHeightForIndexPath:indexPath];
}

- (CGFloat)rowHeightForIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    
    switch (indexPath.row) {
        case AVGMovieDetailRowTypeInfo:
            height = UITableViewAutomaticDimension;
            break;
        case AVGMovieDetailRowTypePlayer:
            height = 180.0;
            break;
        default:
            break;
    }
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return AVGMovieDetailRowTypeCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case AVGMovieDetailRowTypeInfo: {
            AVGMovieInfoTableViewCell *infoCell = [self.tableView dequeueReusableCellWithIdentifier:kInfoCellReuseIdentifier forIndexPath:indexPath];
            [infoCell configureWithMovie:self.movie];
            infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = infoCell;
        } break;
        case AVGMovieDetailRowTypePlayer: {
            AVGMoviePlayerTableViewCell *playerCell = [self.tableView dequeueReusableCellWithIdentifier:kPlayerCellReuseIdentifier forIndexPath:indexPath];
            playerCell.delegate = self;
            NSURL *imageUrl = [NSURL URLWithString:self.movie.artworkUrl];
            [playerCell configureWithPreviewImageUrl:imageUrl];
            cell = playerCell;
        } break;
        default:
            break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case AVGMovieDetailRowTypePlayer: {
            NSURL *movieUrl = [NSURL URLWithString:self.movie.previewUrl];
            AVGMoviePlayerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell configureWithUrl:movieUrl];
        } break;
            
        default:
            break;
    }
}

#pragma mark - AVGMoviePlayerTableViewCellDelegate

- (void)moviePlayerTableViewCellDidFailToPlayMovie:(AVGMoviePlayerTableViewCell *)cell {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oh no" message:@"This movie preview cannot be played." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
