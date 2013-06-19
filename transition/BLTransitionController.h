//
//  BLAdTransitionController.h
//  prototype
//
//  Created by César Pinto Castillo on 12/06/13.
//  Copyright (c) 2013 Blocket. All rights reserved.
//

@import UIKit;

typedef enum {
    BLAnimationTransitionFlip
} BLAnimationTransitions;

@interface BLTransitionController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BLAnimationTransitions animationTransition;

@end
