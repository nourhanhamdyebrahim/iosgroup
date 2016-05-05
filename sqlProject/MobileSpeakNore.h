//
//  MobileSpeakNore.h
//  sqlProject
//
//  Created by JETS on 5/3/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PeakersNoRe;

@interface MobileSpeakNore : NSManagedObject

@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) PeakersNoRe *speakerMoNO;

@end
