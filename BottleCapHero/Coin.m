//
//  Coin.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/22/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "Coin.h"

@implementation Coin
@synthesize  rotateCoin;
-(id) init{
	
	if(self = [super init])
	{
		self.gameObjectType = kTreasureCoinType;
			[self initAnimations];
	
		[self changeState:kStateSpawning];
		
	}
	
	return  self;
}


-(void) initAnimations{
	[self setRotateCoin:
	 [self loadPlistForAnimationWithName:@"rotateCoin" 
                            andClassName:NSStringFromClass([self class])]];
	
}
-(void) changeState:(CharacterStates)newState
{
	
	if(newState == kStateSpawning){
		id action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:rotateCoin restoreOriginalFrame:NO]];
				[self runAction:action];
	}
	else {
		[self setVisible:NO];
		[self removeFromParentAndCleanup:YES];
	}
	
}

-(CGRect) adjustedBoundingBox{
	return [self boundingBox];
}@end
