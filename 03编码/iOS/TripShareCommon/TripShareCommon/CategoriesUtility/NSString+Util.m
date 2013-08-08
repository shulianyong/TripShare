//
//  NSString+Util.m
//  VVM
//
//  Created by shulianyong on 12/03/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+Util.h"
#import "NSData+Util.h"
#import <CommonCrypto/CommonDigest.h>
#import "spelling.h"

@interface NSString (PrivateDelegateHandling)
+ (BOOL)isSigleByte:(NSString*)character;
@end


@implementation NSString (Util)

#pragma mark - Private Methods

+ (BOOL)isSigleByte:(NSString*)character {
	NSString* const singlePattern = @"[\\x20-\\x7E\\xA1-\\xDF]"; // Multi=Byte character's include 8bit-Kana, accents.
	NSRange match = [character rangeOfString:singlePattern options:NSRegularExpressionSearch];
	if (match.location != NSNotFound) {
		return YES;
	}
	return NO;
}


#pragma mark - Public Methods

- (BOOL)isEmpty{
	if (self == nil) return YES;
    BOOL ret = ([[self trim] length]==0);
	return ret;
}

+ (NSString*)urlEncode:(NSString*)aSource {
    CFStringRef result = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aSource, NULL, CFSTR(";,/?:@&=+$#"), kCFStringEncodingUTF8);
    NSString *resultString = (__bridge NSString *)(result);
    CFRelease(result);
	return resultString;
}

+ (NSString*)urlDecode:(NSString*)aSource {
    CFStringRef result = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)aSource, CFSTR(""), kCFStringEncodingUTF8);
    NSString *resultString = (__bridge NSString*)result;
    CFRelease(result);
	return resultString;
}

+ (unsigned int)convertHexString:(NSString*)aHex {
	NSScanner* scanner = [NSScanner scannerWithString:aHex];
	unsigned int value;
	[scanner scanHexInt:&value];
	return value;
}

static char encodingTable[64] = {
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
	'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
	'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
	'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };

+ (NSString*)base64Encode:(NSData*)aData {
	unsigned long ixtext = 0;
	unsigned long lentext = [aData length];
	long ctremaining = 0;
	unsigned char inbuf[3], outbuf[4];
	unsigned short i = 0;
	unsigned short charsonline = 0, ctcopy = 0;
	unsigned long ix = 0;
	const unsigned char *bytes = [aData bytes];
	NSMutableString *result = [NSMutableString stringWithCapacity:lentext];
	
	while (1) {
		ctremaining = lentext - ixtext;
		if( ctremaining <= 0 ) break;
		
		for( i = 0; i < 3; i++ ) {
			ix = ixtext + i;
			if( ix < lentext ) inbuf[i] = bytes[ix];
			else inbuf [i] = 0;
		}
		
		outbuf [0] = (inbuf [0] & 0xFC) >> 2;
		outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
		outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
		outbuf [3] = inbuf [2] & 0x3F;
		ctcopy = 4;
		
		switch (ctremaining) {
			case 1:
				ctcopy = 2;
				break;
			case 2:
				ctcopy = 3;
				break;
            default:
                ctcopy = 4;
                break;
		}
		
		for (i = 0; i < ctcopy; i++) [result appendFormat:@"%c", encodingTable[outbuf[i]]];
		
		for (i = ctcopy; i < 4; i++) [result appendString:@"="];
		
		ixtext += 3;
		charsonline += 4;
	}
	return [NSString stringWithString:result];
}

+ (NSString*)base64Encode:(NSString*)aString encoding:(NSStringEncoding)aEncoding {
	return [self base64Encode:[aString dataUsingEncoding:aEncoding]];
}

+ (NSString*)base64Decode:(NSString*)aBase64 encoding:(NSStringEncoding)aEncoding {
	return [[NSString alloc] initWithData:[NSData base64Decode:aBase64] encoding:aEncoding];
}

+ (NSString*)base64Decode:(NSString*)aBase64 {
	NSStringEncoding encoding = [aBase64 smallestEncoding];
	return [self base64Decode:aBase64 encoding:encoding];
}

+ (NSUInteger)length:(NSString*)aString {
	NSUInteger length = 0;
	NSUInteger i;
	for (i = 0; i < [aString length]; ++i) {
		NSString *character = [aString substringWithRange:NSMakeRange(i, 1)];
		++length;
		if (![self isSigleByte:character]) {
			++length;
		}
	}
	return length;
}

+ (BOOL)isAsciiOnly:(NSString*)aString {
	NSUInteger i;
	for (i = 0; i < [aString length]; ++i) {
		NSString* character = [aString substringWithRange:NSMakeRange(i, 1)];
		NSString* encoded = [character stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		if (!encoded || [encoded length] > 3) return NO;
	}
	return YES;
}

+ (BOOL) regexWithFormat:(NSString*)aFormat ValueString:(NSString*)aValueString
{
    NSPredicate *_Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",aFormat];
	return [_Predicate evaluateWithObject:aValueString];
}

+ (NSString*) MD5:(NSString*)aValue
{
	const char * cStr = [aValue cStringUsingEncoding: NSUTF8StringEncoding]; 
	
	unsigned char result[CC_MD5_DIGEST_LENGTH]; 
	
	CC_MD5(cStr, strlen(cStr), result); 
	
	return [NSString 
			
			stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", 
			
			result[0], result[1], 
			
			result[2], result[3], 
			
			result[4], result[5], 
			
			result[6], result[7], 
			
			result[8], result[9], 
			
			result[10], result[11], 
			
			result[12], result[13], 
			
			result[14], result[15] 
			
			]; 
}

+ (NSString *) phoneNumFormat:(NSString*)aValue;
{
    NSMutableString*tmp = [[NSMutableString alloc]init];
	for(int j=0;j<[aValue length];j++)
	{
		if(([aValue characterAtIndex:j] >= '0' &&[aValue characterAtIndex:j] <= '9') || [aValue characterAtIndex:j] == '+') {
			//					NSString *str = [tmpText substringWithRange:NSMakeRange(j,1)];
			[tmp appendFormat:@"%c",[aValue characterAtIndex:j]];
		}
	}
	return tmp;
}

#define EMAILFORMAT @"(?:\\w+\\.?)*\\w+@(?:\\w+\\.?)*\\w+"

+ (NSArray*)emails:(NSString*)aText {
	NSError* error = nil;
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:EMAILFORMAT options:NSRegularExpressionAnchorsMatchLines error:&error];
	NSArray* matches = [regex matchesInString:aText options:0 range:NSMakeRange(0, [aText length])];
	NSMutableArray* values = [NSMutableArray array];
	for (NSTextCheckingResult* result in matches) {
		[values	addObject:[aText substringWithRange:result.range]];
	}
	return values;
}


+ (NSString *) valueNotNull:(NSString*)aValue
{
    NSString *temp = nil;
    temp = [aValue isEmpty]?@"":aValue;
    return temp;
}

+ (BOOL) marchStringForSearch:(NSString*)aBaseString withMarch:(NSString*)aMarchString
{
    if ( aBaseString == nil || aMarchString == nil) 
    {
        return NO;
    }
	NSComparisonResult result = [aBaseString compare:aMarchString options:NSCaseInsensitiveSearch range:NSMakeRange(0, aMarchString.length)];
	if (result == NSOrderedSame) {
		return YES;
	} 
    NSRange range = [aBaseString rangeOfString:aMarchString];
    if ( range.length>0 ) {
        return YES;		
    }
    return NO;
}

+ (NSString *) firstLetter:(NSString*)aString
{
    NSString *firstLetter = @"#";
    char firstLetterChar = pinyinFirstLetter([aString characterAtIndex:0]);
    if (firstLetterChar >='a' && firstLetterChar <= 'z') {
        firstLetterChar = firstLetterChar - 32;
    }
    if (firstLetterChar>='A' && firstLetterChar <='Z') {
        firstLetter = [NSString stringWithFormat:@"%c",firstLetterChar];
    }
    return firstLetter;
}

#pragma mark 文件路径管理

+ (NSString*)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

+ (NSString*)pathInDocument:(NSString*)aPath
{
    NSString *folderPath = [NSString stringWithFormat:@"%@/%@",[self documentPath],aPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
	{
		NSError *err = nil;
		if (![[NSFileManager defaultManager] createDirectoryAtPath:folderPath
		                               withIntermediateDirectories:YES attributes:nil error:&err])
		{
			NSLog(@"Error creating logsDirectory: %@", err);
		}
	}
    return folderPath;
}

//获取文件名
+ (NSString*)fileNameWithFilePath:(NSString*)aFilePath
{
    NSString *filename = [aFilePath lastPathComponent];
    filename = [filename stringByDeletingPathExtension];
    return filename;
}

//获取文件名，主要取下划线之前的数据
+ (NSString*)fileNameWithFilePathForUnderline:(NSString *)aFilePath
{
    NSString *fileName = [self fileNameWithFilePath:aFilePath];
    NSRange range = [fileName rangeOfString:@"_Save"];
    if (range.length>0) {
        fileName = [fileName substringToIndex:range.location];
    }
    return fileName;
}

//获取plist路，用于存线条的路径
+ (NSString*)dcmPlistDataPath:(NSString*)aFileName
{
    NSString *documentPath = [NSString pathInDocument:DCM_DOCUMENT_NAME];
    NSString *fileName = [self fileNameWithFilePath:aFileName];
    fileName = [NSString stringWithFormat:@"%@/%@.plist", documentPath, fileName];
    return fileName;
}

#pragma mark jpeg
//获取jpeg路径
+ (NSString*)jpegFilePathWithFilePath:(NSString*)aFilePath
{
    NSString *fileName = [self fileNameWithFilePath:aFilePath];    
    NSString *documentPath = [NSString pathInDocument:DCM_DOCUMENT_NAME];
    fileName = [documentPath stringByAppendingPathComponent:fileName];
    fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
    return fileName;
}
//获取被剪切的jpeg
+ (NSString*)clippedJpegFilePath:(NSString*)aFilePath
{
    NSString *fileName = [self jpegFilePathWithFilePath:aFilePath];
    fileName = [fileName stringByReplacingOccurrencesOfString:@".jpeg" withString:@"_clipped.jpeg"];
    return fileName;
}
//bmp路径
+ (NSString*)bmpPathWithFilePath:(NSString*)aFilePath
{
    NSString *fileName = [self fileNameWithFilePath:aFilePath];
    NSString *documentPath = [NSString pathInDocument:DCM_DOCUMENT_NAME];
    fileName = [documentPath stringByAppendingPathComponent:fileName];
    fileName = [fileName stringByAppendingPathExtension:@"BMP"];
    return fileName;
}

//获取dcm路径
+ (NSString*)dcmPathWithFilePath:(NSString*)aFilePath
{    
    NSString *fileName = [self fileNameWithFilePathForUnderline:aFilePath];
    NSString *documentPath = [NSString pathInDocument:DCM_DOCUMENT_NAME];
    fileName = [documentPath stringByAppendingPathComponent:fileName];
    fileName = [fileName stringByAppendingPathExtension:@"dcm"];
    return fileName;
}

//获取已经处理的dcm路径
+ (NSString*)dcmProcessedWithFilePath:(NSString*)aFilePath withProcessedRow:(int)aRow
{
    NSString *documentPath = [NSString pathInDocument:DCM_DOCUMENT_NAME];
    NSString *fileName = [self fileNameWithFilePath:aFilePath];
    NSRange range = [fileName rangeOfString:@"_processed"];
    if (range.length>0) {
        fileName = [fileName substringFromIndex:range.location];
    }
    fileName = [documentPath stringByAppendingPathComponent:fileName];
    fileName = [fileName stringByAppendingFormat:@"_processed%d",aRow];
    fileName = [fileName stringByAppendingPathExtension:@"dcm"];
    return fileName;
}

- (NSString*)trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL) isNumberString:(NSString*)aString
{
    const char *strTmp = [aString cStringUsingEncoding:NSUTF8StringEncoding];
    for (NSUInteger i = 0; i < aString.length; ++i)
    {
        if (strTmp[i] < '0' || strTmp[i] > '9')
        {
            return NO;
        }
    }
    
    return YES;
}


@end
