//
//  SectionModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject

@property (retain,nonatomic) NSArray *cells;
@property (retain,nonatomic) NSString *title;

+(SectionModel *) initWithTitle:(NSString *) title cells:(NSArray *) cells;

@end
