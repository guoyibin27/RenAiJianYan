//
//  ProductModel.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/15.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (instancetype) initWithJson:(NSDictionary *)jsonDict{
    self = [super init];
    if(self){
        self.productId = [jsonDict objectForKey:@"_id"];
        self.productNo = [jsonDict objectForKey:@"_productNo"];
        self.supplierId = [jsonDict objectForKey:@"_supplierId"];
        self.productDescription = [jsonDict objectForKey:@"_productDescription"];
        self.status = [jsonDict objectForKey:@"_productStatus"];
        self.type = [jsonDict objectForKey:@"_productType"];
        self.statement = [jsonDict objectForKey:@"_productStatement"];
        self.quantity = [jsonDict objectForKey:@"_productQuantily"];
        self.sold = [jsonDict objectForKey:@"_sold"];
        self.instruction = [jsonDict objectForKey:@"_productInstruction"];
        self.productAmount = [jsonDict objectForKey:@""];
        self.productName = [jsonDict objectForKey:@"_productName"];
        self.productPrice = [jsonDict objectForKey:@"_price"];
        self.primaryPicture = [[jsonDict objectForKey:@"_primaryPicture"] objectForKey:@"_pictureURL"];
        NSArray *pictures = [jsonDict objectForKey:@"_productPictures"];
        for (int i = 0; i < [pictures count];i++) {
            NSDictionary *picture = pictures[i];
            [self.productPictures addObject:[picture objectForKey:@"_pictureURL"]];
        }
        NSDictionary *suppler = [jsonDict objectForKey:@"_supplier"];
        if(suppler != nil){
            self.supplierName = [suppler objectForKey:@"_supplierName"];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.productId forKey:@"productId"];
    [aCoder encodeObject:self.productNo forKey:@"productNo"];
    [aCoder encodeObject:self.supplierId forKey:@"supplierId"];
    [aCoder encodeObject:self.productDescription forKey:@"productDescription"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.statement forKey:@"statement"];
    [aCoder encodeObject:self.quantity forKey:@"quantity"];
    [aCoder encodeObject:self.sold forKey:@"sold"];
    [aCoder encodeObject:self.instruction forKey:@"instruction"];
    [aCoder encodeObject:self.productAmount forKey:@"productAmount"];
    [aCoder encodeObject:self.productName forKey:@"productName"];
    [aCoder encodeObject:self.productPrice forKey:@"productPrice"];
    [aCoder encodeObject:self.primaryPicture forKey:@"primaryPicture"];
    [aCoder encodeObject:self.buyCount forKey:@"buyCount"];
    [aCoder encodeObject:self.supplierName forKey:@"supplierName"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.productId = [aDecoder decodeObjectForKey:@"productId"];
    self.productNo = [aDecoder decodeObjectForKey: @"productNo"];
    self.supplierId = [aDecoder decodeObjectForKey: @"supplierId"];
    self.productDescription = [aDecoder decodeObjectForKey: @"productDescription"];
    self.status = [aDecoder decodeObjectForKey: @"status"];
    self.type = [aDecoder decodeObjectForKey: @"type"];
    self.statement = [aDecoder decodeObjectForKey: @"statement"];
    self.quantity = [aDecoder decodeObjectForKey: @"quantity"];
    self.sold = [aDecoder decodeObjectForKey:@"sold"];
    self.instruction = [aDecoder decodeObjectForKey: @"instruction"];
    self.productAmount = [aDecoder decodeObjectForKey: @"productAmount"];
    self.productName = [aDecoder decodeObjectForKey: @"productName"];
    self.productPrice = [aDecoder decodeObjectForKey: @"productPrice"];
    self.primaryPicture = [aDecoder decodeObjectForKey: @"primaryPicture"];
    self.buyCount = [aDecoder decodeObjectForKey:@"buyCount"];
    self.supplierName = [aDecoder decodeObjectForKey:@"supplierName"];
    return self;
}
@end
