//
//  ViewController.m
//  WorldCup
//
//  Created by hdz on 2018/6/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "ViewController.h"
#import "TeamCell.h"
#import <CoreData/CoreData.h>
#import "Team+CoreDataClass.h"
static  NSString *const teamCellIdentifier = @"teamCellReuseIdentifier";
@interface ViewController ()<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController<Team *> *fetchResultsController;
@end
@implementation ViewController
-(NSFetchedResultsController<Team *> *)fetchResultsController{
    if (!_fetchResultsController) {
        NSFetchRequest<Team *> *fetchRequest = [Team fetchRequest];
        NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"teamName" ascending:YES];
        NSSortDescriptor *scoreDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"wins" ascending:NO];
        NSSortDescriptor *zoneDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"qualifyingZone" ascending:YES];
        [fetchRequest setSortDescriptors:@[zoneDescriptor,scoreDescriptor,nameDescriptor]];
        //“NSFetchedResultsController’s section cache is very sensitive to changes in its fetch request”
        _fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.coreDataStack.managedContext sectionNameKeyPath:@"qualifyingZone" cacheName:@"worldCup"];
        _fetchResultsController.delegate = self;
    }
    return _fetchResultsController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    [self.fetchResultsController performFetch:&error];
    if (error) {
        NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
    }
}

- (void)configureTableViewCell:(TeamCell *)cell forIndexPath:(NSIndexPath *)path{
    Team *team = [self.fetchResultsController objectAtIndexPath:path];
    cell.teamLabel.text = team.teamName;
    cell.flagImageView.image = [UIImage imageNamed:team.imageName];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%d",team.wins];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:teamCellIdentifier forIndexPath:indexPath];
    [self configureTableViewCell:cell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchResultsController.sections[section];
    if (!sectionInfo) {
        return 0;
    }
    return sectionInfo.numberOfObjects;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *sections = self.fetchResultsController.sections;
    if (!sections) {
        return 0;
    }
    return sections.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Team *team = [self.fetchResultsController objectAtIndexPath:indexPath];
    team.wins = team.wins + 1;
    [self.coreDataStack saveContext];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchResultsController.sections[section];
    return sectionInfo.name;
}
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:{
            TeamCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [self configureTableViewCell:cell forIndexPath:indexPath];
        }
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion== UIEventSubtypeMotionShake) {
        [self.addButton setEnabled:YES];
        
    }
}
- (IBAction)addTeam:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Secret Team" message:@"Add a new team" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Team name";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Qualifying Zone";
    }];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameTextField = alert.textFields.firstObject;
        UITextField *zoneTextField = alert.textFields.lastObject;
        if (nameTextField && zoneTextField) {
            Team *team = [[Team alloc] initWithContext:self.coreDataStack.managedContext];
            team.teamName = nameTextField.text;
            team.qualifyingZone = zoneTextField.text;
            team.imageName = @"wenderland-flag";
            [self.coreDataStack saveContext];
        }
    }];
    [alert addAction:save];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
