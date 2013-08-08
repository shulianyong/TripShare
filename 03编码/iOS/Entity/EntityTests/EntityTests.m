//
//  EntityTests.m
//  EntityTests
//
//  Created by shulianyong on 13-7-22.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import "EntityTests.h"
#import "Province.h"
#import "Person.h"

@implementation EntityTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSString *jsonValue = @"{\"provinces\":[{\"id\":11,\"name\":\"北京\",\"citys\":[{\"id\":1,\"name\":\"东城区\",\"messageInfo\":\"sly\"},{\"id\":2,\"name\":\"西城区\",\"messageInfo\":\"sly\"}]}]}";
    
    
//    jsonValue = @"{ \"accounting\" : [{ \"firstName\" : \"John\","
//        "\"lastName\"  : \"Doe\","
//        "\"age\"       : 23 },"                                  
//                                  "{ \"firstName\" : \"Mary\","
//                                      "\"lastName\"  : \"Smith\","
//                                      "\"age\"       : 32 }"
//                                  "],"
//        "\"sales\"      : [{ \"firstName\" : \"Sally\","
//            "\"lastName\"  : \"Green\","
//            "\"age\"       : 27 },"                        
//                        "{ \"firstName\" : \"Jim\","
//                            "\"lastName\"  : \"Galley\","
//                            "\"age\"       : 41 }"
//                        "]}";   
   
    
    NSError *err = nil;
    Provinces *pro = [[Provinces alloc] initWithString:jsonValue error:&err];
//    STAssertNotNil(pro, @"解析失败");
    for (Province *info in pro.provinces) {
//        STAssertNil(info, info.name);
        for (City *city in info.citys) {
            NSLog(@"city:%@",city.messageInfo);
//            STAssertNil(city, city.messageInfo);
//            STAssertNil(city, city.name);
        }
    }
    
//    Department *department = [[Department alloc] initWithString:jsonValue error:&err];
//    if (!err)
//    {
//        for (Person *person in department.accounting) {
//            
//            NSLog(@"%@", person.firstName);
//            NSLog(@"%@", person.lastName);
//            NSLog(@"%@", person.age);
//        }
//        
//        for (Person *person in department.sales) {
//            
//            NSLog(@"%@", person.firstName);
//            NSLog(@"%@", person.lastName);
//            NSLog(@"%@", person.age);         
//        }
//    }
    
//    STFail(@"Unit tests are not implemented yet in EntityTests");
}

@end
