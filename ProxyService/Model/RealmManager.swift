//
//  RealmManager.swift
//  ProxyService
//
//  Created by dubhe on 2024/7/18.
//

import Foundation
import RealmSwift

public class RealmManager {
    static public let shared = try! Realm(configuration: Realm.Configuration(
        // 配置Realm的schema版本
        schemaVersion: 1,
        // 自定义迁移过程（如果需要）
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
                // 执行迁移
            }
        }
    ), queue: DispatchQueue.main)
    
    // 防止外部直接初始化
    private init() {}
}
