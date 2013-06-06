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

    NSArray *jsonKeysAndValues =
        @[
          @{ @"key": @"MPMediaEntityPropertyPersistentID",   @"value" : MPMediaEntityPropertyPersistentID },
          @{ @"key": @"MPMediaItemPropertyMediaType",        @"value" : MPMediaItemPropertyMediaType },
          @{ @"key": @"MPMediaItemPropertyTitle",            @"value" : MPMediaItemPropertyTitle },
          @{ @"key": @"MPMediaItemPropertyAlbumTitle",       @"value" : MPMediaItemPropertyAlbumTitle },
          @{ @"key": @"MPMediaItemPropertyArtist",           @"value" : MPMediaItemPropertyArtist },
          @{ @"key": @"MPMediaItemPropertyAlbumArtist",      @"value" : MPMediaItemPropertyAlbumArtist },
          @{ @"key": @"MPMediaItemPropertyGenre",            @"value" : MPMediaItemPropertyGenre },
          @{ @"key": @"MPMediaItemPropertyComposer",         @"value" : MPMediaItemPropertyComposer },
          @{ @"key": @"MPMediaItemPropertyPlaybackDuration", @"value" : MPMediaItemPropertyPlaybackDuration },
          @{ @"key": @"MPMediaItemPropertyAlbumTrackNumber", @"value" : MPMediaItemPropertyAlbumTrackNumber },
          @{ @"key": @"MPMediaItemPropertyAlbumTrackCount",  @"value" : MPMediaItemPropertyAlbumTrackCount },
          @{ @"key": @"MPMediaItemPropertyDiscNumber",       @"value" : MPMediaItemPropertyDiscNumber },
          @{ @"key": @"MPMediaItemPropertyDiscCount",        @"value" : MPMediaItemPropertyDiscCount },
          @{ @"key": @"MPMediaItemPropertyArtwork",          @"value" : MPMediaItemPropertyArtwork },
          @{ @"key": @"MPMediaItemPropertyLyrics",           @"value" : MPMediaItemPropertyLyrics },
          @{ @"key": @"MPMediaItemPropertyIsCompilation",    @"value" : MPMediaItemPropertyIsCompilation },
          @{ @"key": @"MPMediaItemPropertyReleaseDate",      @"value" : MPMediaItemPropertyReleaseDate },
          @{ @"key": @"MPMediaItemPropertyBeatsPerMinute",   @"value" : MPMediaItemPropertyBeatsPerMinute },
          @{ @"key": @"MPMediaItemPropertyComments",         @"value" : MPMediaItemPropertyComments },
          @{ @"key": @"MPMediaItemPropertyAssetURL",         @"value" : MPMediaItemPropertyAssetURL },
          // Podcast Item Property Keys or User-Defined Property Keys
          @{ @"key": @"MPMediaItemPropertyPlayCount",        @"value" : MPMediaItemPropertyPlayCount },
          @{ @"key": @"MPMediaItemPropertySkipCount",        @"value" : MPMediaItemPropertySkipCount },
          @{ @"key": @"MPMediaItemPropertyRating",           @"value" : MPMediaItemPropertyRating },
          @{ @"key": @"MPMediaItemPropertyLastPlayedDate",   @"value" : MPMediaItemPropertyLastPlayedDate },
          @{ @"key": @"MPMediaItemPropertyUserGrouping",     @"value" : MPMediaItemPropertyUserGrouping },
          @{ @"key": @"MPMediaItemPropertyBookmarkTime",     @"value" : MPMediaItemPropertyBookmarkTime }
          ];
    for (MPMediaItemCollection *collection in [albumQuery collections]) {
        NSMutableDictionary *album = [@{} mutableCopy];
        MPMediaItem *song = [collection representativeItem];

        for (NSDictionary *dict in jsonKeysAndValues) {
            if (
                [song respondsToSelector:NSSelectorFromString(dict[@"value"])] &&
                [song valueForKey:dict[@"value"]] != nil
            ) {
                if ([dict[@"key"] isEqualToString:@"MPMediaItemPropertyArtwork"]) {
                    UIImage *artworkImage = [[song valueForKey:dict[@"value"]] imageWithSize:CGSizeMake(32.0, 32.0)];
                    NSData *imageData = UIImageJPEGRepresentation(artworkImage, 1.0);
                    if (imageData) {
                        album[ dict[@"key"] ] = [imageData base64EncodedString];
                    }
                } else if (
                    [dict[@"key"] isEqualToString:@"MPMediaItemPropertyReleaseDate"] ||
                    [dict[@"key"] isEqualToString:@"MPMediaItemPropertyLastPlayedDate"]
                ) {
                    album[ dict[@"key"] ] = [formatter stringFromDate:[song valueForKey:dict[@"value"]]];
                } else {
                    album[ dict[@"key"] ] = [song valueForKey:dict[@"value"]];
                }
            }
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
