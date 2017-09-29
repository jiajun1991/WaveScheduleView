//
//  WaveSchedule.m
//  WaveScheduleView
//
//  Created by 李骏 on 2017/9/28.
//  Copyright © 2017年 Shenzhen Yi Xiang Aged Services Co., LTD. All rights reserved.
//

#import "WaveSchedule.h"
@interface WaveSchedule()
@property (strong ,nonatomic)CADisplayLink *displayLink;
@property (strong ,nonatomic)CAShapeLayer *waveLayer;
@property (assign ,nonatomic)CGFloat percent;
//使用波形曲线y=Asin(ωx+φ)+k进行绘制
@property (assign ,nonatomic)CGFloat zoomY;// 波纹振幅A
@property (assign ,nonatomic)CGFloat translateX;// 波浪水平位移 Φ
@property (assign ,nonatomic)CGFloat currentWavePointY;// 波浪当前的高度 k
@property (assign ,nonatomic)BOOL flag;
@end
@implementation WaveSchedule
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.zoomY = 1.0f;
        self.flag = NO;
    }
    return self;
}

- (void)drawWaterWavePath:(CGFloat)percent
{
    self.percent = percent;
    
    [self resetProperty];
    [self resetLayer];
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    // 启动同步渲染绘制波纹
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setCurrentWave:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
//绘制波纹
- (void)setCurrentWave:(CADisplayLink *)displayLink
{
    self.translateX += 0.1;
    if (!self.flag)
    {
        self.zoomY += 0.02;
        if (self.zoomY >= 1.5)
        {
            self.flag = YES;
        }
    }
    else
    {
        self.zoomY -= 0.02;
        if (self.zoomY <= 1.0)
        {
            self.flag = NO;
        }
    }
    [self setCurrentWaveLayerPath];
}
- (void)setCurrentWaveLayerPath
{
    // 通过正弦曲线来绘制波浪形状
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.currentWavePointY)];
    CGFloat y= 0.0f;
    CGFloat width = CGRectGetWidth(self.frame);
    for (float x = 0.0f; x <= width; x++)
    {
        // 正弦波浪公式
        y = self.zoomY * sin(x / 180 * M_PI - 4 * self.translateX / M_PI)*5 + self.currentWavePointY;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.currentWavePointY)];
    [path closePath];
    self.waveLayer.path = path.CGPath;
}

- (void)stopWave
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)resetProperty
{
    // 重置属性
    self.currentWavePointY = CGRectGetHeight(self.frame) * (1-self.percent);
}
- (void)resetLayer
{
    // 动画开始之前重置layer
    if (!self.waveLayer){
        self.waveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.waveLayer];
        self.waveLayer.fillColor = [UIColor colorWithRed:164 / 255.0 green:216 / 255.0 blue:222 / 255.0 alpha:1].CGColor;
    }
   
}
@end
