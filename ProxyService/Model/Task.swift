//
//  Task.swift
//  Runner
//
//  Created by Dubhe on 2023/8/13.
//

import Foundation
import SwiftyJSON

public class Task {
    public var id: UUID = UUID()
    public var localEnable: Int = 1
    public var wifiEnable: Int = 1
    
    public var fileFolder = ""
    
    public var rule: TaskRule!
    
    var startTime: Double = 1
    var stopTime: Double = 1
    
    var wifiIP: String = "127.0.0.1"
    var port: Int = 9527
    
    var createTime: Double = 1
    
    public init() {
        
    }
    
    public init(arg: NSDictionary) {
        let json = JSON(arg)
        self.rule = TaskRule(filter: json["filter"], falsify: json["falsify"].array)
        
        fileFolder = "task-\(id)"
    }
    
    func getFullPath() -> String {
        var filePath = ProxyService.getStoreFolder()
        filePath.append(fileFolder)
        return filePath
    }
    
    func createFileFolder(){
        let filePath = getFullPath()
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        let isExits = fileManager.fileExists(atPath: filePath, isDirectory: &isDir)
        if isExits, isDir.boolValue {
            let errorStr = "Delete \(fileFolder)，Because it's not a folder !"
            NSLog(errorStr)
            try? fileManager.removeItem(atPath: filePath)
            try? fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        if !isExits {
            try? fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
    }
}

