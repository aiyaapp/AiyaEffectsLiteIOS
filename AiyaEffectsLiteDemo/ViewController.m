//
//  ViewController.m
//  AiyaEffectsLiteDemo
//
//  Created by 汪洋 on 2017/6/22.
//  Copyright © 2017年 深圳市哎吖科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import "AiyaCameraSDKLite/AiyaCameraSDKLite.h"

@interface ViewController () <GLKViewDelegate>{
    GLKView *glkView;
    CADisplayLink* displayLink;
}

@property (nonatomic, strong) AiyaAnimEffect *animEffect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在正式环境中填入相应的License
    [AiyaLicenseManager initLicense:@"704705f35759"];
    
    UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor blueColor];
    [self.view addSubview:v];
    
    //使用GLKit创建opengl渲染环境
    glkView = [[GLKView alloc]initWithFrame:self.view.bounds context:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]];
    glkView.backgroundColor = [UIColor clearColor];
    glkView.delegate = self;
    
    [self.view addSubview:glkView];
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    displayLink.frameInterval = 4;// 帧率 = 60 / frameInterval
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark CADisplayLink selector
- (void)render:(CADisplayLink*)displayLink {
    [glkView display];
}

#pragma mark GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    
    if (!_animEffect) {
        //初始化AiyaAnimEffect
        _animEffect = [[AiyaAnimEffect alloc] init];
        self.animEffect.effectPath = [[NSBundle mainBundle] pathForResource:@"meta" ofType:@"json" inDirectory:@"mogulin"];
        self.animEffect.effectPlayCount = 2;
        [self.animEffect initEffectContextWithWidth:0 height:0];
    }
    
    //清空画布
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //绘制
    [self.animEffect processWithTexture:0 width:(int)view.drawableWidth height:(int)view.drawableHeight];
    
    
    if (_animEffect.effectStatus == AIYA_EFFECT_STATUS_ERROR){
        NSLog(@"erro %lu",(unsigned long)self.animEffect.effectErrorCode);

    }else {
        NSLog(@"status %lu",(unsigned long)self.animEffect.effectStatus);
    }
}

- (void)dealloc{
    //释放GL资源
    [self.animEffect deinitEffectContext];
    [displayLink invalidate];
    displayLink = nil;
}

@end
