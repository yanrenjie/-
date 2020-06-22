//
//  NSURLSessionViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/22.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "NSURLSessionViewController.h"
#import "SchoolModel.h"

@interface NSURLSessionViewController ()<NSXMLParserDelegate>

@end

@implementation NSURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 将json数据解析为OC对象
//    [self jsonToObjective_CObject];
    // 将OC对象序列化为JSON数据
//    [self OCObjectToJSON];
    // XML 解析
    [self xmlParser];
}

// NSURLSesstion使用步骤
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self postMethod];
}


// 发送一个GET请求
- (void)getMethod {
    // 1、确认请求路径
    NSURL *url = [NSURL URLWithString:@"https://github.com/search?q=PNChart&type=Repositories"];
    
    // 2、创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3、创建会话对象session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4、根据会话对象创建请求任务Task
    // 参数1: 请求对象
    // 参数2: 完成后的回调
    // data：响应体
    // response：响应头
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data =======   %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response ===   %@", response);
    }];
    
    // 5、执行发送请求
    [task resume];
}


- (void)postMethod {
    NSURL *url = [NSURL URLWithString:@"https://github.com/search"];
    // 创建一个可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"q=PNChart&type=Repositories" dataUsingEncoding:NSUTF8StringEncoding];
    // 创建一个NSURLSession
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data =======   %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response ===   %@", response);
    }];
    [task resume];
}


#pragma mark - JSON 解析
- (void)jsonToObjective_CObject {
    // 首先读取一个本地的JSON文件，JSON的最外层是数组，但是这里开始并不能用数组进行接受
    // 先读取二进制数据流
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"school" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    // 然后进行解析
    // NSJSONReadingMutableContainers 可变容器接受
    // NSJSONReadingMutableLeaves 可变字符串
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    
    // 字典转模型
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        SchoolModel *model = [SchoolModel schoolWithDict:dict];
        [tempArray addObject:model];
    }
    
    NSLog(@"这里是模型数据：%@", tempArray);
}


- (void)OCObjectToJSON {
    NSDictionary *dict = @{
        @"name" : @"清华大学",
        @"province" : @"北京市",
        @"id" : @10000001,
        @"city" : @"北京市",
        @"collages" : @[
            @"计算机学院",
            @"土木工程学院",
            @"外语学院",
            @"金融学院",
            @"国际关系学院",
            @"科学学院"
        ]
    };
    
    // 将字典转化为json数据，并且写到document文件夹下
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    // 获取要写到的位置的路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"collage.json"];
    [jsonData writeToFile:filePath atomically:YES];
//    NSLog(@"%@", filePath);
    
    // 查看转化后的json数据的格式
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", jsonString);
}


#pragma mark - XML 解析
- (void)xmlParser {
    // XML 解析分为DOM解析和SAX解析
    // DOM解析是一次性把所有的文件同时加载到内存当值，适合解析小文件
    // SAX接受是逐级一个元素一个元素解析，解析大文件就用SAX，苹果原生的XML解析NSXMLParser就是采用的SAX解析方式
    // GDataXML:DOM解析方法，是一个有Google开发的基于libxml2的DOML解析方式的三方库
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"school" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:filePath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    parser.delegate = self;
    // 下面这个方法是阻塞式的，需要等解析代理方法都执行完了，然后才能走后面的代码
    [parser parse];
    
    // 回到主线程，然后刷新数据，因为上面的阻塞式的解析，所以到这儿的时候，一定有数据
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       // 刷新表哥数据
        
    }];
}

#pragma mark - NSXMLParserDelegate
// 开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"开始解析数据");
}

// 这个方法会调用很多次
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    NSLog(@"开始解析%@这个元素，它的值为%@\n", elementName, attributeDict);
    
    // attributeDict包含里所需要的数据字典，然后通过字典转模型，保存到数组中
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"%@这个元素解析完毕", elementName);
}

// 解析完毕
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"解析完毕");
}

@end
