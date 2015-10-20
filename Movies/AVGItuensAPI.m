//
//  AVGItuensAPI.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGItuensAPI.h"
#import "AVGItunesAPIResponseParser.h"
#import "NSObject+AVGTypeChecking.h"

@implementation AVGItuensAPI

+ (void)getMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray *movies, NSError *error))completion {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", searchTerm];
    NSURL *url = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([result avg_isNonEmptyDictionary] && [result[@"results"] avg_isNonEmptyArray]) {
            NSArray *movies = [AVGItunesAPIResponseParser moviesFromResponses:result[@"results"]];
            
            if (completion) {
                completion(movies, nil);
            }
        } else {
            if (completion) {
                completion(nil, error);
            }
        }
    }] resume];
}

@end
