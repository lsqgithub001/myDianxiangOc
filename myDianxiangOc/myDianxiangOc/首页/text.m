//
//  text.m
//  myDianxiangOc
//
//  Created by 灰常溜 on 2019/7/24.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import "text.h"
#import "DetailCell.h"
#import "model.h"
@interface text ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bindBoxBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIView *myBg;

@property (nonatomic , strong)UIScrollView *myScrollview;

@property (nonatomic  , strong)NSMutableArray *arrm;

@property (nonatomic , strong)NSMutableArray *highArrm;

@property (nonatomic , assign)NSInteger row;

@property  (nonatomic , strong)UIView *myLineView;

@property (nonatomic , strong)CAGradientLayer *xuxianLayer;//虚线

@property (nonatomic , strong)CAGradientLayer *yansexianLayer;//颜色路径

@property (nonatomic , strong)CAGradientLayer *beijingLayer;//渐变图层

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *warningHeig;

@end
@implementation text


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUi];
    
    //self.myBg.userInteractionEnabled = true;
    //self.userInteractionEnabled = true;
    
    //self.myCollectionView.userInteractionEnabled=true;
    // self.myCollectionView.hidden = true;

}

-(void)setUi
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.myCollectionView.collectionViewLayout = layout;
    
    //横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    self.myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.warningHeig.constant, UIScreen.mainScreen.bounds.size.width,self.myCollectionView.frame.size.height+25)];
    
    [self.myBg addSubview:self.myScrollview];
    
    self.myScrollview.delegate = self;
    
    _arrm = [NSMutableArray new];
    
    for(int i = 0 ; i <= 20 ; i ++)
    {
        
        [_arrm addObject:@(i)];
        
    }
    
    _highArrm  = [NSMutableArray new];
    
    for(int i = 0 ; i <= 20 ; i ++)
    {
        if(i == 0)
        {
            model *m = [[model alloc]init];
            m.temp = 0;
            [_highArrm addObject:m];
        }else
        {
            model *m = [[model alloc]init];
            m.temp = arc4random()%(int)(self.myCollectionView.frame.size.height-25);
            [_highArrm addObject:m];
            //  NSLog(@"?=%d",m.temp);
        }
        
    }
    
    self.myScrollview.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width/10 * (_arrm.count-1), 0);
    
    _myLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.warningHeig.constant ,UIScreen.mainScreen.bounds.size.width/10 * _arrm.count , self.myCollectionView.frame.size.height)];
    
    [self.myScrollview addSubview:_myLineView];
    // self.myScrollview.contentSize.backgroundColor = [UIColor redColor];
    //列宽相关
    CGFloat chang = UIScreen.mainScreen.bounds.size.width/10/2;
    //线长  25线低端到底的距离
    CGFloat lineChange = self.myCollectionView.frame.size.height - 25;
    
    //渐变涂层 填充背景
    _beijingLayer = [CAGradientLayer layer];
    
    _beijingLayer.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0 green:71/255.0 blue:157/255.0 alpha:0.48].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:130/255.0 blue:47/255.0 alpha:0.32].CGColor,(__bridge id)[UIColor colorWithRed:41/255.0 green:203/255.0 blue:190/255.0 alpha:0.16].CGColor];
    
    _beijingLayer.locations = @[@(0.0),@(0.5),@(1.0)];
    
    _beijingLayer.startPoint = CGPointMake(0, 0);
    
    _beijingLayer.endPoint = CGPointMake(0, 1);
    
    _beijingLayer.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width/10 * _arrm.count , self.myCollectionView.frame.size.height- 25);// self.myLineView.bounds;
    // _beijingLayer.backgroundColor = [[UIColor redColor] CGColor];;
    
    self.myLineView.alpha = 0.9;
    
    NSLog(@"_myLineView %lf",_myLineView.frame.size.width);
    NSLog(@"_beijingLayer %lf",_beijingLayer.frame.size.width);
    NSLog(@"self.myCollectionView.contentSize %lf",self.myCollectionView.contentSize.width);
    NSLog(@"width %lf",self.myCollectionView.frame.size.width/10*20);
    NSLog(@"UIScreen.mainScreen.bounds.size.width/10 * _arrm.count %lf",UIScreen.mainScreen.bounds.size.width/10 * _arrm.count);
    
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    //UIScreen.mainScreen.bounds.size.width/375*262(线长)
    UIBezierPath *path = [UIBezierPath bezierPath];//26 + 26 + 10 = 62
    //起始点
    [path moveToPoint:CGPointMake(chang, lineChange)];
    //开始画线
    for (int i = 0;  i < 19; i++) {
        
        model *m1 = self.highArrm[i];
        
        model *m2 = self.highArrm[i + 1];
        
        CGPoint tempPoint =  CGPointMake(chang + (i)*chang*2 , lineChange - m1.temp);
        
        CGPoint nectPoint =  CGPointMake(chang + (i + 1)*chang*2, lineChange - m2.temp);
        
        CGPoint controlPoint1 = CGPointMake((tempPoint.x + nectPoint.x)/2,tempPoint.y);
        
        CGPoint controlPoint2 = CGPointMake((tempPoint.x + nectPoint.x)/2,nectPoint.y);
        
        [path addCurveToPoint:nectPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        //   [path addLineToPoint:CGPointMake(chang + (i)*chang*2, m1.temp)];
        
        //  NSLog(@"+++ %lf-- %d",chang + (i)*chang*2,m1.temp);
        //path = [path smoothedPathWithGranularity:10];
    }
    [path addLineToPoint:CGPointMake(chang + (19)*chang*2, lineChange)];
    
    // [path addLineToPoint:CGPointMake(10, 10)];
    
    [path addLineToPoint:CGPointMake(chang, lineChange)];
    
    myShapeLayer.frame  =  self.myLineView.bounds;
    
    //  myShapeLayer.lineWidth = 30;
    myShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    myShapeLayer.path = path.CGPath;
    
    //  myShapeLayer.shadowOffset = CGSizeMake(0,5);
    //  myShapeLayer.shadowOpacity = 1;
    //  myShapeLayer.shadowRadius = 15;
    
    myShapeLayer.borderWidth = 0.1;
    
    // myShapeLayer.shadowColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:89/255.0 alpha:0.3].CGColor;
    //myShapeLayer.fillColor = nil; //*线条内是否填充。空就是不填充*/
    // myShapeLayer.lineJoin = kCALineJoinRound;//*线条边框*/
    // myShapeLayer.lineCap = kCALineCapRound;//*线条边框*/
    // myShapeLayer.lineWidth = 10;
    // myShapeLayer.backgroundColor = [UIColor redColor].CGColor;
    
    _beijingLayer.mask = myShapeLayer;
    
    [self.myLineView.layer addSublayer:_beijingLayer];
    
    //    加虚线
    [self addLine];
    //    加路径
    [self addRoute];
}

- (void)addLine{
    
    //渐变涂层
    _xuxianLayer = [CAGradientLayer layer];
    
    _xuxianLayer.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0 green:71/255.0 blue:157/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:130/255.0 blue:47/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:41/255.0 green:203/255.0 blue:190/255.0 alpha:1].CGColor];
    
    _xuxianLayer.locations = @[@(0.0),@(0.5),@(1.0)];
    
    _xuxianLayer.startPoint = CGPointMake(0, 0);
    
    _xuxianLayer.endPoint = CGPointMake(0, 1);
    
    _xuxianLayer.frame = CGRectMake(0, -self.warningHeig.constant, UIScreen.mainScreen.bounds.size.width/9 * _arrm.count,self.myCollectionView.frame.size.height );// self.myLineView.bounds;
    
    //    self.myLineView.alpha = 0.7;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.myLineView.bounds];
    [shapeLayer setPosition:CGPointMake(self.myLineView.bounds.size.width / 2.0,self.myLineView.bounds.size.height/2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //设置虚线颜色
    [shapeLayer setStrokeColor:[UIColor colorWithRed:253/255.0 green:71/255.0 blue:157/255.0 alpha:1.0].CGColor];
    
    CGFloat high =  (self.myLineView.frame.size.height)/4;
    //设置虚线的线宽度
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //设置虚线的线长及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil]];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    CGFloat dash[] = {10,10};
    [path setLineDash:dash count:1 phase:1];
    
    [path moveToPoint:CGPointMake(0, high)];
    
    [path addLineToPoint: CGPointMake(self.myLineView.bounds.size.width,high)];
    
    [path moveToPoint:CGPointMake(0, high*2)];
    
    [path addLineToPoint: CGPointMake(self.myLineView.bounds.size.width, high*2)];
    
    [path moveToPoint:CGPointMake(0, high*3)];
    
    [path addLineToPoint: CGPointMake(self.myLineView.bounds.size.width, high*3)];
    
    //另一种画虚线的方式
    /*
     //创建虚线绘制路径
     CGMutablePathRef path = CGPathCreateMutable();
     //设置虚线绘制路径起点
     CGPathMoveToPoint(path, NULL, 0, high);
     //设置虚线绘制路径终点
     CGPathAddLineToPoint(path, NULL,self.myLineView.bounds.size.width, high);
     
     //设置虚线绘制路径起点
     CGPathMoveToPoint(path, NULL, 0, high*2);
     //设置虚线绘制路径终点
     CGPathAddLineToPoint(path, NULL,self.myLineView.bounds.size.width, high*2);
     
     CGPathMoveToPoint(path, NULL, 0, high*3);
     //设置虚线绘制路径终点
     CGPathAddLineToPoint(path, NULL,self.myLineView.bounds.size.width, high*3);
     
     
     //    CGPathMoveToPoint(path, NULL, 0, high*2);
     //    //设置虚线绘制路径终点
     //    CGPathAddLineToPoint(path, NULL,self.myLineView.bounds.size.width, 0);
     
     
     //    CGPathMoveToPoint(path, NULL, 0, high *3);
     //    //设置虚线绘制路径终点
     //    CGPathAddLineToPoint(path, NULL,self.myLineView.bounds.size.width, 0);
     
     //设置虚线绘制路径
     // [shapeLayer setPath:path];
     
     
     //CGPathRelease(path);
     
     */
    shapeLayer.path = path.CGPath;
    _xuxianLayer.mask = shapeLayer;
    
    // myShapeLayer.frame  =  self.myLineView.bounds;
    
    //添加虚线
    //[self.layer addSublayer:shapeLayer];
    [self.myLineView.layer addSublayer:_xuxianLayer];
}
- (void)addRoute{
    //列宽相关
    CGFloat chang = UIScreen.mainScreen.bounds.size.width/10/2;
    //线长  25线低端到底的距离
    CGFloat lineChange = self.myCollectionView.frame.size.height - 25;
    //渐变涂层
    _yansexianLayer = [CAGradientLayer layer];
    
    _yansexianLayer.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0 green:71/255.0 blue:157/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:130/255.0 blue:47/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:41/255.0 green:203/255.0 blue:190/255.0 alpha:1].CGColor];
    
    _yansexianLayer.locations = @[@(0.0),@(0.5),@(1.0)];
    
    _yansexianLayer.startPoint = CGPointMake(0, 0);
    
    _yansexianLayer.endPoint = CGPointMake(0, 1);
    
    _yansexianLayer.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width/9 * _arrm.count,self.myCollectionView.frame.size.height);// self.myLineView.bounds;
    
    // self.myLineView.alpha = 0.7;
    
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    //UIScreen.mainScreen.bounds.size.width/375*262(线长)
    UIBezierPath *path = [UIBezierPath bezierPath];//26 + 26 + 10 = 62
    //起始点
    [path moveToPoint:CGPointMake(chang, lineChange)];
    //开始画线
    for (int i = 0;  i < 19; i++) {
        
        model *m1 = self.highArrm[i];
        
        model *m2 = self.highArrm[i + 1];
        
        CGPoint tempPoint =  CGPointMake(chang + (i)*chang*2 , lineChange - m1.temp);
        
        CGPoint nectPoint =  CGPointMake(chang + (i + 1)*chang*2, lineChange - m2.temp);
        
        // [path addQuadCurveToPoint:CGPointMake(chang + ((i + 1) * chang), lineChange - m.temp) controlPoint:CGPointMake(chang + ((i + 1) * chang), 0)];
        
        // (m1.temp + m2.temp)/2
        
        // ( chang + ((i + 1) * chang + chang + ((i + 2) * chang)/2
        
        CGPoint controlPoint1 = CGPointMake((tempPoint.x + nectPoint.x)/2,tempPoint.y);
        
        CGPoint controlPoint2 = CGPointMake((tempPoint.x + nectPoint.x)/2,nectPoint.y);
        
        [path addCurveToPoint:nectPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        
        //path = [path smoothedPathWithGranularity:10];
    }
    
    myShapeLayer.frame  =  self.myLineView.bounds;
    //必须要有下面一行颜色才会i显示 描边色
    myShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    myShapeLayer.path = path.CGPath;
    
    // myShapeLayer.shadowOffset = CGSizeMake(0,100);
    myShapeLayer.shadowOpacity = 1;
    myShapeLayer.shadowRadius = 15;
    myShapeLayer.borderWidth = 0.1;
    myShapeLayer.shadowColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:89/255.0 alpha:0.3].CGColor;
    
    myShapeLayer.fillColor = nil; //*线条内是否填充*/
    myShapeLayer.lineJoin = kCALineJoinRound;/*lineCap为线端点类型，值有三个类型，分别为kCALineCapButt 、kCALineCapRound 、kCALineCapSquare，默认值为Butt；
                                              lineJoin为线连接类型，其值也有三个类型，分别为kCALineJoinMiter、kCALineJoinRound、kCALineJoinBevel，默认值是Miter。
                                              */
    myShapeLayer.lineCap = kCALineCapRound;
    myShapeLayer.lineWidth = 3;
    // myShapeLayer.backgroundColor = [UIColor redColor].CGColor;
    
    _yansexianLayer.mask = myShapeLayer;
    
    [self.myLineView.layer addSublayer:_yansexianLayer];
}


#pragma delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor grayColor];
    //cell.contentView.backgroundColor = [UIColor yellowColor];
    // [cell.myBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
    cell.myLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/10, self.myCollectionView.frame.size.height);
}

//每个cell的偏移
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0  , 0, 0 , 0);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return  CGSizeMake(5, 100);
//}

#pragma delegate scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //scrollView.contentOffset.x >= 0 &&
    if(scrollView == self.myScrollview)
    {
        //  NSLog(@"myScrollview = %f",scrollView.contentOffset.x);
        
        [self.myCollectionView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
        
        //  NSLog(@"self.myCollectionView = %f",self.myCollectionView.contentOffset.x);
    }
    
}
@end
