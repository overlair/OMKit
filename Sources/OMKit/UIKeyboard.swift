//
//  File.swift
//  
//
//  Created by John Knowles on 10/23/24.
//

import UIKit

protocol UIKeyboardDelegate {
    func inputKeyboard(didChangeHeight height: CGFloat)
}

class UIKeyboardObserver: NSObject {
    
    init(delegate: UIKeyboardDelegate) {
        self.delegate = delegate
        super.init()
        
        startObservering()
    }
    
    private let delegate: UIKeyboardDelegate
    
    private(set) var isShowing: Bool = false
    
    var keyboardHeight: CGFloat { keyboardRect.height }
    
    private(set) var keyboardRect: CGRect = .zero {
        didSet {
            delegate.inputKeyboard(didChangeHeight: keyboardRect.height)
        }
    }

    
    private func startObservering() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main) { [weak self] (notification) in
            guard let strongSelf = self else { return }
            strongSelf.isShowing = true
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil,
                                               queue: .main) { [weak self] (notification) in
            guard let strongSelf = self,
                  let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            strongSelf.keyboardRect = keyboardRect
                
        }
            
        
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: .main) { [weak self] (notification) in
            guard let strongSelf = self else { return }

            strongSelf.isShowing = false
        }
    }
 }
