//
//  Fizz.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "CCSprite.h"
#import "GameCharacter.h"
#import "cocos2d.h"


@interface Fizz : GameCharacter 
{
   // CCParticleSystem *emitter;

}
-(void)updateEmitter;
@property (nonatomic,retain) CCParticleSystem *emitter;
@end
