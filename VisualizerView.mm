//
//  VisualizerView.m
//  iPodVisualizer
//
//  Created by ed8009 on 06.04.16.
//  Copyright © 2016 Xinrong Guo. All rights reserved.
//

#import "VisualizerView.h"
#import "MeterTable.h"

@implementation VisualizerView {
    CAEmitterLayer *emitterLayer;
    MeterTable meterTable;
    CGFloat width;
    CGFloat height;

}

+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        emitterLayer = (CAEmitterLayer *)self.layer;
        
        //
        width = MAX(frame.size.width, frame.size.height);
        height = MIN(frame.size.width, frame.size.height);

        emitterLayer.emitterPosition = CGPointMake(width/2, height/2);
        emitterLayer.emitterSize = CGSizeMake(width-80, 60);
        emitterLayer.emitterShape = kCAEmitterLayerRectangle;
        emitterLayer.renderMode = kCAEmitterLayerAdditive;
        
        
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.name = @"cell";
        CAEmitterCell *childCell = [CAEmitterCell emitterCell];
        childCell.name = @"childCell";
        childCell.lifetime = 1.0f / 60.0f;
        childCell.birthRate = 60.0f;
        childCell.velocity = 0.0f;
        childCell.contents = (id)[[UIImage imageNamed:@"particleTexture.png"] CGImage];
        
        cell.emitterCells = @[childCell];
        // color
        cell.color = [[UIColor colorWithRed:1.0f green:0.3f blue:0.0f alpha:0.8f] CGColor];
        cell.redRange = 1.0f;
        cell.greenRange = 1.0f;
        cell.blueRange = 1.0f;
        cell.alphaRange = 0.5f;
        
        // speed
        cell.redSpeed = 0.11f;
        cell.greenSpeed = 0.07f;
        cell.blueSpeed = -0.25f;
        cell.alphaSpeed = 0.15f;
        
        // scale
        cell.scale = 0.2f;
        cell.scaleRange = 1.5f;
        
        // time
        cell.lifetime = 1.0f;
        cell.lifetimeRange = .25f;
        cell.birthRate = 80;
        
        // 8
        cell.velocity = 100.0f;
        cell.velocityRange = 300.0f;
        cell.emissionRange = M_PI * 2;
        
        // 9
        emitterLayer.emitterCells = @[cell];
        CADisplayLink *dpLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [dpLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        NSLog(@"update");

    }
    return self;
}

- (void)update
{
    float scale = 0.3;
    if (_audioPlayer.playing )
    {
        [_audioPlayer updateMeters];
    
        float power = 0.0f;
        for (int i = 0; i < [_audioPlayer numberOfChannels]; i++) {
            power += [_audioPlayer averagePowerForChannel:i];
        }
        power /= [_audioPlayer numberOfChannels];

        float level = meterTable.ValueAt(power);
        scale = level * 5;
        NSLog(@"power: %f", level);

    }
    emitterLayer.scale = scale;

    if (self.effectEnable) {
        emitterLayer.emitterSize = CGSizeMake(5, 5);
    }
    else {
        emitterLayer.emitterSize = CGSizeMake(width, 60);
    }


}

@end