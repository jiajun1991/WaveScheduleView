//
//  WaveSchedule.h
//  WaveScheduleView
//
//  Created by 李骏 on 2017/9/28.
//  Copyright © 2017年 Shenzhen Yi Xiang Aged Services Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveSchedule : UIView
//根据进度的百分比来改变水波纹
- (void)drawWaterWavePath:(CGFloat)percent;
@end
