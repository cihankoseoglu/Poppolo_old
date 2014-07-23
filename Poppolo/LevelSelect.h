//
//  LevelSelect.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LevelSelect : SKScene <UIPickerViewDelegate , UIPickerViewDataSource>


@property(strong,nonatomic) UIPickerView *levelPickerView;
@end
