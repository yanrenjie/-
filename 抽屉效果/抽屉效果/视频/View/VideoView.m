//
//  VideoView.m
//  抽屉效果
//
//  Created by 颜仁浩 on 2020/6/28.
//  Copyright © 2020 Jackey. All rights reserved.
//

#import "VideoView.h"
#import "VideoCell.h"

@interface VideoView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)CGFloat beginOffset;
@property(nonatomic, assign)CGFloat endOffset;
@property(nonatomic, assign)NSInteger pageIndex;

@end

@implementation VideoView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = self.frame.size.height;
        [_tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
        _tableView.pagingEnabled = YES;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pageIndex = 0;
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    [self addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.beginOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.endOffset = scrollView.contentOffset.y;
    CGFloat offset = self.endOffset - self.beginOffset;
    
    // 获取滑动距离的绝对值，看看是否超过了1/2个高度
    CGFloat absOffset = fabs(offset);
    
    // 半个可视化区域高度
    CGFloat halfViewHeight = self.frame.size.height * 0.5;
    // 向前翻看视频，手指向下滑动
    NSInteger tempIndex = self.pageIndex;
    if (offset < 0) {
        if (self.pageIndex != 0) {
            if (absOffset > halfViewHeight) {
                tempIndex--;
            }
        }
    }
    // 向后翻看视频，手指向上滑动
    else {
        if (absOffset > halfViewHeight) {
            tempIndex++;
        }
    }
    
    // 判断是否应该切换到另外一个cell, 如果角标做了改动，则切换
    if (tempIndex != self.pageIndex) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tempIndex inSection:0];
        self.pageIndex = tempIndex;
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

@end
