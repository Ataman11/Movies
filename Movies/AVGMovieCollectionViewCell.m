//
//  AVGMovieCollectionViewCell.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieCollectionViewCell.h"
#import "AVGMovieInfoView.h"

static CGFloat const kCornerRadius = 3.0;

@interface AVGMovieCollectionViewCell ()

@property (nonatomic, weak) AVGMovieInfoView *movieInfoView;

@end

@implementation AVGMovieCollectionViewCell

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
    self.contentView.backgroundColor = [UIColor redColor];
    
    movieInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(movieInfoView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[movieInfoView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[movieInfoView]|" options:0 metrics:nil views:views]];
    
    self.contentView.layer.cornerRadius = kCornerRadius;
    self.contentView.clipsToBounds = YES;
}

- (void)prepareForReuse {
    [self.movieInfoView prepareForReuse];
}

- (void)configureWithMovie:(AVGMovie *)movie {
    [self.movieInfoView configureWithMovie:movie];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.movieInfoView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    } else {
        self.movieInfoView.backgroundColor = [UIColor whiteColor];
    }
}

@end
