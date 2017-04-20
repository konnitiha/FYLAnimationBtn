//
//  FYLAnimationBtn.m
//  FYLAnimationBtn
//
//  Created by FuYunLei on 2017/4/19.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLAnimationBtn.h"

@implementation FYLAnimationBtn
{
    CAShapeLayer *_layerCircle;
    CAShapeLayer *_layerRight;
    CAShapeLayer *_layerLine;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        if (frame.size.width != frame.size.height) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width);
        }
        
        [self addAnimationPath];
    }
    return self;
}

- (void)addAnimationPath{
    
    CGFloat width = self.frame.size.width;

    //最外圈的圆
    UIBezierPath *pathCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:width/2.0 startAngle:-M_PI + M_PI_2/4 endAngle:M_PI*2 clockwise:YES];
    
    _layerCircle = [[CAShapeLayer alloc] init];
    _layerCircle.fillColor = [UIColor clearColor].CGColor;
    _layerCircle.strokeColor = [UIColor greenColor].CGColor;
    _layerCircle.lineWidth = 3;
    _layerCircle.path = pathCircle.CGPath;
    [self.layer addSublayer:_layerCircle];
    
    //对号
    UIBezierPath *pathRight = [[UIBezierPath alloc] init];
    CGPoint pointOrigin = CGPointMake(width/2 - (width/2)*cos(M_PI_2/4), width/2 - (width/2)*sin(M_PI_2/4));
    [pathRight moveToPoint:pointOrigin];
    CGPoint pointTurn = CGPointMake(width/2 - (width/4)*sin(M_PI_2/3),width/2 + (width/4)*cos(M_PI_2/3));
    [pathRight addLineToPoint:pointTurn];
    CGPoint pointEnd = CGPointMake(width/2 + (width*2/7)*cos(M_PI_4), width/2 - (width*2/7)*sin(M_PI_4));
    [pathRight addLineToPoint:pointEnd];
    
    _layerRight = [[CAShapeLayer alloc] init];
    _layerRight.fillColor = [UIColor clearColor].CGColor;
    _layerRight.strokeColor = [UIColor greenColor].CGColor;
    _layerRight.lineWidth = 3;
    _layerRight.path = pathRight.CGPath;
    
    
    //覆盖对号前面
    UIBezierPath *pathLine = [[UIBezierPath alloc] init];
    CGPoint poinLinetOrigin = CGPointMake(width/2 - (width/2)*cos(M_PI_2/4), width/2 - (width/2)*sin(M_PI_2/4));
    [pathLine moveToPoint:poinLinetOrigin];
    CGPoint pointLineEnd = CGPointMake(width/4 - 3, width/2);
    [pathLine addLineToPoint:pointLineEnd];
    
    _layerLine = [[CAShapeLayer alloc] init];
    _layerLine.fillColor = [UIColor clearColor].CGColor;
    _layerLine.strokeColor = self.backgroundColor.CGColor;
    _layerLine.lineWidth = 5;
    _layerLine.path = pathLine.CGPath;

}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.enabled = NO;
    if (self.isSelected) {
        [self startCircleAnimationWithStart:@1 andEnd:@0];
        [self startRightAnimationWithStart:@0 andEnd:@1];
    }else
    {
        [self startRightAnimationWithStart:@1 andEnd:@0];
        [self startLineAnimationWithStart:@1 andEnd:@0];
    }
}

#pragma mark - AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.isSelected) {
        if (anim.duration == 1) {
            [self startLineAnimationWithStart:@0 andEnd:@1];
            [_layerCircle removeFromSuperlayer];
        }
        if (anim.duration == 0.2) {
            self.enabled = YES;
        }

    }else
    {
        if (anim.duration == 0.2) {
           [self startCircleAnimationWithStart:@0 andEnd:@1];
            [_layerLine removeFromSuperlayer];
        }
        if (anim.duration == 1.2) {
            [_layerRight removeFromSuperlayer];
            self.enabled = YES;
        }
 
    }
    
}
#pragma mark - 执行3个动画
//动画时间1秒
- (void)startCircleAnimationWithStart:(NSNumber *)fromValue andEnd:(NSNumber *)endValue{
    CABasicAnimation *animationCircle = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    animationCircle.delegate = self;
    animationCircle.fromValue = fromValue;
    animationCircle.toValue = endValue;
    animationCircle.duration = 1;
    animationCircle.removedOnCompletion = NO;
    [_layerCircle addAnimation:animationCircle forKey:@"circle"];
    
    [self.layer addSublayer:_layerCircle];
}
//动画时间1.2秒
- (void)startRightAnimationWithStart:(NSNumber *)fromValue andEnd:(NSNumber *)endValue{
    CABasicAnimation *animationRight = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animationRight.delegate = self;
    animationRight.fromValue = fromValue;
    animationRight.toValue = endValue;
    animationRight.duration = 1.2;
    animationRight.removedOnCompletion = NO;
    [_layerRight addAnimation:animationRight forKey:@"right"];
    
    [self.layer addSublayer:_layerRight];
}
//动画时间0.2秒
- (void)startLineAnimationWithStart:(NSNumber *)fromValue andEnd:(NSNumber *)endValue{
    CABasicAnimation *animationLine = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
       animationLine.delegate = self;
    animationLine.fromValue = fromValue;
    animationLine.toValue = endValue;
    animationLine.duration = 0.2;
    animationLine.removedOnCompletion = NO;
    [_layerLine addAnimation:animationLine forKey:@"line"];
    [self.layer addSublayer:_layerLine];
}

@end
