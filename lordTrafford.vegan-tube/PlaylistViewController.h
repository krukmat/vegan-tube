
#import "YTPlayerView.h"

@interface PlaylistViewController : UIViewController<YTPlayerViewDelegate>

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property(nonatomic, weak) IBOutlet UIButton *playButton;
@property(nonatomic, weak) IBOutlet UIButton *pauseButton;
@property(nonatomic, weak) IBOutlet UIButton *stopButton;
@property(nonatomic, weak) IBOutlet UIButton *nextVideoButton;
@property(nonatomic, weak) IBOutlet UIButton *previousVideoButton;
@property(nonatomic, weak) IBOutlet UITextView *statusTextView;
@property(nonatomic, weak) IBOutlet UIButton *startButton;
@property(nonatomic, weak) IBOutlet UIButton *reverseButton;
@property(nonatomic, weak) IBOutlet UIButton *forwardButton;

- (IBAction)buttonPressed:(id)sender;

@end