//
//  ViewController.m
//  那你
//
//  Created by 灰常溜 on 2019/7/25.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import "ViewController.h"
#import "myCellView.h"
@interface ViewController ()<NSTableViewDelegate,NSTableViewDataSource>



@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSTableView *tableview = [[NSTableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20)];
    
   [self.view addSubview:tableview];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:@"columnFrist"];
    [column1 setWidth:200];
    [tableview addTableColumn:column1];//第一列
    
    NSTableColumn * column2 = [[NSTableColumn alloc] initWithIdentifier:@"columnSecond"];
    [column2 setWidth:200];
    [tableview addTableColumn:column2];//第二列
    
    
    [tableview registerNib:[[NSNib alloc]initWithNibNamed:@"myCellView" bundle:nil] forIdentifier:@"cell"];
    
    //文件选择器
    NSButton *findBtn = [[NSButton alloc] init];
    findBtn.title = @"添加文件";
    findBtn.frame = CGRectMake(230, CGRectGetMaxY(self.view.frame) - 50, 60, 20);
 //   [self.view addSubview:findBtn];
    findBtn.target = self;
    [findBtn setAction:@selector(findFile)];
    
  
}

#pragma 添加文件
-(void)findFile{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];//是否能选择文件file
    [panel setCanChooseDirectories:YES];//是否能打开文件夹
    [panel setAllowsMultipleSelection:YES];//是否允许多选file
    NSInteger finded = [panel runModal]; //获取panel的响应
         if (finded == NSFileHandlingPanelOKButton) {
            //  NSFileHandlingPanelCancelButton    = NSModalResponseCancel；     NSFileHandlingPanelOKButton    = NSModalResponseOK,
                    for (NSURL *url in [panel URLs]) {
                              NSLog(@"--->%@",url);
            NSString *str = [NSString stringWithFormat:@"%@",url];
            NSArray *arr = [str componentsSeparatedByString:@"/"];
           
            //NSString *unicodeStr = [NSString stringWithCString:[arr.lastObject UTF8String] encoding:NSUnicodeStringEncoding];
            
            /*
             NSString *urlString= [NSString stringWithFormat:@"http://www.baidu.com];
             
                 NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
             
                NSURL *url =[NSURL URLWithString:encodedString];
   
       
             */
            
            NSString *transString = [NSString stringWithString:[arr.lastObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            

             NSLog(@"%@",transString);
                              //这个url是文件的路径
                              //同时这里可以处理你要做的事情 do something
                         }
               }
}


-(NSInteger) numberOfRowsInTableView:(NSTableView*)tableView{
    
    NSInteger rows;
    
    rows = 4;
    //do something
    
    return rows;
    
}

- (NSView*)tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row{
    
//    NSButton *b = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 30, 30)];
//    b.title = @"123";
    
    
    //获取表格列的标识符
    NSString *columnID = tableColumn.identifier;
    NSLog(@"columnID : %@ ,row : %d",columnID,row);
    
    myCellView *cell = [tableView makeViewWithIdentifier:@"cell" owner:self];
    cell.myLabel.stringValue = @"wocainima";
//    NSString *strIdt = @"123";
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:strIdt owner:self];
//    if (!cell) {
//        cell = [[NSTableCellView alloc]init];
//        cell.identifier = strIdt;
//    }
  
    //  cell.wantsLayer = YES;
  //  cell.layer.backgroundColor = [NSColor yellowColor].CGColor;
    
  //  cell.imageView.image = [NSImage imageNamed:@"swift"];
//    cell.textField.stringValue = @"123";//[NSString stringWithFormat:@"cell %ld",(long)row];
//    cell.textField.font = [NSFont systemFontOfSize:36];
//    cell.textField.textColor = [NSColor redColor];
   
    return cell;
}


-(CGFloat)tableView:(NSTableView*)tableView heightOfRow:(NSInteger)row{ CGFloat height;
    
    //do something
    
    return 100;
    
}



//-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
//
//    //设置cell选中高亮颜色
//    NSTableRowView *myRowView = [self.tableView rowViewAtRow:row makeIfNecessary:NO];
//
//    [myRowView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];
//    [myRowView setEmphasized:NO];
//
//    NSLog(@"shouldSelect : %d",row);
//    return YES;
//}

//选中的响应
-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification{
    
    NSTableView* tableView = notification.object;
    
    NSLog(@"didSelect：%@",notification.userInfo);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
