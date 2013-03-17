//
//  DataManager.h
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

/*
 Quản lý dữ liệu khi app đang chạy 
 */

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"
#import "TrainingClass.h"

@interface DataManager : NSObject

@property (nonatomic, strong) NSMutableArray* student;
@property (nonatomic, strong) NSMutableArray* teacher;
@property (nonatomic, strong) NSMutableArray* trainingClass;

-(void) createANewStudent: (Student*) student;
-(void) createANewTeacher: (Teacher*) teacher;
-(void) createANewClass: (TrainingClass*) trainingClass;

-(void) deleteAStudent: (Student*) student;
-(void) deleteATeacher: (Teacher*) teacher;
-(void) deleteAClass: (TrainingClass*) trainingClass;

-(void) addATeacher: (Teacher*) teacher
           toAClass: (TrainingClass*) trainingClass;
-(void) addAStudent: (Student*) student
           toAClass: (TrainingClass*) trainingClass;
-(void) setScore: (NSNumber*) score
      toAStudent: (Student*) student;

-(void) viewFullStudentList;
-(void) viewFullTeacherList;
-(void) viewFullClassList;

-(void) viewDetailOfStudent: (Student*) student;
-(void) viewDetailOfTeacher: (Teacher*) teacher;
-(void) viewDetailOfClass: (TrainingClass*) trainingClass;
@end
