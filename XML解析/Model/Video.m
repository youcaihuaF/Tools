
#import "Video.h"
#import <UIKit/UIKit.h>
@implementation Video

+ (instancetype)videoWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

///  在设置 length 属性的同时，直接计算好时间
///  效率更高！
///  重写了 setter 方法之后，定义属性的 copy 就是摆设了，不会默认进行 copy 操作！
- (void)setLength:(NSNumber *)length {
    // 必须要自己 copy 一下，否则设置数值的时候，不会 copy
    _length = [length copy];
    
    int len = _length.intValue;
    
    self.timeString = [NSString stringWithFormat:@"%02d:%02d:%02d", len / 3600, (len % 3600) / 60, len % 60];
}

///  getter 方法，意味着每次显示那个 cell 都会计算一次
//- (NSString *)timeString {
//    // 根据 length 计算显示的时间
//    int len = self.length.intValue;
//    
//    return [NSString stringWithFormat:@"%02d:%02d:%02d", len / 3600, (len % 3600) / 60, len % 60];
//}

// 好处，一旦更换服务器地址，只需要修改这个宏就行了
#define VIDEO_BASE_URL @"http://192.168.28.3"

- (NSURL *)fullImageURL {
    if (_fullImageURL == nil) {
//        UIWebView *webView = [[UIWebView alloc] init];
//        // 加载图片素材的时候，相对路径
//        webView loadHTMLString:<#(NSString *)#> baseURL:<#(NSURL *)#>
        NSString *urlString = [VIDEO_BASE_URL stringByAppendingPathComponent:self.imageURL];
        
        _fullImageURL = [NSURL URLWithString:urlString];
    }
    return _fullImageURL;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ : %p> { videoId : %@, name : %@ %p, length : %@ %p, videoURL : %@ %p, imageURL : %@, desc : %@, teacher : %@}", [self class], self, self.videoId, self.name, self.name, self.length, self.length, self.videoURL, self.videoURL, self.imageURL, self.desc, self.teacher];
}

@end
