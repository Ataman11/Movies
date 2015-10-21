//
//  AVGMoviePlayerTableViewCell.h
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVGMoviePlayerTableViewCell;

@protocol AVGMoviePlayerTableViewCellDelegate <NSObject>

@optional

- (void)moviePlayerTableViewCellDidFailToPlayMovie:(AVGMoviePlayerTableViewCell *)cell;

@end


@interface AVGMoviePlayerTableViewCell : UITableViewCell

@property (nonatomic, weak) id<AVGMoviePlayerTableViewCellDelegate>delegate;

- (void)configureWithUrl:(NSURL *)movieUrl;
- (void)configureWithPreviewImageUrl:(NSURL *)previewImageUrl;

@end
