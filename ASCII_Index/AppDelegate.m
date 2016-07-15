//
//  AppDelegate.m
//  ASCII_Index
//
//  Created by zhTian on 16/7/14.
//  Copyright © 2016年 zhTian. All rights reserved.
//

#import "AppDelegate.h"
#import "lp_query_ascii_index.h"

@interface AppDelegate ()

@property (strong) lp_query_ascii_index *index;

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSButton *button;
@property (weak) IBOutlet NSTextField *tip;
@property (weak) IBOutlet NSTextField *output;
@property (unsafe_unretained) NSTextView *textField;

- (IBAction)check:(id)sender;

@end



@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSTextView *txtView = [[NSTextView alloc]initWithFrame:CGRectMake(25, 47, 240, 135)];
    [txtView setMinSize:NSMakeSize(0.0, 47)];
    [txtView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [txtView setVerticallyResizable:YES];
    [txtView setHorizontallyResizable:NO];
    [txtView setAutoresizingMask:NSViewWidthSizable];
    [[txtView textContainer]setWidthTracksTextView:YES];
    [txtView setFont:[NSFont fontWithName:@"Helvetica" size:12.0]];
    [txtView setEditable:NO];
    _textField = txtView;
    NSView * v = [_window contentView];
    [v addSubview: _textField];
    
    //decorate text field tip
    [_textField setString: @"查询ASCII码： eg. 输入33,输出!; 输入0x21,输出!;支持十进制和十六进制输入。[32,126]"];
    _textField.editable = NO;
    _textField.selectable = NO;
    
    _index = [[lp_query_ascii_index alloc] init];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)check:(id)sender
{
    NSString *input = _tip.stringValue;
    NSString *output = [_index checkSystem: input];
    [_output setStringValue:output];
}

@end
