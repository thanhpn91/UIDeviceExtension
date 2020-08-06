//
//  UIDevice+UIDevice_Extension.h
//  Component
//
//  Created by Thanh Pham on 8/4/20.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DeviceModel) {
    Unknown,
    Simulator,
    
    iPhone,
    iPhone3G,
    iPhone3GS,
    
    iPhone4,
    iPhone4S,
    
    iPhone5,
    iPhone5C,
    iPhone5S,
    
    iPhone6,
    iPhone6_Plus,
    
    iPhone6S,
    iPhone6S_Plus,
    
    iPhoneSE,
    
    iPhone7,
    iPhone7_Plus,
    
    iPhone8,
    iPhone8_Plus,
    
    iPhoneX,
    iPhoneXS,
    iPhoneXS_Max,
    iPhoneXR,
    iPhone11,
    iPhone11_Pro,
    iPhone11_ProMax,
    iPhoneSE_Gen2,
    
    iPodTouch,
    iPodTouch2G,
    iPodTouch3G,
    iPodTouch4G,
    iPad,
    iPad2,
    iPad3G,
    iPad4G,
    iPad5G_Air,
    iPadMini,
    iPadMini2G,
    
    iPadMini3,
    iPadMini4,
    
    iPadPro12,
    iPadPro9
};

@interface UIDevice (Extension)

+ (nonnull NSString *) IdentifierForVendor;

+ (DeviceModel) CurrentDeviceModel;
- (DeviceModel) Model;

+ (nonnull NSString *) CurrentDeviceModelString;
+ (nonnull NSString *) CurrentDeviceModelStringSimple; // only return iPhone/iPad/iPod
- (nonnull NSString *) ModelString;

+ (BOOL) IsCurrentDeviceIpad;
- (BOOL) IsIpad;

+ (BOOL) IsCurrentDeviceIpod;
- (BOOL) IsIpod;

+ (BOOL) IsCurrentNotchDevice;
- (BOOL) IsNotchDevice;

+ (BOOL) IsCurrentDeviceSimulator;
- (BOOL) IsSimulator;

+ (BOOL) IsCurrentDeviceIphone3_5;
- (BOOL) IsIphone3_5;

- (BOOL) IsIphone4_0;

+ (BOOL) IsCurrentDeviceIphoneX;

@end
