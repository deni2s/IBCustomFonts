//
//  UIFont+IBCustomFonts.m
//  IBCustomFonts
//
//  Created by Deniss Fedotovs on 9/23/13.
//  https://github.com/deni2s/IBCustomFonts
//
/*

IBCustomFonts category allows you to use custom fonts from Interface Builder (IB) when building your iOS apps. Apps using IBCustomFonts category are approved by Apple App Store (as of September 2013).
    No need to use IBOutlets, subclassing of UILabels and UIButtons or change fonts in code.
    Tested on iOS6 and iOS7.
 
 Usage:
 1) Add this file to your Xcode project
 2) Add custom fonts to your application as usual (don't forget to define them in your app Info.plist as "Fonts provided by application" array)
 3) Add new dictionary to your app Info.plist named "IBCustomFonts" and add to it key-value pairs where key is name of font used in IB and value is name of your custom font.
    For example: HelveticaNeue-Regular and CustomFont-Regular.
 4) In previous example in IB use HelveticaNeue-Regular in places where do you want to see your CustomFont-Regular at runtime.
 
 
The MIT License (MIT)

Copyright (c) 2013 Deniss Fedotovs

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface UIFont (IBCustomFonts)
@end

@implementation UIFont (IBCustomFonts)
static NSDictionary *iBCustomFontsDict;

+(void)load {
    iBCustomFontsDict = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IBCustomFonts"];
    NSArray *methods = @[@"fontWithName:size:", @"fontWithName:size:traits:", @"fontWithDescriptor:size:"];
    for (NSString* methodName in methods) {
        Method from = class_getClassMethod([UIFont class], NSSelectorFromString(methodName)), to = class_getClassMethod([UIFont class], NSSelectorFromString([NSString stringWithFormat:@"new_%@",methodName]));
        if (from && to && strcmp(method_getTypeEncoding(from), method_getTypeEncoding(to)) == 0) method_exchangeImplementations(from, to);
    }
}
+(UIFont*)new_fontWithName:(NSString*)fontName size:(CGFloat)fontSize {
	return [self new_fontWithName:[iBCustomFontsDict objectForKey:fontName] ?: fontName size:fontSize];
}
+(UIFont*)new_fontWithName:(NSString*)fontName size:(CGFloat)fontSize traits:(int)traits {
	return [self new_fontWithName:[iBCustomFontsDict objectForKey:fontName] ?: fontName size:fontSize traits:traits];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
+(UIFont*)new_fontWithDescriptor:(UIFontDescriptor*)descriptor size:(CGFloat)fontSize {
    NSString* newName = [iBCustomFontsDict objectForKey:[descriptor.fontAttributes objectForKey:UIFontDescriptorNameAttribute]];
    return [self new_fontWithDescriptor: newName ? [UIFontDescriptor fontDescriptorWithName:newName size:fontSize] : descriptor size:fontSize];
}
#endif
@end
