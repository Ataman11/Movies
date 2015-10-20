//
//  AVGMovieInfoTableViewCell.h
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVGMovie.h"

@interface AVGMovieInfoTableViewCell : UITableViewCell

- (void)configureWithMovie:(AVGMovie *)movie;

@end
