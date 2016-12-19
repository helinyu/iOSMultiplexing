//
//  LivePackage.h
//  guimiquan
//
//  Created by felix on 2016/11/29.
//  Copyright © 2016年 Vanchu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LivePackageCommand) {
    LivePackageCommandEnterRoomRequest = 0x01, //加入房间
    LivePackageCommandEnterRoomRespoonse = 0x11, //加入房间命令结果
    LivePackageCommandLoginRequest = 0x02,  //登录房间
    LivePackageCommandLoginResponse = 0x12,  //登录房间命令结果
    LivePackageCommandTalkRequest = 0x03, //发送广播请求
    LivePackageCommandTalkResponse = 0x13, //发送广 播请求结果  (目前Server端不发送此包)
    LivePackageCommandCommonBroadcast = 0x06,  //消息广播
    LivePackageCommandCloseRoomBoadcast = 0x07,   // 直播结束广播
    LivePackageCommandMakeUserSilenceRequest = 0x08,   //禁言用户
    LivePackageCommandSilencePush = 0x09,   //被禁言通知
    LivePackageCommandCreateRoomRequest = 0x04, // 创建房间(目前前端不用实现）
    LivePackageCommandCreateRoomResponse = 0x14, //  创建房间命令结果（目前前端不用实现）
    LivePackageCommandCloseRoomRequest = 0x05, // 关闭房间
    LivePackageCommandCloseRoomResponse = 0x15, // 关闭房间请求结果（目前Server端不发送此包）
    LivePackageCommandHeartbeat = 0xff //心跳包   服务端目前心跳超时设置为90秒
};

@interface LivePackage : NSObject
@property (assign, nonatomic) LivePackageCommand cmd;
@end

@interface LivePackage_CreateRoomRequest : LivePackage
@property (strong, nonatomic) NSString *admin;
@end

@interface LivePackage_CreateRoomResponse : LivePackage
@property (assign, nonatomic) NSInteger result;
@end

@interface LivePackage_UserInfo : LivePackage
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *headUrl;
@end

@interface LivePackage_EnterRoomStatement : LivePackage
@property (assign, nonatomic) NSInteger online;
@end
@interface LivePackage_EnterRoomResponse : LivePackage
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) LivePackage_UserInfo *userInfo;
@property (strong, nonatomic) LivePackage_EnterRoomStatement *statement;
@property (strong, nonatomic) NSString *systemId;
@end

@interface LivePackage_LoginRequest : LivePackage
@property (strong, nonatomic) NSString *auth;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *headUrl;
@end

@interface LivePackage_LoginResponse : LivePackage
@property (assign, nonatomic) NSInteger result;
@end

@interface LivePackage_TaikRequest : LivePackage
@property (strong, nonatomic) NSString *talkId;
@property (strong, nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger time;
@end

@interface LivePackage_TalkResponse : LivePackage
@property (strong, nonatomic) NSString *talkId;
@end

@interface LivePackage_Broadcast : LivePackage
@property (strong, nonatomic) NSString *bId;
@property (strong, nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger time;
@property (strong, nonatomic) LivePackage_UserInfo *userInfo;
@property (strong, nonatomic) NSString *clientId;
@end

@interface LivePackage_CloseRoomRequest : LivePackage
@property (strong, nonatomic) NSString *roomId;
@property (assign, nonatomic) NSInteger reason;
@end

@interface LivePackage_CloseRoomResponse : LivePackage
@property (assign, nonatomic) NSInteger result;
@end


@interface LivePackage_BroadcastStatement : LivePackage
@property (assign, nonatomic) NSInteger liveTotal;
@property (assign, nonatomic) NSInteger postsTotal;
@property (assign, nonatomic) NSInteger onlineTotal;
@property (assign, nonatomic) NSInteger duration;
@end

@interface LivePackage_RoomCloseBroadcast : LivePackage
@property (strong, nonatomic) LivePackage_BroadcastStatement *statement;
@property (assign, nonatomic) NSInteger reason;
@end

@interface LivePackage_MakeUserSilenceReqeust : LivePackage
@property (strong, nonatomic) NSString *userId;
@end
