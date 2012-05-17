//
//  QuestionDetailViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuestionDetailViewController.h"

@interface QuestionDetailViewController ()
{
    NSString * _questionId;
}

-(void)fetchQuestion;
-(void)fetchQuestionFinish:(ASIHTTPRequest*)theRequest;
-(void)fetchQuestionFail:(ASIHTTPRequest*)theRequest;
@end

@implementation QuestionDetailViewController
@synthesize tableView=_tableView;
@synthesize questionInfo=_questionInfo;
@synthesize questionAnswers=_questionAnswers;
#pragma mark - private method
-(void)fetchQuestion{
    NSString *sURL = [NSString stringWithFormat:@"%@%@",FETCH_QUESTION_URL,_questionId];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithCNString:sURL]];
    request.delegate = self;
    request.didFailSelector = @selector(fetchQuestionFail:);
    request.didFinishSelector = @selector(fetchQuestionFinish:);
    request.timeOutSeconds = 10;
    [request startAsynchronous];
    
}
-(void)fetchQuestionFinish:(ASIHTTPRequest*)theRequest{
    NSMutableArray *result = [NSMutableArray array];
    NSString *theJSON = [theRequest responseString];
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSMutableDictionary *jsonDictionary = [parser objectWithString:theJSON];
    NSMutableDictionary *question = [jsonDictionary objectForKey:@"q"];
    NSArray *answers = [question objectForKey:@"answers"];
    self.questionInfo = [QuestionInfo objWithJsonDictionary:question];
    for (NSMutableDictionary *answer in answers) {
        [result addObject:[AnswerInfo objWithJsonDictionary:answer]];
    }
    self.questionAnswers = result;
    [_tableView reloadData];
}
-(void)fetchQuestionFail:(ASIHTTPRequest*)request{
    
}
#pragma mark - view lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithIdentifier:(NSString *)questionId{
    self = [super init];
    if (self) {
        _questionId = questionId;
    }
    return self;
}

- (void)dealloc
{
    [_questionInfo release];
    [_questionAnswers release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fetchQuestion];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return (_questionInfo)?1:0;
    }else {
        return [_questionAnswers count];
    }
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CellIdentifier = @"QDVCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if (indexPath.section==0) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"QuestionView" owner:nil options:nil];
            QuestionView *view = [array lastObject];
            [view populateWithInfo:_questionInfo];
            UIImage *questionViewBG = [[UIImage imageNamed:@"bg_tt"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 0, 30, 0)];
            UIImageView *imageView = [[[UIImageView alloc] initWithImage:questionViewBG] autorelease];
            imageView.frame = CGRectMake(3, 0, view.frame.size.width, view.frame.size.height);
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, view.frame.size.height);
            [cell addSubview:imageView];
            //view.backgroundColor = [UIColor colorWithPatternImage:questionViewBG];
            [cell addSubview:view];
        }
        if (indexPath.section==1) {
             NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AnswerView" owner:nil options:nil];
            AnswerView *view = [array lastObject];
            AnswerInfo *info = [_questionAnswers objectAtIndex:indexPath.row];
            [view populateWithInfo:info];
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, view.frame.size.height);
            [cell addSubview:view];
        }
        
    }
    return  cell;
}
@end
