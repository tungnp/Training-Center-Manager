//
//  FileManager.m
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "FileManager.h"
#import "DataManager.h"

NSFileManager* fileManager;


@implementation FileManager

// khởi tạo đường dẫn của 3 file plist, nếu chưa có file trong thư mục thì copy file trong main bundle vào (do file trong main bundle không thể trực tiếp chỉnh sửa bằng code được nên phải copy ra thư mục khác để chỉnh sửa
-(id) init{
    if (self = [super init]) {
        fileManager = [NSFileManager defaultManager];
        NSError* error;
        
        NSMutableString* directoriesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) objectAtIndex:0] ;
        
        _studentFilePath = [directoriesPath stringByAppendingPathComponent:@"student.plist"];
        if (![fileManager fileExistsAtPath:self.studentFilePath]) {
            NSString* bundleFilePath = [[NSBundle mainBundle] pathForResource:@"student" ofType:@"plist"];
            [fileManager copyItemAtPath:bundleFilePath toPath:self.studentFilePath error:&error];
        }
        
        _teacherFilePath = [directoriesPath stringByAppendingPathComponent:@"teacher.plist"];
        if (![fileManager fileExistsAtPath:self.teacherFilePath]) {
            NSString* bundleFilePath = [[NSBundle mainBundle] pathForResource:@"teacher" ofType:@"plist"];
            [fileManager copyItemAtPath:bundleFilePath toPath:self.teacherFilePath error:&error];
        }
        
        _classFilePath = [directoriesPath stringByAppendingPathComponent:@"class.plist"];
        if (![fileManager fileExistsAtPath:self.classFilePath]) {
            NSString* bundleFilePath = [[NSBundle mainBundle] pathForResource:@"class" ofType:@"plist"];
            [fileManager copyItemAtPath:bundleFilePath toPath:self.classFilePath error:&error];
        }
    }
    return self;
}

// load dữ liệu từ file vào bộ quản lý dữ liệu
-(void) loadDataTo:(DataManager *)dataManager{
    NSArray *studentArray = [NSArray arrayWithContentsOfFile:self.studentFilePath];
    for (NSDictionary* studentDict in studentArray){
        Student* student = [[Student alloc] initWithName:[studentDict objectForKey:@"name"]
                                                      iD:[studentDict objectForKey:@"iD"]
                                                   phone:[studentDict objectForKey:@"phone"]
                                                   email:[studentDict objectForKey:@"email"]];
        [dataManager setScore:[studentDict objectForKey:@"score"]
                   toAStudent:student];
        [dataManager createANewStudent:student];
    }
    
    NSArray *teacherArray = [NSArray arrayWithContentsOfFile:self.teacherFilePath];
    for (NSDictionary* teacherDict in teacherArray){
        Teacher* teacher = [[Teacher alloc]initWithName:[teacherDict objectForKey:@"name"]
                                                     iD:[teacherDict objectForKey:@"iD"]
                                                  phone:[teacherDict objectForKey:@"phone"]
                                                  email:[teacherDict objectForKey:@"email"]];
        [dataManager createANewTeacher:teacher];
    }
    
    NSArray *classArray = [NSArray arrayWithContentsOfFile:self.classFilePath];
    for (NSDictionary* classDict in classArray){
        TrainingClass* trainingClass = [[TrainingClass alloc] initWithName:[classDict objectForKey:@"name"]];
        [dataManager createANewClass:trainingClass];
        for (Teacher* teacher in dataManager.teacher){
            if ([teacher.iD isEqualToString:[classDict objectForKey:@"teacher"]]) {
                [dataManager addATeacher:teacher
                                toAClass:trainingClass];
            }
        }
        for (Student* student in dataManager.student){
            for (NSString* iDInDict in [classDict objectForKey:@"student"]){
                if ([student.iD isEqualToString:iDInDict]){
                    [dataManager addAStudent:student
                                    toAClass:trainingClass];
                }
            }
        }
    }
}

//convert các đối tượng thành dictionary để lưu vào file plist

-(void) saveDataFrom:(DataManager *)dataManager{
    NSMutableArray* studentDictionaryArray = [NSMutableArray new];
    for ( Student* student in dataManager.student){
        NSDictionary* studentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         student.name,                 @"name",                                           
                                         student.iD,                   @"iD",
                                         student.phone,                @"phone",
                                         student.email,                @"email",
                                         student.trainingClass.name,     @"trainingClass",
                                         student.score,                @"score",
                                         nil];
        [studentDictionaryArray addObject:studentDictionary];
    }
    [studentDictionaryArray writeToFile:self.studentFilePath
                             atomically:true];
    NSMutableArray* teacherDictionaryArray = [NSMutableArray new];
    for ( Teacher* teacher in dataManager.teacher){
        NSMutableArray* trainingClassArray = [NSMutableArray new];
        for (TrainingClass* traingClass in teacher.trainingClass){
            [trainingClassArray addObject:traingClass.name];
        }
        NSDictionary* teacherDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                           teacher.name,                 @"name",
                                           teacher.iD,                   @"iD",
                                           teacher.phone,                @"phone",
                                           teacher.email,                @"email",
                                           trainingClassArray,           @"trainingClass",
                                           nil];
        [teacherDictionaryArray addObject:teacherDictionary];
    }
    [teacherDictionaryArray writeToFile:self.teacherFilePath
                             atomically:true];
    
    NSMutableArray* classDictionaryArray = [NSMutableArray new];
    for (TrainingClass* trainingClass in dataManager.trainingClass) {
        NSMutableArray* studentIDArray = [NSMutableArray new];
        for (Student* student in trainingClass.student){
            [studentIDArray addObject:student.iD];
        }
        NSDictionary* classDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         trainingClass.name,        @"name",
                                         trainingClass.teacher.iD,  @"teacher",
                                         studentIDArray,             @"student",
                                         nil];
        [classDictionaryArray addObject:classDictionary];
    }
    [classDictionaryArray writeToFile:self.classFilePath
                           atomically:true];

}

@end
