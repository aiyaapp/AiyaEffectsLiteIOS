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

typedef NS_ENUM(NSUInteger, AIYA_ANIM_EFFECT_ERROR_CODE) {
    AIYA_ANIM_EFFECT_ERROR_CODE_NO_ERROR, /** 没有错误 */
    AIYA_ANIM_EFFECT_ERROR_CODE_INVALID_RESOURCE, /** 无效的资源 */
};

typedef NS_ENUM(NSUInteger, AIYA_ANIM_EFFECT_STATUS) {
    AIYA_ANIM_EFFECT_STATUS_INIT, /** 没有设置任何特效 */
    AIYA_ANIM_EFFECT_STATUS_PLAYING, /** 特效播放中 */
    AIYA_ANIM_EFFECT_STATUS_PLAYEND, /** 特效播放结束 */
    AIYA_ANIM_EFFECT_STATUS_ERROR /** 特效播放失败 */
};

@interface AiyaAnimEffect : NSObject

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
 @param effectPath 特效资源路径
 @param errorCode 错误码
 @return 绘制结果
 */
- (int)effectWithTexture:(GLuint)texture width:(GLuint)width height:(GLuint)height effectPath:(NSString *)effectPath error:(AIYA_ANIM_EFFECT_ERROR_CODE *)errorCode;

/**
 销毁上下文
 */
- (void)deinitEffectContext;



@end
