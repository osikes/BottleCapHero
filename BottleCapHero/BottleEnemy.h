//
//  EPBottleClass.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "GameCharacter.h"
#import "Fizz.h"
#import "BottleCap.h"

@interface BottleEnemy : GameCharacter
{

	//CCParticleSystem *emitter;
    Fizz *fizz;
}

//@property (nonatomic,retain) CCParticleSystem *emitter;
@property CGPoint eye;
@property CGPoint captarget;
@property BOOL canSeeBottleCap;


- (Fizz *)fizz;

- (void)setFizz:(Fizz *)newValue;

-(void)updateStateWithDeltaTime:(ccTime)deltaTime ;

-(void)testmethod;

@end
