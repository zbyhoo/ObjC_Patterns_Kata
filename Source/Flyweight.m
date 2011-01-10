//  Flyweight.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 1/10/11.
//  Copyright 2011. All rights reserved.

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Objects for rental

/*! \brief Flyweight
 */
@protocol Playable
@property (nonatomic, retain) NSString* title;
- (void) play:(NSString*)fromPosition;
@end

/*! \brief Concrete Flyweight
 */
@interface DvdMovie : NSObject <Playable>
{
    NSString* title;
}
@end
@implementation DvdMovie
@synthesize title;
- (void) play:(NSString*)fromPosition 
{ 
    NSLog(@"Playing \"%@\" starting from %@", self.title, fromPosition); 
}
@end

#pragma mark -
#pragma mark Rental

/*! \brief Flyweight Factory
 */
@interface MovieRental : NSObject
{
    NSMutableArray* movies;
}
- (NSObject<Playable>*) getMovie:(NSString*)title;
@end
@implementation MovieRental
- (id) init
{
    if ([super init] != nil)
    {
        movies = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSObject<Playable>*) getMovie:(NSString*)title 
{
    NSEnumerator* e = [movies objectEnumerator];
    NSObject<Playable>* movie;
    while (movie = (NSObject<Playable>*)[e nextObject])
    {
        if ([movie.title compare:title] == NSOrderedSame)
        {
            NSLog(@"Movie already in use.");
            return movie;
        }
    }
    
    NSLog(@"Making new copy.");
    DvdMovie* newMovie = [[DvdMovie alloc] init];
    newMovie.title = title;
    [movies addObject:newMovie];
    
    return [newMovie autorelease];
}
- (void) dealloc
{
    [movies release];
    [super dealloc];
}
@end

#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    MovieRental* movieRental = [[[MovieRental alloc] init] autorelease];
    
    //client 1
    NSObject<Playable>* client1Movie = [movieRental getMovie:@"Rambo"];
    [client1Movie play:@"the beginning"];
    
    //client 2
    NSObject<Playable>* client2Movie = [movieRental getMovie:@"Rush Hours"];
    [client2Movie play:@"the middle"];
    
    //client 3
    NSObject<Playable>* client3Movie = [movieRental getMovie:@"Rambo"];
    [client3Movie play:@"the end"];
    
    [pool drain];
    return 0;
}

