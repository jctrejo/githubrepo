//
//  contributorsViewCell.m
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import "contributorsViewCell.h"

@implementation contributorsViewCell

@synthesize nameLabel = _nameLabel;
@synthesize loginLabel = _loginLabel;
@synthesize locationLabel = _locationLabel;
@synthesize emailLabel = _emailLabel;
@synthesize blogLabel = _blogLabel;
@synthesize contributionsLabel = _contributionsLabel;
@synthesize followLabel = _followLabel;
@synthesize avatarRepo = _avatarRepo;

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
