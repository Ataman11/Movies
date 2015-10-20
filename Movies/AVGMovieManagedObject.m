//
//  AVGMovieManagedObject.m
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMovieManagedObject.h"

@interface AVGMovieManagedObject ()



@end

@implementation AVGMovieManagedObject

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

+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc; {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:moc];
}

- (void)updateWithMovie:(AVGMovie *)movie {
    self.trackId = movie.trackId;
    self.trackName = movie.trackName;
    self.artistName = movie.artistName;
    self.releaseDate = movie.releaseDate;
    self.longDescription = movie.longDescription;
    self.artworkUrl = movie.artworkUrl;
    self.previewUrl = movie.previewUrl;
    self.favorite = movie.favorite;
}

- (AVGMovie *)movie {
    AVGMovie *movie = [[AVGMovie alloc] init];
    movie.trackId = self.trackId;
    movie.trackName = self.trackName;
    movie.artistName = self.artistName;
    movie.releaseDate = self.releaseDate;
    movie.longDescription = self.longDescription;
    movie.artworkUrl = self.artworkUrl;
    movie.previewUrl = self.previewUrl;
    movie.favorite = self.favorite;
    
    return movie;
}

@end
