//
//  KoyamaInputController.swift
//  KoyamaInput
//
//  Created by hiromi_mi on 2022/01/07.
//

import Foundation
import InputMethodKit

class KoyamaInputController : IMKInputController {
    // IMで処理後のテキスト
    var composedbuffer: String = ""
    // 受け取ったテキスト
    var originalbuffer: String = ""
    // composedBufferのどのindexまで打ち込んだか
    var insertationindex: String.Index = "".startIndex
    // 次にcommitされるか？
    var didconver: Bool = false
    
    // main function.
    override func inputText(_ string: String!, client sender: Any!) -> Bool {
        var inputHandled = false;
        let scanner = Scanner.init(string: string)
        let decimal = scanner.scanDecimal()
        
        if let _ = decimal {
            self.originalbuffer.append(string)
            inputHandled = true
        } else {
            inputHandled = self.convert(trigger: string, sender: sender)
        }
        
        print("string: \(String(describing: string))")
        return inputHandled
    }
    
    // input session が終了するアクションがあったときに呼ばれる。IMを付け替えた時がほとんど
    // senderはAny!
    override func commitComposition(_ sender: Any!) {
        var text = self.composedbuffer
        // 現在のinput bufferをclientに送りクリーンアップを行う
        if !composedbuffer.isEmpty {
            text = originalbuffer
        }
        
        (sender as AnyObject).insertText(text, replacementRange: NSMakeRange(NSNotFound, NSNotFound))
        
        self.composedbuffer = ""
        self.originalbuffer = ""
        self.insertationindex = originalbuffer.startIndex

    }
    
    
    /* Internal Function */
    
    func convert(trigger: String, sender: Any!) -> Bool {
        let originalText = originalbuffer
        var convertedString = ""
        var handled = false
        
        if (didconver && !composedbuffer.isEmpty) {
            convertedString = composedbuffer
            convertedString.append(trigger)
            
            (sender as AnyObject).insertText(convertedString, replacementRange: NSMakeRange(NSNotFound, NSNotFound))

            composedbuffer = ""
            originalbuffer = ""
            
            insertationindex = originalbuffer.startIndex
            handled = true
            didconver = false
        } else if (!originalText.isEmpty){
            let r = insertationindex..<insertationindex
            convertedString = (NSApplication.shared.delegate as! AppDelegate).conversionEngine.convert(string: originalText)
            self.composedbuffer = convertedString
            if (trigger == " ") {
                (sender as AnyObject).setMarkedText(self.originalbuffer, selectionRange: NSRange(r, in:originalText), replacementRange: NSMakeRange(NSNotFound, NSNotFound))
            } else {
                self.commitComposition(sender)
                (sender as AnyObject).insertText(trigger, replacementRange: NSMakeRange(NSNotFound, NSNotFound))
            }
            handled = true
        }
        return handled
    }
    
    func originalBufferAppend(string: String, sender: Any!) {
        self.originalbuffer.append(string)
        (sender as AnyObject).setMarkedText(self.originalbuffer, selectionRange: NSMakeRange(0, originalbuffer.count), replacementRange: NSMakeRange(NSNotFound, NSNotFound))
    }
    
    @objc func insertNewLine(_ sender: Any!) {
        self.commitComposition(sender)
    }
    
    @objc func deleteBackward(_ sender: Any!) {
        var originalText = originalbuffer
        if (originalText.startIndex < insertationindex && insertationindex < originalText.endIndex) {
            insertationindex = originalText.index(before: insertationindex)
            
            originalText.remove(at: originalText.index(insertationindex, offsetBy: 1))
            
            (sender as AnyObject).setMarkedText(self.originalbuffer, selectionRange: NSMakeRange(0, originalbuffer.count), replacementRange: NSMakeRange(NSNotFound, NSNotFound))
        }
    }
    
    override func didCommand(by aSelector: Selector!, client sender: Any!) -> Bool {
        if self.responds(to: aSelector) {
            let text = self.originalbuffer
            if !text.isEmpty {
                if (aSelector == #selector(self.insertNewLine) || aSelector == #selector(self.deleteBackward)) {
                    self.perform(aSelector, with: sender)
                    return true
                }
            }
        }
        return false
    }
}
