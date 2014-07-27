//
//  LaserNode.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/27/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LaserNode.h"
@interface LaserNode(){
    
    CGSize laserBeamSize;
}

@end
@implementation LaserNode


- (id) init {
    if (self = [super init]) {
        
        laserBeamSize = CGSizeMake(4, 60);
        
        self = [LaserNode spriteNodeWithColor:[SKColor colorWithRed:200.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:0.9] size:laserBeamSize];
        
        self.name = @"LaserNode";
        self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:laserBeamSize];
        self.physicsBody.friction = 0;
        self.physicsBody.angularDamping = 0;
        self.physicsBody.linearDamping = 0;
        self.physicsBody.restitution =1;

              
    }
    return self;
}





@end
