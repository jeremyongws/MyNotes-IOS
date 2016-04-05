//
//  ViewController.m
//  MyNotes
//
//  Created by Jeremy Ong on 05/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "NotesViewController.h"
#import "ContentViewController.h"
#import "GroupViewController.h"

@interface NotesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property AVAudioPlayer *audioPlayer;

@end

@implementation NotesViewController

- (void)viewDidLoad {
	NSString *path = [NSString stringWithFormat:@"%@/wind.mp3", [[NSBundle mainBundle] resourcePath]];
	NSURL *soundUrl = [NSURL fileURLWithPath:path];
	
	// Create audio player object and initialize with URL to sound
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	UISwipeGestureRecognizer *gestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
	[gestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
	UISwipeGestureRecognizer *gestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
	[gestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[[self view] addGestureRecognizer:gestureRecognizerLeft];
	[[self view] addGestureRecognizer:gestureRecognizerRight];

	
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onSwipeRight:(id)sender {
	[[self audioPlayer] play];
}

- (IBAction)onSwipeLeft:(id)sender {
	[[self audioPlayer] play];
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


//- (void)viewDidAppear:(BOOL)animated{
//	[self.tableView reloadData];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	NSString *title = [[self.notes objectAtIndex:[indexPath row]] title];
	NSString *content = [[self.notes objectAtIndex:[indexPath row]] content];
	cell.textLabel.text = title;
	cell.imageView.image = [UIImage imageNamed:@"logo"];
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
	if ([[segue identifier] isEqualToString:@"AddNoteSegue"]){
		destination.note = [Note new];
		destination.note.title = @"";
		destination.editing = NO;
		self.note = destination.note;
		[self.notes addObject:destination.note];
	} else if ([[segue identifier] isEqualToString:@"ShowNoteSegue"]) {
		destination.note = [self.notes objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
		destination.editing = YES;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self performSegueWithIdentifier:@"ShowNoteSegue" sender:cell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.notes count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	UIAlertController *deleteController = [UIAlertController alertControllerWithTitle:@"Are you sure" message:@"you want to delete this?" preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"DELETE" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
		[self.notes removeObjectAtIndex:[indexPath row]];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
		[[self audioPlayer] play];
		
	}];;
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
		[self.tableView setEditing:NO];
	}];;
	
	[deleteController addAction:deleteAction];
	[deleteController addAction:cancelAction];
	[self presentViewController:deleteController animated:YES completion:nil];
	
}


@end
