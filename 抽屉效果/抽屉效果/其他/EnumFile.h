//
//  EnumFile.h
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/7/10.
//  Copyright © 2020 Jackey. All rights reserved.
//

#ifndef EnumFile_h
#define EnumFile_h
#import <Foundation/Foundation.h>

// 新闻详情页面底部评论Tab
typedef enum : NSUInteger {
    CommonTypeMessage,  //消息
    CommonTypeSave,// 收藏
    CommonTypeLike,// 点赞
    CommonTypeForward //转发
} CommonType;


// 新闻详情弹出评论框的时候（今日头条样式）
typedef enum : NSUInteger {
    CommonInputTypeForwardSameTime, //同时转发
    CommonInputTypePublish,// 发布
    CommonInputTypePhotoLibrary,//相册
    CommonInputTypeAt,//@
    CommonInputTypeShape,//#
    CommonInputTypeGif,//Gif
    CommonInputTypeSmile//微笑
} CommonInputType;


// 消息类型：文本，图片，视频，广告
typedef enum : NSUInteger {
    MessageType_Text,
    MessageType_Image,
    MessageType_Video,
    MessageType_ADs
} MessageType;

// 消息方向：接受消息，发送消息
typedef enum : NSUInteger {
    MessageDerection_Send,
    MessageDerection_Recive
} MessageDerection;

#endif /* EnumFile_h */
