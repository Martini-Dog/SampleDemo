//
//  VIPhotosManager.m
//  APFramework
//
//  Created by viatom on 2020/8/10.
//  Copyright © 2020 The_X. All rights reserved.
//

#import "VIPhotosManager.h"
#import <Photos/Photos.h>

@interface VIPhotosManager ()

@property (nonatomic, strong) PHPhotoLibrary *libraryManager;

@end

@implementation VIPhotosManager

#pragma mark -

+ (instancetype)defaultManager {
    static VIPhotosManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[super allocWithZone:NULL] init];
    });
    return defaultManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self defaultManager];
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.libraryManager = [PHPhotoLibrary sharedPhotoLibrary];
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status != PHAuthorizationStatusAuthorized) {
                NSString *bundleName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
                NSString *remindStr = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-照片\"选项中，允许%@访问您的手机相册", bundleName];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil)  message:remindStr preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"授权" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }];
                    [alertVC addAction:action];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                });
                return;
            }
        }];
    }
    return self;
}

#pragma mark -

- (void)saveImage:(UIImage *)image withAlbum:(NSString *)album {

    PHAssetCollection *appAlbum = [self fetchApplicationAlbum];
    
    
    BOOL success = [self.libraryManager performChangesAndWait:^{

        NSLog(@"333 -- %@", [NSThread currentThread]);

        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        PHObjectPlaceholder *assetPlaceholder = assetRequest.placeholderForCreatedAsset;


        PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:appAlbum];
        [collectionRequest addAssets:@[assetPlaceholder]];
    } error:nil];
    
    NSLog(@"%d", success);
    
    
//    [self.libraryManager performChanges:^{
//        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
//        PHObjectPlaceholder *assetPlaceholder = assetRequest.placeholderForCreatedAsset;
//
//
//        PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:appAlbum];
//        [collectionRequest addAssets:@[assetPlaceholder]];
//
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        NSLog(@"%d", success);
//        NSLog(@"%@", error);
//    }];
    
}



- (PHAssetCollection *)fetchApplicationAlbum {
    
    PHAssetCollection *assetCollection;
    
    NSString *bundleName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    PHFetchOptions *fetchOption = [[PHFetchOptions alloc] init];
    fetchOption.predicate = [NSPredicate predicateWithFormat:@"localizedTitle = %@", bundleName];
    PHFetchResult<PHCollection *> *result = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOption];
    
    if (result.count != 0) {
        assetCollection = (PHAssetCollection *)result.firstObject;
    } else {
        __block NSString *localIdentifier;
        BOOL success = [self.libraryManager performChangesAndWait:^{
            PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:bundleName];
            PHObjectPlaceholder *collectionPlaceholder = collectionRequest.placeholderForCreatedAssetCollection;
            localIdentifier = collectionPlaceholder.localIdentifier;
        } error:nil];
        PHFetchResult<PHCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[localIdentifier] options:nil];
        if (success) { assetCollection = (PHAssetCollection *)result.firstObject; }
    }
    NSLog(@"%@", assetCollection);
    return assetCollection;
}

@end
