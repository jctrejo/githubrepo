//
//  detailsRepoViewController.h
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailsRepoViewController : UIViewController  <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSString *reporitorieUrl;
@property(nonatomic) NSString *viewSelector;
@property(nonatomic) NSString *urlEnding;
@property(nonatomic) NSString *urlCollab;

@property (nonatomic) NSString *nameLabel;
@property (nonatomic) NSString *loginLabel;
@property (nonatomic) NSString *locationLabel;
@property (nonatomic) NSString *emailLabel;
@property (nonatomic) NSString *blogLabel;
@property (nonatomic) NSString *contributionsLabel;
@property (nonatomic) NSString *followLabel;
@property (nonatomic) NSString *avatarRepo;

-(IBAction)back:(id)sender;


@end
