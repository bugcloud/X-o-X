//
//  ViewController.m
//  X-o-X
//

#import "ViewController.h"
#import "NSData+Base64.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainView_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Load HTML
    mainView_.scalesPageToFit = YES;
    mainView_.delegate = self;
    [mainView_.scrollView setBounces:NO];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [mainView_ loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    NSMutableArray *albums = [@[] mutableCopy];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];

    for (MPMediaItemCollection *collection in [albumQuery collections]) {
        NSMutableDictionary *album = [@{} mutableCopy];

        MPMediaItem *song = [collection representativeItem];
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaEntityPropertyPersistentID)] &&
            [song valueForKey:MPMediaItemPropertyPersistentID] != nil
        ) {
            album[@"MPMediaItemPropertyPersistentID"] = [song valueForKey:MPMediaItemPropertyPersistentID];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyMediaType)] &&
            [song valueForKey:MPMediaItemPropertyMediaType] != nil
        ) {
            album[@"MPMediaItemPropertyMediaType"]  = [song valueForKey:MPMediaItemPropertyMediaType];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyTitle)] &&
            [song valueForKey:MPMediaItemPropertyTitle] != nil
        ) {
            album[@"MPMediaItemPropertyTitle"] = [song valueForKey:MPMediaItemPropertyTitle];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyAlbumTitle)] &&
            [song valueForKey:MPMediaItemPropertyAlbumTitle] != nil
        ) {
            album[@"MPMediaItemPropertyAlbumTitle"] = [song valueForKey:MPMediaItemPropertyAlbumTitle];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyArtist)] &&
            [song valueForKey:MPMediaItemPropertyArtist] != nil
        ) {
            album[@"MPMediaItemPropertyArtist"] = [song valueForKey:MPMediaItemPropertyArtist];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyAlbumArtist)] &&
            [song valueForKey:MPMediaItemPropertyAlbumArtist] != nil
        ) {
            album[@"MPMediaItemPropertyAlbumArtist"] = [song valueForKey:MPMediaItemPropertyAlbumArtist];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyGenre)] &&
            [song valueForKey:MPMediaItemPropertyGenre] != nil
        ) {
            album[@"MPMediaItemPropertyGenre"] = [song valueForKey:MPMediaItemPropertyGenre];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyComposer)] &&
            [song valueForKey:MPMediaItemPropertyComposer] != nil
        ) {
            album[@"MPMediaItemPropertyComposer"] = [song valueForKey:MPMediaItemPropertyComposer];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyPlaybackDuration)] &&
            [song valueForKey:MPMediaItemPropertyPlaybackDuration] != nil
        ) {
            album[@"MPMediaItemPropertyPlaybackDuration"] = [song valueForKey:MPMediaItemPropertyPlaybackDuration];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyAlbumTrackNumber)] &&
            [song valueForKey:MPMediaItemPropertyAlbumTrackNumber] != nil
        ) {
            album[@"MPMediaItemPropertyAlbumTrackNumber"] = [song valueForKey:MPMediaItemPropertyAlbumTrackNumber];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyAlbumTrackCount)] &&
            [song valueForKey:MPMediaItemPropertyAlbumTrackCount] != nil
        ) {
            album[@"MPMediaItemPropertyAlbumTrackCount"] = [song valueForKey:MPMediaItemPropertyAlbumTrackCount];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyDiscNumber)] &&
            [song valueForKey:MPMediaItemPropertyDiscNumber] != nil
        ) {
            album[@"MPMediaItemPropertyDiscNumber"] = [song valueForKey:MPMediaItemPropertyDiscNumber];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyDiscCount)] &&
            [song valueForKey:MPMediaItemPropertyDiscCount] != nil
        ) {
            album[@"MPMediaItemPropertyDiscCount"] = [song valueForKey:MPMediaItemPropertyDiscCount];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyArtwork)] &&
            [song valueForKey:MPMediaItemPropertyArtwork] != nil
        ) {
            UIImage *artworkImage = [[song valueForKey:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(32.0, 32.0)];
            NSData *imageData = UIImageJPEGRepresentation(artworkImage, 1.0);
            if (imageData) {
                album[@"MPMediaItemPropertyArtwork"] = [imageData base64EncodedString];
            }
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyLyrics)] &&
            [song valueForKey:MPMediaItemPropertyLyrics] != nil
        ) {
            album[@"MPMediaItemPropertyLyrics"] = [song valueForKey:MPMediaItemPropertyLyrics];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyIsCompilation)] &&
            [song valueForKey:MPMediaItemPropertyIsCompilation] != nil
        ) {
            album[@"MPMediaItemPropertyIsCompilation"] = [song valueForKey:MPMediaItemPropertyIsCompilation];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyReleaseDate)] &&
            [song valueForKey:MPMediaItemPropertyReleaseDate] != nil
        ) {
            album[@"MPMediaItemPropertyReleaseDate"] = [formatter stringFromDate:[song valueForKey:MPMediaItemPropertyReleaseDate]];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyBeatsPerMinute)] &&
            [song valueForKey:MPMediaItemPropertyBeatsPerMinute] != nil
        ) {
            album[@"MPMediaItemPropertyBeatsPerMinute"] = [song valueForKey:MPMediaItemPropertyBeatsPerMinute];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyComments)] &&
            [song valueForKey:MPMediaItemPropertyComments] != nil
        ) {
            album[@"MPMediaItemPropertyComments"] = [song valueForKey:MPMediaItemPropertyComments];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyAssetURL)] &&
            [song valueForKey:MPMediaItemPropertyAssetURL] != nil
        ) {
            album[@"MPMediaItemPropertyAssetURL"] = [song valueForKey:MPMediaItemPropertyAssetURL];
        }
        // Podcast Item Property Keys or User-Defined Property Keys
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyPlayCount)] &&
            [song valueForKey:MPMediaItemPropertyPlayCount] != nil
        ) {
            album[@"MPMediaItemPropertyPlayCount"] = [song valueForKey:MPMediaItemPropertyPlayCount];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertySkipCount)] &&
            [song valueForKey:MPMediaItemPropertySkipCount] != nil
        ) {
            album[@"MPMediaItemPropertySkipCount"] = [song valueForKey:MPMediaItemPropertySkipCount];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyRating)] &&
            [song valueForKey:MPMediaItemPropertyRating] != nil
        ) {
            album[@"MPMediaItemPropertyRating"] = [song valueForKey:MPMediaItemPropertyRating];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyLastPlayedDate)] &&
            [song valueForKey:MPMediaItemPropertyLastPlayedDate] != nil
        ) {
            album[@"MPMediaItemPropertyLastPlayedDate"] = [formatter stringFromDate:[song valueForKey:MPMediaItemPropertyLastPlayedDate]];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyUserGrouping)] &&
            [song valueForKey:MPMediaItemPropertyUserGrouping] != nil
        ) {
            album[@"MPMediaItemPropertyUserGrouping"] = [song valueForKey:MPMediaItemPropertyUserGrouping];
        }
        if (
            [song respondsToSelector:NSSelectorFromString(MPMediaItemPropertyBookmarkTime)] &&
            [song valueForKey:MPMediaItemPropertyBookmarkTime] != nil
        ) {
            album[@"MPMediaItemPropertyBookmarkTime"] = [song valueForKey:MPMediaItemPropertyBookmarkTime];
        }
        [albums addObject:album];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:albums
                                                       options:0
                                                         error:&error
                        ];
    if (!jsonData) {
        NSLog(@"ERROR %@", [error description]);
    } else {
        NSString *jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes]
                                                     length:[jsonData length]
                                                   encoding:NSUTF8StringEncoding
                             ];
        NSString *js = [NSString stringWithFormat:@"_app.initWithAlbums(%@);", jsonStr];
        //NSString *js = @"_app.initWithAlbums()";
        [mainView_ stringByEvaluatingJavaScriptFromString:js];
    }
}

@end
