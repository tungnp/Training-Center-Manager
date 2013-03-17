//
//  DataManager.m
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

-(id) init{
    if (self = [super init]){
        self.student        = [[NSMutableArray alloc] init];
        self.teacher        = [[NSMutableArray alloc] init];
        self.trainingClass  = [[NSMutableArray alloc] init];
    }
return self;
}

-(void) createANewStudent:(Student *)student{
    [self.student addObject:student];
}

-(void) deleteAStudent:(Student*) student{
    TrainingClass* tr=student.trainingClass;
    [tr.student removeObject: student];
    [self.student removeObject:student];
}

-(void) createANewTeacher: (Teacher*) teacher{
    [self.teacher addObject:teacher];
}

-(void) deleteATeacher: (Teacher*) teacher{
    [self.teacher removeObject:teacher];
}

-(void) createANewClass: (TrainingClass*) trainingClass{
    [self.trainingClass addObject:trainingClass];
}

-(void) deleteAClass: (TrainingClass*) trainingClass{
    Teacher* t = trainingClass.teacher;
    [t.trainingClass removeObject: trainingClass];
    [self.trainingClass removeObject:trainingClass];
}


-(void) addATeacher: (Teacher*) teacher
           toAClass: (TrainingClass*) trainingClass{
    if (!trainingClass.teacher) {
        [teacher.trainingClass addObject:trainingClass];
        trainingClass.teacher = teacher;
    }
}
-(void) addAStudent: (Student*) student
           toAClass: (TrainingClass*) trainingClass{
    if (!student.trainingClass) {
        student.trainingClass = trainingClass;
        [trainingClass.student addObject:student];
    }
}


-(void) setScore: (NSNumber*) score
      toAStudent: (Student*) student{
        student.score = score;
}

-(void) viewFullStudentList{
    NSMutableString* studentList = [NSMutableString stringWithString:@" Full Student List: \n"];
    for ( Student* student in self.student){
        studentList = [NSMutableString stringWithFormat:@"%@ %20@  iD: %@\n",studentList,student.name,student.iD];
    }
    NSLog(@"%@",studentList);
}

-(void) viewFullTeacherList{
    NSMutableString* teacherList = [NSMutableString stringWithString:@" Full Teacher List: \n"];
    for ( Teacher* teacher in self.teacher){
        teacherList = [NSMutableString stringWithFormat:@"%@ %20@  iD: %@\n",teacherList,teacher.name, teacher.iD];
    }
    NSLog(@"%@",teacherList);
}

-(void) viewFullClassList{
    NSMutableString* classList = [NSMutableString stringWithString:@" Full Class List: \n"];
    for ( TrainingClass* trainingClass in self.trainingClass){
        classList = [NSMutableString stringWithFormat:@"%@ \n %@",classList,trainingClass.name];
    }
    NSLog(@"%@",classList);
}

-(void) viewDetailOfStudent: (Student*) student{
    NSLog(@"Student's Infomation: \nName: %@\nID: %@\nPhone: %@\nMail: %@\nClass: %@\nScore:%@\n ",student.name,student.iD,student.phone,student.email,student.trainingClass.name,student.score);
}

-(void) viewDetailOfTeacher: (Teacher*) teacher{
    NSLog(@"Teacher's Infomation: \nName: %@\nID: %@\nPhone: %@\nMail: %@\nClass: %@\n",teacher.name,teacher.iD,teacher.phone,teacher.email,teacher.trainingClass);
}
-(void) viewDetailOfClass: (TrainingClass*) trainingClass{
    NSMutableString *detail = [NSMutableString stringWithFormat:@"Class Infomation: \nName: %@\nTeacher: %@\nClass List And Score:\n",trainingClass.name,trainingClass.teacher.name];
    for (Student* student in trainingClass.student){
        detail = [NSMutableString stringWithFormat:@"%@%20@:  %@\n",detail,student.name, student.score];
    }
    NSLog(@"%@",detail);
}
@end
