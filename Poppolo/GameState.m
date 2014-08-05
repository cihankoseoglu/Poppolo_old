//
//  GameState.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 8/6/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "GameState.h"

@implementation GameState

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred = 0;
    static GameState *_sharedInstance = nil;
    
    dispatch_once( &pred, ^{
        _sharedInstance = [[super alloc] init];
    });
    return _sharedInstance;
}


- (id) init
{
    if (self = [super init]) {
        // Init
        _score = 0;
        _highScore = 0;
        _stars = 0;
        _levelCount = 0;
        
        // Load game state
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id highScore = [defaults objectForKey:@"highScore"];
        if (highScore) {
            _highScore = [highScore intValue];
        }
        id stars = [defaults objectForKey:@"stars"];
        if (stars) {
            _stars = [stars intValue];
        }
        id levelCount = [defaults objectForKey:@"levelCount"];
        if (levelCount) {
            _levelCount = [levelCount intValue];
        }
    }
    return self;
}

- (void) saveState
{
    // Update highScore if the current score is greater
    _highScore = MAX(_score, _highScore);
    
    // Store in user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:_highScore] forKey:@"highScore"];
    [defaults setObject:[NSNumber numberWithInt:_stars] forKey:@"stars"];
    [defaults setObject:[NSNumber numberWithInt:_levelCount] forKey:@"levelCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
