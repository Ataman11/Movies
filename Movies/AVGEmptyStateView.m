//
//  AVGEmptyStateView.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGEmptyStateView.h"

@interface AVGEmptyStateView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation AVGEmptyStateView

+ (instancetype)newInstance {
    AVGEmptyStateView *emptyStateView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AVGEmptyStateView class]) owner:nil options:nil] firstObject];
    return emptyStateView;
}

+ (instancetype)viewWithTitle:(NSString *)title message:(NSString *)message {
    AVGEmptyStateView *emptyStateView = [AVGEmptyStateView newInstance];
    
    emptyStateView.titleLabel.text = title;
    emptyStateView.messageLabel.text = message;

    return emptyStateView;
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [self addLayoutConstraintsInView:view];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:nil];
}

- (void)addLayoutConstraintsInView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{ @"view" : view,
                             @"emptyStateView" : self };
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[emptyStateView]|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[emptyStateView]|" options:0 metrics:nil views:views]];
}

- (void)close {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
