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

#import "AlgoliaUILabel.h"

@implementation ASUILabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.highlightedTextColor = [UIColor colorWithRed:0.21f green:0.69f blue:1.0f alpha:1.0f];
    }
    return self;
}

-(void) drawString:(NSString*)str idx:(NSUInteger)idx length:(NSUInteger)length rect:(CGRect)rect bold:(BOOL)bold emphasis:(BOOL)emphasis
{
  if (length > 0) {
    NSString* toDisplay = [str substringWithRange:NSMakeRange(idx, length)];
    if (bold && self.highlightedTextColor != nil)
      [self.highlightedTextColor setFill];
    else
      [self.textColor setFill];
    UIFont* font = self.font;
    if (emphasis)
      font = (self.emphasisTextFont != nil ? self.emphasisTextFont : self.font);
    else if (bold)
      font = (self.highlightedTextFont != nil ? self.highlightedTextFont : self.font);
    CGSize s = [toDisplay drawInRect:CGRectMake(rect.origin.x + offset, rect.origin.y, rect.size.width, rect.size.height) withFont:font];
    offset += s.width;
  }
}

BOOL containsString(NSString* src, NSUInteger idx, const char* toSearch)
{
  NSUInteger count = [src length];
  for (NSUInteger i = 0; toSearch[i] != 0; ++i) {
    NSUInteger srcIdx = idx + i;
    if (srcIdx >= count)
      return NO;
    unichar c = [src characterAtIndex:srcIdx];
    if (c != toSearch[i] && c != toupper(toSearch[i]))
      return NO;
  }
  return YES;
}

-(void) drawRect:(CGRect)rect
{
  BOOL isBold = NO;
  BOOL isEmphasis = NO;
    
  offset = 0;
  if (self.text != nil) {
    NSUInteger prevPos = 0;
    NSUInteger count = [self.text length];
    for (NSUInteger i = 0; i < count; ) {
      if ([self.text characterAtIndex:i] == '<') {
	if (containsString(self.text, i, "<b>")) {
	  [self drawString:self.text idx:prevPos length:(i - prevPos) rect:rect bold:isBold emphasis:isEmphasis];
	  i += 3;
	  prevPos = i;
	  isBold = YES;
	} else if (containsString(self.text, i, "</b>")) {
	  [self drawString:self.text idx:prevPos length:(i - prevPos) rect:rect bold:isBold emphasis:isEmphasis];
	  i += 4;
	  prevPos = i;
	  isBold = NO;
	} else if (containsString(self.text, i, "<em>")) {
	  [self drawString:self.text idx:prevPos length:(i - prevPos) rect:rect bold:isBold emphasis:isEmphasis];
	  i += 4;
	  prevPos = i;
	  isEmphasis = YES;
	} else if (containsString(self.text, i, "</em>")) {
	  [self drawString:self.text idx:prevPos length:(i - prevPos) rect:rect bold:isBold emphasis:isEmphasis];
	  i += 5;
	  prevPos = i;
	  isEmphasis = NO;
	} else {
	  ++i;
	}
      } else {
	++i;
      }
    }
    if (prevPos < count) {
      [self drawString:self.text idx:prevPos length:(count - prevPos) rect:rect bold:isBold emphasis:isEmphasis];
    }
  } else {
    [super drawRect:rect];
  }
}

@synthesize highlightedTextFont;
@synthesize emphasisTextFont;
@end
