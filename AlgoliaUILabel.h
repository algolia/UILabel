
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
 * This class is a simple Label that interprets Bold HTML tags (<b> and </b>)
 *  in the text attribute of the Label.
 *
 * Sections between <b>..</b> are displayed with ('highlightedTextColor' color
 * and 'highlightedTextFont' font attributes).
 *
 * Other sections are displayed with 'textColor' and 'font' attributes.
 *
 * This implementation is faster than UIWebView and is perfect for
 * UITableViewCell.
 */
@interface AlgoliaUILabel : UILabel
{
    UIFont* highlightedTextFont;
    NSUInteger offset;
}
@property (strong, nonatomic) UIFont* highlightedTextFont;

@end
