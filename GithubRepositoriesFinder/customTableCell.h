//
//  customTableCell.h
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;
@property (nonatomic, weak) IBOutlet UILabel *watchersLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarRepo;

@end
