//
//  Session.swift
//  Runner
//
//  Created by dubhe on 2023/10/8.
//

import Foundation
import NIOCore
import NIOHTTP1
import SwiftData

public enum FileType {
    case Request
    case Response
}

@Model
public class Session {
    public var id: UUID = UUID()
    public var task_id: UUID!
    public var remoteAddress: String?
    public var localAddress: String?
    public var host: String?
    public var schemes: String?
    public var requestLine: String?
    public var methods: String?
    public var uri: String?
    public var suffix: String?
    
    public var requestContentType: String?
    public var requestContentEncoding: String?
    public var requestHeader: String?
    public var requestHttpVersion: String?
    public var requestBody: String?
    
    public var target: String?
    public var httpCode: String?
    
    public var responseContentType: String?
    public var responseContentEncoding: String?
    public var responseHeader: String?
    public var responseHttpVersion: String?
    public var responseBody: String?
    public var responseMsg: String?
    
    public var startTime: Double?
    public var connectTime: Double?
    public var connectedTime: Double?
    public var handshakeTime: Double?
    public var requestEndTime: Double?
    public var responseStartTime: Double?
    public var responseEndTime: Double?
    public var endTime: Double?
    
    public var uploadFlow: Int = 0
    public var downloadFlow: Int = 0
    
    public var state: Int = 1
    public var note: String?
    
    public var ignore = false
    
    public let random = arc4random()
    
    public var fileFolder = ""
    public var fileName = ""
    
    public init() {
        
    }
    
    public static func newSession(_ task: Task) -> Session {
        let session = Session()
        session.task_id = task.id
        session.startTime = Date().timeIntervalSince1970
        session.fileFolder = task.fileFolder
        return session
    }
    
    
    public func save() {
//        if self.ignore {
//            return
//        }
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "save_session"), object: JSONSerializer.toJson(self, ignore: ["fileName", "fileFolder"]))
//        }
    }
    
    public func writeBody(type: FileType, buffer: ByteBuffer?, realName: String = "") {
        if self.ignore {
            return
        }
        
        if requestBody == nil, type == .Request {
            requestBody = "req_\(task_id.uuidString)_\(random)\(realName)"
        }
        if responseBody == nil, type == .Response {
            responseBody = "rsp_\(task_id.uuidString)_\(random)\(realName)"
        }
        guard let body = buffer else {
            return
        }
        
        var filePath = type == .Request ? requestBody : responseBody
        filePath = "\(ProxyService.getStoreFolder())\(fileFolder)/\(filePath!)"
        let fileManager = FileManager.default
        let exist = fileManager.fileExists(atPath: filePath!)
        if !exist {
            fileManager.createFile(atPath: filePath!, contents: nil, attributes: nil)
        }
        
        guard let data = body.getData(at: body.readerIndex, length: body.readableBytes) else {
            print("no data !")
            return
        }
        
        let fileHandle = FileHandle(forWritingAtPath: filePath!)
        if exist {
            fileHandle?.seekToEndOfFile()
        }
        fileHandle?.write(data)
        fileHandle?.closeFile()
    }
    
    static func getIPAddress(socketAddress: SocketAddress?) -> String {
        if let address = socketAddress?.description {
            let array = address.components(separatedBy: "/")
            return array.last ?? address
        } else {
            return "unknow"
        }
    }
    
    static func getUserAgent(target: String?) -> String {
        if target != nil {
            let firstTarget = target!.components(separatedBy: " ").first
            return firstTarget?.components(separatedBy: "/").first ?? target!
        }
        return ""
    }
    
    static func getHeadsJson(headers: HTTPHeaders) -> String {
        var reqHeads = [String: String]()
        for kv in headers {
            reqHeads[kv.name] = kv.value
        }
        return reqHeads.toJson()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
