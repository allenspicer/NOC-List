//
//  MasterViewController.m
//  NOC List
//
//  Created by Ben Gohlke on 1/28/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Agent.h"

@interface MasterViewController ()

@property NSMutableArray *agents;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    // 3. Set the title of the view to "NOC List"
    //
    self.title = @"NOC List";
    
    //
    // 4. Initialize the agents array as an NSMutableArray
    //
    //multiple ways to do this. Below is one, others are
    //NSMutableArray *myMutableArray = [[NSMutableArray new];
    //NSMutableArray *myMutableArray = [[NSMutableArray array];
    
    self.agents = [[NSMutableArray alloc]init];


    //
    // 5. Call the method loadNocList so the tableview will actually have objects to load into its cells.
    //
    [self loadNocList];
    
}

- (void)loadNocList
{
    // This creates a string with the filepath to the NOC List JSON file.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NOC" ofType:@"json"];
    // This is a built in method that allows us to load a JSON file into native Cocoa objects (NSDictionaries and NSArrays).
    NSArray *agents = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    //
    // 6. Once we have an array of dictionaries, we need to iterate over them and convert them into Agent objects.
   
   // if ([agents count]>0){

    
    //    Type in "forin" below. It should offer code completion for a for-in loop. Just hit enter to accept it.
    //    Use the "agents" array from above as the array to iterate over. Create an NSDictionary object on the left side
    //    of the for-in loop. You will use this inside the for loop to create an Agent object.
    
    //Classic creation of For Loop/forin:
    //swift deleted ++ and maybe i +=1 but i+1 does the same thing
        
   // for (int i = 0; i<= agents.count - 1 ; i = i+1 ){
     //  NSLog(@"%@", [agents[i] valueForKey:@"agentName"]);
       // }
    //}
    
    
    //alternative creation of For Loop/forin. Identical product:
        
    for (NSDictionary*anAgentDictionary in agents) {
        Agent*someAgent = [Agent agentWithDictionary:anAgentDictionary];
        [self.agents addObject:someAgent];
    
        }
    
    //
    // 7. Now that we have agent objects, call a method to instruct the table to reload its data.
    //
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
    // 8. We need to set the segue identifier to the same one we used in the segue on the storyboard
    //
    if ([[segue identifier] isEqualToString:@"DetailIdentifier"])
    {
        //
        // 9. We need to get an NSIndexPath for the selected cell
        //
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(sender)];

        //
        // 10. Now we're going to use the "row" property of the indexPath from above to pull out the associated Agent object
        //     from the agents array.
        //
        Agent *selectedAgent = self.agents[indexPath.row];
        
        //
        // 11. Now we need to send this Agent object to the detail view controller so it know's which agent's info to show.
        //     See the method call below on the segue object for how to get a handle to the detail view controller.
        //
        //     How would we go about setting this agent object?
        //

//sending Agent object from master view controller to detail view controller
       
        DetailViewController *destinationViewController =  [segue destinationViewController];

        destinationViewController.agent = selectedAgent;
    
    }
        }


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //
    // 12. How do we tell the table view how many rows we need?
    //
    //
    //self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    return self.agents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    // 13. We need the tableview to dequeue a cell for us to use. This will either pull an unused cell and give it to us to
    //     reuse, or it will create a brand new cell. In either case, we need to make sure to set/reset all the UI elements
    //     so we don't show stale data.
    //
    //     The method call below will perform this dequeuing operation. What should we set as the identifier?
    //
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentIdentifier" forIndexPath:indexPath];

    //
    // 14. We need to get a handle to the appropriate Agent object. How do we do that? (hint: we've done this already ^)
    //
    Agent *anAgent = self.agents[indexPath.row];
    
    //
    // 15. The cell needs to show both the cover name and the real name of the agent. Since we are using one of the built-in
    //     cell types, the "cell" object above has properties for these two labels already. How do we assign those?
    //
    
    cell.textLabel.text = anAgent.coverName;
    cell.detailTextLabel.text = anAgent.realName;
    
    //
    // 16. This method is supposed to give a cell back to its caller. How do we do that? Why is this method currently
    //     throwing an error?
    //
    
    return cell;
    
}

@end