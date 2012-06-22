//
//  GamePlayLayer.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GLES-Render.h"
#import "CCLayer.h"
#import "BottleEnemy.h"
#import "BottleCap.h"
#import "GLES-Render.h"
@interface GamePlayLayer : CCLayer
{
    	BottleEnemy *bottle;
	CCParticleSystem *emitter;
	BottleCap *hero;
	CCParticleSystem *waterEmitter;
    CGPoint current_point;
    float current_angle;
	CCSpriteBatchNode *sceneSpriteBatchNode;
	float millisecondsBetweenTouch;
	BOOL touchoccured;
	float PlayerAngle;
}
@end
