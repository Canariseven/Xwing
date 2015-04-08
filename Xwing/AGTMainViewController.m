//
//  AGTMainViewController.m
//  Xwing
//
//  Created by Carmelo Ruymán Quintana Santana on 6/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTMainViewController.h"

@interface AGTMainViewController ()

@end

@implementation AGTMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Creamos un detector de Tap
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    // Lo añadimos
    [self.view addGestureRecognizer:pan];
    self.deathStar.hidden = YES;
    [self startScene];
    
    
}
-(void)startScene{
    self.spaceView.image = [UIImage imageNamed:@"saiUfL2.png"];
    self.spaceView.alpha = 0.5;
    self.space2View.image = [UIImage imageNamed:@"space.jpg"];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:200];
    animation.duration = 2.0f;
    animation.repeatCount = INFINITY;
    [self.spaceView.layer addAnimation:animation forKey:@"SpinAnimation"];
    [self moveSpaceShip];
    
    
}
-(void)moveSpaceShip{
    [self.xwingView.layer removeAllAnimations];
    
    [UIView animateWithDuration:4
                          delay:0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         self.xwingView.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width -150, -20);
                         self.xwingView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                     } completion:nil];
}

-(void)didTap:(UITapGestureRecognizer *)tap{
        [self.view removeGestureRecognizer:tap];
    [self endSpaceJump];
    
    
}
-(void)didPan:(UITapGestureRecognizer *)pan{
    // Creamos un detector de Tap
    [self.view removeGestureRecognizer:pan];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    // Lo añadimos
    [self.view addGestureRecognizer:tap];
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut |
    UIViewAnimationOptionBeginFromCurrentState;
    //Traslación
    [UIView animateWithDuration:0.8
                          delay:0.3
                        options: options
                     animations:^{
                         self.xwingView.center = CGPointMake(self.view.center.x-self.view.frame.size.width/4, self.view.center.y);
                         [self changeAlpha];
                     } completion:^(BOOL finished){
                         [self rotateSpace];
                     }];
    // Rotación
    // Rotación
    
}
-(void)endSpaceJump{
    //    [self.xwingView.layer removeAllAnimations];
    self.deathStar.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.deathStar.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width, 0);
    self.deathStar.hidden = NO;
    [self.spaceView.layer removeAllAnimations];
    self.space2View.image = [UIImage imageNamed:@"jumpSpace.jpg"];
    self.space2View.contentMode = UIViewContentModeScaleAspectFill;
    [UIView animateWithDuration:0.4
                          delay:0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.spaceView.alpha = 0;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:10
                                               delay:0
                                             options: UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              self.space2View.transform = CGAffineTransformMakeTranslation(300, 0);
                                          } completion:^(BOOL finished){
                                              
                                          }];
                     }];
    [UIView animateWithDuration:10
                          delay:0
                        options: 0
                     animations:^{
                         self.deathStar.transform = CGAffineTransformMakeTranslation(0, 0);
                         self.deathStar.transform = CGAffineTransformMakeScale(1.8, 1.8);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:4
                                               delay:0
                                             options: 0
                                          animations:^{
                                              
                                              self.xwingView.frame = CGRectMake(50, 100, 0, 0);
                                          } completion:^(BOOL finished) {
                                              
                                              [UIView animateWithDuration:4
                                                                    delay:0
                                                                  options: 0
                                                               animations:^{
                                                                   
                                                                   self.deathStar.transform = CGAffineTransformMakeScale(4, 4);
                                                                   self.view.alpha = 0;
                                                               } completion:^(BOOL finished) {
                                                                   
                                                                   
                                                               }];
                                              
                                          }];
                     }];
    
    
}
-(void)changeAlpha{
    [UIView animateWithDuration:0
                          delay:0
                        options: 0
                     animations:^{
                         self.xwingView.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                     }];
}
-(void)rotateSpace{
    [UIView animateWithDuration:0.4
                          delay:0
                        options: 0
                     animations:^{
                         self.spaceView.alpha = 0;
                         self.space2View.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.spaceView.image = [UIImage imageNamed:@"black-hole.jpg"];
                         self.xwingView.image = [UIImage imageNamed:@"xwingBehind.png"];
                         [UIView animateWithDuration:1
                                               delay:0
                                             options: 0
                                          animations:^{
                                              self.spaceView.alpha = 1;
                                              self.xwingView.alpha = 1;
                                              self.space2View.alpha = 1;
                                          } completion:^(BOOL finished) {

                                              [self.spaceView.layer removeAllAnimations];
                                              if ([self.spaceView.layer animationForKey:@"SpinAnimation"] == nil){
                                                  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                                                  animation.fromValue = [NSNumber numberWithFloat:0.0f];
                                                  animation.toValue = [NSNumber numberWithFloat:2*M_PI];
                                                  animation.duration = 2.0f;
                                                  animation.repeatCount = INFINITY;
                                                  [self.spaceView.layer addAnimation:animation forKey:@"SpinAnimation"];
                                              }
                                          }];
                     }];
    
}
@end
