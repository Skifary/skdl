//
//  CrashManager.m
//  KSCrashDemo
//
//  Created by Skifary on 07/03/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

#import "CrashManager.h"
#import "KSCrashFramework.h"
#import <objc/runtime.h>

@implementation CrashManager

#pragma mark - replace

void replaceMethod(Class originalCls, SEL original, Class replacedCls , SEL replaced, bool isInstanceMethod) {
    Method replacedMethod;
    if (isInstanceMethod) {
        replacedMethod = class_getInstanceMethod(replacedCls, replaced);
    } else {
        replacedMethod = class_getClassMethod(replacedCls, replaced);
    }
    class_replaceMethod(originalCls, original, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
}

+ (void)load {
    // 拦截方法，正常使用EMail的方式，
    Class sinkCls = [KSCrashReportSinkEMail class];
    Class selfCls = [self class];
    replaceMethod(sinkCls, @selector(defaultCrashReportFilterSetAppleFmt), selfCls, @selector(crashReportFilterSetAppleTextFmt), true);
    replaceMethod(sinkCls, @selector(filterReports:onCompletion:), selfCls, @selector(filterReports:onCompletion:), true);
}

- (id <KSCrashReportFilter>)crashReportFilterSetAppleTextFmt {
    return [KSCrashReportFilterPipeline filterWithFilters:
            [KSCrashReportFilterAppleFmt filterWithReportStyle:KSAppleReportStyleSymbolicatedSideBySide],
            self,
            nil];
}

- (void)filterReports:(NSArray*)reports onCompletion:(KSCrashReportFilterCompletion)onCompletion {
    
    NSString* crashDir = [CrashManager crashDir];
    
    for (NSString* report in reports) {
        NSString* filename = [CrashManager filename:report];
        NSString* filepath = [crashDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.crash", filename]];
        NSError* error = nil;
        [report writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"write crash report failed, error is %@", error);
        }
    }
    kscrash_callCompletion(onCompletion, reports, true, nil);
}

#pragma mark - config

+ (NSString *)crashDir {

    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* supportDir = [paths firstObject];
    NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString* crashDir = [[supportDir stringByAppendingPathComponent:bundleID] stringByAppendingPathComponent:@"crash"];

    [self createDirectoryIfNotExist:crashDir];
    
    return crashDir;
}

+ (void)createDirectoryIfNotExist:(NSString *)path {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return;
    }
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) {
        NSLog(@"create directory failed, error is %@", error);
    }
}

+ (NSString *)filename:(NSString *)report {
    static NSString* magicDateHeader = @"Date/Time:       ";
    static int magicLength = 29;
    
    NSRange range = [report rangeOfString:magicDateHeader];
    NSRange dateRange = {
        .location = range.location + range.length,
        .length = magicLength
    };
    NSString* filename = [report substringWithRange:dateRange];
    
    return filename;
}

#pragma mark - api

+ (NSString *)crashDirectory {
    return [self crashDir];
}

@end
