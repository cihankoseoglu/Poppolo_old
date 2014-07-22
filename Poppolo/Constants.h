//
//  Constants.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/21/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

// Label Colors

#define instructionColor [SKColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define warningColor [SKColor colorWithRed:230/255.0 green:190/255.0 blue:190/255.0 alpha:1.0]
#define levelPassColor [SKColor colorWithRed:200/255.0 green:200/255.0 blue:215/255.0 alpha:1.0]

// Ball Colors

#define YellowBall @"YellowBall"
#define PinkBall @"PinkBall"
#define PurpleBall @"PurpleBall"
#define BlueBall @"BlueBall"
#define GreenBall @"GreenBall"


// Animation List

#define fadeOutFast() [SKAction fadeOutWithDuration:0.3]
#define fadeOutMid() [SKAction fadeOutWithDuration:0.9]
#define fadeOutSlow() [SKAction fadeOutWithDuration:1.5]

#define fadeInFast() [SKAction fadeInWithDuration:0.3]
#define fadeInMid() [SKAction fadeInWithDuration:0.9]
#define fadeInSlow() [SKAction fadeInWithDuration:1.5]

#define goDown() [SKAction moveByX:0 y:-10 duration 0.5]
#define goUp() [SKAction moveByX:0 y:10 duration 0.5]
#define goLeft() [SKAction moveByX:-10 y:0 duration 0.5]
#define goRight() [SKAction moveByX:10 y:0 duration 0.5]

#define goDownMore() [SKAction moveByX:0 y:-30 duration 0.5]
#define goUpMore() [SKAction moveByX:0 y:30 duration 0.5]
#define goLeftMore() [SKAction moveByX:-30 y:0 duration 0.5]
#define goRightMore() [SKAction moveByX:30 y:0 duration 0.5]


//Functions

#define deleteInTimeInterval(timeInterval) [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(removeFromParent) userInfo:nil repeats:NO]




//Grouped Actions

#define labelFadeOut() [SKAction group:@[fadeOutFast,goDown]]
#define labelFadeIn() [SKAction group:@[fadeOutFast,goUp]]

