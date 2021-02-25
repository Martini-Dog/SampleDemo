//
//  VIPhotosManager.h
//  APFramework
//
//  Created by viatom on 2020/8/10.
//  Copyright © 2020 The_X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VIPhotosManager : NSObject

+ (instancetype)defaultManager;

- (void)requestAuthorization;

- (void)saveImage:(UIImage *)image withAlbum:(NSString *)album;
- (void)saveImageFromPath:(NSString *)path withAlbum:(NSString *)album;


@end

