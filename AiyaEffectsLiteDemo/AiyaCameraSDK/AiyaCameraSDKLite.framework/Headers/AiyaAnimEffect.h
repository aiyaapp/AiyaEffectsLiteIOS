//
//  AiyaAnimEffect.h
//  AiyaCameraSDK
//
//  Created by 汪洋 on 2017/6/22.
//  Copyright © 2017年 深圳哎吖科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

typedef NS_ENUM(NSUInteger, AIYA_EFFECT_STATUS) {
    AIYA_EFFECT_STATUS_INIT, /** 没有设置任何特效 */
    AIYA_EFFECT_STATUS_PLAYING, /** 特效播放中 */
    AIYA_EFFECT_STATUS_PLAYEND, /** 特效播放结束 */
    AIYA_EFFECT_STATUS_ERROR /** 特效播放失败 */
};

typedef NS_ENUM(NSUInteger, AIYA_EFFECT_ERROR_CODE) {
    AIYA_EFFECT_ERROR_CODE_NO_ERROR, /** 没有错误 */
    AIYA_EFFECT_ERROR_CODE_INVALID_RESOURCE, /** 无效的资源 */
};

@interface AiyaAnimEffect : NSObject

/**
 设置特效,通过设置特效文件路径的方式
 */
@property (nonatomic, copy) NSString *effectPath;

/** 
 设置特效播放次数 默认0 0表示一直渲染当前特效
 */
@property (nonatomic, assign) NSUInteger effectPlayCount;

/** 
 特效播放状态 AIYA_EFFECT_STATUS
 因为只有一个通知,所以使用KVO这种简易的方式.
 */
@property (nonatomic, assign, readonly) AIYA_EFFECT_STATUS effectStatus;

/**
 播放错误时的错误码
 */
@property (nonatomic, assign, readonly) AIYA_EFFECT_ERROR_CODE effectErrorCode;

/**
 初始化上下文
 
 @param width 保留字段,传0
 @param height 保留字段,传0
 */
- (void)initEffectContextWithWidth:(GLuint)width height:(GLuint)height;

/**
 绘制特效
 
 @param texture 保留字段,传0
 @param width 宽度
 @param height 高度
 */
- (void)processWithTexture:(GLuint)texture width:(GLuint)width height:(GLuint)height;

/**
 销毁上下文
 */
- (void)deinitEffectContext;



@end
