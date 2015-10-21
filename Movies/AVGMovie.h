//
//  AVGMovie.h
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface AVGMovie : NSManagedObject

@property (nonatomic, retain) NSNumber *trackId;
@property (nonatomic, retain) NSString *artistName;
@property (nonatomic, retain) NSString *trackName;
@property (nonatomic, retain) NSString *longDescription;
@property (nonatomic, retain) NSString *artworkUrl;
@property (nonatomic, retain) NSDate *releaseDate;
@property (nonatomic, retain) NSString *previewUrl;
@property (nonatomic, retain) NSNumber *favorite;

+ (NSString *)entityName;
+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc;

@end
