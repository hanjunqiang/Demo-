//
//  XWDataCacheTool.m
//  SixNews
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 张声扬. All rights reserved.
//

#import "XWDataCacheTool.h"

static FMDatabaseQueue *_queue;

@implementation XWDataCacheTool
+(void)initialize
{
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"newsqlite"];
    

    _queue=[FMDatabaseQueue databaseQueueWithPath:path];
    //创建表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL b=[db executeUpdate:@"create table if not exists info(ID interger primary key autoincrement,data blb,idstr text)"];
        if (!b) {
            NSLog(@"创建表失败");
        }
        
    }];

}

+(void)addArr:(NSArray *)arr andId:(NSString *)idstr
{
    for (NSDictionary *dict in arr) {
        [self addDict:dict andId:idstr];
        
    }


}

+(void)addDict:(NSDictionary *)dict andId:(NSString *)idstr
{
[_queue inDatabase:^(FMDatabase *db) {
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:dict];
    [db executeUpdate:@"insert into info(data,idstr) values(?,?)",data,idstr];
    
}];


}

//返回数组
+(NSArray *)dataWithID:(NSString *)ID
{
    __block NSMutableArray *arr=nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result=[db executeQuery:@"select * from info where idstr=?",ID];
        if (result) {
            arr=[NSMutableArray array];
            while ([result next]) {
                NSData *data=[result dataForColumn:@"data"];
                //转成字典
                NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:dict];
                
            }
        }
    }];
    return arr;

}


#pragma mark  删除对应的数据
+(void)deleteWidthId:(NSString *)ID
{
[_queue inDatabase:^(FMDatabase *db) {
    BOOL b=[db executeUpdate:@"delete from info where idstr=?",ID];
    if (!b) {
        NSLog(@"删除失败");
        
    }
}];



}
@end
