//
//  NetworkType.h
//  NetworkType
//
//  Created by Admin on 2023/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NetworkTypeValue) {
    NetworkTypeValueUnKnow = 0,
    NetworkTypeValueWifi,
    NetworkTypeValue2G,
    NetworkTypeValue3G,
    NetworkTypeValue4G,
    NetworkTypeValue5G
};

@interface NetworkType : NSObject

+ (NetworkTypeValue)getNetworkType;

@end

NS_ASSUME_NONNULL_END
