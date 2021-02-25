//
//  VIWebSocketIO.h
//  APFramework
//
//  Created by viatom on 2020/5/12.
//  Copyright © 2020 The_X. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SocketIO;
@class VIWebSocketIO;

@protocol VIWebSocketIODelegate <NSObject>

- (void)VIWebSocketIO:(VIWebSocketIO *)socketIO didConnectToHost:(NSString *)host;

- (void)VIWebSocketIO:(VIWebSocketIO *)socketIO didReceiveData:(NSDictionary *)dataDic;

@end


@interface VIWebSocketIO : NSObject

@property (nonatomic, weak) id<VIWebSocketIODelegate> delegate;

+ (VIWebSocketIO *)shared;

- (void)connect;

- (void)joinChannel:(NSString *)channel;

@end


