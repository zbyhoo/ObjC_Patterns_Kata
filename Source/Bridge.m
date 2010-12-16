//  Bridge.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/16/10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Guns

/*! \brief Implementator
 */
@interface Gun : NSObject
- (void) fire;
@end
@implementation Gun
- (void) fire {}
@end

/*! \brief Concrete Implementator
 */
@interface Colt : Gun
- (void) fire;
@end
@implementation Colt
- (void) fire { NSLog(@"shooting with %@", [self class]); }
@end

/*! \brief Concrete Implementator
 */
@interface SniperRifle : Gun
- (void) fire;
@end
@implementation SniperRifle
- (void) fire { NSLog(@"shooting with %@", [self class]); }
@end

#pragma mark -
#pragma mark Shooters

/*! \brief Abstraction
 */
@interface Shooter : NSObject
{
    Gun* gun;
}
@property (nonatomic, retain) Gun* gun;
- (void) shoot;
@end
@implementation Shooter
@synthesize gun;
- (void) shoot {}
- (void) dealloc
{
    [gun release];
    [super dealloc];
}
@end

/*! \brief Refined Abstraction
 */
@interface Cowboy : Shooter
@end
@implementation Cowboy
- (id) init
{
    if ([super init] != nil)
    {
        gun = [[Colt alloc] init];
    }
    return self;
}
- (void) shoot 
{ 
    NSLog(@"%@ is ... ", [self class]);
    [self.gun fire];
}
@end

/*! \brief Refined Abstraction
 */
@interface Sniper : Shooter
@end
@implementation Sniper
- (id) init
{
    if ([super init] != nil)
    {
        gun = [[SniperRifle alloc] init];
    }
    return self;
}
- (void) shoot 
{ 
    NSLog(@"%@ is ... ", [self class]);
    [self.gun fire];
}
@end


#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    Shooter* cowboy = [[[Cowboy alloc] init] autorelease];
    Shooter* sniper = [[[Sniper alloc] init] autorelease];
    
    [cowboy shoot];
    [sniper shoot];
    
    // dynamically changing "implementation" of gun
    sniper.gun = [[[Colt alloc] init] autorelease];
    [sniper shoot];
    
    [pool drain];
    return 0;
}
