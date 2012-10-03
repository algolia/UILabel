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

@implementation AlgoliaUILabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.highlightedTextColor = [UIColor colorWithRed:0.21f green:0.69f blue:1.0f alpha:1.0f];
    }
    return self;
}

-(void) drawNormalString:(NSString*)str rect:(CGRect)rect
{
    [self.textColor setFill];
    CGSize s = [str drawInRect:CGRectMake(rect.origin.x + offset, rect.origin.y, rect.size.width, rect.size.height) withFont:self.font];
    offset += s.width;   
}

-(void) drawHighlightedString:(NSString*)str rect:(CGRect)rect
{
    [self.highlightedTextColor setFill];
    CGSize s = [str drawInRect:CGRectMake(rect.origin.x + offset, rect.origin.y, rect.size.width, rect.size.height) withFont:(self.highlightedTextFont != nil ? self.highlightedTextFont : self.font)];
    offset += s.width;
}

-(void) drawRect:(CGRect)rect
{
    offset = 0;
    if (self.text != nil) {
        NSUInteger prevPos = 0;
        NSUInteger count = [self.text length];
        for (NSUInteger i = 0; i + 2 < count; ++i) {
            if ([self.text characterAtIndex:i] == '<' &&
                ([self.text characterAtIndex:(i + 1)] == 'b' || [self.text characterAtIndex:(i + 1)]== 'B') &&
                [self.text characterAtIndex:(i + 2)] == '>') {
                if (i > prevPos)
                    [self drawNormalString:[self.text substringWithRange:NSMakeRange(prevPos, i - prevPos)] rect:rect];
                i += 3;
                prevPos = i;
                // search for end of string
                BOOL found = NO;
                for (NSUInteger j = i; !found && j + 4 <= count; ++j) {
                    if ([self.text characterAtIndex:j] == '<' &&
                       [self.text characterAtIndex:(j + 1)] == '/' &&
                       ([self.text characterAtIndex:(j + 2)] == 'b' || [self.text characterAtIndex:(j + 2)]== 'B') &&
                       [self.text characterAtIndex:(j + 3)] == '>') {
                        [self drawHighlightedString:[self.text substringWithRange:NSMakeRange(prevPos, j - prevPos)] rect:rect];
                        i = j + 3;
                        prevPos = j + 4;
                        found = YES;
                    }
                }
            }
        }
        if (prevPos < count) {
            [self drawNormalString:[self.text substringWithRange:NSMakeRange(prevPos, count - prevPos)] rect:rect];
        }
    } else {
        [super drawRect:rect];
    }
}

@synthesize highlightedTextFont;
@end
