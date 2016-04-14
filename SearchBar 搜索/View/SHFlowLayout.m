//
//  FHFlowLayout.m
//  VinuxPost
//
//  Created by qsy on 15/12/30.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "SHFlowLayout.h"

@implementation SHFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *superAttributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];//获取到的item数组
    
    NSMutableDictionary *rowCollections = [NSMutableDictionary new];//创建字典存储所有item的布局
    
    // Collect attributes by their midY coordinate.. i.e. rows!
    for (UICollectionViewLayoutAttributes *itemAttributes in superAttributes)//遍历item获得每个item的布局,将布局加入数组itemAttributes
    {
        NSNumber *yCenter = @(CGRectGetMidY(itemAttributes.frame));//获取每个item的最小Y值
        
        if (!rowCollections[yCenter])
            rowCollections[yCenter] = [NSMutableArray new];//将每个item最小Y值作为数组写成字典
        
        [rowCollections[yCenter] addObject:itemAttributes];//将每个item布局数组加入字典Value中
    }
    
    // Adjust the items in each row
    [rowCollections enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {//遍历布局字典,obj是每个item的布局
        
        NSArray *itemAttributesCollection = obj;
        
        // Sum the width of all elements in the row  行中所有元素的宽度
        CGFloat aggregateItemWidths = 0.f;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection)
            aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
        
        CGFloat alignmentXOffset = 10;//每行item的x
        
        // Adjust each item's position to be centered   定义item的位置,排列好item
        CGRect previousFrame = CGRectZero;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection)
        {
            CGRect itemFrame = itemAttributes.frame;
            
            if (CGRectEqualToRect(previousFrame, CGRectZero))//如果CGRect为空
                itemFrame.origin.x = alignmentXOffset;//item的x为首行x
            else
                itemFrame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;//否则就是item的右边x+间隔
            
            itemAttributes.frame = itemFrame;
            previousFrame = itemFrame;
        }
    }];
    
    return superAttributes;
}

@end
