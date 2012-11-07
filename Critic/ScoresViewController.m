//
//  ScoresViewController.m
//  Critic
//
//  Created by Brian Soule on 11/5/12.
//  Copyright (c) 2012 Brian Soule. All rights reserved.
//

#import "ScoresViewController.h"

@interface ScoresViewController ()

@end

@implementation ScoresViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // auth token example: THkpzDLy5Yopn2DpPmsg
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSURL *url = [NSURL URLWithString:@"https://www.saygent.com/api/v2/recordings?auth_token=THkpzDLy5Yopn2DpPmsg"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    //NSString *requestBodyString = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    //NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    //[request setHTTPBody:requestBody];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    if (!requestError) {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData //1
                              
                              options:kNilOptions
                              error:&requestError];
        
        NSString* recordings = [json objectForKey:@"recordings"];
        NSLog(@"recordings: %@", recordings);
        
        scoresDictionary = json;
        
        [self.tableView reloadData];
        
       // if (token) {
           // NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
           // [data setObject:token forKey:@"authToken"];
           // [data synchronize];
            
            
            
            //[UserData sharedInstance].authToken = token;
           // [[self delegate] authQueryFinished:YES];
      //  }
      //  else {
            //[[self delegate] authQueryFinished:NO];
      //  }
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"responseString: %@",responseString);
    }
    else {
        //Error
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    if(scoresDictionary){
//        return [scoresDictionary count];
//    }
    
//    else{
    
    
        return 4;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
    }
    
    // Configure the cell...
    
    NSArray *scores = [scoresDictionary objectForKey:@"recordings"];
    
    for(NSDictionary *score in scores) {
       cell.textLabel.text =  [score objectForKey:@"audio_url"]; 
    }
    
    return cell;
    
    
//    [tableView registerClass:forCellReuseIdentifier:CellIdentifier];
//    
//     registerNib:forCellReuseIdentifier: or
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    ProfileCell *cell = (ProfileCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    Profiles * profile = [self.profilelist objectAtIndex:indexPath.row];
//    
//    cell.nameLabel.text = profile.profile_name;
//    cell.biztypeLabel.text = profile.biz_type_desc;
//    
//    // Configure the cell...
//    
//    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
