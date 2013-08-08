//
//  provinceTests.m
//  TripShareUI
//
//  Created by shulianyong on 13-8-2.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import "provinceTests.h"
#import "../../Entity/Entity/Province.h"
#import "../../TripShareCommon/Expecta/Expecta.h"

@implementation provinceTests

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

- (void)testProvinces
{    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *fileProvince = [bundle pathForResource:@"provinces" ofType:@"plist"];
    NSLog(@"filePath%@",fileProvince);
    NSDictionary *dicProvinces = [NSDictionary dictionaryWithContentsOfFile:fileProvince];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dicProvinces options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    Provinces *provinces = [[Provinces alloc] initWithString:json error:&error];
    expect(provinces).to.beNil();
    provinces = [[Provinces alloc] initWithDictionary:dicProvinces error:&error];
    STAssertNil(error, @"解析失败：%@",error);
}

@end
