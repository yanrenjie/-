//
//  MineViewController.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/29.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "MineViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MineViewController ()<CBPeripheralManagerDelegate>

@property(nonatomic, strong)AVCaptureSession *session;
@property(nonatomic, strong)CBPeripheralManager *manager;
@property(nonatomic, strong)dispatch_queue_t queue;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = dispatch_queue_create("com.jackey.yan", DISPATCH_QUEUE_CONCURRENT);
    CBPeripheralManager *manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:self.queue];
    self.manager = manager;
}


- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    /**
     CBManagerStateUnknown = 0,
     CBManagerStateResetting,
     CBManagerStateUnsupported,
     CBManagerStateUnauthorized,
     CBManagerStatePoweredOff,
     CBManagerStatePoweredOn,
     */
    switch (peripheral.state) {
        case CBManagerStateUnknown:
            NSLog(@"CBManagerStateUnknown");
            break;
            
        case CBManagerStateResetting:
        NSLog(@"CBManagerStateResetting");
        break;
            
        case CBManagerStateUnsupported:
        NSLog(@"CBManagerStateUnsupported");
        break;
            
        case CBManagerStateUnauthorized:
        NSLog(@"CBManagerStateUnauthorized");
        break;
            
        case CBManagerStatePoweredOff:
        NSLog(@"CBManagerStatePoweredOff");
        break;
            
        case CBManagerStatePoweredOn:
        NSLog(@"CBManagerStatePoweredOn");
        break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //语音播报

//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"床前明月光，疑是地上霜。"];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"hello, how`s the weather like today? Let`s go to swimming, how do you think"];
    
    utterance.pitchMultiplier = 0.8;

    //中式发音

//    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];

    //英式发音

    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    utterance.voice = voice;

    NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);

    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];

    [synth speakUtterance:utterance];
}

@end
