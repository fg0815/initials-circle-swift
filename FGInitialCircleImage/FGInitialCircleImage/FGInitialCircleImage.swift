//
//  FGInitialCircleImage.swift
//  FGInitialCircleImage
//
//  Created by Feng Guo on 19/01/2016.
//  Copyright © 2016 Feng Guo. All rights reserved.
//

import UIKit

class FGInitialCircleImage: NSObject {
    
    class func circleImage(firstName: NSString, lastName: NSString, size: CGFloat, borderWidth: CGFloat, borderColor: UIColor, backgroundColor: UIColor, textColor: UIColor) -> UIImage {
        let imageRect: CGRect = CGRectMake(0, 0, size, size);
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.mainScreen().scale);
        
        let factor: CGFloat = 2.0;
        let bezierRect: CGRect = CGRectInset(imageRect, ceil(borderWidth / factor), ceil(borderWidth / factor));
        
        let circlePath: UIBezierPath = UIBezierPath.init(ovalInRect: bezierRect);
        
        // Border
        borderColor.setStroke();
        circlePath.lineWidth = borderWidth;
        circlePath.stroke();
        
        // Fill
        backgroundColor.setFill();
        circlePath.fill();
        
        // Text
        let internalCircleRect = calculateInternalRectSize(imageRect);
        let attributeString = initals(firstName, lastName: lastName, size: internalCircleRect, textColor: textColor);
        
        attributeString.drawInRect(internalCircleRect);
        
        // Final rendering
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image.imageWithRenderingMode(UIImageRenderingMode.Automatic);
    }
    
    // MARK: Internal
    
    private class func initals(firstName: NSString, lastName: NSString, size: CGRect, textColor: UIColor) -> NSAttributedString {
        let firstNameInitial: NSString = firstName.substringToIndex(1);
        let lastNameInitial: NSString = lastName.substringToIndex(1);
        let inital: NSString = (firstNameInitial as String) + (lastNameInitial as String);
        
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle;
        paragraphStyle.alignment = NSTextAlignment.Center;
        let attributes: [String: AnyObject] = [
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle
        ];
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: inital as String, attributes: attributes);
        
        addDynamicFontAttribute(attributeString, rect: size);

        return attributeString;
    }
    
    private class func addDynamicFontAttribute(attributeString: NSMutableAttributedString, rect: CGRect) {
        let text :NSString = attributeString.string;
        
        if (text.length == 0) {
            return;
        }
        
        let maxFontSize: CGFloat = 150.0;
        let minFontSize: CGFloat = 5.0;
        
        var maxFont = Int(maxFontSize);
        var minFont = Int(minFontSize);
        
        let constraintSize = CGSize(width: rect.width, height: CGFloat.max);
        
        var font: UIFont = UIFont.systemFontOfSize(CGFloat(1.0));
        
        while (minFont <= maxFont) {
            let currentSize = (minFont + maxFont) / 2;
            font = font.fontWithSize(CGFloat(currentSize));
            
            attributeString.removeAttribute(NSFontAttributeName, range: NSMakeRange(0, text.length));
            attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.length));
            let textRect = attributeString.boundingRectWithSize(constraintSize, options:.UsesLineFragmentOrigin, context: nil);
            
            let labelSize = textRect.size;
            
            if (labelSize.height < rect.height &&
                labelSize.height >= rect.height &&
                labelSize.width < rect.width &&
                labelSize.width >= rect.width) {
                break;
            } else if (labelSize.height > rect.height || labelSize.width > rect.width) {
                maxFont = currentSize - 1;
            } else {
                minFont = currentSize + 1;
            }
        }
    }
    
    private class func calculateInternalRectSize(size: CGRect) -> CGRect {
        let radius = size.width / 2;
        let newOrigin = (size.width / sqrt(CGFloat(2)) - radius) / sqrt(CGFloat(2));
        let newSize = sqrt(CGFloat(2)) * radius;
        
        return CGRectMake(newOrigin, newOrigin, newSize, newSize);
    }
}