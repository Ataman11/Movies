//
//  AVGMovieCollectionViewCell.h
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVGMovie.h"

@interface AVGMovieCollectionViewCell : UICollectionViewCell

- (void)configureWithMovie:(AVGMovie *)movie;

@end
