//
//  UIImage+clipScreen.h
//  q
//
//  Created by daming on 15-5-14.
//  Copyright (c) 2015年 daming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (clipScreen)

// 将一个view截图
+ (instancetype)captureWithView:(UIView *)view;

@end
