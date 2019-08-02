//
//  GyroscopeViewController.m
//  SensorDemo
//
//  Created by 王双龙 on 2017/7/27.
//  Copyright © 2017年 王双龙. All rights reserved.
//

#import "GyroscopeViewController.h"
#import <CoreMotion/CoreMotion.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@interface GyroscopeViewController ()


@property (nonatomic, strong) CMMotionManager * motionManager;

@property (nonatomic, strong) CMPedometer *stepCounter;

@property (nonatomic, strong) UILabel * textLabel;
@end

@implementation GyroscopeViewController

- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.frame = CGRectMake(20, 120, SCREEN_WIDTH-40, 100);
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:16.f];
        _textLabel.text = @"我们一起来摇一摇";
        
    }
    return _textLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
    
    
    [self createPedometer];
    [self.view addSubview:self.textLabel];
    
//    [self createGyroscope];
}


- (void)createGyroscope{
    
    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/2 + 60, SCREEN_WIDTH/2, 250)];
    
    imageView2.image = [UIImage imageNamed:@"image_1"];
    [self.view addSubview:imageView2];
    
    
    //初始化全局管理对象
    self.motionManager = [[CMMotionManager alloc] init];
    
    //判断陀螺仪是否可用和开启&& [self.motionManager isGyroActive]
    if ([self.motionManager isGyroAvailable] ){
        //更新频率是100Hz
        self.motionManager.gyroUpdateInterval = 0.1;
        //Push方式获取和处理数据
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                        withHandler:^(CMGyroData *gyroData, NSError *error)
         {  //设备在X、Y、Z轴上所旋转的角速度
             NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
             NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
             NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
             
         }];
    }
    
}

#pragma maerk -- 摇一摇

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"开始摇了，坐稳咯");
    self.textLabel.text = @"开始摇了，坐稳咯";
}

-  (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"不摇了，你走吧");
    self.textLabel.text = @"不摇了，你走吧";
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"摇完了，下车吧");
    self.textLabel.text = @"摇完了，下车吧";
}

#pragma mark -- 计步器
- (void)createPedometer{
    
    // 1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable] && ![CMPedometer isDistanceAvailable]) {
        NSLog(@"记步功能不可用");
        self.textLabel.text = @"记步功能不可用";
        return;
    }
    
    // 2.创建计步器对象
    self.stepCounter = [[CMPedometer alloc] init];
    
    // 3.开始计步(走多少步之后调用一次该方法)
    // FromDate : 从什么时间开始计步
    NSDate *date = [NSDate date];
    [self.stepCounter startPedometerUpdatesFromDate:date withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"您一共走了%@步  %@米", pedometerData.numberOfSteps, pedometerData.distance);
        dispatch_sync(dispatch_get_main_queue(), ^{
             self.textLabel.text = [NSString stringWithFormat:@"您一共走了%@步  %@米", pedometerData.numberOfSteps, pedometerData.distance];
        });
    }];
    
    //根据开始和结束时间查询行走相关信息
    //    - (void)queryPedometerDataFromDate:(NSDate )start toDate:(NSDate )end withHandler:(CMPedometerHandler)handler;
    
}



- (void)dealloc{
    [self.motionManager stopGyroUpdates];
    [self.stepCounter stopPedometerUpdates];
    self.motionManager = nil;
    self.stepCounter = nil;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
