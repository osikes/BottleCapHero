//
//  Fizz.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "Fizz.h"

@implementation Fizz

@synthesize emitter;
-(void)initParticle
{
	self.emitter =  [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
    [self.emitter setPositionType:kPositionTypeFree]; 
}

-(id) init
{
    if ((self = [super init]))
    {
        [self initParticle];
        
    
    }
    return  self; 
}

-(void)updateEmitter
{
    emitter.rotation = self.rotation;
}
@end
