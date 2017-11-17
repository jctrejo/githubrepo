//
//  contributorsViewCell.h
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contributorsViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *loginLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UILabel *blogLabel;
@property (nonatomic, weak) IBOutlet UILabel *contributionsLabel;
@property (nonatomic, weak) IBOutlet UILabel *followLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarRepo;
@end
