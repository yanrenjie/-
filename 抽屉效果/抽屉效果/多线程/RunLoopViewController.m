//
//  RunLoopViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/22.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@property(nonatomic, strong)NSThread *thread;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)test1 {
    // 开启一个子线程
    [self performSelectorInBackground:@selector(test2) withObject:nil];
}


- (void)test2 {
    // 在子线程里面开启了一个定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // 子线程里面的定时器需要自己手动开启一个runloop
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop run];
}

- (void)run {
    NSLog(@"%s", __FUNCTION__);
}


- (void)runloopObserver {
    /*
    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
        kCFRunLoopEntry = (1UL << 0),             // 即将进入runloop
        kCFRunLoopBeforeTimers = (1UL << 1),        //即将处理timer
        kCFRunLoopBeforeSources = (1UL << 2),    // 即将处理source
        kCFRunLoopBeforeWaiting = (1UL << 5),    // 即将进入休眠
        kCFRunLoopAfterWaiting = (1UL << 6),        // 刚从休眠中唤醒
        kCFRunLoopExit = (1UL << 7),                // 即将推出runloop
        kCFRunLoopAllActivities = 0x0FFFFFFFU
    };
     */

    // 参数1: 分配内存，不知道如何分配，使用默认的分配方式
    // 参数2: 要监听的状态
    // 创建一个observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        // 根据状态作出对应的处理
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"刚从休眠中唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"即将推出runloop");
                break;
                
            default:
                break;
        }
    });
    
    // 参数1:要监听哪一个runloop对象
    // 参数2：哪个监听者去监听
    // 在那种模式下进行监听
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
    
    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
}



#pragma mark - 开启一条常驻线程
// 使用runloop开启一条常驻线程
// 说明：当点击一个按钮的时候，创建一个线程，让线程执行一个方法run1, 当点击另外一个按钮的时候，让之前开启的线程继续执行任务
// 线程都是在执行完任务之后就进入死亡状态，不能在重新开启, 不论线程是否是强引用，只要没有source事件或者timer事件，执行完任务就挂掉了
- (IBAction)createThread:(id)sender {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1) object:nil];
    self.thread = thread;
    [thread start];
}

// 让之前创建的线程继续执行run2任务
- (IBAction)continueWork:(id)sender {
    // 解决方式1：失败，因为线程已死亡
    // [self.thread start]; //重新启动一个死亡的线程，不行
    
     [self performSelector:@selector(run2) onThread:self.thread withObject:nil waitUntilDone:YES];
}


- (void)run1 {
    NSLog(@"run1----------%@", [NSThread currentThread]);
    
    // 解决方式2: 失败，因为while死循环执行不完，此线程永远不能执行接下来的其他任务；
    // 开启一个死循环让线程或者，也不可行，因为当前线程上的任务执行不完，以后不能再继续让这个线程做其他的事，只能做当前的死循环
//    while (1) {
//
//    }
    
    // 解决方式3: 成功：添加一个timer事件，因为有timer事件，所以线程会一直存活下来，但是这个方式不好，多了让定时器工作，虽然可行，但不推荐
    // [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run3) userInfo:nil repeats:YES];
    
    // 解决方式4: 成功：添加一个source，port端口事件，因为有source事件，所以线程也会一直存活下来
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    // 自己创建的runloop，需要自己开启
    [runloop run];
    
    NSLog(@"因为runloop一直存在，这里的代码将一直不执行");
}

// 让常驻线程继续干活
- (void)run2 {
    NSLog(@"run2-----------%@", [NSThread currentThread]);
}

// 定时器事件
- (void)run3 {
    NSLog(@"run3-----------这个是定时器干的活，不是runloop执行的线程干的活");
}


@end
