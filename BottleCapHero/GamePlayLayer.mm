//
//  GamePlayLayer.m
//  BottleCapHero
//
//  Created by Owen Sikes on 6/21/12.
//  Copyright (c) 2012 University of Alabama Athletics. All rights reserved.
//

#import "GamePlayLayer.h"
#import "BottleOpener.h"
#import "Coin.h"
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
	
	CGPoint point =CGPointMake(arc4random()%330, 300);
    
	if(point.x < 50) point.x = 50;
	
	
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
    
    
    
    
    
    
    current_point = point;
}

-(void)CheckForGameOver
{
	if(hero != nil)
	if(hero.characterState == kStateDead){
		
	}
	if(bottle != nil)
	if(bottle.characterState == kStateDead){
		NSLog(@"Victory");
	}
	
}

-(void)update:(ccTime)deltaTime{
    
	
	
	CCArray *listOfGameObjects = 
    [sceneSpriteBatchNode children];                     
    for (GameCharacter *tempChar in listOfGameObjects) {
		[tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];                       
    }
    
	[self DetermineIfCapInterceptsFizz]; 

	
	if(hero.characterState == kStateOnWater)
	{ 
		hero.rotation = bottle.rotation;
		
		millisecondsBetweenTouch = millisecondsBetweenTouch + deltaTime;
		
		if(touchoccured)
		{
		
			touchoccured = NO;
			if(millisecondsBetweenTouch*1000 < 1500)
			{
				//handle moving down y-axis
				if(hero.characterState == kStateOnWater)
					[hero changeState:kStateMovingDown];
			
			}else {
			
				if(deltaTime*1000 > 200)
					[hero changeState:kStateMovingUp];
			}
		 
			millisecondsBetweenTouch = 0;
		
		}
		else {
				//	NSLog(@"delta %f",millisecondsBetweenTouch*1000);
			if(millisecondsBetweenTouch*1000 > 200)
			{millisecondsBetweenTouch = 0;[hero changeState:kStateMovingUp];} 
		}
	
	}
		[self CheckForGameOver];
}


-(void)DetermineIfCapInterceptsFizz
{
	
		//get radius by computing distance from bottle, to hero point 
	float radius = sqrtf( pow((hero.position.x - bottle.position.x),2) + pow((hero.position.y-bottle.position.y),2));
		//computer appropitate x to check to determine if hero is in way of stream
	
    float x = bottle.position.x+( radius * cos( (-1*(bottle.rotation-90.0f))*3.14/180));
    
    emitter.rotation = bottle.rotation;
	
    if (hero.position.x-45 <= x && hero.position.x+45 >= x ) 
        [hero changeState:kStateOnWater]; 

	else 
		[hero changeState:kStateIdle]; //after checking, the Cap is still not in the vector  of the Fizz, meaning, no need to push up or down on the item
}


-(CGPoint) ComputerCoordinate:(CGPoint)point:(float)angle:(float)distance
{
	CGPoint finalpoint;

	float x = hero.position.x+( distance * cos( (-1*(bottle.rotation-90.0f))*3.14/180));

	float y = hero.position.y+( distance * sin( (-1*(bottle.rotation-90.0f))*3.14/180));

	
	finalpoint.x = x;
	finalpoint.y = y;
   	return finalpoint;
}

-(void)MoveCapUp
{
	CGSize wins = [[CCDirector sharedDirector] winSize];
	CGPoint newpoint = [self ComputerCoordinate:hero.position :bottle.rotation :6];	
	CCAction *actionup = [CCMoveTo actionWithDuration:.3 position: CGPointMake(newpoint.x, newpoint.y)];// CGPointMake(hero.position.x, hero.position.y+5)];
	
		if(hero.position.y < wins.height-60)
		[hero runAction:actionup];	
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	touchoccured = YES;
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
	
		PlayerAngle = 0;
		millisecondsBetweenTouch = 0;
			// create and initialize a Label
			// Enable touch events
	
		touchoccured = NO;
		
			// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		[self LoadAtlas];
		
        bottle = [[BottleEnemy alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bottle.png"]];
		
        
        bottle.position = ccp(bottle.contentSize.width/2 +120, winSize.height/2-100 );
			
emitter =  [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
        [emitter setPositionType:kCCPositionTypeFree];//bottle.emitter = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"water.plist"];
        
		
		[self addChild:emitter z:5];
		[sceneSpriteBatchNode addChild:bottle z:kBottleSpriteZvalue tag:kBottleSpriteTagValue];
		
		hero = [[BottleCap alloc]init];
		
        hero = [[BottleCap alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bottlecaphero.png"]]; // initWithFile:@"bottlecaphero.png"];
        hero.position = ccp(bottle.contentSize.width/2 +70, winSize.height/2+100 );
		[sceneSpriteBatchNode addChild:hero z:kBottleCapHeroSpriteZValue tag:kBottleCapHeroSpriteTagValue];
       
		
		[self createObjectOfType:kBottleOpenerType  atLocation:CGPointMake(hero.position.x, hero.position.y-70) withZValue:10];
        
			//add coins
		[self LoadRandomCoins];
	
      		// ask director the the window size
		// position the label on the center of the screen
		[self schedule:@selector(ChangeDirectionOfBottle) interval:5.0];
		
		
		[self scheduleUpdate];
		
		self.isAccelerometerEnabled = YES;
		
		[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationPortrait];
		
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1/60];
	}
	self.isTouchEnabled = YES;
	return self;
}

-(void)LoadAtlas
{
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"atlas.plist"];
		sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"atlas.png"];
		[self addChild:sceneSpriteBatchNode z:0];
}


-(void) LoadRandomCoins
{
	
	for (int i = 0; i < 1; i++) {
		
	[self createObjectOfType:kTreasureCoinType atLocation:CGPointMake(arc4random()%300+45, arc4random()%400+100) withZValue:10];
	}
}

-(void) drawBoundingBox:(CGRect) rect
{
	

CGPoint vertices[4]={
        ccp(rect.origin.x,rect.origin.y),
        ccp(rect.origin.x+rect.size.width,rect.origin.y),
        ccp(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height),
        ccp(rect.origin.x,rect.origin.y+rect.size.height),
    };
    ccDrawPoly(vertices, 4, YES);}

-(void) draw
{
	 glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);

   // _world->DrawDebugData();

    glColor4f(1.0, 0, 0, 1.0);
    glLineWidth(1.0f);

  for (GameCharacter *tempChar in  [sceneSpriteBatchNode children]) {         // 2
	  [self drawBoundingBox:tempChar.adjustedBoundingBox]; 
  }
	 
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);

    [super draw];

}
-(void)createObjectOfType:(GameObjectType)objectType 
             
               atLocation:(CGPoint)spawnLocation 
               withZValue:(int)ZValue 
{

	if(objectType == kPowerUpTypeTeleport)
	{
		
	}
	if(objectType == kBottleOpenerType){
		
		 BottleOpener *bottleOpener = [[BottleOpener alloc] initWithSpriteFrameName:@"bottleopenertrans.png"];
        [bottleOpener setPosition:spawnLocation];
        [sceneSpriteBatchNode addChild:bottleOpener z:ZValue];
	}
	if(objectType == kTreasureCoinType){
		Coin *coin = [[Coin alloc] initWithSpriteFrameName:@"yellowcoin.png"];
		[coin setPosition:spawnLocation];
		[sceneSpriteBatchNode addChild:coin z:ZValue];
	}
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
		// use the running scene to grab the appropriate game layer by it's tag
		// grab the player sprite from that layer using it's tag
    float destX, destY;
    BOOL shouldMove = NO;
//	NSLog(@"accelerations %f",acceleration.x);
    float currentX = hero.position.x;
    float currentY = hero.position.y;
		//computer radius
	
	
		//	NSLog(@"radius %f",radius);
	float kPlayerSpeed =35.0f;
     if(acceleration.x > 0.15) {  // tilting the device to the right
        
		 
		 destX = currentX + (acceleration.x * kPlayerSpeed);
			 //    destY = currentY + (acceleration.x * kPlayerSpeed);
        shouldMove = YES;
    } else if (acceleration.x < -0.15) {  // tilting the device to the left
		
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
            
			
			
				//	hero.rotation=bottle.rotation;
			
				CCAction *action = [CCMoveTo actionWithDuration:.2 position: CGPointMake(destX, currentY)];
			
					//	hero.rotation = (PlayerAngle);
			
			[action setTag:1111101];
            
				[hero runAction:action];
        }
    } else {
			// should stop
			[hero stopActionByTag:1111101];
    }
	
}


-(CGPoint) RotateAroundPt:(CGPoint) centerPt withAngle:(float) radAngle withRadius:(float) radius {
	CGPoint newpoint;
	newpoint.x = centerPt.x + cosf(radAngle) * radius;
	newpoint.y = centerPt.y + sinf(radAngle) * radius;
	return newpoint;
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
