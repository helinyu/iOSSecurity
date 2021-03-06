//
//  ShareLayerView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ShapeLayerView.h"

@interface ShapeLayerView()<CAAnimationDelegate>
{
    UIBezierPath    *_path;
}

@property (strong, nonatomic) CAShapeLayer *progressLayer;

@end

#define Screen_width [[UIScreen mainScreen] bounds].size.width
const CGFloat LayerHeight = 20.0f;
const CGFloat PistionY = 100.0f;

@implementation ShapeLayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, LayerHeight)];
        backView.backgroundColor = [UIColor greenColor];
        [self addSubview:backView];
        
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointMake(0,PistionY+10)];
        [_path addLineToPoint:CGPointMake(Screen_width,PistionY+10)];

        self.backgroundColor = [UIColor grayColor];
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.path = _path.CGPath;
        progressLayer.strokeColor = [[UIColor redColor] CGColor];
        progressLayer.fillColor = [[UIColor clearColor] CGColor];
        progressLayer.lineWidth = LayerHeight;
        progressLayer.strokeEnd = 0.0f;
        _progressLayer = progressLayer;
        [self.layer addSublayer:progressLayer];
        
        [self renderProgress];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            progressLayer.strokeEnd = 1.0f;
        });
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    //create path
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
//    
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;// 填充空区域，笔画中油连带，有弯曲的地方就会填充颜色
//    shapeLayer.lineWidth = 20;
//    shapeLayer.lineJoin = kCALineJoinMiter; // 也即是斜接的时候是接着的（两个线段之间的关系）
//    shapeLayer.lineCap = kCALineCapRound; //  设置角是圆的
//    shapeLayer.path = path.CGPath;
//    shapeLayer.miterLimit = 0;
//    
//    UIBezierPath *namePath = [UIBezierPath new];
//    [namePath moveToPoint:CGPointMake(20, 200)];
//    [namePath addLineToPoint:CGPointMake(60, 200)];
//    [namePath moveToPoint:CGPointMake(20, 200)];
//    [namePath addLineToPoint:CGPointMake(20, 350)];
//    [namePath moveToPoint:CGPointMake(20, 260)];
//    [namePath addLineToPoint:CGPointMake(55, 260)];
//    // F
//    
//    // E
//    [namePath moveToPoint:CGPointMake(80, 260)];
//    [namePath addLineToPoint:CGPointMake(130, 260)];
//    [namePath addArcWithCenter:CGPointMake(100, 260) radius:30.0f startAngle:0 endAngle:((M_PI/8)-(M_PI*2)) clockwise:false];
//// 这里需要上下翻转一下
//    
//    // L
//    [namePath moveToPoint:CGPointMake(140, 200)];
//    [namePath addLineToPoint:CGPointMake(140, 350)];
//    [namePath addLineToPoint:CGPointMake(210, 350)];
//    
//    // I
//    [namePath moveToPoint:CGPointMake(220, 200)];
//    [namePath addLineToPoint:CGPointMake(220, 350)];
//    
//    // X
//    [namePath moveToPoint:CGPointMake(230, 200)];
//    [namePath addLineToPoint:CGPointMake(280, 350)];
//    [namePath moveToPoint:CGPointMake(280, 200)];
//    [namePath addLineToPoint:CGPointMake(230, 350)];
//    
//    
//    CAShapeLayer *nameLayer = [CAShapeLayer layer];
//    nameLayer.strokeColor = [UIColor blueColor].CGColor;
//    nameLayer.fillColor = [UIColor clearColor].CGColor;
//    nameLayer.lineWidth = 5.0f;
//    nameLayer.lineCap = kCALineCapSquare;
//    nameLayer.lineJoin = kCALineJoinMiter;
//    nameLayer.path = namePath.CGPath;
//    
////    self.progressLayer.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 20);
////    self.progressLayer.strokeColor = [UIColor redColor].CGColor;
////    self.progressLayer.fillColor = [UIColor greenColor].CGColor;
////    [self.layer addSublayer:self.progressLayer];
//    
////    [self.layer addSublayer:nameLayer];
//
//    //add it to our view
////    [self.layer addSublayer:shapeLayer];
//}

- (void)renderProgress {
       CABasicAnimation* strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration = 3.0;
        strokeEndAnimation.fromValue = @(0.0);
        strokeEndAnimation.toValue = @(1.0);
        strokeEndAnimation.autoreverses = NO;
        strokeEndAnimation.repeatCount = 0.0f;
        strokeEndAnimation.delegate = self;
        [_progressLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}


/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
//    NSLog(@"animationDidStart");
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
//    NSLog(@"animationDidStop");
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    self.progressLayer.strokeEnd = 1.0f;
//    [CATransaction setDisableActions:NO];
//    [CATransaction commit];

}

@end

/*

CAShapeLayer ： 这个类是关于绘制图形的图层；
和UIBizerPath有很强的关系，也就是有关的内容；（通过贝塞尔曲线来绘制对应的曲线内容）
 @property(nullable) CGPathRef path; // 绘制的路径
 @property(nullable) CGColorRef fillColor; // 填充的颜色，空缺就会填充
 @property(copy) NSString *fillRule; // 填充路径的规则
 CA_EXTERN NSString *const kCAFillRuleNonZero
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString *const kCAFillRuleEvenOdd
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 @property(nullable) CGColorRef strokeColor; // 插入颜色【彩色】（而不是填充）【注意插入颜色和填充颜色的区别】
 
 @property CGFloat strokeStart; // 彩色的开始
 @property CGFloat strokeEnd;  // 彩色的结束
 
 @property CGFloat lineWidth; // 线条的宽度
 
 @property CGFloat miterLimit; // 路径上衔接的处理
 
 @property(copy) NSString *lineCap; // 选装的角度
CA_EXTERN NSString *const kCALineCapButt
CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
CA_EXTERN NSString *const kCALineCapRound
CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
CA_EXTERN NSString *const kCALineCapSquare
CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 @property(copy) NSString *lineJoin; // 线条的拼接
  CA_EXTERN NSString *const kCALineJoinMiter
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString *const kCALineJoinRound
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString *const kCALineJoinBevel
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 @property CGFloat lineDashPhase; //默认是0
 @property(nullable, copy) NSArray<NSNumber *> *lineDashPattern;
 
 https://zsisme.gitbooks.io/ios-/content/chapter6/cashapelayer.html
 参考的链接
 
 CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。 
 也即是-矢量而不是标量像素的内容
 

*/
