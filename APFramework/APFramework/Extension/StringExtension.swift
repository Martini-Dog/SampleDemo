//
//  StringExtension.swift
//  Flypie
//
//  Created by Apple on 2017/10/9.
//  Copyright © 2017年 The_X All rights reserved.
//

import Foundation

extension String {
    
    /// 字符串截取子串(从字符串起始点截取到指定位置(包含指定位置))
    ///
    /// - Parameter index: 指定位置(从0开始，包含指定位置)
    /// - Returns: 返回字符串子串
    public func subString(to index: Int) -> String {
        if self.count > index {
            let endIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    
    /// 字符串截取子串(从指定位置(不包含指定位置)截取到字符串终点)
    ///
    /// - Parameter index: 指定位置(从0开始，不包含指定位置)
    /// - Returns: 返回字符串子串
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    
    
    /// 字符串截取子串(从字符串终点倒数指定位数截取到字符串终点)
    ///
    /// - Parameter index: index: 指定位置(从字符串终点倒数开始，不包含指定位置)
    /// - Returns: 返回字符串子串
    public func substring(end index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.endIndex, offsetBy: -index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    
    public func substring(range: Range<Int>) -> String {
        if range.lowerBound < 0 || range.upperBound > self.count { return self}
        let startIndex = self.index(self.startIndex, offsetBy:range.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:range.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
