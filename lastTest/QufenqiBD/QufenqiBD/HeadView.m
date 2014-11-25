

#import "HeadView.h"
#import "OrderCountModel.h"

@interface HeadView()
{
    UIButton *_bgButton;
    UILabel *_numLabel;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
        view.backgroundColor=UIColorFromRGB(0x7db17f);
        [self addSubview:view];
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
        bgButton.frame=CGRectMake(kSCREEN_WIDTH-150, 0, 80, 40);
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *lineImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lineh.png"]];
        lineImageView.frame=CGRectMake(0, 39, kSCREEN_WIDTH, 1);
        [view addSubview:lineImageView];
        [view addSubview:bgButton];
        _bgButton = bgButton;
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:numLabel];
        _numLabel = numLabel;
    }
    return self;
}

- (void)headBtnClick
{
    _friendGroup.opened = !_friendGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}

- (void)setFriendGroup:(SchoolModel *)friendGroup
{
    _friendGroup = friendGroup;
    _numLabel.text = [NSString stringWithFormat:@"%@(%@)",friendGroup.school_name,friendGroup.count];
}

- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = _friendGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = CGRectMake(0, 0, self.bounds.size.width-20, self.bounds.size.height);
    _numLabel.frame = CGRectMake(10, 0, kSCREEN_WIDTH, self.frame.size.height);
}

@end
