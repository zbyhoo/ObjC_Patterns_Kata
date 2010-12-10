//  Prototype.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/10/10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Warriors

/*! \brief Prototype
 */
@interface Warrior : NSObject <NSCopying>
- (void) presentMyself;
@end

@implementation Warrior
- (void) presentMyself
{
    NSLog(@"Just a warrior");
}
- (id)copyWithZone:(NSZone *)zone
{
    Warrior* warrior = [[Warrior allocWithZone:zone] init];
    return  warrior;
}
@end

/*! \brief Concrete Prototype
 */
@interface StarWarsWarrior : Warrior
{
    NSString* type;
    NSString* side;
    NSString* weapon;
}
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* side;
@property (nonatomic, retain) NSString* weapon;
- (id) initWithType:(NSString*)hisType side:(NSString*)fightingSide weapon:(NSString*)fightingWeapon;
@end

@implementation StarWarsWarrior
@synthesize type, side, weapon;
- (id) initWithType:(NSString*)hisType side:(NSString*)fightingSide weapon:(NSString*)fightingWeapon
{
    if ([super init] != nil)
    {
        self.type = hisType;
        self.side = fightingSide;
        self.weapon = fightingWeapon;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    StarWarsWarrior* warrior = [[StarWarsWarrior allocWithZone:zone] initWithType:self.type side:self.side weapon:self.weapon];
    return warrior; 
}
- (void) presentMyself
{
    NSLog(@"I'm %@, fighting on %@ and I'll kill you with my %@.", self.type, self.side, self.weapon);
}
- (void) dealloc
{
    [type release];
    [side release];
    [weapon release];
    [super dealloc];
}
@end

/*! \brief Concrete Prototype
 */
@interface ShaolinMonk : Warrior
{
    NSString* name;
    NSString* style;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* style;
- (id) initWithName:(NSString*)realName style:(NSString*)kungFuStyle;
@end

@implementation ShaolinMonk
@synthesize name, style;
- (id) initWithName:(NSString*)realName style:(NSString*)kungFuStyle
{
    if ([super init] != nil)
    {
        self.name = realName;
        self.style = kungFuStyle;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone 
{ 
    ShaolinMonk* warrior = [[ShaolinMonk allocWithZone:zone] initWithName:self.name style:self.style];
    return warrior; 
}
- (void) presentMyself
{
    NSLog(@"My name is %@. I know %@ kung-fu style, be aware.", self.name, self.style);
}
- (void) dealloc
{
    [name release];
    [style release];
    [super dealloc];
}
@end

#pragma mark -
#pragma mark Helpful method

/*! \brier Client
 *  \param Uses this prototype to create new warrior.
 */
void cloneWarrior(Warrior* warriorPrototype)
{
    Warrior* clonedWarrior = [warriorPrototype copy];
    [clonedWarrior presentMyself];
    [clonedWarrior release];
}

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    // creating prototypes, Abstract Factory or Factory Method could be used
    StarWarsWarrior* sithLord = [[StarWarsWarrior alloc] initWithType:@"Sith Lord" side:@"the Dark Side" weapon:@"Red Lightsaber"];
    ShaolinMonk* bruceLee = [[ShaolinMonk alloc] initWithName:@"Bruce Lee" style:@"Jeet Kune Do"];
    
    cloneWarrior(sithLord);
    cloneWarrior(bruceLee);
    
    [bruceLee release];
    [sithLord release];
    
    [pool drain];
    return 0;
}
