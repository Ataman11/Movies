//
//  AVGMovieDetailViewController.m
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieDetailViewController.h"

@interface AVGMovieDetailViewController ()

@property (nonatomic, strong) AVGMovie *movie;

@end

@implementation AVGMovieDetailViewController

+ (instancetype)newDetailViewControllerWithMovie:(AVGMovie *)movie {
    AVGMovieDetailViewController *detailViewController = [[AVGMovieDetailViewController alloc] initWithNibName:NSStringFromClass([AVGMovieDetailViewController class]) bundle:nil];
    detailViewController.movie = movie;
    
    return detailViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
