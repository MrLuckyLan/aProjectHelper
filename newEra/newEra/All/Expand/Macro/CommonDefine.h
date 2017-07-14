
#import <Foundation/Foundation.h>


/*常用宏*/


//Print
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//LazyCode
#define UserDefaultsSetObjectforKey(object, key) { NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; [userDefaults setObject:(object) forKey:(key)]; [userDefaults synchronize];}
#define UserDefaultsGetObjectforKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]
#define __WEAKSELF  __weak __typeof(&*self)weakSelf = self;


//Color
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGB_alpha(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//Object
#define ScreenBounds [[UIScreen mainScreen] bounds]
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height
#define WINDOW [UIApplication sharedApplication].keyWindow
#define VERSION [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]

//Device
#define ISPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define ISPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)






















