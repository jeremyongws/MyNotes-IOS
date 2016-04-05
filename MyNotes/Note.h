//
//  Note.h
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property NSString* title;
@property NSString* content;

+ (Note*)initWithTitle:(NSString*)title andContent:(NSString*)content;

@end
