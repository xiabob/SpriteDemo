//
//  XBBaseScene.h
//  SpriteDemo
//
//  Created by xiabob on 2017/11/15.
//  Copyright © 2017年 xiabob. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface XBBaseScene : SKScene

/**
 You must need call [super update:] at first. Override this to perform per-frame game logic. Called exactly once per frame before any actions are evaluated and any physics are simulated.
 
 @param currentTime the current time in the app. This must be monotonically increasing.
 */
- (void)update:(NSTimeInterval)currentTime;

/**
 You must need call [super didEvaluateActions] at first. Override this to perform game logic. Called exactly once per frame after any actions have been evaluated but before any physics are simulated. Any additional actions applied is not evaluated until the next update.
 */
- (void)didEvaluateActions;

/**
 You must need call [super didSimulatePhysics] at first. Override this to perform game logic. Called exactly once per frame after any actions have been evaluated and any physics have been simulated. Any additional actions applied is not evaluated until the next update. Any changes to physics bodies is not simulated until the next update.
 */
- (void)didSimulatePhysics;

/**
 You must need call [super didApplyConstraints] at first. Override this to perform game logic. Called exactly once per frame after any enabled constraints have been applied. Any additional actions applied is not evaluated until the next update. Any changes to physics bodies is not simulated until the next update. Any changes to constarints will not be applied until the next update.
 */
- (void)didApplyConstraints NS_AVAILABLE(10_10, 8_0);

/**
 You must need call [super didFinishUpdate] at first. Override this to perform game logic. Called after all update logic has been completed. Any additional actions applied are not evaluated until the next update. Any changes to physics bodies are not simulated until the next update. Any changes to constarints will not be applied until the next update.
 
 No futher update logic will be applied to the scene after this call. Any values set on nodes here will be used when the scene is rendered for the current frame.
 */
- (void)didFinishUpdate NS_AVAILABLE(10_10, 8_0);


@end
