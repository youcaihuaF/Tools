

#import "SAXVideoParser.h"
#import "Video.h"

@interface SAXVideoParser() <NSXMLParserDelegate>
// MARK: - XML 解析需要的素材
// 1. 目标数组
@property (nonatomic, strong) NSMutableArray *videos;
// 2. 当前正在解析的对象
@property (nonatomic, strong) Video *currentVideo;
// 3. 拼接的节点字符串
@property (nonatomic, strong) NSMutableString *elementString;

@property (nonatomic, copy) void (^completionBLock)(NSArray *);
@end

@implementation SAXVideoParser

+ (void)saxParser:(NSXMLParser *)parser completion:(void (^)(NSArray *))completion {

    SAXVideoParser *p = [[self alloc] init];
    
    /**
     类似的概念：通知一定先注册，再执行后续的方法
     */
    // 记录块代码
    p.completionBLock = completion;

    parser.delegate = p;
    // 注意：parse 会一直到解析完成
    [parser parse];
    
    NSLog(@"come here");
}

// MARK: - <NSXMLParserDelegate>
// 1. 打开文档
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"1. 打开文档");
    
    // 清除数组 - 为了保证能够多次解析
    [self.videos removeAllObjects];
}

// 2. 开始节点 - "Element" 元素 节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    NSLog(@"2. 开始节点 %@ %@", elementName, attributeDict);
    
    // 判断是否是 video，如果是新建一个 video 对象，并且设置 videoId 的属性
    if ([elementName isEqualToString:@"video"]) {
        self.currentVideo = [[Video alloc] init];
        
        // 设置 videoId 属性
        self.currentVideo.videoId = @([attributeDict[@"videoId"] intValue]);
    }
    
    // 清空节点内容
    [self.elementString setString:@""];
}

// 3. 发现节点的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"==> %@", string);
    // 拼接内容
    [self.elementString appendString:string];
}

// 4. 结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSLog(@"4. 结束节点 %@", elementName);
    
    // 如果是 video，添加到数组
    if ([elementName isEqualToString:@"video"]) {
        [self.videos addObject:self.currentVideo];
    } else if (![elementName isEqualToString:@"videos"]) {
        // KVC 设置数值
        // KVC 是一种间接设置数值的技术，被称为 cocoa 的大招！
        [self.currentVideo setValue:self.elementString forKey:elementName];
    }
}

// 5. 结束文档
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"5. 结束文档 %@", [NSThread currentThread]);
    
    // 主线程更新UI
    if (self.completionBLock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBLock([self.videos copy]);
        });
    }
}

// MARK: - 懒加载
- (NSMutableArray *)videos {
    if (_videos == nil) {
        _videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (NSMutableString *)elementString {
    if (_elementString == nil) {
        _elementString = [[NSMutableString alloc] init];
    }
    return _elementString;
}

@end
