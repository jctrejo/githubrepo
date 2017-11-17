//
//  restRequestViewController.h
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface restRequestViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
- (IBAction)fetchGreeting;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *languajeRepoText;
@end
