//
//  UIImageView+AVGImageLoading.m
//  Movies
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "UIImageView+AVGImageLoading.h"

@implementation UIImageView (AVGImageLoading)

- (void)setImageWithUrl:(NSURL *)imageUrl {
    NSURLSessionDownloadTask *getImageTask = [[NSURLSession sharedSession] downloadTaskWithURL:imageUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = downloadedImage;
        });
    }];
    
    [getImageTask resume];
}

@end
