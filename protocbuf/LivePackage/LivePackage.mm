//
//  LivePackage.m
//  guimiquan
//
//  Created by felix on 2016/11/29.
//  Copyright © 2016年 Vanchu. All rights reserved.
//

#import "LivePackage.h"
#undef TYPE_BOOL
#import "LivePackage_client.pb.h"
#import "NSMutableData+Helper.h"

#define LIVE_PACKAGE_VERSION 0x01
#define LIVE_PACKAGE_HEAD_SIZE 4

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

@implementation LivePackage_EnterRoomRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandEnterRoomRequest;
    }
    return self;
}

@end

@implementation LivePackage_EnterRoomStatement

- (instancetype)init
{
    self = [super init];
    if (self) {
        _online = 3;
    }
    return self;
}

@end

@implementation LivePackage_UserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userId = @"";
        _nickName = @"";
        _headUrl = @"";
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
        _result = 3;
        _userInfo = [NSMutableArray<LivePackage_UserInfo*> new];
    }
    return self;
}
@end

@implementation LivePackage_LoginRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandLoginRequest;
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
        _result = 1;
    }
    return self;
}
@end

@implementation LivePackage_TalkRequest
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

@implementation LivePackage_RoomCloseBroadcastStatement

- (instancetype)init
{
    self = [super init];
    if (self) {
        _likeTotal = 0;
        _postsTotal = 0;
        _onlineTotal = 0;
        _duration = 0;
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
        _statement = [LivePackage_RoomCloseBroadcastStatement new];
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

@implementation LivePackage_UserSilencePush

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandSilencePush;
    }
    return self;
}

@end

@implementation LivePackage_HeartHeat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cmd = LivePackageCommandHeartbeat;
    }
    return self;
}

@end


@implementation LivePackageFactory

+ (NSData *)encode:(LivePackage *)livePackage {
    
        NSMutableData *data= [NSMutableData new];
        [data writeUInt8:LIVE_PACKAGE_VERSION];
        
        std::string body;
        switch (livePackage.cmd) {
            case LivePackageCommandEnterRoomRequest:
            {
                LivePackage_EnterRoomRequest *enterRoomRequestPackage = (LivePackage_EnterRoomRequest *)livePackage;
                EnterRoomRequest pbPackage;
                pbPackage.set_roomid(enterRoomRequestPackage.roomId.UTF8String);
                pbPackage.SerializeToString(&body);
            }
                break;
            case LivePackageCommandLoginRequest:
            {
                LivePackage_LoginRequest *loginRequest = (LivePackage_LoginRequest*)livePackage;
                LoginRequest pbPackage ;
                pbPackage.set_auth(loginRequest.auth.UTF8String);
                pbPackage.set_nickname(loginRequest.nickName.UTF8String);
                pbPackage.set_headurl(loginRequest.headUrl.UTF8String);
                pbPackage.SerializeToString(&body);
            }
                break;
            case LivePackageCommandTalkRequest:
            {
                LivePackage_TalkRequest *talkRequest = (LivePackage_TalkRequest *)livePackage;
                TalkRequest pbPackage;
                pbPackage.set_id(talkRequest.mId.UTF8String);
                pbPackage.set_content(talkRequest.content.UTF8String);
                pbPackage.set_type((int32_t)talkRequest.type);
                pbPackage.set_time(talkRequest.time * 1000);
                pbPackage.SerializeToString(&body);
            }
                break;
            case LivePackageCommandCloseRoomRequest:
            {
                LivePackage_CloseRoomRequest *closeRoomRequest = (LivePackage_CloseRoomRequest *)livePackage;
                CloseRoomRequest pbPackage;
                pbPackage.set_reason((int32_t)closeRoomRequest.reason);
                pbPackage.set_roomid(closeRoomRequest.roomId.UTF8String);
                pbPackage.SerializeToString(&body);
            }
                break;
            case LivePackageCommandHeartbeat:
                break;
           default:
            {
                NSLog(@"live package cannot encode message with cmd = %d", (int)(livePackage.cmd));
                [NSException raise:@"Invalid Param" format:@"cannot encode message with cmd = %d", (int)(livePackage.cmd)];
            }
                break;
         }
        
        [data writeUInt16:LIVE_PACKAGE_HEAD_SIZE + body.length()];
        [data writeUInt8:livePackage.cmd];
        [data writeData:[NSData dataWithBytes:body.data() length:body.length()]];
        return data;
}

// 解码 将二进制数据转化为对象，c++转化为oc
+ (LivePackage *)decode:(NSMutableData *)data withError:(NSError *__autoreleasing *)error withShouldContinueWhenError:(BOOL*)shouldContiue {
    if (data.length < LIVE_PACKAGE_HEAD_SIZE) {
        *shouldContiue = false;
        return nil;
    }
    
    NSInteger version = [data peekUInt8WithOffset:0];
    NSInteger length = [data peekUInt16WithOffset:1];
    NSInteger command = [data peekUInt8WithOffset:3];
    
    if (version != LIVE_PACKAGE_VERSION) {
        if (error) {
            *error = [NSError errorWithDomain:@"Network" code:-1 userInfo:nil];
        }
        *shouldContiue = false;
        return nil;
    }
    
    if (data.length <length) {
        *shouldContiue = false;
        return nil;
    }
    
    [data replaceBytesInRange:NSMakeRange(0, LIVE_PACKAGE_HEAD_SIZE) withBytes:NULL length:0];
    length -= LIVE_PACKAGE_HEAD_SIZE;
    
    LivePackage *package = nil;
    switch (command) {
        case LivePackageCommandEnterRoomRespoonse:
        {
            EnterRoomResponse pbPackage;
            if (!pbPackage.ParseFromArray(data.bytes, @(length).intValue)) {
                if(error) {
                    *error = [NSError errorWithDomain:@"Application" code:-2 userInfo:nil];
                }
                return nil;
            }
            
            LivePackage_EnterRoomResponse *enterRoomResponse = [LivePackage_EnterRoomResponse new];
            enterRoomResponse.result = pbPackage.result();
            enterRoomResponse.likeTotal = @(pbPackage.liketotal()).integerValue;
            enterRoomResponse.clientId = [NSString stringWithUTF8String:pbPackage.id().c_str()];

            LivePackage_EnterRoomStatement *statement = [LivePackage_EnterRoomStatement new];
            statement.online = @(pbPackage.statement().online()).integerValue;
            enterRoomResponse.statement = statement;
            
            for (int index = 0 ; index < pbPackage.users_size(); index ++) {
                LivePackage_UserInfo *userInfoItem = [LivePackage_UserInfo new];
                userInfoItem.userId = [NSString stringWithUTF8String:pbPackage.users(index).userid().c_str()];
                userInfoItem.nickName = [NSString stringWithUTF8String:pbPackage.users(index).nickname().c_str()];
                userInfoItem.headUrl = [NSString stringWithUTF8String:pbPackage.users(index).headurl().c_str()];
                [enterRoomResponse.userInfo addObject:userInfoItem];
            }
            enterRoomResponse.statement = statement;
            package = enterRoomResponse;
        }
            break;
        case LivePackageCommandLoginResponse:
        {
            LoginResponse pbPackage;
            if (!pbPackage.ParseFromArray(data.bytes, @(length).intValue)) {
                if(error) {
                    *error = [NSError errorWithDomain:@"Application" code:-2 userInfo:nil];
                }
                return nil;
            }
            
            LivePackage_LoginResponse *loginResponse = [LivePackage_LoginResponse new];
            loginResponse.result = @(pbPackage.result()).integerValue;
            package = loginResponse;
                
        }
            break;
        case LivePackageCommandTalkResponse:
        {
            
        }
            break;
        case LivePackageCommandCommonBroadcast:
        {
            Broadcast pbPackage;
            if (!pbPackage.ParseFromArray(data.bytes, @(length).intValue)) {
                if(error) {
                    *error = [NSError errorWithDomain:@"Application" code:-2 userInfo:nil];
                }
                return nil;
            }

            LivePackage_Broadcast *broadcast = [LivePackage_Broadcast new];
            broadcast.mId = [NSString stringWithUTF8String:pbPackage.id().c_str()];
            broadcast.content = [NSString stringWithUTF8String:pbPackage.content().c_str()];
            switch (@(pbPackage.type()).integerValue) {
                case 0:
                    broadcast.type = LiveMessageTypeText;
                    break;
                case 1:
                    broadcast.type = LiveMessageTypeLike;
                    break;
                case 2:
                    broadcast.type = LiveMessageTypeFollow;
                    break;
                case 3:
                    broadcast.type = LiveMessageTypeEnterRoom;
                    break;
                case 4:
                    broadcast.type = LiveMessageTypeExitRoom;
                    break;
                default:
                    break;
            }
            broadcast.time = @(pbPackage.time()).integerValue;
            LivePackage_UserInfo *userInfo = [LivePackage_UserInfo new];
            userInfo.userId = [NSString stringWithUTF8String:pbPackage.user().userid().c_str()];
            userInfo.nickName = [NSString stringWithUTF8String:pbPackage.user().nickname().c_str()];
            userInfo.headUrl = [NSString stringWithUTF8String:pbPackage.user().headurl().c_str()];
            broadcast.userInfo = userInfo;
            package  = broadcast;
            
        }
            break;
        case LivePackageCommandCloseRoomBoadcast:
        {
            RoomCloseBroadcast pbPackage;
            if (!pbPackage.ParseFromArray(data.bytes, @(length).intValue)) {
                if(error) {
                    *error = [NSError errorWithDomain:@"Application" code:-2 userInfo:nil];
                }
                return nil;
            }
            
            LivePackage_RoomCloseBroadcast *roomCloseBroadcast = [LivePackage_RoomCloseBroadcast new];
            roomCloseBroadcast.reason = pbPackage.reason();
            LivePackage_RoomCloseBroadcastStatement *statement = [LivePackage_RoomCloseBroadcastStatement new];
            statement.likeTotal = @(pbPackage.statement().liketotal()).integerValue;
            statement.postsTotal = @(pbPackage.statement().poststotal()).integerValue;
            statement.onlineTotal = @(pbPackage.statement().onlinetotal()).integerValue;
            statement.duration = @(pbPackage.statement().duration()).integerValue;
            roomCloseBroadcast.statement = statement;
            roomCloseBroadcast.reason = @(pbPackage.reason()).integerValue;
            package  = roomCloseBroadcast;
        }
            break;
        case LivePackageCommandMakeUserSilenceRequest:
        {
            MakeUserSilenceRequest pbPackage;
            if (!pbPackage.ParseFromArray(data.bytes, @(length).intValue)) {
                if(error) {
                    *error = [NSError errorWithDomain:@"Application" code:-2 userInfo:nil];
                }
                return nil;
            }
            
            LivePackage_MakeUserSilenceReqeust *silenceRequest = [LivePackage_MakeUserSilenceReqeust new];
            silenceRequest.userId = [NSString stringWithUTF8String:pbPackage.userid().c_str()];
            package = silenceRequest;
        }
            break;
        case LivePackageCommandSilencePush:
        {
            LivePackage_UserSilencePush *silencePush = [LivePackage_UserSilencePush new];
            silencePush.uesrId = @"uesrid";//表示当前用户已经被禁言了
            package = silencePush;
        }
            break;
        default:
            NSLog(@"unsupported command %d received",(int)command);
            *shouldContiue = true;
            break;
    }
    [data replaceBytesInRange:NSMakeRange(0, length) withBytes:NULL length:0];
    return package;
    
}

@end
