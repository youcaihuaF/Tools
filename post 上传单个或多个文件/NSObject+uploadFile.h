//
//  NSObject+uploadFile.h
//  upload
//
//  Created by daming on 15-5-21.
//  Copyright (c) 2015年 daming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (uploadFile)

/// 上传单个文件
// fieldName :负责上传文件脚本中的 字段名
// fileName :将文件保存在服务器上的文件名称
// data : 要上传的文件
// urlStr :负责上传文件的脚本
+ (void)uploadFile:(NSString *)fieldName fileName:(NSString *)fileName data:(NSData *)data withURL:(NSString *)urlStr;


/// 上传多个文件
/*
 // 1.上传的二进制文件
 NSDictionary *dataDict = @{@"xxx.png": data1};
 
 // 2. 同时提交的参数
 NSDictionary *params = @{@"status": @"happy", @"name": @"ma daha"};
 */
// urlStr :负责上传文件的脚本
+ (void)uploadFile:(NSString *)fieldName dataDict:(NSDictionary *)dataDict params:(NSDictionary *)params withURL:(NSString *)urlStr;

@end
