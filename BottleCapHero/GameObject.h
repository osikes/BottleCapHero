//
//  GameObject.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CommonProtocols.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "cocos2d.h"



@interface GameObject: CCSprite {
	
	GameObjectType gameObjectType;
}

@property (readwrite) GameObjectType gameObjectType;

-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className;

-(CGRect)adjustedBoundingBox;

-(void)changeState:(CharacterStates)newState; 


-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects; 

@end
