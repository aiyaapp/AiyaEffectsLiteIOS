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

@property (nonatomic, strong) AiyaAnimHandler *animHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在正式环境中填入相应的License
    [AiyaLicenseManager initLicense:@"704705f35759" succ:^{
        
    } failed:^(NSString *errMsg) {
        
    }];
    
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
    
    if (!_animHandler) {
        //初始化AiyaAnimEffect
        _animHandler = [[AiyaAnimHandler alloc] init];
        self.animHandler.effectPath = [[NSBundle mainBundle] pathForResource:@"meta" ofType:@"json" inDirectory:@"mogulin"];
        self.animHandler.effectPlayCount = 2;
    }
    
    //清空画布
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //绘制
    AIYA_ANIM_EFFECT_ERROR_CODE errorCode;
    AIYA_ANIM_EFFECT_STATUS effectStatus = [self.animHandler processWithWidth:(int)glkView.drawableWidth height:(int)glkView.drawableHeight error:&errorCode];
    
    if (effectStatus == AIYA_ANIM_EFFECT_STATUS_ERROR){
        NSLog(@"erro %lu",errorCode);

    }else {
        NSLog(@"status %lu",effectStatus);
    }
}

@end
