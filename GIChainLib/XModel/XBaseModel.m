//
//  XBaseModel.m
//  XFoundation
//
//  Created by Ray on 2018/9/26.
//

#import "XBaseModel.h"

#import "YYModel.h"

@implementation XBaseModel

+ (instancetype)model_from_json:(id)json {
    return [self yy_modelWithJSON:json];
}

- (id)model_to_json {
    return [self yy_modelToJSONObject];
}

+ (NSArray *)model_from_json_list:(NSArray *)jsonArray {
    
    if (!jsonArray.count) { return @[]; }

    return [NSArray yy_modelArrayWithClass:self json:jsonArray];
}

+ (NSDictionary *)modelCustomPropertyMapper { return @{}; }
+ (NSDictionary *)modelContainerPropertyGenericClass { return @{}; }

- (NSString *)debugDescription {
    return [self yy_modelDescription];
}

@end
