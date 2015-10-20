//
//  NSObject+AVGTypeChecking.h
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AVGTypeChecking)

- (BOOL)avg_isNonNullObject;
- (BOOL)avg_isString;
- (BOOL)avg_isNonEmptyString;
- (BOOL)avg_isArray;
- (BOOL)avg_isNonEmptyArray;
- (BOOL)avg_isDictionary;
- (BOOL)avg_isNonEmptyDictionary;
- (BOOL)avg_isNumber;
- (BOOL)avg_isDate;

@end
