//
//  MobileUser.h
//  sqlProject
//
//  Created by JETS on 5/3/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface MobileUser : NSManagedObject

@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) User *userPh;

@end
