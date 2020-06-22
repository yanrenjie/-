//
//  ThreadViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/19.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "ThreadViewController.h"
#import <pthread.h>

@interface ThreadViewController ()

@property(nonatomic, strong)UIImage *image1;
@property(nonatomic, strong)UIImage *image2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end



@implementation ThreadViewController

static NSString *zaza = @"HHHHHH";
NSInteger _jie = 100;
NSString *_jie_name = @"JackeyYan";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    
//    dispatch_queue_t queue = dispatch_queue_create("jackey yan", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue, ^{
//        NSLog(@"jjjjjjdajf;dkjf");
//    });
//
//    NSLog(@"111111111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self compositePicture];
}


- (IBAction)pthread:(id)sender {
    // 1 倒入函数库
    pthread_t thread = nil;
    /**
     参数：
     1:线程
     2:线程属性：
     3:线程要执行的方法名称
     4:线程要执行的方法的参数
     */
    pthread_create(&thread, NULL, runAction, "Hello, Thread");
}

void * _Nullable runAction(void * _Nullable string) {
    NSLog(@"%s", string);
    for (int i = 0; i < 100000; i++) {
        NSLog(@"%@  --------  %d", [NSThread currentThread], i);
    }
    return NULL;
}


- (IBAction)NSThread:(id)sender {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(nsthreadRun:) object:@[@1, @2]];
    [thread start];
}


- (void)nsthreadRun:(id)t {
    NSLog(@"%@", t);
    for (int i = 0; i < 100000; i++) {
        NSLog(@"%@  --------  %d", [NSThread currentThread], i);
    }
}

- (IBAction)GCD:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100000; i++) {
            NSLog(@"%@  --------  %d", [NSThread currentThread], i);
        }
    });
}

- (IBAction)NSOptation:(id)sender {
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    // 确定队列是并行的还是串行的，当最大为1时，标示是串行队列，当大于1时，标示是并行队列
    queue1.maxConcurrentOperationCount = 3;
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"%@  --------  %d", [NSThread currentThread], i);
        }
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"%@  ++++  %d", [NSThread currentThread], i);
        }
    }];
    // 添加依赖关系，只有等operation2的任务执行完了，才开始执行operation1
    [operation1 addDependency:operation2];
    [queue1 addOperation:operation1];
    [queue1 addOperation:operation2];
    // 相当于栅栏函数，以下内容要等queue1队列的任务都执行完了，才能执行其他队列的任务，相当于同步
    [queue1 waitUntilAllOperationsAreFinished];
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"%@  <-------->  %d", [NSThread currentThread], i);
        }
    }];
    [queue2 addOperation:operation3];
}

- (void)addLock {
    // 为代码添加同步锁
    // token:锁对象（必须使用全局变量）,建议直接使用self
    // {} 要加锁的代码
    // 注意点：加多把锁无效，注意加锁的位置
    @synchronized (self) {
        
    }
}


// 特别h注意主队列中开同步串行队列会发生死锁
- (void)test {
    // DISPATCH_QUEUE_SERIAL
    // DISPATCH_QUEUE_CONCURRENT
//    dispatch_queue_t queue = dispatch_queue_create("jackey", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_queue_create("jackey", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    
    dispatch_queue_t main = dispatch_get_main_queue();
//    dispatch_sync(main, ^{
//        NSLog(@"121212121");
//    });
    dispatch_async(main, ^{
        NSLog(@"11111");
    });
    dispatch_async(main, ^{
        NSLog(@"22222");
    });
    dispatch_async(main, ^{
        NSLog(@"333333");
    });dispatch_async(main, ^{
        NSLog(@"44444");
    });
}


// 以前当有多个任务，多个队列的时候，需要等任务执行完毕之后，才开始执行某个操作的做法是要使用
// 需求：有一个对列有3个任务，另一个队列有两个任务，现在需要等这些任务都执行完毕之后，执行一个打印操作，打印“所有任务都执行完了”；
// 实现方案1：可以直接使用栅栏函数进行拦截，等任务都执行完了，完后再栅栏函数中进行打印操作；
// 实现方案2: 任务组，进行监听通知
- (void)notify1 {
    // 创建一个任务组
    dispatch_group_t group = dispatch_group_create();
    // 创建一个并发队列1
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    // 创建一个并发队列2
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    // 包装任务
    dispatch_group_async(group, queue1, ^{
        NSLog(@"1111----------%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue1, ^{
        NSLog(@"2222----------%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue1, ^{
        NSLog(@"3333----------%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"4444----------%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"5555----------%@", [NSThread currentThread]);
    });
    
    // 通知
    // 参数1: 表示那个group里面的任务执行之后然后执行通知里面的block
    // 参数2: 表示通知中要执行的block在哪个队列中执行，可以在queue1，也可以在queue2中，当然也可以在主队列中，或其他队列中
    // block：表示以上任务执行完毕之后，应该做的操作
    dispatch_group_notify(group, queue1, ^{
        NSLog(@"所有的任务都已经执行完毕了，你可以在这儿做你要做的处理");
    });
}


// 以前监听多个任务执行完毕之后，然后再做其他逻辑处理的方法
// dispatch_group_enter(group); 和dispatch_group_leave(group);是成对出现的
- (void)notify2 {
    // 创建一个任务组
    dispatch_group_t group = dispatch_group_create();
    // 创建一个并发队列1
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    
    
    
    // dispatch_group_enter之后的任务会被队列组监听
    dispatch_group_enter(group);
    // 包装任务
    dispatch_async(queue1, ^{
        NSLog(@"111111");
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue1, ^{
        NSLog(@"222222");
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue1, ^{
        NSLog(@"3333333");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue1, ^{
        NSLog(@"所有任务都执行完毕了");
    });
}


// 下载两张图片，然后合成显示
- (void)compositePicture {
    // 创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("downloadImage", DISPATCH_QUEUE_CONCURRENT);
    
    // 下载任务一
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"http://image2.sina.com.cn/lx/fa/p/2006/1016/U1562P8T1D309353F913DT20061016104508.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:data];
    });
    // 下载任务二
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"http://img.soufunimg.com/news/2008_08/14/rent/1218675598093_000.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image2 = [UIImage imageWithData:data];
    });
    
    // 合成图片并进行显示
    dispatch_group_notify(group, queue, ^{
        // 开启一个图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        
        [self.image1 drawInRect:CGRectMake(0, 0, 150, 300)];
        [self.image2 drawInRect:CGRectMake(150, 0, 150, 300)];
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = newImage;
        });
    });
}


#pragma mark - GCD定时器
- (void)GCD_Timer {
    // 参数1: 指定source类型为定时器类型
    // 参数4: 指定定时执行的任务在哪个队列中进行
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    // 参数3: 间隔执行时间
    // 参数4: 精准度
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"这儿就是定时执行的任务");
    });
    // 启动定时器
    dispatch_resume(timer);
    
    
    // 如果直接调用这个方法，会不执行定时器任务，因为定时器对象是局部变量，方法执行完毕后都释放了，所以需要一个属性强引用
    // self.timer = timer;
}


@end
