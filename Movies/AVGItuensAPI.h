//
//  AVGItuensAPI.h
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVGItuensAPI : NSObject

+ (void)getMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray *movies, NSError *error))completion;

@end
