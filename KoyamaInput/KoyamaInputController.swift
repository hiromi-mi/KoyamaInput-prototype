//
//  KoyamaInputController.swift
//  KoyamaInput
//
//  Created by hiromi_mi on 2022/01/07.
//

import Foundation
import InputMethodKit

class KoyamaInputController : IMKInputController {
    override func inputText(_ string: String!, client sender: Any!) -> Bool {
        print("string: \(String(describing: string))")
        return false
    }
}
