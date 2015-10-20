//
//  AVGMovieInfoView.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieInfoView.h"
#import "UIImageView+AVGImageLoading.h"

@interface AVGMovieInfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;

@end

@implementation AVGMovieInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.imageView.layer.cornerRadius = floorf(CGRectGetWidth(self.imageView.frame) / 2);
    self.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageView.layer.borderWidth = 0.5;
    
    self.favoriteImageView.tintColor = self.tintColor;
    self.favoriteImageView.image = [[UIImage imageNamed:@"like_tab_icon_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)prepareForReuse {
    self.imageView.image = nil;
}

- (void)configureWithMovie:(AVGMovie *)movie {
    self.nameLabel.text = movie.trackName;
    self.descriptionLabel.text = movie.longDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    self.directorLabel.text = [NSString stringWithFormat:@"%@, %@", movie.artistName, [formatter stringFromDate:movie.releaseDate]];
    
    NSURL *imageUrl = [NSURL URLWithString:movie.artworkUrl];
    [self.imageView setImageWithUrl:imageUrl];
    
    self.favoriteImageView.hidden = !movie.favorite.boolValue;
}

@end
