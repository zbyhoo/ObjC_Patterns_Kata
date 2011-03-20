//  ChainOfResponsibility.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 3/20/11.
//  Copyright 2011. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Worker description

/*! \brief Handler
 */
@protocol DoTheJob
- (void)workHard;
- (void)getTheBonus;
@property (nonatomic, retain) NSObject<DoTheJob> *worker;
@end

#pragma mark -
#pragma mark Type of workers

/*! \brief Concrete Handler
 */
@interface Manager : NSObject <DoTheJob> {
@private
    NSObject<DoTheJob> *_worker;
}
@end
@implementation Manager
@synthesize worker = _worker;
- (void)workHard {
    NSLog(@"%@: Someone should do it for me...", self.class);
    [self.worker workHard]; 
}
- (void)getTheBonus   { NSLog(@"%@: bonus, at last", self.class); }
@end

/*! \brief Concrete Handler
 */
@interface SoftwareDeveloper : NSObject <DoTheJob> {
@private
    NSObject<DoTheJob> *_worker;
}
@end
@implementation SoftwareDeveloper
- (NSObject<DoTheJob>*)worker { NSLog(@"I have to do it myself."); return nil; }
- (void)setWorker:(NSObject<DoTheJob> *)worker { NSLog(@"It will never happen"); }
- (void)workHard      { NSLog(@"%@: Ok, I'll do it on saturday and sunday.", self.class); }
- (void)getTheBonus   { NSLog(@"%@: Wow, I didn't expect it.", self.class); }
@end

/*! \brief Client
 */
@interface BossOfTheBigCo : NSObject {
@private
    NSObject<DoTheJob> *_worker;
}
@property (nonatomic, retain) NSObject<DoTheJob> *worker;
@end
@implementation BossOfTheBigCo
@synthesize worker = _worker;
@end


#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    BossOfTheBigCo *theBoss = [[[BossOfTheBigCo alloc] init] autorelease];
    theBoss.worker = [[[Manager alloc] init] autorelease];
    theBoss.worker.worker = [[[SoftwareDeveloper alloc] init] autorelease];
    
    [theBoss.worker workHard];
    [theBoss.worker getTheBonus];
    
    [pool drain];
    return 0;
}