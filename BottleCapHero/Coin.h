//
//  Coin.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/22/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GameObject.h"

@interface Coin : GameObject
{
	CCAnimation *rotateCoin;	
}

@property (nonatomic,retain) CCAnimation *rotateCoin;
@end
