//  FactoryMethod.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/9/10.
//  Copyright 2010 . All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Drinks

/*! \brief Product
 */
@interface Drink : NSObject
- (void) make;
@end
@implementation Drink
- (void) make {}
@end

/*! \brief Concrete Product
 */
@interface BloodyMarryDrink : Drink
@end
@implementation BloodyMarryDrink
- (void) make { NSLog(@"%@ done, but from tomato juice, not real blood.", [self class]); }
@end

/*! \brief Concrete Product
 */
@interface MartiniDrink : Drink
@end
@implementation MartiniDrink
- (void) make { NSLog(@"%@ done, shaken, not stirred.", [self class]); }
@end

#pragma mark -
#pragma mark Cocktail Shakers

/*! \brief Creator
 */
@interface Shaker : NSObject
{
    Drink* drink;
}
- (void) prepare;
- (void) makeDrink;
@end
@implementation Shaker
- (void) prepare    {}
- (void) makeDrink  { [drink make]; }
- (void) dealloc
{
    if (drink != nil)
        [drink release];
    [super dealloc];
}
@end

/*! \brief Concrete Creator
 */
@interface DraculaShaker : Shaker
@end
@implementation DraculaShaker
- (void) prepare { drink = [[BloodyMarryDrink alloc] init]; }
@end

/*! \brief Concrete Creator
 */
@interface JamesBondShaker : Shaker
@end
@implementation JamesBondShaker
- (void) prepare { drink = [[MartiniDrink alloc] init]; }
@end

#pragma mark -
#pragma mark Helpful method

/*! \brief Client
 */
void createDrink(Shaker* shaker)
{
    [shaker prepare];
    [shaker makeDrink];
}

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    Shaker* shaker = [[DraculaShaker alloc] init];
    createDrink(shaker);
    [shaker release];
    
    shaker = [[JamesBondShaker alloc] init];
    createDrink(shaker);
    [shaker release];
    
    [pool drain];
    return 0;
}

