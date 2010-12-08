//  AbstractFactory.m
//  ObjC_Patterns_Kata
//
//  Created by Zbigniew Kominek on 12/8/10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>


#pragma mark -
#pragma mark Abstract Widget Family

/*! \brief Abstract Product
 */
@interface ScrollBar : NSObject
@end
@implementation ScrollBar
@end

/*! \brief Abstract Product
 */
@interface Window : NSObject 
@end
@implementation Window
@end

/*! \brief Abstract Factory
 */
@interface WidgetFactory : NSObject 
- (ScrollBar*) createScrollBar;
- (Window*)    createWindow;
@end
@implementation WidgetFactory
- (ScrollBar*) createScrollBar  { return nil; }
- (Window*)    createWindow     { return nil; }
@end


#pragma mark -
#pragma mark Mac Widget Family

/*! \brief Concrete Product
 */
@interface MacScrollBar : ScrollBar 
@end
@implementation MacScrollBar
@end

/*! \brief Concrete Product
 */
@interface MacWindow : Window 
@end
@implementation MacWindow
@end

/*! \brief Concrete Factory
 */
@interface MacWidgetFactory : WidgetFactory 
@end
@implementation MacWidgetFactory
- (ScrollBar*) createScrollBar  { return [[[MacScrollBar alloc] init] autorelease]; }
- (Window*) createWindow        { return [[[MacWindow alloc] init] autorelease]; }
@end


#pragma mark -
#pragma mark Linux Widget Family

/*! \brief Concrete Product
 */
@interface LinuxScrollBar : ScrollBar 
@end
@implementation LinuxScrollBar
@end

/*! \brief Concrete Product
 */
@interface LinuxWindow : Window 
@end
@implementation LinuxWindow
@end

/*! \brief Concrete Factory
 */
@interface LinuxWidgetFactory : WidgetFactory 
@end
@implementation LinuxWidgetFactory
- (ScrollBar*) createScrollBar  { return [[[LinuxScrollBar alloc] init] autorelease]; }
- (Window*) createWindow        { return [[[LinuxWindow alloc] init] autorelease]; }
@end


#pragma mark -
#pragma mark Helpful Functions

/*! \brief Client
 *         This function uses only interfaces declared in abstract factory and abstract products. 
 *  \param Instance of class inherited from abstract factory
 */
void createWidgets(WidgetFactory* widgetFactory)
{
    Window* window = [widgetFactory createWindow];
    NSLog(@"Window class   : %@", [window class]);
    
    ScrollBar* scrollBar = [widgetFactory createScrollBar];
    NSLog(@"ScrollBar class: %@", [scrollBar class]);
}


#pragma mark -

int main (int argc, const char * argv[]) 
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    WidgetFactory* widgetFactory = [[MacWidgetFactory alloc] init];
    createWidgets(widgetFactory);
    [widgetFactory release];
    
    widgetFactory = [[LinuxWidgetFactory alloc] init];
    createWidgets(widgetFactory);
    [widgetFactory release];
    
    [pool drain];
    return 0;
}
