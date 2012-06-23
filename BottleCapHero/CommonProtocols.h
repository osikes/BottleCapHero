//
//  CommonProtocols.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//



typedef enum
{
	kStateSpawning,
    kStateOnWater,
    kStateSlippingOff,
    kStateDead,
	kStateIdle,
	kStateMovingDown,
	kStateMovingUp
} CharacterStates;


typedef enum
{
	kPowerUpTypeTeleport,
	kPowerUpTypeFaster,
	kBottleCapType,
	kBottleType,
	kBottleOpenerType,
	kTreasureCoinType,
} GameObjectType;


@protocol GameplayLayerDelegate
-(void)createObjectOfType:(GameObjectType)objectType 
               atLocation:(CGPoint)spawnLocation 
               withZValue:(int)ZValue;
@end