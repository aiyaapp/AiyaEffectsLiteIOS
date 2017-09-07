//
//  AiyaLicenseManager.h
//  AiyaCameraSDKDemo
//
//  Created by 汪洋 on 2016/11/19.
//  Copyright © 2016年 深圳哎吖科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AiyaLicenseManager : NSObject

/**
 初始化lisence
 异步请求服务器确认lisence
 */
+ (void)initLicense:(NSString *)appKey succ:(void(^)())succ failed:(void(^)(NSString *errMsg))failed;

@end
