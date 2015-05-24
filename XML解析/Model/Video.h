

#import <Foundation/Foundation.h>

@interface Video : NSObject

// copy 属性，在设置数值的时候，如果有一方是可变的，会默认做一次 copy 操作，会建立新的副本
///  视频代号
@property (nonatomic, copy) NSNumber *videoId;
///  视频名称
@property (nonatomic, copy) NSString *name;
///  视频长度
@property (nonatomic, copy) NSNumber *length;
///  视频URL
@property (nonatomic, copy) NSString *videoURL;
///  图像URL
@property (nonatomic, copy) NSString *imageURL;
///  介绍
@property (nonatomic, copy) NSString *desc;
///  讲师
@property (nonatomic, copy) NSString *teacher;
///  完整的图片路径
@property (nonatomic, strong) NSURL *fullImageURL;
///  时间字符串
@property (nonatomic, copy) NSString *timeString;

+ (instancetype)videoWithDict:(NSDictionary *)dict;

@end
