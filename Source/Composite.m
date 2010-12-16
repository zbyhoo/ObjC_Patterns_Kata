//  Composite.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/16/10.
//  Copyright 2010. All rights reserved.

#pragma mark -
#pragma mark Design Parts

/*! \brief Component
 */
@protocol Designable
- (void) present;
- (void) add:(NSObject<Designable>*)design;
- (void) remove:(NSObject<Designable>*)design;
- (NSObject<Designable>*) getDesign:(NSUInteger)index;
@end

/*! \brief Leaf
 */
@interface Dimentions : NSObject <Designable>
{
    NSString* description;
}
@property (nonatomic, retain) NSString* description;
- (id) initWithDescription:(NSString*)desc;
@end
@implementation Dimentions
@synthesize description;
- (id)   initWithDescription:(NSString *)desc
{
    if ([super init] != nil)
    {
        self.description = desc;
    }
    return self;
}
- (void) present                                { NSLog(@" - %@ : %@", self.class, [self description]); }
- (void) add:(NSObject<Designable>*)design      {}
- (void) remove:(NSObject<Designable>*)design   {}
- (NSObject<Designable>*) getDesign:(NSUInteger)index  { return nil; }
- (void) dealloc
{
    [description release];
    [super dealloc];
}
@end

/*! \brief Leaf
 */
@interface Materials : NSObject <Designable>
{
    NSString* description;
}
@property (nonatomic, retain) NSString* description;
- (id) initWithDescription:(NSString*)desc;
@end
@implementation Materials
@synthesize description;
- (id)   initWithDescription:(NSString *)desc
{
    if ([super init] != nil)
    {
        self.description = desc;
    }
    return self;
}
- (void) present                                { NSLog(@" - %@  : %@", self.class, self.description); }
- (void) add:(NSObject<Designable>*)design      {}
- (void) remove:(NSObject<Designable>*)design   {}
- (NSObject<Designable>*) getDesign:(NSUInteger)index  { return nil; }
- (void) dealloc
{
    [description release];
    [super dealloc];
}
@end

/*! \brief Composite
 */
@interface LevelDesign : NSObject <Designable>
{
    NSString*       description;
    NSMutableArray* designs;
}
@property (nonatomic, retain) NSString* description;
- (id) initWithDescription:(NSString*)desc;
@end
@implementation LevelDesign
@synthesize description;
- (id) initWithDescription:(NSString*)desc
{
    if ([self init] != nil)
    {
        self.description = desc;
        designs = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) present
{
    NSLog(@"Presenting design for %@:", self.description);
    NSEnumerator* e = [designs objectEnumerator];
    NSObject<Designable>* object;
    while (object = (NSObject<Designable>*)[e nextObject])
    {
        [object present];
    }
}
- (void) add:(NSObject<Designable>*)design
{
    [designs addObject:(id)design];
}
- (void) remove:(NSObject<Designable>*)design
{
    [designs removeObject:(id)design];
}
- (NSObject<Designable>*) getDesign:(NSUInteger)index
{
    return (NSObject<Designable>*)[designs objectAtIndex:index];
}
- (void) dealloc
{
    [designs release];
    [super dealloc];
}
@end

#pragma mark -
#pragma mark Design Creation

NSObject<Designable>* makeHouseDesign()
{
    LevelDesign* house = [[LevelDesign alloc] initWithDescription:@"My House"];
    [house add:[[[Dimentions alloc] initWithDescription:@"pretty large"] autorelease]];
    [house add:[[[Materials alloc] initWithDescription:@"extra strong"] autorelease]];
    [house add:[[[LevelDesign alloc] initWithDescription:@"First Floor"] autorelease]];
    [[house getDesign:2] add:[[[Dimentions alloc] initWithDescription:@"high enough"] autorelease]];
    [[house getDesign:2] add:[[[Materials alloc] initWithDescription:@"exclusive"] autorelease]];
    [house add:[[[LevelDesign alloc] initWithDescription:@"Roof"] autorelease]];
    [[house getDesign:3] add:[[[Materials alloc] initWithDescription:@"glass"] autorelease]];
    return house;
}

#pragma mark -
#pragma mark Client

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSObject<Designable>* houseProject = makeHouseDesign();
    [houseProject present];
    [houseProject release];
    
    [pool drain];
    return 0;
}
