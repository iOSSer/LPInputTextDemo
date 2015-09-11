//
//  LPInputToolView.m
//  LPInputTextDemo
//
//  Created by MacBook on 15/9/11.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "LPInputToolView.h"

@implementation LPInputToolView

+ (CGFloat)getDefaultHeight
{
    return 44.0f;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textView];
    }
    return self;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(60, (self.bounds.size.height - 40) / 2, self.bounds.size.width - 60 * 2, 40)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.layer.borderWidth = 1.0f;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}


@end
