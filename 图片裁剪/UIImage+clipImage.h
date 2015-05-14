//
//  UIImage+clipImage.h
//
//  Created by daming on 15-5-14.
//  Copyright (c) 2015年 daming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (clipImage)

/**
 *  图片裁剪（可加圆边）
 *
 *  @param name          要裁剪的图片
 *  @param borderWidth   圆边的宽度
 *  @param borderColor   圆边的颜色
 *  
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


@end
