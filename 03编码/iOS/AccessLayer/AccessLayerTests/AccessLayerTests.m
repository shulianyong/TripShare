//
//  AccessLayerTests.m
//  AccessLayerTests
//
//  Created by shulianyong on 13-7-22.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import "AccessLayerTests.h"

#import "../../Entity/Entity/Province.h"
#import "AFNetworking.h"
#import "../../TripShareCommon/TripShareCommon/TripShareCommon.h"


@implementation AccessLayerTests

- (void)setUp
{
    [super setUp];
    client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.t.sina.com.cn/provinces.json"]];    
    client.parameterEncoding = AFJSONParameterEncoding;
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    [TripShareCommon lookThis];
//    STFail(@"Unit tests are not implemented yet in AccessLayerTests");
    
}

@end
