//
//  AppDelegate.swift
//  KoyamaInput
//
//  Created by hiromi_mi on 2022/01/07.
//

import Cocoa
import InputMethodKit

class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    
    @IBOutlet var conversionEngine: ConversionEngine!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}
