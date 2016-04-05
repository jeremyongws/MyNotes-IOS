//
//  ContentViewController.m
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ContentViewController

- (void)viewDidLoad {
	if (self.editing){
		[self.button setTitle:@"Edit Note" forState:UIControlStateNormal];
	} else {
		[self.button setTitle:@"Add Note" forState:UIControlStateNormal];
	}
	self.noteTitle.text = [[self note] title];
	self.noteContent.text = [[self note] content];
	
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
	
	self.note.title = self.noteTitle.text;
	self.note.content = self.noteContent.text;
	
	
	[super viewWillDisappear:animated];
}

@end
