//  Decorator.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/20/10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Decorations for Chritmas

/*! \brief Component
 */
@protocol ChristmasDecoration
- (NSString*) show;
@end

/*! \brief Concrete Component
 */
@interface ChristmasTree : NSObject <ChristmasDecoration>
@end
@implementation ChristmasTree
- (NSString*) show { return [[NSString stringWithFormat:@"I'm a %@", self.class] autorelease]; }
@end

#pragma mark -
#pragma mark Christmas Tree Decorators

/*! \brief Decorator
 */
@interface PrettyDecorator : NSObject <ChristmasDecoration>
{
    NSObject<ChristmasDecoration>* component;
}
@property (nonatomic, retain) NSObject<ChristmasDecoration>* component;
- (id) initWithComponent:(NSObject<ChristmasDecoration>*)decoration;
@end

@implementation PrettyDecorator
@synthesize component;
- (id) initWithComponent:(NSObject<ChristmasDecoration>*)decoration
{
    if ([super init] != nil)
    {
        self.component = decoration;
    }
    return self;
}
- (NSString*) show 
{ 
    return [component show]; 
}
- (void) dealloc
{
    [component release];
    [super dealloc];
}
@end

/*! \brief Concrete Decorator
 */
@interface ChristmasTreeBauble : PrettyDecorator
@end
@implementation ChristmasTreeBauble
- (NSString*) show 
{ 
    NSString* parentDescription = [component show];
    return [[NSString stringWithFormat:@"%@ with %@", parentDescription, self.class] autorelease]; 
}
@end

/*! \brief Concrete Decorator
 */
@interface ChristmasTreeLights : PrettyDecorator
@end
@implementation ChristmasTreeLights
- (NSString*) show 
{ 
    NSString* parentDescription = [component show];
    return [[NSString stringWithFormat:@"%@ and beautfil %@", parentDescription, self.class] autorelease]; 
}
@end

#pragma mark -
#pragma mark Helpful function

NSObject<ChristmasDecoration>* createChristmasTree()
{
    return [[[ChristmasTreeLights alloc] initWithComponent:
             [[[ChristmasTreeBauble alloc] initWithComponent:
               [[[ChristmasTree alloc] init] autorelease]] autorelease]] autorelease];
}

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSObject<ChristmasDecoration>* christmasTree = createChristmasTree();
    NSLog(@"%@", [christmasTree show]);
    
    [pool drain];
    return 0;
}
