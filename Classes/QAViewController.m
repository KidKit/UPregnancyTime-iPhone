//
//  QAViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QAViewController.h"

@interface QAViewController ()
{
    
}
@property (nonatomic,retain)NSArray *hotWords;
@property (nonatomic,retain)NSArray *searchHistories;
-(void)fetchHotSearchKeyWord;
-(void)fetchHotSearchKeyWordWithIndicator;
-(void)fetchHotSearchKeyWordFinish:(ASIHTTPRequest *)theRequest;
-(void)fetchHotSearchKeyWordFail:(ASIHTTPRequest *)theRequest;
-(void)querySearchHistory;
-(void)querySearchHistoryWithIndicator;
-(void)querySearchHistoryFinish;
-(void)saveSearchHistory:(NSString *)keyWord;
-(void)doSearch:(NSString *)keyWord;
-(void)doSearchWithIndicator:(NSString *)keyWord;
-(void)doSearchFinish:(ASIHTTPRequest *)theRequest;
-(void)doSearchFail:(ASIHTTPRequest *)theRequest;
-(void)doRealTimeSearch:(NSString *)keyWord;
-(void)doRealTimeSearchWithIndicator:(NSString *)keyWord;
@end

@implementation QAViewController
@synthesize searchView = _searchView;
@synthesize historyView=_historyView;
@synthesize indicator=_indicator;
@synthesize hotWordsView=_hotWordsView;
@synthesize hotWordsTitleView=_hotWordsTitleView;
@synthesize mainView=_mainView;
@synthesize searchTextField = _searchTextField;
@synthesize overlay = _overlay;
@synthesize rootDelegate=_rootDelegate;
@synthesize hotWords=_hotWords;
@synthesize searchHistories=_searchHistories;

#pragma mark - private method
-(void)doRealTimeSearch:(NSString *)keyWord{
    
}
-(void)doRealTimeSearchWithIndicator:(NSString *)keyWord{

}

-(void)doSearch:(NSString *)keyWord{
    if ([keyWord length]>0) {
        [self saveSearchHistory:keyWord];
        NSString *searchUrl = [NSString stringWithFormat:@"%@%@",SEARCH_URL,keyWord];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithCNString:searchUrl]];
        request.delegate = self;
        request.didFailSelector = @selector(doSearchFail:);
        request.didFinishSelector = @selector(doSearchFinish:);
        request.timeOutSeconds = 10;
        [request startAsynchronous];
    }
}
-(void)doSearchWithIndicator:(NSString *)keyWord{
    [_indicator startAnimating];
    [self doSearch:keyWord];
}

-(void)doSearchFinish:(ASIHTTPRequest *)theRequest{
    NSMutableArray *result = [NSMutableArray array];
    NSString *theJSON = [theRequest responseString];
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSMutableDictionary *jsonDictionary = [parser objectWithString:theJSON];
    NSArray *questions = [((NSDictionary *)[jsonDictionary objectForKey:@"qr"])objectForKey:@"questions"];
    for (NSDictionary * eachJson in questions) {
        QuestionInfo *info = [QuestionInfo objWithJsonDictionary:eachJson];
        //NSLog(@"%@",info.questionTitle);
        if ([info.questionTitle length]>0) {
            [result addObject:info];
        }
    }
    SearchResultViewController *resultViewController = [[[SearchResultViewController alloc] initWithResult:result] autorelease];
    [self.navigationController pushViewController:resultViewController animated:YES];
    [_indicator stopAnimating];
}
-(void)doSearchFail:(ASIHTTPRequest *)theRequest{
    [_indicator stopAnimating];
}

-(void)saveSearchHistory:(NSString *)keyWord{
   
    SearchHistory *exist = [[DatabaseAccess sharedAccess] executeQueryForUnique:[SearchHistory class] withSql:@"select * from qa_search_history where key_word=?" withArgumentsInArray:[NSArray arrayWithObjects:keyWord, nil ]];
    if(exist){
        exist.search_date = [NSDate date];
        [[DatabaseAccess sharedAccess] updateObjectWithUniqueId:exist];
    }else {
        SearchHistory *history = [[[SearchHistory alloc] init] autorelease];
        history.key_word = keyWord;
        history.search_date = [NSDate date];
        [[DatabaseAccess sharedAccess] insertObject:history];
    }
}

-(void)querySearchHistory{
    self.searchHistories = [[DatabaseAccess sharedAccess] executeQueryForList:[SearchHistory class] limit:20 withSql:@"select * from qa_search_history order by search_date desc" withArgumentsInArray:nil];
}
-(void)querySearchHistoryWithIndicator{
    [_mainView bringSubviewToFront:_indicator];
    [_indicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self querySearchHistory];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self querySearchHistoryFinish];
        });
    });
}


-(void)querySearchHistoryFinish{
    [_historyView reloadData];
    [_indicator stopAnimating];
}

-(void)fetchHotSearchKeyWordWithIndicator{
    [_indicator startAnimating];
    [self fetchHotSearchKeyWord];
}
-(void)fetchHotSearchKeyWord{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:HOT_WORDS_URL]];
    request.delegate = self;
    request.didFailSelector = @selector(fetchHotSearchKeyWordFail:);
    request.didFinishSelector = @selector(fetchHotSearchKeyWordFinish:);
    request.timeOutSeconds = 10;
    [request startAsynchronous];
    
}
-(void)fetchHotSearchKeyWordFinish:(ASIHTTPRequest *)theRequest{
    [UIView animateWithDuration:0.3 animations:^{
        for(UIView *sub in [_hotWordsView subviews]){
            [sub removeFromSuperview];
        }
        _hotWordsView.frame = CGRectMake(_hotWordsView.frame.origin.x, _hotWordsView.frame.origin.y, _hotWordsView.frame.size.width, 0);
    }];
    NSString *theJSON = [theRequest responseString];
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSMutableDictionary *jsonDictionary = [parser objectWithString:theJSON];
    self.hotWords = [jsonDictionary objectForKey:@"pop"];
    int i=0;
    for (NSMutableDictionary *hotWord in _hotWords) {
        int fix = i % 2;
        UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(fix*(_hotWordsView.frame.size.width/2), _hotWordsTitleView.frame.size.height*(i/2), _hotWordsView.frame.size.width/2, 25)];
        hotLabel.layer.borderColor = [UIColor brownColor].CGColor;
        hotLabel.layer.borderWidth = 0.0f;
        hotLabel.layer.cornerRadius = 3.0f;
        hotLabel.layer.masksToBounds = YES;
        hotLabel.backgroundColor = [UIColor clearColor];
        hotLabel.text = [hotWord objectForKey:@"name"];;
        hotLabel.textAlignment = UITextAlignmentCenter;
        hotLabel.font= [UIFont systemFontOfSize:14.0f];
        [_hotWordsView addSubview:hotLabel];
        i++;
    }
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        int count = [_hotWords count];
        if (count % 2) {
            count = (count/2)+1;
        }else {
            count = count/2;
        }
        _hotWordsView.frame = CGRectMake(_hotWordsView.frame.origin.x, _hotWordsView.frame.origin.y, _hotWordsView.frame.size.width, _hotWordsTitleView.frame.size.height*(count));
        _historyView.frame = CGRectMake(_historyView.frame.origin.x, _hotWordsView.frame.origin.y+_hotWordsView.frame.size.height, _historyView.frame.size.width, _historyView.frame.size.height);
    } completion:NULL];
    [_indicator stopAnimating];
}
-(void)fetchHotSearchKeyWordFail:(ASIHTTPRequest *)theRequest{
    [_indicator stopAnimating];
}

#pragma mark - view life cycle method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)dealloc
{
    [_overlay release];
    [_hotWords release];
    [_searchHistories release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _hotWordsView.backgroundColor = [UIColor clearColor];
    _historyView.backgroundColor = [UIColor clearColor];
    _searchView.backgroundColor = [UIColor clearColor];
    //_mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainView = nil;
    self.searchView = nil;
    self.historyView = nil;
    self.indicator = nil;
    self.searchTextField = nil;
    self.hotWordsView = nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [self fetchHotSearchKeyWordWithIndicator];
    [self querySearchHistoryWithIndicator];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_searchHistories count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}// Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"历史搜索";
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)  
    {  
        // Create a cell to display an ingredient.  
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
    }
    SearchHistory *history = [_searchHistories objectAtIndex:indexPath.row];
    cell.textLabel.text = history.key_word;
    cell.detailTextLabel.text = [history.search_date stringWithFormat:[NSDate dateTimeFormatStringCNFull]];
    return cell;
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_overlay==nil) {
        self.overlay = [[[OverlayViewController alloc] init] autorelease];
        _overlay.delegate = self;
        CGFloat xaxis = _searchView.frame.origin.x;
        CGFloat yaxis = _searchView.frame.size.height+_searchView.frame.origin.y;
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height - _searchView.frame.size.height;
        CGRect frame = CGRectMake(xaxis, yaxis, width, height);
        _overlay.view.frame = frame;
        _overlay.view.backgroundColor = [UIColor blackColor];
        _overlay.view.alpha = 0.3;
        [self.view insertSubview:_overlay.view atIndex: [[self.view subviews] count]];
    }
    _overlay.view.hidden=NO;
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *keyWord = textField.text;
    [self doSearchWithIndicator:keyWord];
    _overlay.view.hidden=YES;
    [_searchTextField resignFirstResponder];
    return YES;
}

#pragma mark - OverlayViewControllerDelegate

-(void)touchBeginOnOverlayView{
    _overlay.view.hidden=YES;
    [_searchTextField resignFirstResponder];
    
}
@end
