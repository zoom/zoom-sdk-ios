//
//  SDKStartJoinMeetingPresenter+RestApiWithoutLoginUser.m
//  MobileRTCSample
//
//  Created by Murray Li on 2018/11/19.
//  Copyright © 2018 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+RestApiWithoutLoginUser.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

typedef enum {
    ///Token
    MobileRTCSampleTokenType_Token,
    ///ZAK
    MobileRTCSampleTokenType_ZAK,
}MobileRTCSampleTokenType;

@implementation SDKStartJoinMeetingPresenter (RestApiWithoutLoginUser)

- (void)startMeeting_RestApiWithoutLoginUser:(BOOL)appShare
{
    MobileRTCMeetingService *ms = [[MobileRTC sharedRTC] getMeetingService];
    if (ms)
    {
#if 0
        //customize meeting title
        [ms customizeMeetingTitle:@"Sample Meeting Title"];
#endif
    }
    
    //Sample for Start Param interface
    MobileRTCMeetingStartParam * param = nil;
    
    //Sample: How to Get Token or ZAK via RestAPI
    NSString * token = [self requestTokenOrZAKWithType:MobileRTCSampleTokenType_Token];
    NSString * ZAK = [self requestTokenOrZAKWithType:MobileRTCSampleTokenType_ZAK];

    MobileRTCMeetingStartParam4WithoutLoginUser * user = [[[MobileRTCMeetingStartParam4WithoutLoginUser alloc]init] autorelease];
    user.userType = MobileRTCUserType_APIUser;
    user.meetingNumber = kSDKMeetNumber;
    user.userName = kSDKUserName;
    user.userToken = token;
    user.userID = kSDKUserID;
    user.isAppShare = appShare;
    user.zak = ZAK;
    param = user;
    
    MobileRTCMeetError ret = [ms startMeetingWithStartParam:param];
    NSLog(@"onMeetNow ret:%d", ret);
    return;
}


/*
 * Request User Token Or ZAK Via Rest API
 * Rest API(List User): https://api.zoom.us/v2/users
 */
- (NSString*)requestTokenOrZAKWithType:(MobileRTCSampleTokenType)type
{
    NSString * bodyString = [NSString stringWithFormat:@"token?type=%@&access_token=%@",type==MobileRTCSampleTokenType_Token?@"token":@"zak", [self createJWTAccessToken]];
    NSString * urlString = [NSString stringWithFormat:@"%@/%@/%@",@"https://api.zoom.us/v2/users",kSDKUserID,bodyString];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"urlString = %@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [mRequest setHTTPMethod:@"GET"];
    
    NSData *resultData = [NSURLConnection sendSynchronousRequest:mRequest returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingAllowFragments error:nil];
    
    return [dictionary objectForKey:@"token"];
}

/*
 * Create JSON Web Tokens (JWT) for Authentication.
 * Guide Link: https://zoom.github.io/api/#authentication
 */
- (NSString*)createJWTAccessToken
{
#warning APIKEY APISECRET is rest api key and seccret, is not SDK key sceret
#define APIKEY      @""
#define APISECRET   @""
    
    //    {
    //        "alg": "HS256",
    //        "typ": "JWT"
    //    }
    NSMutableDictionary * dictHeader = [NSMutableDictionary dictionary];
    [dictHeader setValue:@"HS256" forKey:@"alg"];
    [dictHeader setValue:@"JWT" forKey:@"typ"];
    NSString * base64Header = [self base64Encode:[self dictionaryToJson:dictHeader]];
    
    //    {
    //        "iss": "API_KEY",
    //        "exp": 1496091964000
    //    }
    NSMutableDictionary * dictPayload = [NSMutableDictionary dictionary];
    [dictPayload setValue:APIKEY forKey:@"iss"];
    [dictPayload setValue:@"123456789101" forKey:@"exp"];
    NSString * base64Payload = [self base64Encode:[self dictionaryToJson:dictPayload]];
    
    NSString * composer = [NSString stringWithFormat:@"%@.%@",base64Header,base64Payload];
    NSString * hashmac = [self hmac:composer withKey:APISECRET];
    
    NSString * accesstoken = [NSString stringWithFormat:@"%@.%@.%@",base64Header,base64Payload,hashmac];
    return accesstoken;
}


- (NSString*)dictionaryToJson:(NSMutableDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (jsonData == nil)
    {
        return nil;
    }
    else
    {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (NSString*)base64Encode:(NSString*)decodeString
{
    NSData *encodeData = [decodeString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:0];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:base64String];
    NSRange range = {0,base64String.length};
    [mutStr replaceOccurrencesOfString:@"=" withString:@"" options:NSLiteralSearch range:range];
    
    return mutStr;
}

/*
 * Hmac AlgSHA256 Encryption.
 */
- (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString * hash = [HMAC base64Encoding];
    return hash;
}

@end
