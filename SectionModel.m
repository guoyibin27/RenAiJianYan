//
//  SectionModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel

+(SectionModel *) initWithTitle:(NSString *) title cells:(NSArray *) cells{
    SectionModel *section = [[SectionModel alloc] init];
    section.title = title;
    section.cells = cells;
    return section;
}

@end
