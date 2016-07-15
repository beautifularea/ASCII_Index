//
//  lp_query_ascii_index.m
//  ASCII_Index
//
//  Created by zhTian on 16/7/14.
//  Copyright © 2016年 zhTian. All rights reserved.
//

#import "lp_query_ascii_index.h"
#include <math.h>
#include <string.h>

typedef enum : NSUInteger {
    Binary = 1,
    Decimal,
    Hex,
} Sys_;

@interface lp_query_ascii_index ()
{
    NSArray *_charsets;
    
    Sys_ _sys;
    unsigned int _input;
}

- (NSString *)input_binary: (Byte)input;

- (NSString *)input_decimal: (unsigned int)input;
- (NSString *)input_hex: (unsigned int)input;

@end



@implementation lp_query_ascii_index

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        NSString *pt = [[NSBundle mainBundle] pathForResource: @"charset" ofType: @"txt"];
        NSString *content = [NSString stringWithContentsOfFile: pt encoding:NSUTF8StringEncoding error:nil];

        _charsets = [content componentsSeparatedByString: @"\n"];
        
        _sys = Decimal;
        _input = 0;
        
        
    }
    
    return self;
}

unsigned int trans(unsigned char c)
{
    if('0'<=c && '9'>=c) return (c-0x30);//0x30は'0'の文字コード
    if('A'<=c && 'F'>=c) return (c+0x0A-0x41);//0x41は'A'の文字コード
    if('a'<=c && 'f'>=c) return (c+0x0A-0x61);//0x61は'a'の文字コード
    return 0;
}

- (unsigned int)hex_to_decimal: (NSString *)hex
{
    unsigned int i,j=0;
    char*str= (char *)[hex UTF8String];
    char*str_ptr=str+strlen(str)-1;
    
    for(i=0;i<strlen(str);i++){
        j+=trans(*str_ptr--)*(unsigned int)pow(16,i);
    }
    
    return j;
}

- (NSString *)input_binary: (Byte)input
{
    NSString *ret;
    return ret;
}

- (NSString *)input_decimal: (unsigned int)input
{
    _input -= 32;
    
    NSString *ret;
    
    ret = [_charsets objectAtIndex: _input];

    return ret;
}

- (NSString *)input_hex: (unsigned int)input
{
    return [self input_decimal: input];
}
/*
 
 input strings
 output ascii code
 
 */
- (NSString *)checkSystem: (NSString *)input
{    
    if([input hasPrefix: @"0x"])
    {
        _sys = Hex;
        
        _input = [self hex_to_decimal: input];
    }
    else if(input.length)
    {
        _input = [input intValue];
    }
    
    if(_input < 32 || _input > 126)
        return @"Error input. [32(0x20), 126(0x7E)]";
    
    return [self input_decimal: _input];
}

@end
