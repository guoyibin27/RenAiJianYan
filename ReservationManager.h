//
//  ReservationManager.h
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "BaseManager.h"

@interface ReservationManager : BaseManager

+(instancetype)manager;

-(void) fetchAvailableReservations:(NSNumber *)userId expert:(NSNumber *)expertId service:(NSNumber *)serviceId start:(NSString *)start end:(NSString *)end  block:(ArrayResultBlock)block;

-(void) checkReservationForPay:(NSNumber *)userId block:(ObjectResultBlock)block;

-(void) getReservedServices:(NSString *)username block:(ArrayResultBlock)block;

-(void) reserveWithUserId:(NSNumber *)userId reservationId:(NSNumber *)reservationId info:(NSString *)reservationInfo method:(NSString *)reservationMethod  block:(ObjectResultBlock)block;

-(void) commitReservationWithUserId:(NSNumber *)userId username:(NSString *)username block:(BooleanResultBlock)block;

-(void) fetchServicesWithBlock:(ArrayResultBlock)block;

-(void)fetchServicersWithServiceId:(NSNumber *)serviceId subType:(NSString *)subType block:(ArrayResultBlock)block;

-(void) closeReservationWithId:(NSNumber *)reservationId block:(BooleanResultBlock)block;

@end
