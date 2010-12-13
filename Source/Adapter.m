//  Adapter.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/13/10.
//  Copyright 2010. All rights reserved.

#pragma mark -
#pragma mark Dormitory

/*! \brief Target's interface
 */
@protocol PartyMakeable
- (void) makeParty;
@end

/*! \brief Client
 */
@interface Dormitory : NSObject
{
    NSArray* students;
}
@property (nonatomic, retain) NSArray* students;
- (void) makeBigParty;
@end

@implementation Dormitory
@synthesize students;
- (void) makeBigParty
{
    NSEnumerator* e = [students objectEnumerator];
    id object;
    while (object = [e nextObject])
    {
        if ([object conformsToProtocol:@protocol(PartyMakeable)])
        {
            [object makeParty];
        }
        else 
        {
            NSLog(@"What the ...!");
        }
    }
}
- (void) dealloc
{
    if (students != nil)
    {
        [students release];
    }
    [super dealloc];
}
@end

#pragma mark -
#pragma mark Students

/*! \brief Target
 */
@interface Student : NSObject <PartyMakeable>
@end
@implementation Student
- (void) makeParty { NSLog(@"Party, yeah!!!"); }
@end

/*! \brief Adaptee
 */
@interface RookieStudent : NSObject
- (void) littleDance;
@end
@implementation RookieStudent
- (void) littleDance { NSLog(@"Shall we dance?"); }
@end

/*! \brief Adapter
 */
@interface RookieStudentAdapter : NSObject <PartyMakeable>
{
    RookieStudent* rookieStudent;
}
@end
@implementation RookieStudentAdapter
- (id) init
{
    if ([super init] != nil)
    {
        rookieStudent = [[RookieStudent alloc] init];
    }
    return self;
}
- (void) makeParty { [rookieStudent littleDance]; }
- (void) dealloc
{
    [rookieStudent release];
    [super dealloc];
}
@end

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    Student* student = [[Student alloc] init];
    RookieStudentAdapter* rookieStudent = [[RookieStudentAdapter alloc] init];
                        
    Dormitory* dormitory = [[Dormitory alloc] init];
    NSArray* students = [[NSArray alloc] initWithObjects: student, rookieStudent, nil];
    
    [student release];
    [rookieStudent release];
    
    dormitory.students = students;
    [students release];
    
    [dormitory makeBigParty];
    [dormitory release];
    
    [pool drain];
    return 0;
}
