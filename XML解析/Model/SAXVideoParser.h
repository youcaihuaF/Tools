

#import <Foundation/Foundation.h>

// 面向接口开发
@interface SAXVideoParser : NSObject

/// SAX XML 解析
+ (void)saxParser:(NSXMLParser *)parser completion:(void (^)(NSArray *dataList))completion;

@end
