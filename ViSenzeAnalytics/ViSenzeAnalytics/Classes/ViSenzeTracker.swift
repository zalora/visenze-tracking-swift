//
//  ViSenzeTracker.swift
//  ViSenzeAnalytics
//
//  Created by Hung on 8/9/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

public enum VaApiMethod: String {
    case TRACKER  = "v3/__va.gif"
    case BATCH_EVENTS = "v3/events"
}

public class ViSenzeTracker: NSObject {
    public static let DEFAULT_ENDPOINT = "https://analytics.data.visenze.com"
    public static let DEFAULT_CN_ENDPOINT = "https://analytics.visenze.com.cn"
    
    private static let userAgentHeader : String = "User-Agent"
    
    public typealias VaFailureHandler = (Error) -> ()
    
    // MARK: properties
    
    public var code : String
    public var baseUrl : String
    
    public var session : URLSession
    public var sessionConfig : URLSessionConfiguration

    public var timeoutInterval : TimeInterval = 10
    public var requestSerialization : VaRequestSerialization
    
    public let userAgent : String
    
    public convenience init?(code: String, isCn: Bool){
        let baseUrl = isCn ? ViSenzeTracker.DEFAULT_CN_ENDPOINT : ViSenzeTracker.DEFAULT_ENDPOINT
        self.init(baseUrl: baseUrl, code: code, timeout: 10)
    }
    
    public init?(baseUrl: String, code: String , timeout: TimeInterval) {
        
        if code.isEmpty || baseUrl.isEmpty {
            return nil;
        }
        
        self.baseUrl = baseUrl
        self.code = code
        self.timeoutInterval = timeout
        
        self.requestSerialization = VaRequestSerialization()
        
        // config default session
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = true
        sessionConfig.timeoutIntervalForRequest = timeoutInterval
        sessionConfig.timeoutIntervalForResource = timeoutInterval
        
        // Configuring caching behavior for the default session
        let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cachesDirectoryURL.appendingPathComponent("visenzeAnalyticsCache")
        let diskPath = cacheURL.path
        
        let cache = URLCache(memoryCapacity:16384, diskCapacity: 268435456, diskPath: diskPath)
        sessionConfig.urlCache = cache
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        
        session = URLSession(configuration: sessionConfig)
        
        self.userAgent =  VaDeviceData.sharedInstance.userAgent
    }
    
    
    
}
