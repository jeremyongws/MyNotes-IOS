//
//  Note.m
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "Note.h"

@implementation Note

+ (Note*)initWithTitle:(NSString*)title andContent:(NSString *)content{
	Note *note = [Note new];
	note.title = title;
	note.content = content;
	return note;
}

@end
