//
//  BottleCap.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GameCharacter.h"
#import "Constants.h"
#import "cocos2d.h"
@interface BottleCap : GameCharacter
{
	CCAnimation *balancingonwater;	
	BOOL isSmiling;
}


@property (nonatomic,retain) CCAnimation *balancingonwater;
	//@property (nonatomic,retain) CCAnimation delegate;
-(void) updateNow:(BOOL)val;
@end
