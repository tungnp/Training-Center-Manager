//
//  FileManager.h
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//
/*
 Quản lý việc tải và lưu trữ dữ liệu
 */


#import <Foundation/Foundation.h>
#import "DataManager.h"

@interface FileManager : NSObject

// 3 đường dẫn của 3 file plist trong thư mục document

@property (nonatomic,strong,readonly) NSString* studentFilePath;
@property (nonatomic,strong,readonly) NSString* teacherFilePath;
@property (nonatomic,strong,readonly) NSString* classFilePath;

-(void) loadDataTo: (DataManager*) dataManager;
-(void) saveDataFrom: (DataManager*) dataManager;

@end
