//
//  AVGItunesAPIResponseParser.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGItunesAPIResponseParser.h"
#import "NSObject+AVGTypeChecking.h"

@implementation AVGItunesAPIResponseParser

+ (NSArray *)moviesFromResponses:(NSArray *)responses {
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *moviewDictionary in responses) {
        AVGMovie *movie = [AVGItunesAPIResponseParser movieFromReponse:moviewDictionary];
        if (movie) {
            [movies addObject:movie];
        }
    }
    
    return movies;
}

+ (AVGMovie *)movieFromReponse:(NSDictionary *)response {
    if (![response isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    AVGMovie *movie = [[AVGMovie alloc] init];
    
    if ([response[@"trackId"] avg_isNumber]) {
        movie.trackId = [response[@"trackId"] integerValue];
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
    
    /*"wrapperType": "track",
    "kind": "feature-movie",
    "collectionId": 948979890,
    "trackId": 303888092,
    "artistName": "Terence Young",
    "collectionName": "The James Bond Collection",
    "trackName": "From Russia With Love",
    "collectionCensoredName": "The James Bond Collection",
    "trackCensoredName": "From Russia With Love",
    "collectionArtistId": 84755883,
    "collectionArtistViewUrl": "https://itunes.apple.com/us/artist/mgm/id84755883?uo=4",
    "collectionViewUrl": "https://itunes.apple.com/us/movie/from-russia-with-love/id303888092?uo=4",
    "trackViewUrl": "https://itunes.apple.com/us/movie/from-russia-with-love/id303888092?uo=4",
    "previewUrl": "http://a1987.v.phobos.apple.com/us/r1000/022/Video2/v4/db/e7/06/dbe70647-b352-99e3-d535-f460b0b9ef49/mzvf_3522537816560044012.640x480.h264lc.D2.p.m4v",
    "artworkUrl30": "http://is2.mzstatic.com/image/thumb/Video1/v4/be/87/17/be871734-68a6-bad2-124e-554282214949/pr_source.lsr/30x30bb-85.jpg",
    "artworkUrl60": "http://is4.mzstatic.com/image/thumb/Video1/v4/be/87/17/be871734-68a6-bad2-124e-554282214949/pr_source.lsr/60x60bb-85.jpg",
    "artworkUrl100": "http://is5.mzstatic.com/image/thumb/Video1/v4/be/87/17/be871734-68a6-bad2-124e-554282214949/pr_source.lsr/100x100bb-85.jpg",
    "collectionPrice": 99.99,
    "trackPrice": 10.99,
    "collectionHdPrice": 99.99,
    "trackHdPrice": 14.99,
    "releaseDate": "1963-10-11T07:00:00Z",
    "collectionExplicitness": "notExplicit",
    "trackExplicitness": "notExplicit",
    "discCount": 1,
    "discNumber": 1,
    "trackCount": 23,
    "trackNumber": 2,
    "trackTimeMillis": 6919752,
    "country": "USA",
    "currency": "USD",
    "primaryGenreName": "Action & Adventure",
    "contentAdvisoryRating": "PG",
    "longDescription": "The Cold War's about to get colder in Bond number two...which sends Secret Agent 007 to mysterious, exotic Istanbul to lift a top-secret Russian decoding machine from the Embassy...and where Bond falls for a Russian cipher clerk who is an unwitting pawn of Spectre, an international crime syndicate. Based on the novel by Ian Fleming.",
    "radioStationUrl": "https://itunes.apple.com/station/idra.303888092"*/
    
    if (!movie.trackId) {
        return nil;
    }
    
    return movie;
}

+ (NSDate *)dateForString:(NSString *)timeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //"2010-10-05T07:00:00Z"
    
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    NSDate *date = [formatter dateFromString:timeString];
    return date;
}

@end
