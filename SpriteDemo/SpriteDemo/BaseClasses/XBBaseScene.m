//
//  XBBaseScene.m
//  SpriteDemo
//
//  Created by xiabob on 2017/11/15.
//  Copyright © 2017年 xiabob. All rights reserved.
//

#import "XBBaseScene.h"
#import "XBBaseNodeProtocol.h"

@interface XBBaseScene ()

@property (nonatomic, strong) NSHashTable<SKNode<XBBaseNodeProtocol> *> *childrenConformProtocol;

@end

@implementation XBBaseScene

#pragma mark - Node Add/Remove

- (void)addChild:(SKNode *)node {
    [super addChild:node];
    
    if ([node conformsToProtocol:@protocol(XBBaseNodeProtocol)]) {
        [self.childrenConformProtocol addObject:(SKNode<XBBaseNodeProtocol> *)node];
    }
}

- (void)insertChild:(SKNode *)node atIndex:(NSInteger)index {
    [super insertChild:node atIndex:index];
    
    if ([node conformsToProtocol:@protocol(XBBaseNodeProtocol)]) {
        [self.childrenConformProtocol addObject:(SKNode<XBBaseNodeProtocol> *)node];
    }
}

- (void)removeAllChildren {
    [super removeAllChildren];
    
    [self.childrenConformProtocol removeAllObjects];
}

- (void)removeChildrenInArray:(NSArray<SKNode *> *)nodes {
    [super removeChildrenInArray:nodes];
    
    for (SKNode *node in nodes) {
        if ([node conformsToProtocol:@protocol(XBBaseNodeProtocol)]) {
            [self.childrenConformProtocol removeObject:(SKNode<XBBaseNodeProtocol> *)node];
        }
    }
}

#pragma mark - Logic Methods

- (void)update:(NSTimeInterval)currentTime {
    NSHashTable *children = [self.childrenConformProtocol copy];
    for (SKNode<XBBaseNodeProtocol> *node in children) {
        if ([node respondsToSelector:@selector(xb_update:)]) {
            [node xb_update:currentTime];
        }
    }
}

- (void)didEvaluateActions {
    NSHashTable *children = [self.childrenConformProtocol copy];
    for (SKNode<XBBaseNodeProtocol> *node in children) {
        if ([node respondsToSelector:@selector(xb_didEvaluateActions)]) {
            [node xb_didEvaluateActions];
        }
    }
}


- (void)didSimulatePhysics {
    NSHashTable *children = [self.childrenConformProtocol copy];
    for (SKNode<XBBaseNodeProtocol> *node in children) {
        if ([node respondsToSelector:@selector(xb_didSimulatePhysics)]) {
            [node xb_didSimulatePhysics];
        }
    }
}


- (void)didApplyConstraints {
    NSHashTable *children = [self.childrenConformProtocol copy];
    for (SKNode<XBBaseNodeProtocol> *node in children) {
        if ([node respondsToSelector:@selector(xb_didApplyConstraints)]) {
            [node xb_didApplyConstraints];
        }
    }
}

- (void)didFinishUpdate {
    NSHashTable *children = [self.childrenConformProtocol copy];
    for (SKNode<XBBaseNodeProtocol> *node in children) {
        if ([node respondsToSelector:@selector(xb_didFinishUpdate)]) {
            [node xb_didFinishUpdate];
        }
    }
}


#pragma mark - Getter

- (NSHashTable<SKNode<XBBaseNodeProtocol> *> *)childrenConformProtocol {
    if (!_childrenConformProtocol) {
        _childrenConformProtocol = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    
    return _childrenConformProtocol;
}

@end
