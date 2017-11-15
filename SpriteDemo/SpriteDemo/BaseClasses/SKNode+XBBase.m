//
//  SKNode+XBBase.m
//  SpriteDemo
//
//  Created by xiabob on 2017/11/15.
//  Copyright © 2017年 xiabob. All rights reserved.
//

#import "SKNode+XBBase.h"
#import <objc/runtime.h>

@implementation SKNode (XBBase)

+ (void)xb_methodSwizzWithOriginSelector:(SEL)originSelector andSwizzlingSelector:(SEL)swizzlingSelector {
    Class class = [self class];
    
    //得到method
    Method originMethod    = class_getInstanceMethod(class, originSelector);
    Method swizzlingMethod  = class_getInstanceMethod(class, swizzlingSelector);
    
    //添加实例方法
    BOOL didAddMethod = class_addMethod(class,
                                        originSelector,
                                        method_getImplementation(swizzlingMethod),
                                        method_getTypeEncoding(swizzlingMethod));
    if (didAddMethod) {
        //替换方法名对应的实现方式
        class_replaceMethod(class,
                            swizzlingSelector,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        //没有添加成功，比如要添加的方法已经存在，这时交换实现
        method_exchangeImplementations(originMethod, swizzlingMethod);
    }
}

+ (void)load {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        [self xb_methodSwizzWithOriginSelector:@selector(addChild:) andSwizzlingSelector:@selector(swizzling_addChild:)];
        [self xb_methodSwizzWithOriginSelector:@selector(insertChild:atIndex:) andSwizzlingSelector:@selector(swizzling_insertChild:atIndex:)];
        [self xb_methodSwizzWithOriginSelector:@selector(removeChildrenInArray:) andSwizzlingSelector:@selector(swizzling_removeChildrenInArray:)];
        [self xb_methodSwizzWithOriginSelector:@selector(removeAllChildren) andSwizzlingSelector:@selector(swizzling_removeAllChildren)];
        [self xb_methodSwizzWithOriginSelector:@selector(removeFromParent) andSwizzlingSelector:@selector(swizzling_removeFromParent)];
        [self xb_methodSwizzWithOriginSelector:@selector(moveToParent:) andSwizzlingSelector:@selector(swizzling_moveToParent:)];
    });
}


#pragma mark - Swizzling Method

- (void)swizzling_addChild:(SKNode *)node {
    [self swizzling_addChild:node];
    
    [node xb_didAddedToParent:self];
}

- (void)swizzling_insertChild:(SKNode *)node atIndex:(NSInteger)index {
    [self swizzling_insertChild:node atIndex:index];
    
    [node xb_didAddedToParent:self];
}

- (void)swizzling_removeChildrenInArray:(NSArray<SKNode*> *)nodes {
    for (SKNode *node in nodes) {
        [node xb_willRemoveFromParent:self];
    }
    
    [self swizzling_removeChildrenInArray:nodes];
}

- (void)swizzling_removeAllChildren {
    for (SKNode *node in self.children) {
        [node xb_willRemoveFromParent:self];
    }
    
    [self swizzling_removeAllChildren];
}

- (void)swizzling_removeFromParent {
    [self xb_willRemoveFromParent:self.parent];
    
    [self swizzling_removeFromParent];
}

- (void)swizzling_moveToParent:(SKNode *)parent NS_AVAILABLE(10_11, 9_0) {
    [self xb_willRemoveFromParent:self.parent];
    
    [self swizzling_moveToParent:parent];
    
    [self xb_didAddedToParent:parent];
}


#pragma mark - Utils Method

- (void)xb_didAddedToParent:(SKNode *)parent {}

- (void)xb_willRemoveFromParent:(SKNode *)parent {}

@end
