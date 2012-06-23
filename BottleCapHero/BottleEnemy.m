//
//  EPBottleClass.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "BottleEnemy.h"

@implementation BottleEnemy



-(id) init
{
    
  
	if((self != [super init]))
	{
    
	
    }

	return  self;
}

-(CGRect)adjustedBoundingBox{
	CGRect currentBox = [self boundingBox];
	
	float xcropamount = currentBox.size.width * 0.04;
	float ycropamount = currentBox.size.height * 0.2f;
	
	return  CGRectMake(currentBox.origin.x+xcropamount, currentBox.origin.y, currentBox.size.width-xcropamount, currentBox.size.height-ycropamount);
}



-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects
{
		CGRect myBoundingBox = [self adjustedBoundingBox];
    for (GameCharacter *character in listOfGameObjects) 
	{
        // This is Ole the Viking himself
        // No need to check collision with one's self
        if ([character tag] == kBottleSpriteTagValue)//this is self 
            continue;
	
		if(CGRectIntersectsRect(myBoundingBox, character.adjustedBoundingBox))
		{
			if([character tag] == kBottleCapHeroSpriteTagValue){
			
				[self changeState:kStateDead];
				NSLog(@"We Win");
			
			}
			
		}
	}
}
    
    @end
