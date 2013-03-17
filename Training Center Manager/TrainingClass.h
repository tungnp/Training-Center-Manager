//
//  TrainingClass.h
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher.h"

@interface TrainingClass : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSMutableArray* student;
@property (nonatomic) __weak Teacher* teacher;

-(id) initWithName: (NSString*) name;
@end
