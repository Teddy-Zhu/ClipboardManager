//
//  ClipboardChecker.swift
//  ClipboardManager
//
//  Created by Никита Васильев on 16/01/2019.
//  Copyright © 2019 Никита Васильев. All rights reserved.
//

protocol ClipboardCheckerDelegate: class {
    /// Tells the delegate that a new item was copied.
    ///
    /// - Parameter item: A new copied item.
    func clipboardDidChanged(item: ClipboardItem)
}

final class ClipboardChecker {
    
    // MARK: Properties
    
    /// The element that is stored in the system clipboard.
    private(set) var item: ClipboardItem?
    
    /// An instance of ClipboardCheckerDelegate.
    weak var delegate: ClipboardCheckerDelegate?
    
    /// A ClipboardEngine value that contains the system clipboard instance.
    private let clipboard: ClipboardEngine!
    
    /// A TimeInterval value that contains check the clipboard interval.
    private let timeInterval: TimeInterval = 0.25
    
    /// Last copied item.
    private var lastCopiedItem: NSPasteboardItem?
    
    /// A DefaultTimer value that contains the timer instance.
    private var timer: DefaultTimer!
    
    /// A TimerFactory value that contains the timer factory.
    private let timerFactory: TimerFactory!
    
    // MARK: Initialization
    
    /// Returns the ClipboardChecker object.
    ///
    /// - Parameters:
    ///   - clipboard: A ClipboardEngine object.
    ///   - timerFactory: A TimeFactory object.
    init(clipboard: ClipboardEngine,
         timerFactory: TimerFactory = DefaultTimerFactory()) {
        self.clipboard = clipboard
        self.timerFactory = timerFactory
        
        start()
    }
    
    // MARK: Private Methods
    
    /// Start the timer to check the system clipboard.
    private func start() {
        lastCopiedItem = clipboard.fetch()
//        timer = timerFactory.create(timeInterval: timeInterval,
//                                    repeats: true,
//                                    block: { [weak self] (_) in
//            self?.checkClipboard()
//        })

       timer = timerFactory.create(timeInterval: timeInterval, repeats: true, block: { [weak self] (_) in
        self?.checkForChangesInPasteboard()
       })
        
        RunLoop.main.add(timer as! Timer, forMode: .common)
    }
    
    private let pasteboard = NSPasteboard.general

    private var lastChangeCount: Int = NSPasteboard.general.changeCount

    func checkForChangesInPasteboard() {
        guard pasteboard.changeCount != lastChangeCount else {
            return
        }
        lastChangeCount = pasteboard.changeCount
        delegate?.clipboardDidChanged(item: createClipboardItem(pasteboard.pasteboardItems!))
    }

    /// Check the system clipboard.
//    func checkClipboard() {
//        guard let item = clipboard.fetch() else { return }
//
//        if lastCopiedItem == nil || lastCopiedItem != item {
//            lastCopiedItem = item
//            delegate?.clipboardDidChanged(item: createClipboardItem(item))
//        }
//    }
//
    /// Create an instance of the ClipboardItem.
    ///
    /// - Parameter values: A tuple with data and type of content.
    /// - Returns: ClipboardItem instance.
    private func createClipboardItem(_ items: [NSPasteboardItem]) -> ClipboardItem {
        return ClipboardItem(window: WindowManager.shared.windowInfo,
                             pasteboardItems: items)
    }
}
