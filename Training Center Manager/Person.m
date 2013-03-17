//
//  Person.m
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "Person.h"

@implementation Person

-(id) initWithName:(NSString *)name
                iD:(NSString *)iD
             phone:(NSString *)phone
             email:(NSString *)email{
    
    if ( self = [super init]){
        self.name = name;
        self.iD = iD;
        self.phone = phone;
        self.email = email;
    }
    return self;
}

@end
