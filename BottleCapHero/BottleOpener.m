//
//  BottleOpener.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/22/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "BottleOpener.h"

@implementation BottleOpener
-(id) init{
	
	if(self = [super init])
	{
		self.gameObjectType = kBottleOpenerType;
	}
	
	return  self;
}


-(CGRect) adjustedBoundingBox{
	return [self boundingBox];
}
@end
