//  Proxy.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 1/12/11.
//  Copyright 2011. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Money and other

/*! \brief Subject
 */
@protocol Valuable
- (void) pay;
@end

/*! \brief Real Subject
 */
@interface RealMoney : NSObject <Valuable>
@end
@implementation RealMoney
- (void) pay { NSLog(@"Paying with %@", self.class); }
@end

/*! \brief Proxy
 */
@interface CasheMachine : NSObject <Valuable>
{
    RealMoney* money;
}
@end
@implementation CasheMachine
- (void) pay
{
    if (money == nil)
    {
        NSLog(@"Getting money");
        money = [[RealMoney alloc] init];
    }
    [money pay];
}
- (void) dealloc
{
    if (money != nil)
    {
        [money dealloc];
    }
    [super dealloc];
}
@end

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSObject<Valuable>* money = [[[CasheMachine alloc] init] autorelease];
    
    //using money for the first time (getting real money from cache machine)
    [money pay];
    
    //using second time (already got real money)
    [money pay];
    
    [pool drain];
    return 0;
}
