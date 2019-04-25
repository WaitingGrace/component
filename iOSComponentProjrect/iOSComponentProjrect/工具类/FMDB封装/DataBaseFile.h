//
//  DataBaseFile.h
//  01-数据持久化作业
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#ifndef DataBaseFile_h
#define DataBaseFile_h
#define BaseFileName @"healthNews.db"
//创建表
#define createTabel @"create table if not exists healthNews(cover_small text,title text,publish_time text,content text,id integer);"
//插入数据
#define Inserinto @"insert into healthNews values(:cover_small,:title,:publish_time,:content,:id)"

//查询本地数据
#define selectAll @"select * from healthNews"
#define selectVH(a) [NSString stringWithFormat:@"select *from healthNews where id like'%%%@%%'",a]
//删除操作
#define DeleteAll @"delete from healthNews"
#define DeleteVH_Id @"delete from healthNews where id=:id"



#endif /* DataBaseFile_h */
