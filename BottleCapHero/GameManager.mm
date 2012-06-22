//
//  GameManager.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GameManager.h"
#import "GameScene.h"
#import "MainMenuScene.h"
@implementation GameManager

static GameManager* _sharedGameManager = nil; 


@synthesize curLevel;
@synthesize lastLevel;

+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])                             // 2
    {
        if(!_sharedGameManager)                                    // 3
            [[self alloc] init]; 
        return _sharedGameManager;                                 // 4
    }
    return nil; 
}

+(id)alloc 
{
    @synchronized ([GameManager class])                            // 5
    {
        NSAssert(_sharedGameManager == nil,
                 @"Attempted to allocated a second instance of the Game Manager singleton"); // 6
        _sharedGameManager = [super alloc];
        return _sharedGameManager;                                 // 7
    }
    return nil;  
}



-(id)init {                                                        // 8
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
                      currentScene = kNoSceneUninitialized;
                 }
    return self;
}
-(void)runSceneWithID:(SceneTypes)sceneID {

    lastLevel = curLevel;
    curLevel = sceneID;
    
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;

    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene: 
            sceneToRun = [MainMenuScene node];
            break;
               case kGameLevel1: 
            sceneToRun = [GameScene node];
            break;
                 
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil) {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    // Menu Scenes have a value of < 100
    if (sceneID < 100) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) { 
            CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels; 
            if (screenSize.width == 960.0f) {
                // iPhone 4 Retina
                [sceneToRun setScaleX:0.9375f];
                [sceneToRun setScaleY:0.8333f];
                CCLOG(@"GameMgr:Scaling for iPhone 4 (retina)");
                
            } else {
                [sceneToRun setScaleX:0.4688f];
                [sceneToRun setScaleY:0.4166f];
                CCLOG(@"GameMgr:Scaling for iPhone 3GS or older (non-retina)");
                
            }
        }
    }
    
   // [self performSelectorInBackground:@selector(loadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:sceneID]];
    
        
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
        
    } else {
        
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
  //  [self performSelectorInBackground:@selector(unloadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:oldScene]];

}

@end
