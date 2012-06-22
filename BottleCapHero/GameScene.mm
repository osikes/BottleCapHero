//
//  GameScene.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
-(id)init{
    
    self = [super init];
    
    if(self != nil){
        
        GamePlayLayer *layer = [GamePlayLayer node];
        [self addChild:layer z:5];
	
    }
    return  self; 
    
}
@end
