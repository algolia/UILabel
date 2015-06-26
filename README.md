# UILabel+Highlighting

[![](http://img.shields.io/badge/iOS-7.0%2B-lightgrey.svg)]()
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/algolia/UILabel)

This extension of UILabel help you to interprets emphasis HTML tags `<em>` in the text attribute of the label.

Parts of the text between `<em></em>` are rendered with `highlightedTextColor`.

This implementation is faster than UIWebView or NSScanner, and is perfect for **UITableViewCell**. It is very easy to customize it for your needs.

## Setup

Simply drag and drop the file in your project.

## Example

```swift
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
    
    let contact = contacts[indexPath.row]
    
    // Choose the color. Can also be done in the Storyboard
    cell.textLabel?.highlightedTextColor = UIColor(red:1, green:1, blue:0.898, alpha:1)
    
    // Set a text with highlighting part
    cell.textLabel?.highlightedText = contact.name

    return cell
}
```