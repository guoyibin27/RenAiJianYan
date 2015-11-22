//
//  AddressManager.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "BaseManager.h"

@class AddressModel;
@interface AddressManager : BaseManager

+(instancetype)manager;

-(void) fetchAddressList:(NSNumber *)cid block:(ArrayResultBlock)block;

-(void) addAddress:(AddressModel *)address block:(BooleanResultBlock)block;

-(void) deleteAddress:(NSNumber *)addressId userId:(NSNumber *)userId block:(BooleanResultBlock)block;

@end
