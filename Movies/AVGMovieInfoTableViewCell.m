//
//  AVGMovieInfoTableViewCell.m
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieInfoTableViewCell.h"
#import "AVGMovieInfoView.h"


@interface AVGMovieInfoTableViewCell ()

@property (nonatomic, weak) AVGMovieInfoView *movieInfoView;

@end

@implementation AVGMovieInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    AVGMovieInfoView *movieInfoView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AVGMovieInfoView class]) owner:nil options:nil].firstObject;
    
    self.movieInfoView = movieInfoView;
    
    [self.contentView addSubview:movieInfoView];
    
    movieInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(movieInfoView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[movieInfoView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[movieInfoView]|" options:0 metrics:nil views:views]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.movieInfoView prepareForReuse];
}

- (void)configureWithMovie:(AVGMovie *)movie {
    [self.movieInfoView configureWithMovie:movie];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.movieInfoView.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.movieInfoView.backgroundColor = [UIColor whiteColor];
    }
}

@end
