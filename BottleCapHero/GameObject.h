//
//  GameObject.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "CCSprite.h"
#import "Constants.h"
#import "CommonProtocols.h"
@interface GameObject : CCSprite
{
    
}
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className;

-(CGRect)adjustedBoundingBox;

-(void)changeState:(CharacterStates)newState; 


-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects; 

@end
