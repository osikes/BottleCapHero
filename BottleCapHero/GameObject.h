//
//  GameObject.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "CCSprite.h"

@interface GameObject : CCSprite
{
    
}
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className;

-(CGRect)adjustedBoundingBox;

@end
