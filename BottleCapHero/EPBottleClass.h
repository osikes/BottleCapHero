//
//  EPBottleClass.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
@interface EPBottleClass : CCSprite
{

	CCParticleSystem *emitter;

}

@property (nonatomic,retain) CCParticleSystem *emitter;

@end
