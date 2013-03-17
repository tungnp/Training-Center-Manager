//
//  Student.h
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "Person.h"
#import "TrainingClass.h"

@interface Student : Person

@property (nonatomic) __weak TrainingClass* trainingClass;
@property (nonatomic,strong) NSNumber* score;

@end
