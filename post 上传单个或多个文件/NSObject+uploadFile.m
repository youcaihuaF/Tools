//
//  NSObject+uploadFile.m
//  upload
//
//  Created by daming on 15-5-21.
//  Copyright (c) 2015年 daming. All rights reserved.
//

#import "NSObject+uploadFile.h"

@implementation NSObject (uploadFile)

#define boundary @"uploadFile"

// 多个
+ (void)uploadFile:(NSString *)fieldName dataDict:(NSDictionary *)dataDict params:(NSDictionary *)params withURL:(NSString *)urlStr
{
    // 1. url - 负责上传文件的脚本
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    // 设置请求的 content-type
    // 告诉服务器一些额外的信息 multipart/form-data - 要上传文件
    NSString *type = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:type forHTTPHeaderField:@"Content-Type"];
    
    // 设置二进制数据
    request.HTTPBody = [self formData:fieldName dataDict:dataDict params:params];
    
    // 3. connection
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError !=nil || data.length == 0) {
            NSLog(@"%@",connectionError);
            return ;
        }
        [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    }];
}

+ (NSData *)formData:(NSString *)fieldName dataDict:(NSDictionary *)dataDict params:(NSDictionary *)params {
    
    // 1. 准备二进制数据
    NSMutableData *dataM = [NSMutableData data];
    
    // 2. 拼接文件的数据(循环 - 同样可以上传一个文件)
    [dataDict enumerateKeysAndObjectsUsingBlock:^(NSString *fileName, NSData *data, BOOL *stop) {
        NSMutableString *strM = [NSMutableString stringWithFormat:@"--%@\r\n", boundary];
        [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, fileName];
        [strM appendString:@"Content-Type: application/octet-stream\r\n\r\n"];
        
        [dataM appendData:[strM dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 拼接文件二进制数据
        [dataM appendData:data];
        
        // 拼接一个回车
        [dataM appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // 3. 拼接参数的数据(循环 - 可以有参数，也可以没有参数)
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        NSMutableString *strM = [NSMutableString stringWithFormat:@"--%@\r\n", boundary];
        [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        [strM appendFormat:@"%@\r\n", value];
        
        [dataM appendData:[strM dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // 4. 尾部字符串
    NSString *tail = [NSString stringWithFormat:@"--%@--", boundary];
    [dataM appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [dataM copy];
}


// 单个
+ (void)uploadFile:(NSString *)fieldName fileName:(NSString *)fileName data:(NSData *)data withURL:(NSString *)urlStr
{
    // 1. url － 负责上传文件的脚本
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. request － 网络访问中，真正变化的位置，都在 request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    // 设置请求的 content-type
    // 告诉服务器一些额外的信息 multipart/form-data - 要上传文件
    NSString *type = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:type forHTTPHeaderField:@"Content-Type"];
    
    // 设置二进制数据
    request.HTTPBody = [self formData:fieldName fileName:fileName data:data];
    
    // 3. connection
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }];

}

/**
 --boundary\r\n
 Content-Disposition: form-data; name="userfile"; filename="aaa.txt"\r\n
 Content-Type: application/octet-stream\r\n\r\n
 
 要上传文件的二进制数据
 
 \r\n--boundary--
 
 注意：以上格式一定要严格按照标准来写，多一个空格都不行
 */
+ (NSData *)formData:(NSString *)fieldName fileName:(NSString *)fileName data:(NSData *)data {
    
    NSMutableData *dataM = [NSMutableData data];
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@"--%@\r\n", boundary];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, fileName];
    [strM appendString:@"Content-Type: application/octet-stream\r\n\r\n"];
    
    [dataM appendData:[strM dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 拼接文件二进制数据
    [dataM appendData:data];
    
    NSString *tail = [NSString stringWithFormat:@"\r\n--%@--", boundary];
    [dataM appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [dataM copy];
}


@end
