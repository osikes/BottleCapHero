//
//  GameCharacter.h
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GameObject.h"

@interface GameCharacter : GameObject
{
	CharacterStates characterState;

}
@property (readwrite) CharacterStates characterState;
@end
