
#import "PlaylistViewController.h"

@implementation PlaylistViewController
NSArray *videosToDisplay;
Boolean videoSetLoaded = false;

- (void)viewDidLoad {
  [super viewDidLoad];

    
  // For a full list of player parameters, see the documentation for the HTML5 player
  // at: https://developers.google.com/youtube/player_parameters?playerVersion=HTML5
  NSDictionary *playerVars = @{
    @"controls" : @0,
    @"playsinline" : @1,
    @"autohide" : @1,
    @"showinfo" : @0,
    @"modestbranding" : @0
  };
  NSString *videoId = @"tk5XLWxYQyk";
  self.playerView.delegate = self;
  [self.playerView loadWithVideoId:videoId playerVars:playerVars];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receivedPlaybackStartedNotification:)
                                               name:@"Playback started"
                                             object:nil];
}

- (IBAction)buttonPressed:(id)sender {
  if (sender == self.playButton) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
      [self.playerView playVideo];
  } else if (sender == self.pauseButton) {
    [self.playerView pauseVideo];
  } else if (sender == self.stopButton) {
    [self.playerView stopVideo];
  } else if (sender == self.nextVideoButton) {
    [self appendStatusText:@"Loading next video in playlist\n"];
    [self.playerView nextVideo];
  } else if (sender == self.previousVideoButton) {
    [self appendStatusText:@"Loading previous video in playlist\n"];
    [self.playerView previousVideo];
  } else if (sender == self.reverseButton) {
      float seekToTime = self.playerView.currentTime - 30.0;
      [self.playerView seekToSeconds:seekToTime allowSeekAhead:YES];
      [self appendStatusText:[NSString stringWithFormat:@"Seeking to time: %.0f seconds\n", seekToTime]];
  } else if (sender == self.forwardButton) {
      float seekToTime = self.playerView.currentTime + 30.0;
      [self.playerView seekToSeconds:seekToTime allowSeekAhead:YES];
      [self appendStatusText:[NSString stringWithFormat:@"Seeking to time: %.0f seconds\n", seekToTime]];
  } else if (sender == self.startButton) {
      [self.playerView seekToSeconds:0 allowSeekAhead:YES];
      [self appendStatusText:@"Seeking to beginning\n"];
  }
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
  if([notification.name isEqual:@"Playback started"] && notification.object != self) {
     [self.playerView pauseVideo];
  }
}

/**
 * Private helper method to add player status in statusTextView and scroll view automatically.
 *
 * @param status a string describing current player state
 */
- (void)appendStatusText:(NSString*)status {
  [self.statusTextView setText:[self.statusTextView.text stringByAppendingString:status]];
  NSRange range = NSMakeRange(self.statusTextView.text.length - 1, 1);

  // To avoid dizzying scrolling on appending latest status.
  self.statusTextView.scrollEnabled = NO;
  [self.statusTextView scrollRangeToVisible:range];
  self.statusTextView.scrollEnabled = YES;
}

@end