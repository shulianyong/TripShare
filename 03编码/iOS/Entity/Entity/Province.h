//
//  Province.h
//  Entity
//
//  Created by shulianyong on 13-7-22.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import "JSONModel/JSONModel/JSONModel.h"

@protocol BaseEntity <NSObject>

@optional
@property (nonatomic,copy) NSString *messageInfo;

@end

@interface City : JSONModel

@property (nonatomic) NSNumber *id;


@end

@protocol City,Province;

@interface Province : JSONModel

@property (nonatomic) NSNumber *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableArray<City> *citys;

@end

@interface Provinces : JSONModel

@property (nonatomic,strong) NSMutableArray<Province> *provinces;
//
//@property (nonatomic,strong) NSNumber *result;
//@property (nonatomic,strong) NSNumber *messageCode;

@end
