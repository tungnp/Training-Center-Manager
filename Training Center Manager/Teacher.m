//
//  Teacher.m
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

-(id) initWithName:(NSString *)name
                iD:(NSString *)iD
             phone:(NSString *)phone
             email:(NSString *)email{
    if (self = [super initWithName:name
                                iD:iD
                             phone:phone
                             email:email]) {
        self.trainingClass = [[NSMutableArray alloc] init];
    }
return self;
}

@end
