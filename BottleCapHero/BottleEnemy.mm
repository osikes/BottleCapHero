//
//  EPBottleClass.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/20/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "BottleEnemy.h"

@implementation BottleEnemy

@synthesize  eye;
@synthesize captarget;
@synthesize canSeeBottleCap;

-(id) init
{
    
    NSLog(@"init");
	if((self != [super init]))
	{
    
       // fizz = [[Fizz alloc]init]; 
	
        //self =  [CCSprite spriteWithFile:@"bottle.png"] ;
    }

	return  self;
}





-(CGRect)adjustedBoundingBox
{
    CGRect bottleBoundingBox = [self boundingBox];
    
    
    
    return bottleBoundingBox;

}

- (Fizz *)fizz {
    return fizz;
}

-(void)testmethod
{}

- (void)setFizz:(Fizz *)newValue {
    [fizz autorelease];
    fizz = [newValue retain];
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime  {
    NSLog(@"updateZ");
    fizz.rotation = self.rotation;
    [fizz updateEmitter];
}
    
    @end
