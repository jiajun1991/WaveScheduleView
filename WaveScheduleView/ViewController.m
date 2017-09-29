//
//  ViewController.m
//  WaveScheduleView
//
//  Created by 李骏 on 2017/9/28.
//  Copyright © 2017年 Shenzhen Yi Xiang Aged Services Co., LTD. All rights reserved.
//

#import "ViewController.h"
#import "WaveSchedule.h"
@interface ViewController ()
@property (strong ,nonatomic)WaveSchedule *waveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, 30, 150, 30)];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    self.waveView =  [[WaveSchedule alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.waveView.center = self.view.center;
    [self.view addSubview:self.waveView];
    self.waveView.layer.cornerRadius = 100;
    self.waveView.clipsToBounds = YES;
    self.waveView.layer.borderColor = [UIColor colorWithRed:164 / 255.0 green:216 / 255.0 blue:222 / 255.0 alpha:1].CGColor;
    self.waveView.layer.borderWidth = 5;
}
- (void)sliderValueChange:(UISlider *)slider
{
    [self.waveView drawWaterWavePath:slider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
