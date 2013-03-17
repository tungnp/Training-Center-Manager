//
//  TrainingClass.m
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "TrainingClass.h"

@implementation TrainingClass

-(id) initWithName:(NSString*) name{
    if (self = [super init]) {
        self.name = name;
        self.student = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
