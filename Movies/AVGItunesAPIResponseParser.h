//
//  AVGItunesAPIResponseParser.h
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVGMovie.h"

@interface AVGItunesAPIResponseParser : NSObject

+ (NSArray *)moviesFromResponses:(NSArray *)responses;
+ (AVGMovie *)movieFromReponse:(NSDictionary *)response;

@end
