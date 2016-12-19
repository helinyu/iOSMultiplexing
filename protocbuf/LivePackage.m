//
//  LivePackage.m
//  guimiquan
//
//  Created by felix on 2016/11/29.
//  Copyright © 2016年 Vanchu. All rights reserved.
//

#import "LivePackage.h"

@implementation LivePackage

@end

@implementation LivePackage_CreateRoomRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandCreateRoomRequest;
    }
    return self;
}
@end

@implementation LivePackage_CreateRoomResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandCreateRoomResponse;
    }
    return self;
}
@end

@implementation LivePackage_EnterRoomResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandEnterRoomRespoonse;
    }
    return self;
}
@end

@implementation LivePackage_LoginRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandEnterRoomRespoonse;
    }
    return self;
}
@end

@implementation LivePackage_LoginResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandLoginResponse;
    }
    return self;
}
@end

@implementation LivePackage_TaikRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandTalkRequest;
    }
    return self;
}
@end

@implementation LivePackage_TalkResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandTalkResponse;
    }
    return self;
}
@end

@implementation LivePackage_Broadcast
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandCommonBroadcast;
    }
    return self;
}
@end

@implementation LivePackage_CloseRoomRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandCloseRoomRequest;
    }
    return self;
}
@end

@implementation LivePackage_CloseRoomResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandCloseRoomResponse;
    }
    return self;
}
@end

@implementation LivePackage_RoomCloseBroadcast
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandCloseRoomBoadcast;
    }
    return self;
}
@end

@implementation LivePackage_MakeUserSilenceReqeust
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandMakeUserSilenceRequest;
    }
    return self;
}
@end
