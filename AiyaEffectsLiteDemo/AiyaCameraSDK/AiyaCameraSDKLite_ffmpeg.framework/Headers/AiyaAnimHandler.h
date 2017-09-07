//
//  AiyaAnimHandler.h
//  AiyaCameraSDK
//
//  Created by 汪洋 on 2017/8/5.
//  Copyright © 2017年 深圳哎吖科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#include "AiyaAnimEffect.h"

@interface AiyaAnimHandler : NSObject

/**
 设置特效,通过设置特效文件路径的方式
 */
@property (nonatomic, copy) NSString *effectPath;

/**
 设置特效播放次数 默认0 0表示一直渲染当前特效
 */
@property (nonatomic, assign) NSUInteger effectPlayCount;

/**
 绘制特效
 @param width 宽度
 @param height 高度
 */
- (AIYA_ANIM_EFFECT_STATUS)processWithWidth:(GLuint)width height:(GLuint)height error:(AIYA_ANIM_EFFECT_ERROR_CODE *)errorCode;

@end
