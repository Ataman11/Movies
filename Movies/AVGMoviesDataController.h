//
//  AVGMoviesDataController.h
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVGMovie.h"
@import CoreData;

@interface AVGMoviesDataController : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedInstance;
- (AVGMovie *)movieWithTrackId:(NSNumber *)trackId;

@end
