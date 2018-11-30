//
//  XBaseModel.h
//  XFoundation
//
//  Created by Ray on 2018/9/26.
//

#import <Foundation/Foundation.h>

@class XBaseModel;

@interface XBaseModel : NSObject

/*
 json转模型
 
 @param json json
 @return 模型
 */
+ (instancetype)model_from_json:(id)json;


/**
 模型转json
 
 @return json
 */
- (id)model_to_json;


+ (NSArray *)model_from_json_list:(NSArray *)jsonArray;

/**
 Custom property mapper.
 
 @discussion If the key in JSON/Dictionary does not match to the model's property name,
 implements this method and returns the additional mapper.
 
 Example:
 
 json:
 {
 "n":"Harry Pottery",
 "p": 256,
 "ext" : {
 "desc" : "A book written by J.K.Rowling."
 },
 "ID" : 100010
 }
 
 model:

 @property NSString *name;
 @property NSInteger page;
 @property NSString *desc;
 @property NSString *bookID;
 @end
 
 @implementation YYBook
 + (NSDictionary *)modelCustomPropertyMapper {
 return @{@"name"  : @"n",
 @"page"  : @"p",
 @"desc"  : @"ext.desc",
 @"bookID": @[@"id", @"ID", @"book_id"]};
 }
 @end
 
 @return A custom mapper for properties.
 */
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;

/**
 The generic class mapper for container properties.
 
 @discussion If the property is a container object, such as NSArray/NSSet/NSDictionary,
 implements this method and returns a property->class mapper, tells which kind of
 object will be add to the array/set/dictionary.
 
 Example:

 @property NSString *name;
 @property NSArray *shadows;
 @property NSSet *borders;
 @property NSDictionary *attachments;
 @end
 
 @implementation YYAttributes
 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"shadows" : [YYShadow class],
 @"borders" : YYBorder.class,
 @"attachments" : @"YYAttachment" };
 }
 @end
 
 @return A class mapper.
 */
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass;

@end


