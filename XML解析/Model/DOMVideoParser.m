//  Created by teacher on 15/3/30.
//  Copyright (c) 2015年
//

#import "DOMVideoParser.h"
#import "GDataXMLNode.h"
#import "Video.h"

@implementation DOMVideoParser

+ (NSArray *)gdataParser:(NSData *)data {
    
    // 1. 实例化 GDataXMLDocument
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:NULL];
    
    //    NSLog(@"%@ - %tu", doc.rootElement.children, doc.rootElement.childCount);
    
    // -1. - 目标：得到一个 video 的数组
    NSMutableArray *videos = [NSMutableArray array];
    
    // 2. 遍历所有的子节点，每一个子节点，对应一个 video 对象的信息
    for (GDataXMLElement *element in doc.rootElement.children) {
        NSLog(@"%@", element);
        
        // -2. - 新建一个 video 对象
        Video *v = [[Video alloc] init];
        
        // 添加到数组 － 没有影响！
        [videos addObject:v];
        
        // 继续遍历所有的子节点 － 可以获得属性
        for (GDataXMLElement *property in element.children) {
            NSLog(@"%@ - %@", property.name, property.stringValue);
            
            // -3.- 通过 KVC 设置对象数值
            // KVC forKeyPath 键值路径 myTeacher.name
            // forKey 键值，设置直接属性 name, length
            [v setValue:property.stringValue forKeyPath:property.name];
        }
        
        for (GDataXMLNode *attr in element.attributes) {
            NSLog(@"==> %@ - %@", attr.name, attr.stringValue);
            
            // -4.- 通过 KVC 设置对象属性字典中的属性
            [v setValue:attr.stringValue forKeyPath:attr.name];
        }
        
        // -5.- 添加到数组
        //        [videos addObject:v];
    }
    
    return videos.copy;
}

@end
