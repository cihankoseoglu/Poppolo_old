//
//  GameData.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 6/27/15.
//  Copyright (c) 2015 Cihan Koseoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject <NSCoding>

@property (assign, nonatomic) long score;
@property (assign, nonatomic) long highScore;

@property (assign, nonatomic) int adShowCount;


+(instancetype)sharedGameData;
-(void)reset;
-(void)save;


@end
