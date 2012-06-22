//
//  Constants.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#define kBottleCapHeroSpriteZValue 500
#define kBottleCapHeroSpriteTagValue 501
#define kBottleSpriteZvalue 499
#define kCapOnWaterTagValue 1000

typedef enum{
    
    kNoSceneUninitialized = 0,
    kMainMenuScene = 1,
    kCreditsScene = 2,
    kLevelCompleteScene = 3,
    kIntroScene = 100,
    kGameLevel1 = 101,
    kGameLevel2 = 102,
    kCutSceneForLevel2 = 201

} SceneTypes;