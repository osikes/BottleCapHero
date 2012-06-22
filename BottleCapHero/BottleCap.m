//
//  BottleCap.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "BottleCap.h"
#import "Constants.h"
#import "CommonProtocols.h"
@implementation BottleCap

-(id) init
{
    if(self != [super init])
    {
        
    }
    
    return self;

}
-(void)updateNow:(BOOL) val
{

    if(val)
    [self changeState:kStateOnWater];
    else {
        [self changeState:kStateSlippingOff];
    }
    
}

-(void)changeState:(CharacterStates)newState
{

    //[self stopAllActions];
    
    id action = nil;
    id movementAction = nil;
    CGPoint newPosition;
    
    switch (newState) {
        case kStateOnWater:
           /*  [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                    spriteFrameByName:@"bottlecapherowater.png"]];
            */
      //     [self setDisplayFrame:
        //     [CCSprite spriteWithFile:@"bottlecapherowater.png"]];
            
            [self setTexture:[[CCTextureCache sharedTextureCache] addImage:@"bottlecapherowater.png"]];
              break;
            
            
        default:
            [self setTexture:[[CCTextureCache sharedTextureCache] addImage:@"bottlecaphero.png"]];

            break;
    }
    
}


@end
