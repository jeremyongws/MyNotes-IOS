//
//  ViewController.m
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"
#import "GroupViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *notes;
@end

@implementation RootViewController

- (void)viewDidLoad {
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	Note *noteOne = [Note initWithTitle:@"I am title One" andContent:@"lulz"];
	Note *noteTwo = [Note initWithTitle:@"I am title Two" andContent:@"lulz2"];
	Note *noteThree = [Note initWithTitle:@"I am title Three" andContent:@"lulz312309128418748109380918309128490128903012983019283091283098120938019"];
	self.notes = [[NSMutableArray alloc] initWithObjects:noteOne, noteTwo, noteThree, nil];
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onEditButtonPressed:(id)sender {
	if ([[self tableView] isEditing]){
		self.tableView.editing = NO;
	} else {
		self.tableView.editing = YES;
	}
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated{
	[self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	NSString *title = [[self.notes objectAtIndex:[indexPath row]] title];
	NSString *content = [[self.notes objectAtIndex:[indexPath row]] content];
	cell.textLabel.text = title;
	if ([content length] < 15){
		cell.detailTextLabel.text = content;
	} else {
		NSString *snippet = [content substringToIndex:14];
		cell.detailTextLabel.text = snippet;
	}
	
	return cell;
}

- (IBAction)onPlusButtonPressed:(id)sender {
	[self performSegueWithIdentifier:@"AddNoteSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	ContentViewController *destination = segue.destinationViewController;
	GroupViewController *groupDestination = segue.destinationViewController;
	if ([[segue identifier] isEqualToString:@"AddNoteSegue"]){
		destination.note = [Note new];
		destination.note.title = @"";
		destination.editing = NO;
		self.note = destination.note;
		[self.notes addObject:destination.note];
	} else if ([[segue identifier] isEqualToString:@"ShowNoteSegue"]) {
		destination.note = [self.notes objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
		destination.editing = YES;
	} else if ([[segue identifier] isEqualToString:@"AddToGroup"]){
		groupDestination.notes = self.notes;
	}
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self performSegueWithIdentifier:@"ShowNoteSegue" sender:cell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.notes count];
}

@end
