//
//  detailsRepoViewController.m
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import "detailsRepoViewController.h"
#import "issuesTableCell.h"
#import "contributorsViewCell.h"
#import "MBProgressHUD.h"

@interface detailsRepoViewController ()

@end

@implementation detailsRepoViewController
{
    
    NSDictionary *repoDic;
    NSArray *arrDatos;
    NSMutableArray *arrDatosIssues;
    NSMutableArray *arrDatosCollab;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    NSLog(@"detail:  %@",self.reporitorieUrl);
    NSLog(@"view:  %@",self.viewSelector);
    
    if([self.viewSelector isEqualToString:@"issue"]){
       self.urlEnding = @"/issues";
       self.title = @"Issues";

    }else if([self.viewSelector isEqualToString:@"collab"]){
        self.title = @"Contributors";
        self.urlEnding = @"/contributors";
    }
    
    [self response];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)response;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
    
    NSString *issuesUrl = [NSString stringWithFormat:@"%@%@",self.reporitorieUrl,self.urlEnding];
    NSLog(@"%@",issuesUrl);
    NSURL *url = [NSURL URLWithString:issuesUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSArray *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
         if (data.length > 0 && connectionError == nil)
         {
             
             arrDatosIssues = [[NSMutableArray alloc] init];
             if ([greeting isKindOfClass:[NSArray class]]) {
                 [arrDatosIssues addObject:greeting];
                 
                 if( [arrDatosIssues[0] count] == 0 ){
                     

                     [self showAlertViewWithTitle:@"Lo sentimos" message:@"No existen issues en este repositorio." OptionParameter:@"Continuar"];
                 }
                 
                 
                 
                 
                 [self.tableView reloadData];

             }else{
                 
                 NSDictionary *badResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:0
                                                                             error:NULL];
                 
                 
                 [self showAlertViewWithTitle:@"ERROR" message:badResponse[@"message"] OptionParameter:@"REGRESAR"];
                 
             }
                      }
     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrDatosIssues[0] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self.viewSelector isEqualToString:@"issue"]){
        
        static NSString *simpleTableIdentifier = @"issueTableCell";
        
        issuesTableCell *cell = (issuesTableCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib2 = [[NSBundle mainBundle] loadNibNamed:@"issuesTableCell" owner:self options:nil];
            cell = [nib2 objectAtIndex:0];
        }
        
        cell.loginLabel.text = [NSString stringWithFormat:@"User:  %@",arrDatosIssues[0][indexPath.row][@"user"][@"login"]];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",arrDatosIssues[0][indexPath.row][@"title"]];
        cell.bodyLabel.text = [NSString stringWithFormat:@"%@",(arrDatosIssues[0][indexPath.row][@"body"])];
        NSString *mystr = arrDatosIssues[0][indexPath.row][@"created_at"];
        mystr=[mystr substringToIndex:10];
        cell.createdAt.text = [NSString stringWithFormat:@"%@",mystr];
        
        
        cell.backgroundColor = [UIColor clearColor];

        return cell;
        
    }else if([self.viewSelector isEqualToString:@"collab"]){
        static NSString *simpleTableIdentifier = @"contributorsTableCell";
        
        
        contributorsViewCell *cell = (contributorsViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib2 = [[NSBundle mainBundle] loadNibNamed:@"contributorsTableCell" owner:self options:nil];
            cell = [nib2 objectAtIndex:0];
        }
        
        _urlCollab = [NSString stringWithFormat:@"%@",arrDatosIssues[0][indexPath.row][@"url"]];
        
        
       // cell.nameLabel.text = [NSString stringWithFormat:@"%@",arrDatosIssues[0][indexPath.row][@"login"]];
        cell.loginLabel.text = [NSString stringWithFormat:@"ID: %@",arrDatosIssues[0][indexPath.row][@"id"]];
        cell.locationLabel.text = _locationLabel;
        cell.emailLabel.text = _emailLabel;
        cell.blogLabel.text = _blogLabel;
        cell.followLabel.text = [NSString stringWithFormat:@"%@",arrDatosIssues[0][indexPath.row][@"contributions"]];
        
        NSString *urlImagen = [NSString stringWithFormat:@"%@",arrDatosIssues[0][indexPath.row][@"avatar_url"]];
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImagen]];
        cell.avatarRepo.image = [UIImage imageWithData: imageData];
        cell.backgroundColor = [UIColor clearColor];
        
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;

        
    }else{
        return nil;
    }
    
    
}



-(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message OptionParameter:(NSString *)buttonTitle{
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:buttonTitle
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                }];
    
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(2.);
}

@end
