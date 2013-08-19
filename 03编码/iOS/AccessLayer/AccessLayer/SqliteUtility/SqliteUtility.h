//
//  SqliteUtility.h
//  CommonUtil
//
//  Created by shulianyong on 13-7-25.
//  Copyright (c) 2013年 Chengdu Sifang Information Technology Co.LTD. All rights reserved.
//

//lipo -create Release-iphoneos/CDSFDataBase/libCDSFDataBase.a Release-iphonesimulator/CDSFDataBase/libCDSFDataBase.a -output libCDSFDataBase.a 模拟器与真机的库加在一起
//Other Linker Flags:添加-force_load-$(BUILT_PRODUCTS_DIR)/libCDSFDataBase.a

//数据库处理
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

