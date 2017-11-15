//
//  SKNode+XBBase.h
//  SpriteDemo
//
//  Created by xiabob on 2017/11/15.
//  Copyright © 2017年 xiabob. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (XBBase)

/**
 Called immediately after a node is added. Override this, not called directly.
 */
- (void)xb_didAddedToParent:(SKNode *)parent;

/**
 Called immediately before a node is removed from it's parent. Override this, not called directly.
 */
- (void)xb_willRemoveFromParent:(SKNode *)parent;

@end
