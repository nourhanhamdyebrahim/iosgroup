//
//  PhonesEx.h
//  sqlProject
//
//  Created by JETS on 5/3/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exhibitors;

@interface PhonesEx : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) Exhibitors *exhibtorsPh;

@end
