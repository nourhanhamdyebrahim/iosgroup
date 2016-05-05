//
//  AllDaysViewController.m
//  sqlProject
//
//  Created by JETS on 4/29/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "AllDaysViewController.h"

@interface AllDaysViewController ()

@end

@implementation AllDaysViewController
{
    NSArray *sesssionArray;
    ManagerClass *db;
    UIRefreshControl *refreshControl;
    UITableViewController *tableViewController;
    AgendaModel *agendaModel;

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    db = [ManagerClass myManagerObjectMethod ];
//    NSLog(@"in view did load of agenda");
//    _sesstionArr= [NSMutableArray new];
//    AgendaModel *agendaModel = [AgendaModel new];
//    
//    [agendaModel test];
//    [agendaModel setShowdataDelegate:self];
//   // NSLog(@"view did load agendatable");
//
//  self.navigationItem.hidesBackButton=YES;
//    _allDays.backgroundColor = [UIColor clearColor];
//    UIImageView * bgImage =[[UIImageView alloc]initWithFrame:self.view.frame];
//    
//    bgImage.image = [UIImage imageNamed:@"MDW 2016 Mobile APP-01.png"];
//    [self.view addSubview:bgImage];
//    [self.view sendSubviewToBack:bgImage];
    // Do any additional setup after loading the view.
    db = [ManagerClass myManagerObjectMethod ];
    _sesstionArr= [NSMutableArray new];
    
    agendaModel = [AgendaModel new];
    
    tableViewController=[[UITableViewController alloc]init];
    tableViewController.tableView=self.allDays;
    refreshControl=[[UIRefreshControl alloc] init];
    refreshControl.backgroundColor=[UIColor clearColor];
    refreshControl.tintColor=[UIColor blueColor];
    refreshControl.alpha=0.50;
    [refreshControl addTarget:self action:@selector(getdata) forControlEvents:UIControlEventValueChanged];
    [self getdata];
    [self performSelectorOnMainThread:@selector(rerenderTable) withObject:nil waitUntilDone:NO];
   tableViewController.refreshControl=refreshControl;
    
}

- (void) getdata
{
    
    NSLog(@"in view did load of agenda");
    
    //[self performSelectorOnMainThread:@selector(rerenderTable) withObject:nil waitUntilDone:NO];
    //tableViewController.refreshControl=refreshControl;
    [agendaModel test];
    [agendaModel setShowdataDelegate:self];
    // NSLog(@"view did load agendatable");
    
    self.navigationItem.hidesBackButton=YES;
    _allDays.backgroundColor = [UIColor clearColor];
    UIImageView * bgImage =[[UIImageView alloc]initWithFrame:self.view.frame];
    
    bgImage.image = [UIImage imageNamed:@"MDW 2016 Mobile APP-01.png"];
    [self.view addSubview:bgImage];
    [self.view sendSubviewToBack:bgImage];
    
}

-(void)rerenderTable
{   UITableView *tableView=[[UITableView alloc] init];
    [tableView reloadData];
    if(refreshControl){
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d,h:mm a"];
        NSString *title=[NSString stringWithFormat:@"Last update: %@",[formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary=[NSDictionary dictionaryWithObject:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle=[[NSAttributedString alloc]initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle=attributedTitle;
        [refreshControl endRefreshing];
        
        
    }
    
    
}

-(void) showExFromSql :(NSMutableArray *) dataArr{
    
    // NSLog(@"showExFromSql func");
    [self SorttedTheSesstionFrom:dataArr];
    
    NSLog(@"in state func of agenda = 0");
    //  NSLog(@"%@",[_exhibtorArr[1] companyName])  ;
    
    //  NSLog(@"%@", [_exhibtorArr[1] imageURLExh])  ;
    
    [self.allDays reloadData];
    
}




-(void) showDate : (NSMutableArray *) dataArr
{
    [self SorttedTheSesstionFrom:dataArr];
    [self.allDays reloadData];
    
    NSLog(@"in showDate of agenda");
    }

-(void) SorttedTheSesstionFrom:(NSMutableArray*) Agenda
{
    NSLog(@"\n \n \n \nhere in sorrted sesstion\n \n \n \n");
    NSSortDescriptor *myDescribtour = [[NSSortDescriptor alloc] initWithKey:@"startDateSession" ascending:YES];
    NSArray *theArrayOfDescriptour = [[NSArray alloc] initWithObjects:myDescribtour, nil];
    Agendas *agendaOfDay = [NSEntityDescription insertNewObjectForEntityForName:@"Agendas" inManagedObjectContext:db.context];
    
    for (int i=0; i<[Agenda count]; i++) {
        
      agendaOfDay = [Agenda objectAtIndex:i];
        if (i==0) {
        _firstSesstionArr=[[agendaOfDay sessionsAgenda] sortedArrayUsingDescriptors:theArrayOfDescriptour];
            [_sesstionArr addObjectsFromArray:_firstSesstionArr];
            NSLog(@"_firstSesstionArr : \n \n %@ \n",[_firstSesstionArr objectAtIndex:0]);
            NSLog(@"%d \n",[_sesstionArr count]);
            
        }
        else if (i==1) {
            _secoundSesstionArr=[[agendaOfDay sessionsAgenda] sortedArrayUsingDescriptors:theArrayOfDescriptour];
            [_sesstionArr addObjectsFromArray:_secoundSesstionArr];
            NSLog(@"_secoundSesstionArr: \n \n%@ \n",[_secoundSesstionArr objectAtIndex:0]);
            NSLog(@"%d \n",[_sesstionArr count]);

        }

        else {
            _thirdSesstionArr=[[agendaOfDay sessionsAgenda] sortedArrayUsingDescriptors:theArrayOfDescriptour];
            [_sesstionArr addObjectsFromArray:_thirdSesstionArr];
            NSLog(@"_thirdSesstionArr: \n \n %@ \n ",[_thirdSesstionArr objectAtIndex:0]);
            NSLog(@"%d \n",[_sesstionArr count]);

        }

    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
   return [_sesstionArr count];
    
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"dd"];
  //  NSDate*myNSDateInstance= [_agendasArr[indexPath.row] startData];
    
  //  NSString *stringFromDate = [formatter stringFromDate:myNSDateInstance];
   // cell.textLabel.text= stringFromDate;
//    NSSet * sessionsSet=[_agendasArr[indexPath.row] sessionsAgenda];
//    sesssionArray= [sessionsSet allObjects];
    cell.textLabel.text=[_sesstionArr[indexPath.row] nameSession] ;
    NSLog(@"sesstion type %@ \n \n \n ",[_sesstionArr[indexPath.row] sessionType]);
    NSLog(@"sesstion tag %@ \n \n \n ",[_sesstionArr[indexPath.row] sessionTage]);
    NSLog(@"date %@ \n \n \n ",[_sesstionArr[indexPath.row] startDateSession]);
    if([[_sesstionArr[indexPath.row] sessionType] isEqual:@"Workshop"])
    {
        cell.imageView.image=[UIImage imageNamed:@"green.png"];
    }
    else if ([[_sesstionArr[indexPath.row] sessionType] isEqual:@"Hackathon"])
    {
        cell.imageView.image=[UIImage imageNamed:@"orange.png"];
    }
    else
    {
        cell.imageView.image=[UIImage imageNamed:@"blue.png"];
    }
    NSString *firstString = @"Hello\n";
    NSString *sec = @"Is it me";
    cell.detailTextLabel.text =[_sesstionArr[indexPath.row] sessionType];
    NSDate *startDatee = [_sesstionArr[indexPath.row] startDateSession];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:startDatee];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSDateFormatter *timeFormater = [[NSDateFormatter alloc] init];
    [timeFormater setDateFormat:@"HH:mm"];
    [timeFormater setTimeZone:[NSTimeZone timeZoneWithName:@"Africa/Cairo"]];
    NSString *str = [timeFormater stringFromDate:startDatee];
    NSLog(@"%@",str);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
