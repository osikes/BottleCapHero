//
//  GameManager.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface GameManager : NSObject
{

    SceneTypes currentScene;
       SceneTypes curLevel;
    SceneTypes lastLevel;
}

+(GameManager*)sharedGameManager;                                  // 1
-(void)runSceneWithID:(SceneTypes)sceneID;                         // 2

@property (assign) SceneTypes curLevel;
@property (assign) SceneTypes lastLevel;


@end
