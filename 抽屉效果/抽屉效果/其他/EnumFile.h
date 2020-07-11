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


#endif /* EnumFile_h */
