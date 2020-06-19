//
//  ProgressReportViewController.m
//  iSH
//
//  Created by Theodore Dubois on 6/18/20.
//

#import "ProgressReportViewController.h"

@interface ProgressReportViewController ()

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *bar;

@property (nonatomic) double progress;
@property (nonatomic) NSString *message;

@property CADisplayLink *timer;

@end

@implementation ProgressReportViewController

- (void)viewDidLoad {
    self.titleLabel.text = self.title;
}

- (void)viewDidLayoutSubviews {
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.path = [UIBezierPath bezierPathWithRoundedRect:self.popupView.bounds cornerRadius:13].CGPath;
    self.popupView.layer.mask = mask;
    self.popupView.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.timer addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

- (void)updateProgress:(double)progressFraction message:(NSString *)progressMessage {
    @synchronized (self) {
        _progress = progressFraction;
        _message = progressMessage;
    }
}

- (void)update {
    @synchronized (self) {
        self.bar.progress = _progress;
        self.statusLabel.text = _message;
    }
}

@end