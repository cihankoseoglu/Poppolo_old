//
//  GameState.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 8/6/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject

@property (nonatomic , assign) int score;
@property (nonatomic, assign) int highScore;
@property (nonatomic, assign) int stars;
@property (nonatomic, assign) int levelCount;

+ (instancetype)sharedInstance;

- (void) saveState;

@end
