//
//  ClipboardContent.swift
//  ClipboardManager
//
//  Created by Никита Васильев on 05/12/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

public protocol Content {
    /// A NSPasteboardItem value that contains the data and types.
    var pasteboardItems: [NSPasteboardItem]? { get }
    
}

public class ClipboardContent: Content {
    public let pasteboardItems: [NSPasteboardItem]?
    
    public init(items: [NSPasteboardItem]?) {
        self.pasteboardItems = items
    }
}
