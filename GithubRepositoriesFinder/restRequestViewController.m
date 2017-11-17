//
//  restRequestViewController.m
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import "restRequestViewController.h"
#import "Repositorie.h"
#import "customTableCell.h"
#import "detailsRepoViewController.h"
#import "MBProgressHUD.h"

@interface restRequestViewController () <UIAlertViewDelegate>

@end

@implementation restRequestViewController
{
    NSDictionary *repoDic;
    NSArray *arrDatos;
    NSMutableArray *arrDatosIssues;

    NSString *segueURL;
    NSString *viewSelector;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.languajeRepoText.delegate = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];

    [self fetchGreeting];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchGreeting;
{
    [self.view endEditing:YES];
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
        
        NSString *generateURL = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=+language:%@&sort=watchers&order=desc",self.languajeRepoText.text];
        
        NSURL *url = [NSURL URLWithString:generateURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             
             
             if (data.length > 0 && connectionError == nil)
             {
                 repoDic = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:NULL];
                 arrDatos = [repoDic objectForKey:@"items"];
                 
                 if( arrDatos == nil ){
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"LO SENTIMOS"
                                                                     message:@"No existen repositorios con este lenguaje de programacion."
                                                                    delegate:self
                                                           cancelButtonTitle:@"Continuar"
                                                           otherButtonTitles:nil];
                     [alert show];
                 }
                 
                 
                 
                 
                 [self.tableView reloadData];
                 
             }
         }];
        
        
        
    
    
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrDatos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"customTableCell";
    
    customTableCell *cell = (customTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"customTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",arrDatos[indexPath.row][@"name"]];
    cell.descLabel.text = [NSString stringWithFormat:@"%@",arrDatos[indexPath.row][@"description"]];
    cell.watchersLabel.text = [NSString stringWithFormat:@"Watchers: %d",(int) (arrDatos[indexPath.row][@"watchers"])];
    NSString *mystr = arrDatos[indexPath.row][@"created_at"];
    mystr=[mystr substringToIndex:10];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",mystr];
    
    NSString *urlImagen = arrDatos[indexPath.row][@"owner"][@"avatar_url"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImagen]];
    cell.avatarRepo.image = [UIImage imageWithData: imageData];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

    segueURL = arrDatos[indexPath.row][@"url"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",arrDatos[indexPath.row][@"name"]] message:@"\nSelecciona una opción\n\n" delegate:self cancelButtonTitle:@"Cancelar"  otherButtonTitles:@"Mostrar Issues",@"Mostrar Colaboradores", nil];
    
    
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if(buttonIndex == 1)
    {
        
        viewSelector = @"issue";
        [self performSegueWithIdentifier:@"pushDetail" sender:self];
        
       
        
    }else if(buttonIndex == 2)
    {
        viewSelector = @"collab";
        [self performSegueWithIdentifier:@"pushDetail" sender:self];
    }
}
 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    detailsRepoViewController *detailsRepoView = [segue destinationViewController];
    detailsRepoView.viewSelector = viewSelector;
    detailsRepoView.reporitorieUrl = segueURL;
    
}

- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self fetchGreeting];
    [self.view endEditing:YES];
    return YES;
}

@end
