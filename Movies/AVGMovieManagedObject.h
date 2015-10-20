//
//  AVGMovieManagedObject.h
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AVGMovie.h"

@interface AVGMovieManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber *trackId;
@property (nonatomic, retain) NSString *artistName;
@property (nonatomic, retain) NSString *trackName;
@property (nonatomic, retain) NSString *longDescription;
@property (nonatomic, retain) NSString *artworkUrl;
@property (nonatomic, retain) NSDate *releaseDate;
@property (nonatomic, retain) NSString *previewUrl;
@property (nonatomic, retain) NSNumber *favorite;

- (void)updateWithMovie:(AVGMovie *)movie;
- (AVGMovie *)movie;

@end
