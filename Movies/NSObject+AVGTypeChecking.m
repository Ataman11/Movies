//
//  NSObject+AVGTypeChecking.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "NSObject+AVGTypeChecking.h"

@implementation NSObject (AVGTypeChecking)

- (BOOL)avg_isNonNullObject {
    return self && ![self isEqual:[NSNull null]];
}

- (BOOL)avg_isString {
    return self.avg_isNonNullObject && [self isKindOfClass:[NSString class]];
}

- (BOOL)avg_isNonEmptyString {
    return self.avg_isString && ((NSString *)self).length > 0;
}

- (BOOL)avg_isArray {
    return self.avg_isNonNullObject && [self isKindOfClass:[NSArray class]];
}

- (BOOL)avg_isNonEmptyArray {
    return self.avg_isArray && ((NSArray *)self).count > 0;
}

- (BOOL)avg_isDictionary {
    return self.avg_isNonNullObject && [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)avg_isNonEmptyDictionary {
    return self.avg_isDictionary && ((NSDictionary *)self).count > 0;
}

- (BOOL)avg_isNumber {
    return self.avg_isNonNullObject && [self isKindOfClass:[NSNumber class]];
}

- (BOOL)avg_isDate {
    return self.avg_isNonNullObject && [self isKindOfClass:[NSDate class]];
}

@end
