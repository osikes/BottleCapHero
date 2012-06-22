//
//  GamePlayLayer.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GamePlayLayer.h"

@implementation GamePlayLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GamePlayLayer *layer = [GamePlayLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void)ChangeDirectionOfBottle
{

		//get random x coordinate
	
	CGPoint point =CGPointMake(arc4random()%320, 300);
	
    CGPoint shootVector = ccpSub(point, bottle.position);
    CGFloat shootAngle = ccpToAngle(shootVector);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1* shootAngle)+90;//account for orienation
    
    CGFloat curAngle = bottle.rotation;
	
		//NSLog(@"angle %f",shootAngle);
	point = [[CCDirector sharedDirector] convertToGL:point];
    
	CGFloat rotateDiff = (cocosAngle - curAngle);    
    if (rotateDiff > 180)
		rotateDiff -= 360;
	if (rotateDiff < -180)
		rotateDiff += 360;    
		//CGFloat rotateSpeed = 0.5 / 180; // Would take 0.5 seconds to rotate half a circle
	CGFloat rotateSpeed = 25; // degrees per second
    CGFloat rotateDuration = fabs(rotateDiff / rotateSpeed);	
	
    [bottle runAction:[CCSequence actions:
					   [CCRotateTo actionWithDuration:rotateDuration  angle:cocosAngle],
					   [CCCallFunc actionWithTarget:self selector:@selector(finishMove)],
					   nil]];

	
    
}


-(void)update:(ccTime)deltaTime{
	
    
 //   [bottle updateStateWithDeltaTime:deltaTime];
    
    //[bottle testmethod];
    
emitter.rotation = bottle.rotation;
	//NSLog(@"%f point ",emitter.position.x);
    

}


-(void) finishMove
{

		//NSLog(@"happning move");
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
			// create and initialize a Label
			// Enable touch events
		self.isTouchEnabled = YES;
		
			// Initialize arrays
		
			// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
			// Add the player to the middle of the screen along the y-axis, 
			// and as close to the left side edge as we can get
			// Remember that position is based on the anchor point, and by default the anchor
			// point is the middle of the object.
    //    bottle =[[BottleEnemy alloc]initWithSpriteFrameNode:@"bottle.png"];
      
        
        bottle = [CCSprite spriteWithFile:@"bottle.png"]; 
        
        
         //   [bottle setTexture :[[CCTextureCache sharedTextureCache] addImage:@"bottle.png"]];	//	emitter =  [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
        // [CCSprite spriteWithFile:@"bottle.png"] ;
	
        bottle.position = ccp(bottle.contentSize.width/2 +120, winSize.height/2-100 );
		emitter.position = bottle.position;
		
emitter =  [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
        [emitter setPositionType:kCCPositionTypeFree];//bottle.emitter = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
		[self addChild:emitter];
			//[self addChild:waterEmitter];
		
        [self addChild:bottle];
			hero = [CCSprite spriteWithFile:@"bottlecaphero.png"];
		hero.position = ccp(bottle.contentSize.width/2 +70, winSize.height/2+100 );
		[self addChild:hero];
			// ask director the the window size
			//CGSize size = [[CCDirector sharedDirector] winSize];	
		// position the label on the center of the screen
		[self schedule:@selector(ChangeDirectionOfBottle) interval:2.0];
		
		id action = [CCMoveBy actionWithDuration:3 position:ccp(130,0)];
		id ac = [CCRepeatForever actionWithAction:
				 [CCSequence actions: [ action copy] , [action reverse],nil]];
		
			//	[hero runAction:ac];
			//	[hero RunAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:nil restoreOriginalFrame:NO]]];		
		[self scheduleUpdate];
		
		self.isAccelerometerEnabled = YES;
		
		[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationPortrait];
		
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1/60];
	}
	return self;
}


- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
		// use the running scene to grab the appropriate game layer by it's tag
		// grab the player sprite from that layer using it's tag
    float destX, destY;
    BOOL shouldMove = NO;
//	NSLog(@"accelerations %f",acceleration.x);
    float currentX = hero.position.x;
    float currentY = hero.position.y;
	float kPlayerSpeed =35.0f;
     if(acceleration.x > 0.25) {  // tilting the device to the right
        destX = currentX + (acceleration.x * kPlayerSpeed);
			 //    destY = currentY + (acceleration.x * kPlayerSpeed);
        shouldMove = YES;
    } else if (acceleration.x < -0.25) {  // tilting the device to the left
        destX = currentX - (-1*acceleration.x * kPlayerSpeed);
			//	NSLog(@"tilting left");
			//destY = currentY + (acceleration.x * kPlayerSpeed);
        shouldMove = YES;
    } else {
        destX = currentX;
        destY = currentY;
    }
	
    if(shouldMove) {
        CGSize wins = [[CCDirector sharedDirector] winSize];
			// ensure we aren't moving out of bounds     
        if(destX < 30 || destX > wins.width - 30 )				// do nothing
        {}
		else {
				//		NSLog(@" current x %f destx %f",currentX,destX);
            CCAction *action = [CCMoveTo actionWithDuration:.2 position: CGPointMake(destX, currentY)];
				[action setTag:1111101];
            [hero runAction:action];
        }
    } else {
			// should stop
			[hero stopActionByTag:1111101];
    }
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
