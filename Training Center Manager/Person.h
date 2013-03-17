//
//  Person.h
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* iD;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* email;

-(id) initWithName: (NSString*) name
                iD: (NSString*) iD
             phone: (NSString*) phone
             email: (NSString*) email;

@end
