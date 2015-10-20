//
//  AVGMovie.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovie.h"

@implementation AVGMovie

@dynamic trackId;
@dynamic artistName;
@dynamic trackName;
@dynamic longDescription;
@dynamic artworkUrl;
@dynamic releaseDate;
@dynamic previewUrl;
@dynamic favorite;

+ (NSString *)entityName {
    return @"Movie";
}

+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:moc];
}

@end
