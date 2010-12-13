//  Singleton.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/13/10.
//  Copyright 2010. All rights reserved.

#pragma mark -
#pragma mark Single God

/*! Singleton
 */
@interface God : NSObject
{
    NSString* name;
}
@property (nonatomic, retain) NSString* name;
+ (God*) getInstance;
@end

@implementation God
static God* god = nil;
@synthesize name;
+ (God*) getInstance
{
    @synchronized(self)
    {
        if (god == nil)
        {
            god = [[super allocWithZone:NULL] init];
        }
    }
    return god;
}
+ (id) allocWithZone:(NSZone *)zone { return [self getInstance]; }
- (id) copyWithZone:(NSZone *)zone  { return self; }
- (id) retain                       { return self; }
- (NSUInteger) retainCount          { return NSUIntegerMax; }
- (void) release                    { /* do nothing */ }
- (id) autorelease                  { return self; }
@end

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    God* godOfWar = [God getInstance];
    godOfWar.name = @"Kratos";
    
    NSLog(@"There is only one god: %@", [God getInstance].name);
    
    [pool drain];
    return 0;
}
