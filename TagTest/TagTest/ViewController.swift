//
//  ViewController.swift
//  TagTest
//
//  Created by jin on 2016. 7. 21..
//  Copyright © 2016년 jinfactory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tagTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let example = "안녕하세요 #태그 입니다. #태그_테스트 #good @[developerjin!김청진] @[developersy|뚜욘] 이런것도되요 \n 잘부탁드려요 #일상 #맞팔 #똥스타그램"
        
        tagTextView.text = example
        
        
        doReset()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doReset() {
        
        
        
        
        let pattern = "(#\\w+)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        
        let attrString = NSMutableAttributedString(string: tagTextView.attributedText.string, attributes:nil)
        
        
//        let attrString = tagTextView.attributedText
        
        let range = NSMakeRange(0, attrString.string.characters.count)
        let matches = (regex?.matchesInString(attrString.string, options: [], range: range))!
        
        print(matches.count)
        
        //        var colorSet = [
        //            NSForegroundColorAttributeName : UIColor.redColor()
        //        ]
        
        for match in matches.reverse() {
            //Properly print match range
            print(match.range)
            
            //Get username and userid
            //            let userName = attrString.attributedSubstringFromRange(match.rangeAtIndex(2)).string
            //            let userId = attrString.attributedSubstringFromRange(match.rangeAtIndex(3)).string
            
            //A basic idea to add a link attribute on regex match range
            //            attrString.addAttribute(NSLinkAttributeName, value: "\(userId)", range: match.rangeAtIndex(1))
            
            //Still text it's in format @(steve|user_id) how could replace it by @steve keeping the link attribute ?
            //            attrString.replaceCharactersInRange(match.rangeAtIndex(1), withString: "@\(userName)")
            
            print(attrString.attributedSubstringFromRange(match.rangeAtIndex(1)).string)
            
            //            attrString.replaceCharactersInRange(match.rangeAtIndex(1), withAttributedString: colorSet)
            
            attrString.addAttributes([
                NSBackgroundColorAttributeName : UIColor.redColor(),
                NSForegroundColorAttributeName : UIColor.whiteColor()
                //                NSForegroundColorAttributeName : UIColor.redColor(),
                //                NSStrokeWidthAttributeName: 3.0,
                //                NSStrokeColorAttributeName:UIColor.redColor(),
                ], range: match.rangeAtIndex(1))
        }
        
//        tagTextView.
        
        let beforeRange = currentSelectedTextRange()
        tagTextView.attributedText = attrString
        selectTextRange(beforeRange)
        
        
    }
    
    func currentSelectedTextRange() -> NSRange {
        
        let range = tagTextView.selectedTextRange;
        let beginning = tagTextView.beginningOfDocument;
        let location = tagTextView.offsetFromPosition(beginning, toPosition: range!.start)
        let length = tagTextView.offsetFromPosition(range!.start, toPosition: range!.end)
        
        return NSMakeRange(location, length)
        
    }
    
    func selectTextRange(range:NSRange) {
        let start = tagTextView.positionFromPosition(tagTextView.beginningOfDocument, offset: range.location)
        let end = tagTextView.positionFromPosition(start!, offset: range.length)
        let newRange = tagTextView.textRangeFromPosition(start!, toPosition: end!)
        tagTextView.selectedTextRange = newRange
    }
    
//    - (void)selectTextRange:(NSRange)range
//    {
//    UITextPosition *start = [textField positionFromPosition: textField.beginningOfDocument offset:range.location];
//    UITextPosition *end = [textField positionFromPosition: start offset:range.length];
//    UITextRange *newRange = [textField textRangeFromPosition:start toPosition:end];
//    [textField setSelectedTextRange:newRange];
//    }


}

