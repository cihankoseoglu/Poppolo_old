//
//  GameData.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 6/27/15.
//  Copyright (c) 2015 Cihan Koseoglu. All rights reserved.
//
#import "GameData.h"
#import <Foundation/Foundation.h>

@implementation GameData : NSObject

static NSString* const SSGameDataHighScoreKey = @"highScore";

+(instancetype)sharedGameData{
    
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
        
    });
    
    return sharedInstance;
}

-(void)reset{
    self.score=0;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.highScore forKey:SSGameDataHighScoreKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[self init];
    if (self) {
        _highScore = [aDecoder decodeIntegerForKey:SSGameDataHighScoreKey];
        
    }
    
    return self;
}

-(void)save
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
}


+(NSString*)filePath
{
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:@"gamedata"];
    }
    return filePath;
}


+(instancetype)loadInstance{
    NSData *decodedData = [NSData dataWithContentsOfFile:[GameData filePath]];
    if (decodedData) {
        GameData *gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return gameData;
    }
    
    return [[GameData alloc] init];
}
@end