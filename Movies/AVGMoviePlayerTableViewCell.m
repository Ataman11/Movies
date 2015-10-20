//
//  AVGMoviePlayerTableViewCell.m
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMoviePlayerTableViewCell.h"
@import MediaPlayer;
#import "UIImageView+AVGImageLoading.h"

@interface AVGMoviePlayerTableViewCell ()

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

@end

@implementation AVGMoviePlayerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.playImageView.tintColor = self.tintColor;
    self.playImageView.image = [[UIImage imageNamed:@"play_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.contentView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.contentView.layer.borderWidth = 0.5;
    //self.playImageView.layer.cornerRadius = floorf(CGRectGetWidth(self.playImageView.frame) / 2);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerReadyForDisplayDidChangeNotification object:self.moviePlayer];
    
    self.previewImageView.image = nil;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.contentView.alpha = highlighted ? 0.5 : 1.0;
}

- (void)configureWithPreviewImageUrl:(NSURL *)previewImageUrl {
    [self.previewImageView setImageWithUrl:previewImageUrl];
}

- (void)configureWithUrl:(NSURL *)movieUrl {
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerReadyForDisplayDidChangeNotification object:self.moviePlayer];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieUrl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieReadyForDisplayChanged:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:self.moviePlayer];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    //self.moviePlayer.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.moviePlayer.view.hidden = YES;
    [self.contentView addSubview:self.moviePlayer.view];
    [self.contentView bringSubviewToFront:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:NO];
    
    self.moviePlayer.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{ @"moviePlayerView" : self.moviePlayer.view };
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[moviePlayerView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[moviePlayerView]|" options:0 metrics:nil views:views]];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    if (notification.userInfo[@"error"] && [self.delegate respondsToSelector:@selector(moviePlayerTableViewCellDidFailToPlayMovie:)]) {
        [self.delegate moviePlayerTableViewCellDidFailToPlayMovie:self];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.moviePlayer.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.moviePlayer.view.hidden = YES;
    }];
}

- (void)movieReadyForDisplayChanged:(NSNotification *)notification {
    if (self.moviePlayer.readyForDisplay) {
        self.moviePlayer.view.alpha = 0.0;
        self.moviePlayer.view.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.moviePlayer.view.alpha = 1.0;
        }];
    }
}

@end
