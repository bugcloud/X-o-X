//
//  ViewController.h
//  X-o-X
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *mainView_;
}

@property (nonatomic, retain) IBOutlet UIWebView *mainView_;


@end
