//
//  NSDate+Util.m
//  VVM
//
//  Created by shulianyong on 12/03/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Util.h"

@interface NSDate (PrivateDelegateHandling)
+ (NSDateFormatter*)rfc2822Formatter;
@end


@implementation NSDate (Util)

+ (NSDateFormatter*)rfc2822Formatter {
	static NSDateFormatter *formatter = nil;
	if (formatter == nil)  {
		formatter = [[NSDateFormatter alloc] init];
		NSLocale *enUS = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		[formatter setLocale:enUS];
		[formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZ"];
	}
	return formatter;
}

+ (NSDate*)dateFromRFC2822:(NSString *)aRFC2822 {
	NSDateFormatter *formatter = [self rfc2822Formatter];
	return [formatter dateFromString:aRFC2822];
}

+ (NSString*)dateToRFC2822:(NSDate*)aDate {
	NSDateFormatter *formatter = [self rfc2822Formatter];
	return [formatter stringFromDate:aDate];
}

#pragma mark 
#pragma mark ---------------日期格式显示
- (NSString*)descriptionAsFormat:(NSString*)aFormat
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:aFormat];
    return [format stringFromDate:self];   
}

- (NSString*)descriptionAsFormat:(NSString *)aFormat withTimeZone:(NSTimeZone*)aZone
{    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:aFormat];
    [formatter setTimeZone:aZone];
    NSString *ret = [formatter stringFromDate:self];
    return ret;
}

- (NSString*)descriptionLocalAsFormat:(NSString *)aFormat
{
    return [self descriptionAsFormat:aFormat withTimeZone:[NSTimeZone localTimeZone]];
}

- (NSString*)timeString
{ 
    return [self descriptionAsFormat:@"HH:mm:ss" withTimeZone:[NSTimeZone localTimeZone]];
}

- (NSString*)dateString
{
    return [self descriptionAsFormat:@"yyyy-MM-dd" withTimeZone:[NSTimeZone localTimeZone]];
}

- (NSString *)displayDate
{
    return [self descriptionAsFormat:@"MM/dd/yyyy"];
}

@end
