//
//  NetworkType.m
//  NetworkType
//
//  Created by Admin on 2023/8/2.
//

#import "NetworkType.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import "Reachability.h"

////无网络
//static NSString * notReachable = @"notReachable";

@implementation NetworkType

#pragma mark --- 获取当前网络状态
+ (NetworkTypeValue)getNetworkType {
    
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags) {
        return NetworkTypeValueUnKnow;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    if (isReachable && !needsConnection) { }else{
        return NetworkTypeValueUnKnow;
    }
    
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired ) {
        
        return NetworkTypeValueUnKnow;
        
    } else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        
        return [self cellularType];
        
    } else {
        return NetworkTypeValueWifi;
    }
    
}

+ (NetworkTypeValue)cellularType {
    
    CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
    
    NSString *currentRadioAccessTechnology;
    if (@available(iOS 12.1, *)) {
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                currentRadioAccessTechnology = [radioDic objectForKey:radioDic.allKeys[0]];
            } else {
                return NetworkTypeValueUnKnow;
            }
        } else {
            
            return NetworkTypeValueUnKnow;
        }
        
    } else {
        
        currentRadioAccessTechnology = info.currentRadioAccessTechnology;
    }
    
    if (currentRadioAccessTechnology) {
        
        if (@available(iOS 14.1, *)) {
            
            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNRNSA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNR]) {
                
                return NetworkTypeValue5G;
                
            }
        }
        
        if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
            
            return NetworkTypeValue4G;
            
        } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            
            return NetworkTypeValue3G;
            
        } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            
            return NetworkTypeValue2G;
            
        } else {
            
            return NetworkTypeValueUnKnow;
        }
        
        
    } else {
        
        return NetworkTypeValueUnKnow;
    }
}



@end
