//  Builder.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/8/10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>


#pragma mark -
#pragma mark Abstract Story Builder

/*! \brief Builder
 */
@interface StoryBuilder : NSObject
{
    NSMutableString* story;
}
@property (nonatomic, retain) NSMutableString* story;
- (void) setIntroduction;
- (void) setPlot;
- (void) setEnding;
@end

@implementation StoryBuilder
@synthesize story;
- (id)   init            
{
    if ([super init] != nil)
        story = [[NSMutableString alloc] init];
    return self;
}
- (void) setIntroduction {}
- (void) setPlot         {}
- (void) setEnding       {}
- (void) dealloc         
{
    if (story != nil)
        [story release];
    [super dealloc];
}
@end

#pragma mark -
#pragma mark Commedy Story Builders

/*! \brief Concrete Builder
 */
@interface CommedyBuilder : StoryBuilder
@end
@implementation CommedyBuilder
- (void) setIntroduction { [self.story appendString:@"com int\n"]; }
- (void) setPlot         { [self.story appendString:@"com plot\n"]; }
- (void) setEnding       { [self.story appendString:@"com end\n"]; }
@end

#pragma mark -
#pragma mark Horror Story Builders

/*! \brief Concrete Builder
 */
@interface HorrorBuilder : StoryBuilder
@end
@implementation HorrorBuilder
- (void) setIntroduction { [self.story appendString:@"horror int\n"]; }
- (void) setPlot         { [self.story appendString:@"horror plot\n"]; }
- (void) setEnding       { [self.story appendString:@"horror end\n"]; }
@end

#pragma mark -
#pragma mark Story Writer

/*! \brief Director
 */
@interface StoryWriter : NSObject
{
    StoryBuilder* storyBuilder;
}
@property (nonatomic, retain) StoryBuilder* storyBuilder;
- (void)      createStory;
- (NSString*) getStory;
@end

@implementation StoryWriter
@synthesize storyBuilder;
- (void) createStory
{
    [storyBuilder setIntroduction];
    [storyBuilder setPlot];
    [storyBuilder setEnding];
}
- (NSString*) getStory { return [storyBuilder story]; }
@end

#pragma mark -
#pragma mark Helpful function

/*! \brief Client
 */
void writeStory(StoryBuilder* storyBuilder)
{
    StoryWriter* storyWriter = [[StoryWriter alloc] init];
    
    storyWriter.storyBuilder = storyBuilder;
    [storyWriter createStory];
    NSLog(@"%@", [storyWriter getStory]);
    
    [storyWriter release];
}

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    StoryBuilder* storyBuilder = [[CommedyBuilder alloc] init];
    writeStory(storyBuilder);
    [storyBuilder release];
    
    storyBuilder = [[HorrorBuilder alloc] init];
    writeStory(storyBuilder);
    [storyBuilder release];
    
    [pool drain];
    return 0;
}

