//
//  Person.h
//  Entity
//
//  Created by shulianyong on 13-7-22.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import "JSONModel.h"

@interface Person : JSONModel

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *age;

@end


@protocol Person;

@interface Department : JSONModel
@property (nonatomic, strong) NSMutableArray<Person> *accounting;
@property (nonatomic, strong) NSMutableArray<Person> *sales;

@end
