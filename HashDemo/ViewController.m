//
//  ViewController.m
//  HashDemo
//
//  Created by Jack‘s Gray Pro on 2019/8/7.
//  Copyright © 2019 JackPersonal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputer;
@property (weak, nonatomic) IBOutlet UILabel *requltLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)calButtonAction:(UIButton *)sender {
    //ASCII使用8个0/1组成，能够表示出2^8=256种可能，所以创建一个有256个元素的数组
    NSMutableArray *countArray = [NSMutableArray arrayWithCapacity:256];
    for (NSInteger i = 0; i < 256; i++) {
        NSNumber *zero = [NSNumber numberWithInt:0];
        [countArray addObject:zero];
    }
    NSString *proString = self.inputer.text;
    for (NSInteger i = 0; i < proString.length; i++) {
        NSInteger asc = [proString characterAtIndex:i]; //直接输出ASCII值
        NSInteger count = [countArray[asc-1] integerValue];
        count = count + 1;
        //在查找和替换的过程中，通过计算得到储存位置，而为一个个遍历，这样的一个过程是哈希函数
        [countArray replaceObjectAtIndex:(asc-1) withObject:@(count)];
    }
    //应该根据输入的顺序进行遍历
    NSString *result;
    for (int i = 0; i < proString.length; i++) {
        NSInteger count = [countArray[[proString characterAtIndex:i]-1] integerValue];
        if (count == 1) {
            //找到第一个只出现一次的元素，可以结束循环
            result = [proString substringWithRange:NSMakeRange(i, 1)];
            break;  //不再继续循环
        }
    }
    self.requltLabel.text = [NSString stringWithFormat:@"The result is : %@",result];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
