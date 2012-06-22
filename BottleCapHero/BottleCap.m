//
//  BottleCap.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "BottleCap.h"
#import "Constants.h"
#import "CommonProtocols.h"
@implementation BottleCap

@synthesize balancingonwater;

-(id) init
{
    if(self != [super init])
    {
		self.gameObjectType = kBottleCapType;
        [self initAnimations];isSmiling = NO;
    }
    [self initAnimations];
    return self;

}


-(void) initAnimations{
	
	[self setBalancingonwater:[self loadPlistForAnimationWithName:@"balancingonwater" andClassName:NSStringFromClass([self class])]];
	NSLog(@"init animations");	
	
}


-(void)updateNow:(BOOL) val
{

    if(val)
    [self changeState:kStateOnWater];
    else {
        [self changeState:kStateIdle];
    }
    
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects
{
		CGRect myBoundingBox = [self adjustedBoundingBox];
    for (GameCharacter *character in listOfGameObjects) {
        // This is Ole the Viking himself
        // No need to check collision with one's self
        if ([character tag] == kBottleCapHeroSpriteTagValue)//this is self 
            continue;
	
		if([character tag] == kBottleSpriteTagValue )
		{
			
				//inside the only bottle that should be on screen
			
		}
		
		
		if(CGRectIntersectsRect(myBoundingBox, character.boundingBox))
		{
		
			if(character.gameObjectType == kBottleOpenerType){
				
					//than we need to acount for punishment of bottleCap hitting this
				
			}
				
		
		}
	
	
	}
	
	 
	
}



-(CGRect)adjustedBoundingBox{
	return [self boundingBox];
}

-(void)changeState:(CharacterStates)newState
{
	
	[self setCharacterState:newState];
    //[self stopAllActions];
		// [self stopAllActions];
		// action = nil;
    CCAction *action = nil;
    id repeat =nil;
	switch (newState) {
        case kStateOnWater:
			
			 repeat = [CCAnimate actionWithAnimation:balancingonwater restoreOriginalFrame:YES];
		
			id actioncomplete = [CCCallFuncN actionWithTarget:self selector:@selector(donewithsmile:)]; 
			
			if(!isSmiling){
				isSmiling = YES;
				action = [CCSequence actions:repeat,actioncomplete,nil];
				action.tag = kCapOnWaterTagValue;
			}
		
			
			
              break;
		case kStateIdle:
				//NSLog(@"idle");
			[self stopActionByTag:kCapOnWaterTagValue];
			[self setRotation:0];
			isSmiling = NO;
				//action = nil;
			  [self setDisplayFrame:[[CCSpriteFrameCache 
				                      sharedSpriteFrameCache] 
				 spriteFrameByName:@"bottlecaphero.png"]];
            
        default:
				///       [self setTexture:[[CCTextureCache sharedTextureCache] addImage:@"bottlecaphero.png"]];

            break;
    }
    if(action != nil)
		[self runAction:action];
}

-(void) donewithsmile:(CCNode *)aNode{ isSmiling = NO; NSLog(@"done");}

@end
