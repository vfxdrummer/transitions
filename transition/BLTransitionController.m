//
//  BLAdTransitionController.m
//  prototype
//
//  Created by César Pinto Castillo on 12/06/13.
//  Copyright (c) 2013 Blocket. All rights reserved.
//

#import "BLTransitionController.h"
@import QuartzCore;

@implementation BLTransitionController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch ([self animationTransition]) {
        case BLAnimationTransitionFlip:
            [self animateFlipInWithContext:transitionContext];
            break;
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"Animation ended. Woho!");
}

CATransform3D perspectiveTransform() {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500;
    return transform;
}

#pragma mark - Animations

- (void)animateFlipInWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[[transitionContext containerView] layer] setSublayerTransform:perspectiveTransform()];
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    toVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2,0.0,1.0,0.0); //flip halfway
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromVC.view.layer.transform = CATransform3DMakeRotation(M_PI_2,0.0,1.0,0.0); //flip halfway
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              toVC.view.layer.transform = CATransform3DMakeRotation(0.0f,0.0,1.0,0.0); //finish the flip
                                          } completion:^(BOOL finished){
                                              [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                                          }];
                     }];
}

@end
