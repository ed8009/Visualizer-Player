//
//  VisualizerView.h
//  iPodVisualizer
//
//  Created by ed8009 on 06.04.16.
//  Copyright © 2016 Xinrong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface VisualizerView : UIView

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL effectEnable;
//
@end
