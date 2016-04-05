//
//  ContentViewController.h
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface ContentViewController : UIViewController

@property Note *note;
@property BOOL editing;

@end
