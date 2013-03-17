//
//  ViewController.m
//  Training Center Manager
//
//  Created by stevie nguyen on 3/16/13.
//  Copyright (c) 2013 tung nguyen. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "Teacher.h"
#import "TrainingClass.h"
#import "DataManager.h"
#import "FileManager.h"

@interface ViewController ()


@end

// Quản lý giao diên người dùng, bắt các sự kiện và gửi đến bộ quản lý dữ liệu để xử lý

@implementation ViewController

DataManager* dataManager;
FileManager* fileManager;
NSString* input;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dataManager = [DataManager new];
    fileManager = [FileManager new];
    [fileManager loadDataTo:dataManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)InputString:(UITextField *)sender {
    input = sender.text;
}
- (IBAction)ViewFullStudentList:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Info show in XCode debug console" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [dataManager viewFullStudentList];
}
- (IBAction)ViewFullTeacherList:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Info show in XCode debug console" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [dataManager viewFullTeacherList];
}
- (IBAction)ViewFullClassList:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Info show in XCode debug console" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [dataManager viewFullClassList];
}
- (IBAction)ViewDetail:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Set input as student's iD, teacher's iD or class's name to view detail\n\nInfo show in XCode debug console" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    for (Student* student in dataManager.student){
        if ([input isEqualToString:student.iD]) {
            [dataManager viewDetailOfStudent:student];
            return;
        }
    }
    for (Teacher* teacher in dataManager.teacher){
        if ([input isEqualToString:teacher.iD]){
            [dataManager viewDetailOfTeacher:teacher];
            return;
        }
    }
    for (TrainingClass* trainingClass in dataManager.trainingClass){
        if ([input isEqualToString:trainingClass.name]) {
            [dataManager viewDetailOfClass:trainingClass];
            return;
        }
    }
    NSLog(@"No object detail found");
}
- (IBAction)AddStudent:(id)sender {
    NSArray* studentInfo = [input componentsSeparatedByString:@"/"];
    if ([studentInfo count] ==4) {
    Student* student = [[Student alloc] initWithName:studentInfo[0]
                                                  iD:studentInfo[1]
                                               phone:studentInfo[2]
                                               email:studentInfo[3]];
        [dataManager createANewStudent:student];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Student Added Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Student Added Failed\n\n Make sure to add input as:\n \"name/iD/phone/email\"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)AddTeacher:(id)sender {
    NSArray* teacherInfo = [input componentsSeparatedByString:@"/"];
    if ([teacherInfo count] ==4) {
        Teacher* teacher = [[Teacher alloc] initWithName:teacherInfo[0]
                                                      iD:teacherInfo[1]
                                                   phone:teacherInfo[2]
                                                   email:teacherInfo[3]];
        [dataManager createANewTeacher:teacher];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Teacher Added Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Teacher Added Failed\n\n Make sure to add input as:\n \"name/iD/phone/email\"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}
- (IBAction)AddClass:(id)sender {
    TrainingClass* trainingClass = [[TrainingClass alloc] initWithName:input];
    [dataManager createANewClass:trainingClass];
    NSString* string = [NSString stringWithFormat:@"Class Added Succeed With Name: %@", input];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)DeleteStudent:(id)sender {
    for (Student* student in dataManager.student){
        if ([input isEqualToString:student.iD]) {
            [dataManager deleteAStudent:student];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Student delete Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"No Object Found\n\n Input Student's iD to delete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

}
- (IBAction)DeleteTeacher:(id)sender {
    for (Teacher* teacher in dataManager.teacher){
        if ([input isEqualToString:teacher.iD]){
            [dataManager deleteATeacher:teacher];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Teacher delete Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;            
        }
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"No Object Found\n\n Input Teacher's iD to delete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)DeleteClass:(id)sender {
    for (TrainingClass* trainingClass in dataManager.trainingClass){
        if ([input isEqualToString:trainingClass.name]) {
            [dataManager deleteAClass:trainingClass];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Class delete Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"No Object Found\n\n Input Class's name to delete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)AddStudentToClass:(id)sender {
    BOOL found = false;
    NSArray* studentArray = [input componentsSeparatedByString:@"/"];
    if ([studentArray count]==2) {
        for ( Student* student in dataManager.student){
            if ([studentArray[0] isEqualToString:student.iD]) {
                for ( TrainingClass* trainingClass in dataManager.trainingClass) {
                    if ([studentArray[1] isEqualToString:trainingClass.name
                        ]) {
                        found = true;
                        [dataManager addAStudent:student
                                        toAClass:trainingClass];
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Add Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
            }
        }
        if (!found) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"No Student/Class Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Student Add Failed\n\n Make sure to add input as:\n\"student's ID/class's name\"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)AddTeacherToClass:(id)sender {
    BOOL found = false;
    NSArray* teacherArray = [input componentsSeparatedByString:@"/"];
    if ([teacherArray count]==2) {
        for ( Teacher* teacher in dataManager.teacher){
            if ([teacherArray[0] isEqualToString:teacher.iD]) {
                for ( TrainingClass* trainingClass in dataManager.trainingClass) {
                    if ([teacherArray[1] isEqualToString:trainingClass.name
                         ]) {
                        found = true;
                        [dataManager addATeacher:teacher
                                        toAClass:trainingClass];
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Add Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
            }
        }
        if (!found) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"No Teacher/Class Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Teacher Add Failed\n\n Make sure to add input as:\n\"teacher's ID/class's name\"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)SetScoreToStudent:(id)sender {
    BOOL found = false;
    NSArray* scoreArray = [input componentsSeparatedByString:@"/"];
    if ([scoreArray count]==2) {
        for ( Student* student in dataManager.student) {
            if ([scoreArray[0] isEqualToString:student.iD]) {
                found = true;
                NSNumberFormatter* numberFormater = [NSNumberFormatter new];
                [numberFormater setNumberStyle:NSNumberFormatterDecimalStyle];
                [dataManager setScore:[numberFormater numberFromString:scoreArray[1] ] toAStudent:student];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Score Set Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        if (!found) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Student Not Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Score Set Failed\n\n Make sure to input as:\n \"student's iD/score(number)\"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)SaveData:(id)sender {
    [fileManager saveDataFrom:dataManager];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"Save Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
