//
//  RealtimePasteBoardApp.swift
//  Shared
//
//  Created by Book on 2022/7/29.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        RealtimeDatabase.shared.setupObserve()
        return true
    }
}

@main
struct RealtimePasteBoardApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            PasteBoardListView()
        }
    }
}
