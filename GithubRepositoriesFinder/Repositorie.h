//
//  Repositorie.h
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repositorie : NSObject
{
NSString *name;
NSString *descp;
NSString *url;
NSString *created_at;
NSString *watchers;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *descp;
@property(nonatomic, retain) NSString *url;
@property(nonatomic, retain) NSString *crated_at;
@property(nonatomic, retain) NSString *watchers;
@end
