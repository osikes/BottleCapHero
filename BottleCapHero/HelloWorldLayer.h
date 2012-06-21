//
//  HelloWorldLayer.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright University of Alabama Athletics 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "EPBottleClass.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	EPBottleClass *bottle;
	CCParticleSystem *emitter;
	EPBottleClass *hero;
	CCParticleSystem *waterEmitter;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
