//
//  CellModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

+(CellModel *) makeCellWith:(NSString *) title image:(NSString *)image selector:(NSString *) selectorName{
    CellModel *cell = [[CellModel alloc] init];
    cell.title = title;
    cell.image = image;
    cell.selectorName = selectorName;
    cell.badgeTitle = @"0";
    return cell;
}

@end
