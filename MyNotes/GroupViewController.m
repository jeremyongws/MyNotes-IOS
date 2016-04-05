//
//  GroupViewController.m
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GroupViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.groups = [self populateGroups];
	
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//	[self performSegueWithIdentifier:@"ShowGroupSegue" sender:cell];
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	NotesViewController *destination = segue.destinationViewController;
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	destination.notes = [[self.groups objectAtIndex:[indexPath row]] notes];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
	cell.textLabel.text = [[self.groups objectAtIndex:[indexPath row]] title];
	return cell;
}



/*
don't kacau
*/

- (NSMutableArray*)populateGroups{
	Note *noteOne = [Note initWithTitle:@"I am title One" andContent:@"lulz"];
	Note *noteTwo = [Note initWithTitle:@"I am title Two" andContent:@"lulz2"];
	Note *noteThree = [Note initWithTitle:@"I am title Three" andContent:@"lulz312309128418748109380918309128490128903012983019283091283098120938019"];
	Note *noteFour = [Note initWithTitle:@"I am title Four" andContent:@"lulz"];
	Note *noteFive = [Note initWithTitle:@"I am title Five" andContent:@"lulz2"];
	Note *noteSix = [Note initWithTitle:@"I am title Six" andContent:@"lulz312309128418748109380918309128490128903012983019283091283098120938019"];
	Note *noteSeven = [Note initWithTitle:@"I am title Seven" andContent:@"lulz"];
	Note *noteEight = [Note initWithTitle:@"I am title Eight" andContent:@"lulz2"];
	Note *noteNine = [Note initWithTitle:@"I am title Nine" andContent:@"lulz312309128418748109380918309128490128903012983019283091283098120938019"];
	
	NSMutableArray *arrayOne = [[NSMutableArray alloc] initWithObjects:noteOne, noteTwo, noteThree, nil];
	NSMutableArray *arrayTwo = [[NSMutableArray alloc] initWithObjects:noteFour, noteFive, noteSix, nil];
	NSMutableArray *arrayThree = [[NSMutableArray alloc] initWithObjects:noteSeven, noteEight, noteNine, nil];
	
	Group *groupOne = [Group new];
	Group *groupTwo = [Group new];
	Group *groupThree = [Group new];
	groupOne.title = @"Jigglypuff";
	groupTwo.title = @"Wigglybuff";
	groupThree.title = @"Mr Buff";
	groupOne.notes = arrayOne;
	groupTwo.notes = arrayTwo;
	groupThree.notes = arrayThree;
	
	NSMutableArray *tempGroups = [[NSMutableArray alloc] initWithObjects:groupOne, groupTwo, groupThree, nil];
	
	return tempGroups;
	
}

@end
