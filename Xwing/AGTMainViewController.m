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
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    // Lo añadimos
    [self.view addGestureRecognizer:tap];



}

-(void)didTap:(UITapGestureRecognizer *)tap{
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut |
    UIViewAnimationOptionBeginFromCurrentState;
    
    [UIView animateWithDuration:0.8
                          delay:0.3
                        options: options
                     animations:^{
                            self.xwingView.center = [tap locationInView:self.spaceView];
                            [self changeAlpha];
                        } completion:nil];
    
}
-(void)changeAlpha{
    [UIView animateWithDuration:0
                          delay:0
                        options: UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.xwingView.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.xwingView.alpha = 1;
                     }];
}
@end
