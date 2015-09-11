//
//  ViewController.m
//  LPInputTextDemo
//
//  Created by MacBook on 15/9/11.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "ViewController.h"
#import "LPInputToolView.h"

#define MainSize [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, strong) LPInputToolView *toolView;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) double keyboardAnimationDuration;
@property (nonatomic, assign) CGFloat keyboardAnimationCurve;
@property (nonatomic, assign) CGFloat lastTextContentHeight;

@end

@implementation ViewController

static CGFloat maxHeight = 150;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat height = [LPInputToolView getDefaultHeight];
    self.toolView = [[LPInputToolView alloc] initWithFrame:CGRectMake(0, MainSize.height - height, MainSize.width, height)];
    self.toolView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.toolView];
    self.toolView.textView.delegate = self;
    self.toolView.textView.font = [UIFont systemFontOfSize:20];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
   }

- (void) keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    self.keyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.keyboardAnimationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.keyboardAnimationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    [self changeTextViewFrameWithToolViewHeight:self.toolView.frame.size.height];
}

- (void) changeTextViewFrameWithToolViewHeight:(CGFloat) toolViewHeight
{
    if (toolViewHeight >= maxHeight) {
        toolViewHeight = maxHeight;
    }
    
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:self.keyboardAnimationCurve];
    [UIView setAnimationCurve:self.keyboardAnimationCurve];
    self.toolView.frame = CGRectMake(0, MainSize.height - toolViewHeight - self.keyboardHeight, self.toolView.frame.size.width, toolViewHeight);
    self.toolView.textView.frame = CGRectMake(60, 2, self.toolView.bounds.size.width - 60 * 2, self.toolView.bounds.size.height - 4);
    [UIView commitAnimations];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
//    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
//    CGRect frame = textView.frame;
//    frame.size.height = size.height;
//    textView.frame = frame;
//    
//    
//    
//    if (textView.contentSize.height < _lastTextContentHeight) {
//        textView.contentSize = CGSizeMake(textView.contentSize.width, _lastTextContentHeight);
//        NSLog(@"<<<<<<<<<<<<<<<<");
//    }
//    textView.contentOffset = CGPointMake(textView.contentOffset.x, textView.contentSize.height);
//    CGRect line = [textView caretRectForPosition:
//                   textView.selectedTextRange.start];
//    CGFloat overflow = line.origin.y + line.size.height
//    - ( textView.contentOffset.y + textView.bounds.size.height
//       - textView.contentInset.bottom - textView.contentInset.top );
//    if ( overflow > 0 ) {
//        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
//        // Scroll caret to visible area
//        CGPoint offset = textView.contentOffset;
//        offset.y += overflow + 7; // leave 7 pixels margin
//        // Cannot animate with setContentOffset:animated: or caret will not appear
//        [UIView animateWithDuration:.2 animations:^{
//            [textView setContentOffset:offset];
//        }];
//    }
//    UIScrollView *scrollView = (UIScrollView *)textView.superview;
//    textView.contentOffset = CGPointMake(0, textView.contentSize.height);
    
    CGSize size = textView.contentSize;
    _lastTextContentHeight = size.height;
    NSLog(@"size %@", NSStringFromCGSize(size));
    [self changeTextViewFrameWithToolViewHeight:size.height];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
//    self.keyboardHeight = 0;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:self.keyboardAnimationCurve];
    [UIView setAnimationCurve:self.keyboardAnimationCurve];
    self.toolView.frame = CGRectMake(0, MainSize.height - self.toolView.bounds.size.height, self.toolView.frame.size.width, self.toolView.frame.size.height);
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
