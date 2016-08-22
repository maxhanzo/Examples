//
//  CustomShapedTableView.h
//  App Rede
//
//  Created by Ticket Services on 4/1/16.
//  Copyright © 2016 Ticket Serviços. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface CustomShapedTableView : UITableView

@property(assign) IBInspectable CGFloat cornerRadius;
@property(assign) IBInspectable BOOL maskClipsToBounds;

@property(assign, nonatomic) IBInspectable BOOL topEdgeLeft;
@property(assign, nonatomic) IBInspectable BOOL topEdgeRight;
@property(assign, nonatomic) IBInspectable BOOL bottomEdgeLeft;
@property(assign, nonatomic) IBInspectable BOOL bottomEdgeRight;
@property(nonatomic, strong) IBInspectable UIColor *shadowColor;
@property(nonatomic, strong) UIView *shadowView;

@end
