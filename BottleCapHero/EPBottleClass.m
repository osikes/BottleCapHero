//
//  EPBottleClass.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "EPBottleClass.h"

@implementation EPBottleClass

@synthesize emitter;


-(id) init
{
	if((self != [super init]))
	{
		emitter = [[CCParticleSystem alloc]init];
		emitter =  [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
		[emitter setPositionType:kCCPositionTypeFree];

	}

	return  self;
}

-(void)setRotation:(float)rotation
{
	NSLog(@"happening");
	emitter.rotation = rotation;
}

@end
