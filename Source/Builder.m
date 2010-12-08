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
- (void) setIntroduction { [self.story appendString:@"Two friends talking.\n"]; }
- (void) setPlot         { [self.story appendString:@"How many people works in your company?\n"]; }
- (void) setEnding       { [self.story appendString:@"No more than a half :)\n"]; }
@end

#pragma mark -
#pragma mark Horror Story Builders

/*! \brief Concrete Builder
 */
@interface HorrorBuilder : StoryBuilder
@end
@implementation HorrorBuilder
- (void) setIntroduction { [self.story appendString:@"Girl is wandering in the forest.\n"]; }
- (void) setPlot         { [self.story appendString:@"Someone starts chasing her!\n"]; }
- (void) setEnding       { [self.story appendString:@"And ... he kills that girl :(\n"]; }
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

