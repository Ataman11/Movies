//
//  AVGEmptyStateView.h
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVGEmptyStateView : UIView

+ (instancetype)viewWithTitle:(NSString *)title message:(NSString *)message;
- (void)showInView:(UIView *)view;
- (void)close;

@end
