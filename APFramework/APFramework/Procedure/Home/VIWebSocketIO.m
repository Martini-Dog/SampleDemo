//
//  VIWebSocketIO.m
//  APFramework
//
//  Created by viatom on 2020/5/12.
//  Copyright © 2020 The_X. All rights reserved.
//

#import "VIWebSocketIO.h"

@interface VIWebSocketIO ()

@property (nonatomic, strong) SocketManager *manager;
@property (nonatomic, strong) SocketIOClient *socket;

@property (nonatomic, copy) NSString *host;

@end

@implementation VIWebSocketIO


- (instancetype)initWithHost:(NSString *)host delegate:(id<VIWebSocketIODelegate>)delegate {
    self = [super init];
    if (self) {
        self.manager = [[SocketManager alloc] initWithSocketURL:[NSURL URLWithString:host] config:@{@"log": @NO}];
        self.socket = self.manager.defaultSocket;
        
        self.host = host;
        self.delegate = delegate;
    }
    return self;
}




+ (VIWebSocketIO *)shared {
    static VIWebSocketIO *webSocketIO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webSocketIO = [[super allocWithZone:NULL] init];
    });
    return webSocketIO;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [[SocketManager alloc] initWithSocketURL:[NSURL URLWithString:@"http://socket.viatomtech.com.cn"] config:@{@"log": @YES}];
        self.socket = self.manager.defaultSocket;
        
        [self.socket on:@"statusChange" callback:^(NSArray *data, SocketAckEmitter *ack) {
            int status = ((NSNumber *)data[1]).intValue;
            switch (status) {
                case SocketIOStatusDisconnected:
                    
                    break;
                    
                default:
                    break;
            }
        }];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [VIWebSocketIO shared];
}

- (void)joinChannel:(NSString *)channel {
    if (self.socket.status != SocketIOStatusConnected) {
        [self connect];
    }
    
    [self.socket emit:@"join" with:@[channel]];
    [self.socket on:@"data" callback:^(NSArray *data, SocketAckEmitter *ack) {
        NSLog(@"%@", data);
        
        NSString *dataStr = data[0];
        
    }];
    
//    [self.socket on:<#(NSString * _Nonnull)#> callback:<#^(NSArray * _Nonnull, SocketAckEmitter * _Nonnull)callback#>]
}


- (void)connect {
    [self.socket connect];
    [self.socket on:@"connect" callback:^(NSArray *data, SocketAckEmitter *ack) {
        if ([self.delegate respondsToSelector:@selector(VIWebSocketIO:didConnectToHost:)]) {
            [self.delegate VIWebSocketIO:self didConnectToHost:self.host];
        }
    }];
}

@end
