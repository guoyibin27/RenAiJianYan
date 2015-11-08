//
//  CellModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (retain,nonatomic) NSString *image;
@property (retain,nonatomic) NSString *title;
@property (retain,nonatomic) NSString *badgeTitle;

@property (retain,nonatomic) NSString *selectorName;

+(CellModel *) makeCellWith:(NSString *) title image:(NSString *)image selector:(NSString *) selectorName;

@end
