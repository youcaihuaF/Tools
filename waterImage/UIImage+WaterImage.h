//
//  UIImage+WaterImage.h
//  我
//
//  Created by daming on 15-5-13.
//  Copyright (c) 2015年 daming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WaterImage)

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 *  水印的大小位置 可以在方法实现中自行修改
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

@end
