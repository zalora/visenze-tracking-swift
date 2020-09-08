//
//  VaEvent.swift
//  ViSenzeAnalytics
//
//  Created by Hung on 8/9/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

/// Protocol to generate dictionary for query parameters (in the URL)
public protocol VaParamsProtocol{
    
    
    /// Generate dictionary of parameters , will be appended into query string
    ///
    /// - returns: dictionary
    func toDict() -> [String: String]
}

public class VaEvent: VaParamsProtocol {

    // MARK: param protocol
    
    public func toDict() -> [String: String] {
        var dict : [String:String] = [:]
        
        return dict
    }
}
