//
//  AVGItunesAPIResponseParser.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGItunesAPIResponseParser.h"
#import "NSObject+AVGTypeChecking.h"
#import "AVGMoviesDataController.h"

@implementation AVGItunesAPIResponseParser

#pragma mark - Public Methods

+ (NSArray *)moviesFromResponses:(NSArray *)responses {
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *moviewDictionary in responses) {
        AVGMovie *movie = [AVGItunesAPIResponseParser movieFromResponse:moviewDictionary];
        if (movie) {
            [movies addObject:movie];
        }
    }
    
    [[AVGMoviesDataController sharedInstance].managedObjectContext save:nil];
    
    return [movies copy];
}

+ (AVGMovie *)movieFromResponse:(NSDictionary *)response {
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSNumber *trackId;
    if ([response[@"trackId"] avg_isNumber]) {
        trackId = response[@"trackId"];
    }
    
    AVGMovie *movie = [[AVGMoviesDataController sharedInstance] movieWithTrackId:trackId];
    
    if (!movie) {
        movie = [AVGMovie insertNewObjectInManagedObjectContext:[AVGMoviesDataController sharedInstance].managedObjectContext];
    }
    
    if ([response[@"trackId"] avg_isNumber]) {
        movie.trackId = response[@"trackId"];
    }
    
    if ([response[@"artistName"] avg_isNonEmptyString]) {
        movie.artistName = response[@"artistName"];
    }
    
    if ([response[@"trackName"] avg_isNonEmptyString]) {
        movie.trackName = response[@"trackName"];
    }
    
    if ([response[@"longDescription"] avg_isNonEmptyString]) {
        movie.longDescription = response[@"longDescription"];
    }
    
    if ([response[@"artworkUrl100"] avg_isNonEmptyString]) {
        movie.artworkUrl = response[@"artworkUrl100"];
    }
    
    if ([response[@"releaseDate"] avg_isNonEmptyString]) {
        movie.releaseDate = [AVGItunesAPIResponseParser dateForString:response[@"releaseDate"]];
    }
    
    if ([response[@"previewUrl"] avg_isNonEmptyString]) {
        movie.previewUrl = response[@"previewUrl"];
    }
    
    if (!movie.trackId || [movie.trackId isEqual:@(0)]) {
        return nil;
    }
    
    return movie;
}

#pragma mark - Helper Methods

+ (NSDate *)dateForString:(NSString *)timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [formatter dateFromString:timeString];
    return date;
}

@end
