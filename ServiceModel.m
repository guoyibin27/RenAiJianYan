//
//  ServiceModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

- (instancetype) parse:(NSDictionary *)dict
{
    self.serviceId = [dict objectForKey:@"Id"];
    self.name = [dict objectForKey:@"Name"];
    self.serviceDescription = [dict objectForKey:@"Description"];
    self.status = [dict objectForKey:@"Status"];
    self.image = [dict objectForKey:@"Image"];
    self.priceLevel1 = [dict objectForKey:@"PriceLevel1"];
    self.priceLevel2 = [dict objectForKey:@"PriceLevel2"];
    self.priceLevel3 = [dict objectForKey:@"PriceLevel3"];
    self.priceLevel4 = [dict objectForKey:@"PriceLevel4"];
    self.priceLevel5 = [dict objectForKey:@"PriceLevel5"];
    self.services = [dict objectForKey:@"Servicers"];
    return self;
}
@end
