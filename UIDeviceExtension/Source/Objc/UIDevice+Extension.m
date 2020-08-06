//
//  UIDevice+UIDevice_Extension.m
//  Component
//
//  Created by Thanh Pham on 8/4/20.
//

#import "UIDevice+Extension.h"
#import <sys/utsname.h>

// Reference:
// https://gist.github.com/adamawolf/3048717

NSString *const kIdentifierForVendorUserDefault = @"kIdentifierForVendorUserDefault";

@implementation UIDevice (Extension)

+ (NSString *)IdentifierForVendor {
    NSString *identifierForVendor = [[NSUserDefaults standardUserDefaults] stringForKey:kIdentifierForVendorUserDefault];
    if (!identifierForVendor) {
        identifierForVendor = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [[NSUserDefaults standardUserDefaults] setObject:identifierForVendor forKey:kIdentifierForVendorUserDefault];
    }
    return identifierForVendor;
}

+ (DeviceModel) CurrentDeviceModel{
    return [[self currentDevice] Model];
}

- (DeviceModel) Model{
    static DeviceModel model = Unknown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *deviceModelLookupTable = @{
          @"i386"       : @(Simulator),
          @"x86_64"     : @(Simulator),
          @"iPod1,1"    : @(iPodTouch),
          @"iPod2,1"    : @(iPodTouch2G),
          @"iPod3,1"    : @(iPodTouch3G),
          @"iPod4,1"    : @(iPodTouch4G),
          @"iPhone1,1"  : @(iPhone),
          @"iPhone1,2"  : @(iPhone3G),
          @"iPhone2,1"  : @(iPhone3GS),
          @"iPhone3,1"  : @(iPhone4),
          @"iPhone3,3"  : @(iPhone4),
          @"iPhone4,1"  : @(iPhone4S),
          @"iPhone5,1"  : @(iPhone5),
          @"iPhone5,2"  : @(iPhone5),
          @"iPhone5,3"  : @(iPhone5C),
          @"iPhone5,4"  : @(iPhone5C),
          @"iPhone6,1"  : @(iPhone5S),
          @"iPhone6,2"  : @(iPhone5S),
          @"iPhone7,1"  : @(iPhone6_Plus),
          @"iPhone7,2"  : @(iPhone6),
          @"iPhone8,1"  : @(iPhone6S),
          @"iPhone8,2"  : @(iPhone6S_Plus),
          @"iPhone8,4"  : @(iPhoneSE),
          @"iPhone9,1"  : @(iPhone7),
          @"iPhone9,3"  : @(iPhone7),
          @"iPhone9,2"  : @(iPhone7_Plus),
          @"iPhone9,4"  : @(iPhone7_Plus),
          
          @"iPhone10,1" : @(iPhone8),          // CDMA
          @"iPhone10,4" : @(iPhone8),          // GSM
          @"iPhone10,2" : @(iPhone8_Plus),     // CDMA
          @"iPhone10,5" : @(iPhone8_Plus),     // GSM
          @"iPhone10,3" : @(iPhoneX),          // CDMA
          @"iPhone10,6" : @(iPhoneX),          // GSM
          
          @"iPhone11,2" : @(iPhoneXS),          //
          @"iPhone11,4" : @(iPhoneXS_Max),      //
          @"iPhone11,6" : @(iPhoneXS_Max),      //
          @"iPhone11,8" : @(iPhoneXR),          //
          @"iPhone12,1" : @(iPhone11),
          @"iPhone12,3" : @(iPhone11_Pro),
          @"iPhone12,5" : @(iPhone11_ProMax),
          @"iPhone12,8" : @(iPhoneSE_Gen2),
          
          @"iPad1,1"    : @(iPad),
          @"iPad2,1"    : @(iPad2),
          @"iPad3,1"    : @(iPad3G),
          @"iPad3,4"    : @(iPad4G),
          @"iPad2,5"    : @(iPadMini),
          @"iPad4,1"    : @(iPad5G_Air),
          @"iPad4,2"    : @(iPad5G_Air),
          
          @"iPad4,7"    : @(iPadMini3),
          @"iPad4,8"    : @(iPadMini3),
          @"iPad4,9"    : @(iPadMini3),
          @"iPad5,1"    : @(iPadMini4),
          @"iPad5,2"    : @(iPadMini4),
          
          @"iPad4,4"    : @(iPadMini2G),
          @"iPad4,5"    : @(iPadMini2G),
          @"iPad4,6"    : @(iPadMini2G),
          
          @"iPad6,7"    : @(iPadPro12),
          @"iPad6,8"    : @(iPadPro12),
          @"iPad6,3"    : @(iPadPro9),
          @"iPad6,4"    : @(iPadPro9)
          };
        
        struct utsname systemInfo;
        uname(&systemInfo);
        
        NSString *key = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        model = [deviceModelLookupTable[key] unsignedIntegerValue];
    });
    return model;
}

+ (nonnull NSString *) CurrentDeviceModelString{
    return [UIDevice currentDevice].ModelString;
}
+ (NSString *)CurrentDeviceModelStringSimple {
    if ([[UIDevice currentDevice] IsIpod]) {
        return @"iPod";
    } else if ([[UIDevice currentDevice] IsIpad]) {
        return @"iPad";
    } else {
        return @"iPhone";
    }
}
- (nonnull NSString *) ModelString{
    static NSString *modelString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *deviceModelLookupTable = @{
         @"i386"       : @"Simulator i386",
         @"x86_64"     : @"Simulator x86_64",
         @"iPod1,1"    : @"iPod Touch",
         @"iPod2,1"    : @"iPod Touch 2",
         @"iPod3,1"    : @"iPod Touch 3",
         @"iPod4,1"    : @"iPod Touch 4",
         @"iPhone1,1"  : @"iPhone",
         @"iPhone1,2"  : @"iPhone 3G",
         @"iPhone2,1"  : @"iPhone 3GS",
         @"iPhone3,1"  : @"iPhone 4",
         @"iPhone3,3"  : @"iPhone 4",
         @"iPhone4,1"  : @"iPhone 4 S",
         @"iPhone5,1"  : @"iPhone 5",
         @"iPhone5,2"  : @"iPhone 5",
         @"iPhone5,3"  : @"iPhone 5C",
         @"iPhone5,4"  : @"iPhone 5C",
         @"iPhone6,1"  : @"iPhone 5S",
         @"iPhone6,2"  : @"iPhone 5S",
         @"iPhone7,1"  : @"iPhone 6+",
         @"iPhone7,2"  : @"iPhone 6",
         @"iPhone8,1"  : @"iPhone 6S",
         @"iPhone8,2"  : @"iPhone 6S+",
         @"iPhone8,4"  : @"iPhone SE",
         @"iPhone9,1"  : @"iPhone 7",
         @"iPhone9,3"  : @"iPhone 7",
         @"iPhone9,2"  : @"iPhone 7+",
         @"iPhone9,4"  : @"iPhone 7+",
         
         @"iPhone10,1" : @"iPhone 8",
         @"iPhone10,4" : @"iPhone 8",
         @"iPhone10,2" : @"iPhone 8+",
         @"iPhone10,5" : @"iPhone 8+",
         @"iPhone10,3" : @"iPhone X",
         @"iPhone10,6" : @"iPhone X",
         
         @"iPhone11,2" : @"iPhone XS",
         @"iPhone11,4" : @"iPhone XS Max",
         @"iPhone11,6" : @"iPhone XS Max",
         @"iPhone11,8" : @"iPhone XR",
         @"iPhone12,1" : @"iPhone 11",
         @"iPhone12,3" : @"iPhone 11 Pro",
         @"iPhone12,5" : @"iPhone 11 Pro Max",
         @"iPhone12,8" : @"iPhone SE 2nd Gen",
         
         @"iPad1,1"    : @"iPad",
         @"iPad2,1"    : @"iPad 2",
         @"iPad3,1"    : @"iPad 3",
         @"iPad3,4"    : @"iPad 4",
         @"iPad2,5"    : @"iPad Mini",
         @"iPad4,1"    : @"iPad Air",
         @"iPad4,2"    : @"iPad Air",
         @"iPad4,4"    : @"iPad Mini 2",
         @"iPad4,5"    : @"iPad Mini 2",
         @"iPad4,6"    : @"iPad Mini 2",
         
         @"iPad4,7"    : @"iPad Mini3",
         @"iPad4,8"    : @"iPad Mini3",
         @"iPad4,9"    : @"iPad Mini3",
         @"iPad5,1"    : @"iPad Mini4",
         @"iPad5,2"    : @"iPad Mini4",
         
         @"iPad6,7"    : @"iPad Pro 12",
         @"iPad6,8"    : @"iPad Pro 12",
         @"iPad6,3"    : @"iPad Pro 9",
         @"iPad6,4"    : @"iPad Pro 9"
         };
        
        struct utsname systemInfo;
        uname(&systemInfo);
        
        NSString *key = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        modelString = deviceModelLookupTable[key];
        if (modelString == nil) {
            if ([self IsIpod]) {
                modelString = @"iPod";
            } else if ([self IsIpad]) {
                modelString = @"iPad";
            } else {
                modelString = @"iPhone";
            }
        }
    });
    return modelString;
}

+ (BOOL) IsCurrentDeviceIpad{
    return [[self currentDevice] IsIpad];
}
- (BOOL) IsIpad{
    return self.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL) IsCurrentDeviceIpod{
    return [[self currentDevice] IsIpod];
}
- (BOOL) IsIpod{
    return [self.model isEqualToString:@"iPod touch"];
}

+ (BOOL) IsCurrentNotchDevice{
    return [[self currentDevice] IsNotchDevice];
}
- (BOOL) IsNotchDevice{
    switch (self.Model) {
        case iPhoneX:
        case iPhoneXS:
        case iPhoneXS_Max:
        case iPhoneXR:
            return YES;
        case Simulator:
            return [UIScreen mainScreen].bounds.size.height >= 812;
        default:
            return NO;
    }
}

+ (BOOL) IsCurrentDeviceSimulator {
    return [[self currentDevice] IsSimulator];
}
- (BOOL) IsSimulator {
    return self.Model == Simulator;
}

+ (BOOL) IsCurrentDeviceIphone3_5{
    return [self currentDevice].IsIphone3_5;
}
- (BOOL) IsIphone3_5{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return ![self IsIpad] && MAX(screenSize.width, screenSize.height) == 480;
}

- (BOOL) IsIphone4_0 {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return ![self IsIpad] && MAX(screenSize.width, screenSize.height) == 568;
}

+ (BOOL) IsCurrentDeviceIphoneX {
    return [UIScreen mainScreen].bounds.size.height == 812;
}

@end
