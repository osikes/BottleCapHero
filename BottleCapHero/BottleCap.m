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
#import "cocos2d.h"
@implementation BottleCap

@synthesize balancingonwater;

-(id) init
{
    if(self != [super init])
    {
		self.gameObjectType = kBottleCapType;
        [self initAnimations];isSmiling = NO;
		Money = 0;
    }
    [self initAnimations];
    return self;

}


-(void) initAnimations{
	
	[self setBalancingonwater:[self loadPlistForAnimationWithName:@"balancingonwater" andClassName:NSStringFromClass([self class])]];
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
    for (GameCharacter *character in listOfGameObjects) 
	{
        // This is Ole the Viking himself
        // No need to check collision with one's self
        if ([character tag] == kBottleCapHeroSpriteTagValue)//this is self 
            continue;
	
		if([character tag] == kBottleSpriteTagValue )
		{
			
				//	//inside the only bottle that should be on screen
		
			
		}
		
		
		if(CGRectIntersectsRect(myBoundingBox, character.adjustedBoundingBox))
		{
		
			if(character.gameObjectType == kBottleOpenerType){
				
					//than we need to acount for punishment of bottleCap hitting this
				
			}
			
			if([character tag] == kBottleSpriteTagValue)
			{
					//[self changeState:kStateDead];
			}
			if(character.gameObjectType == kTreasureCoinType)
			{
				Money += 1;
				[character changeState:kStateDead];
			}
		
		}
	
	
	}
	
	 
	
}



-(CGRect)adjustedBoundingBox{
	CGRect currentBox = [self boundingBox];
	
	float xcropamount = currentBox.size.width * 0.04;
	float ycropamount = currentBox.size.height * 0.5f;
	
	return  CGRectMake(currentBox.origin.x+xcropamount, currentBox.origin.y+20, currentBox.size.width-xcropamount, currentBox.size.height-ycropamount);
	
	
	
}

-(void)changeState:(CharacterStates)newState
{
	
	[self setCharacterState:newState];
	GameCharacter *bottle = (GameCharacter*)[[self parent]  getChildByTag:kBottleSpriteTagValue];
	
				CGPoint newpoint = [self ComputeCoordinate :bottle.rotation:-5];
		//[self stopAllActions];
		// [self stopAllActions];
		// action = nil;
    CCAction *action = nil;
    id repeat =nil;
	switch (newState) {
		case kStateMovingDown:
			NSLog(@"");
			newpoint = [self ComputeCoordinate :bottle.rotation:-5];
				action = [CCMoveTo actionWithDuration:.2 position: CGPointMake(newpoint.x, newpoint.y)];
			
			
			break; 
			
		case kStateMovingUp:
			NSLog(@"");
			newpoint = [self ComputeCoordinate :bottle.rotation:10];
				action = [CCMoveTo actionWithDuration:.2 position: CGPointMake(newpoint.x, newpoint.y)];
			
			
			break; 
		
		case kStateOnWater:
			
			 repeat = [CCAnimate actionWithAnimation:balancingonwater restoreOriginalFrame:YES];
		
			id actioncomplete = [CCCallFuncN actionWithTarget:self selector:@selector(donewithsmile:)]; 
			
			if(!isSmiling){
				isSmiling = YES;
				action = [CCSequence actions:repeat,actioncomplete,nil];
				action.tag = kCapOnWaterTagValue;
			}
		
			
			
              break;
		case kStateDead:
			
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





-(CGPoint) ComputeCoordinate:(float)angle:(float)distance
{
	
	CGPoint finalpoint;

	float x = self.position.x+( distance * cos( (-1*(angle-90.0f))*3.14/180));

	float y = self.position.y+( distance * sin( (-1*(angle-90.0f))*3.14/180));
	
	finalpoint.x = x;
	finalpoint.y = y;

	
	if( (x< 30 || x > 360) || (y > 450 || y < 30))
		return CGPointMake(self.position.x, self.position.y);
	
   	return finalpoint;
}




-(void) donewithsmile:(CCNode *)aNode{ isSmiling = NO;}

@end
