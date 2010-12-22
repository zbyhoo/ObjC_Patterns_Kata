//  Facade.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/22/10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Company's Divisions

/*! \brief Subsystem
 */
@interface HumanResourcesDepartment : NSObject
- (void) fireWorkerWithName:(NSString*)name;
@end
@implementation HumanResourcesDepartment
- (void) fireWorkerWithName:(NSString*)name { NSLog(@"Firing employee: %@", name); }
@end

/*! \brief Subsystem
 */
@interface AccountancyDepartment : NSObject
- (void) increaseSalaryForEmployee:(NSString*)name;
@end
@implementation AccountancyDepartment
- (void) increaseSalaryForEmployee:(NSString*)name { NSLog(@"Increasing salary for: %@", name); }
@end

/*! \brief Subsystem
 */
@interface PublicRelationsDepartment : NSObject
- (void) tvCommercial;
- (void) freeBeerForEveryone;
@end
@implementation PublicRelationsDepartment
- (void) tvCommercial { NSLog(@"TV Commerial: Best company in the universe."); }
- (void) freeBeerForEveryone { NSLog(@"Free beer for every employee"); }
@end


#pragma mark -
#pragma mark The Secretary

/*! \brief Facade
 */
@interface Secretary : NSObject
{
    HumanResourcesDepartment*  hr;
    AccountancyDepartment*     ac;
    PublicRelationsDepartment* pr;
}
- (id) initWithHRDep:   (HumanResourcesDepartment*)   hrDep 
       accountancy:     (AccountancyDepartment*)      acDep 
       publicRelations: (PublicRelationsDepartment*)  prDep;
- (void) fireBestWorker;
- (void) giveBossARise;
- (void) tellEveryoneCompanyIsTheBest;
@end
@implementation Secretary
- (id) initWithHRDep:   (HumanResourcesDepartment*)   hrDep 
       accountancy:     (AccountancyDepartment*)      acDep 
       publicRelations: (PublicRelationsDepartment*)  prDep
{
    if ([super init] != nil)
    {
        hr = [hrDep retain];
        ac = [acDep retain];
        pr = [prDep retain];
    }
    return self;
}
- (void) fireBestWorker { [hr fireWorkerWithName:@"Zbigniew Kominek"]; }
- (void) giveBossARise { [ac increaseSalaryForEmployee:@"The Boss"]; }
- (void) tellEveryoneCompanyIsTheBest 
{
    [pr tvCommercial];
    [pr freeBeerForEveryone];
}
- (void) dealloc
{
    [hr release];
    [ac release];
    [pr release];
    [super dealloc];
}
@end


#pragma mark -
#pragma mark The Boss

/*! \brief Client
 */
@interface Boss : NSObject
{
    Secretary* secretary;
}
- (id)   initWithSecretary:(Secretary*)newSecretary;
- (void) doMyJob;
@end
@implementation Boss
- (id) initWithSecretary:(Secretary*)newSecretary
{
    if ([super init] != nil)
    {
        secretary = [newSecretary retain];
    }
    return self;
}
- (void) doMyJob
{
    [secretary giveBossARise];
    [secretary fireBestWorker];
    [secretary tellEveryoneCompanyIsTheBest];
}
- (void) dealloc
{
    [secretary release];
    [super dealloc];
}
@end


#pragma mark -
#pragma mark Helpful function

Secretary* buildTheCompany()
{
    HumanResourcesDepartment* hrDep = [[[HumanResourcesDepartment alloc] init] autorelease];
    AccountancyDepartment* acDep = [[[AccountancyDepartment alloc] init] autorelease];
    PublicRelationsDepartment* prDep = [[[PublicRelationsDepartment alloc] init] autorelease];
    Secretary* secretary = [[Secretary alloc] initWithHRDep:hrDep accountancy:acDep publicRelations:prDep];
    return secretary;
}


#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    Secretary* secretary = buildTheCompany();
    Boss* boss = [[Boss alloc] initWithSecretary:secretary];

    [boss doMyJob];
    
    [secretary release];
    [boss release];
    
    [pool drain];
    return 0;
}
