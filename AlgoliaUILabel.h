// Copyright (C) 2012 Julien Lemoine. All rights reserved.
// Contact: contact (at) algolia.com
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
//

#import <UIKit/UIKit.h>

/**
 * This class interprets the <b></b> and <em></em> tags in the text attribute of Label.
 *
 * The label use 3 differents fonts (textFont, highlightedTextFont and emphasisTextFont) and 
 * 2 differents colors (textColor and highlightedTextColor).
 * 
 * Here is the behaviors :
 * - Parts of text without tags are rendered with textColor and textFont
 * - Parts of text between <b></b> tags are rendered with highligtedTextColor and highligtedTextFont
 * - Parts of text between <em></em> tags are rendered with textColor and emphasisTextFont
 * - Parts of text between <b> and <em> (or <em><b>) are rendered with highligtedTextColor and emphasisTextFont
 */
@interface AlgoliaUILabel : UILabel
{
    UIFont* highlightedTextFont;
    UIFont* emphasisTextFont;
    NSUInteger offset;
}
@property (strong, nonatomic) UIFont* highlightedTextFont;
@property (strong, nonatomic) UIFont* emphasisTextFont;

@end
