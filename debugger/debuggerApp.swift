//
//  debuggerApp.swift
//  debugger
//
//  Created by Dubhe on 2024/4/9.
//

import SwiftUI
import SwiftData
import UIKit
//import ProxyService

@main
struct debuggerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init () {
        configNavigationBar()
//        print(ProxyService())
    }
    
    private func configNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = nil
        if let gradientColor = UIColor(gradientBounds: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), gradientColors: [.blue, UIColor(Color.backgroundColor)]) {
            navBarAppearance.backgroundColor = gradientColor
        }
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

extension UIImage {
    static func gradientImage(with bounds: CGRect, colors: [UIColor]) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.15)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}

extension UIColor {
    convenience init?(gradientBounds: CGRect, gradientColors: [UIColor]) {
        guard let gradientImage = UIImage.gradientImage(with: gradientBounds, colors: gradientColors) else {
            return nil
        }
        self.init(patternImage: gradientImage)
    }
}
