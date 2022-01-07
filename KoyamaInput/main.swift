//
//  main.swift
//  KoyamaInput
//
//  Created by hiromi_mi on 2022/01/07.
//

import Foundation
import Cocoa
import InputMethodKit

// [Swift での main 関数の実装方法と起動時引数の扱い方](https://ez-net.jp/article/BC/vWrNTeBO/85hmtcwh9W3Y/)
// [Swift: 常駐型アプリの作り方](https://zenn.dev/kyome/articles/02d9f969fd17e5)
// main.swift ファイルを作成するか、 @main と書くと自動生成される

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate

let identifier = Bundle.main.bundleIdentifier
var server = IMKServer.init(name: "KoyamaInput_0_Connection", bundleIdentifier: identifier)

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
