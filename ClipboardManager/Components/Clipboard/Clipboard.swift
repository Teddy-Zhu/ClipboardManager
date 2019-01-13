//
//  Clipboard.swift
//  ClipboardManager
//
//  Created by Никита Васильев on 04/12/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

protocol ClipboardEngine {
    func fetch() throws -> (Data, NSPasteboard.PasteboardType)
    func set(item: ClipboardItem)
    func clearContents()
}

public enum ClipboardError: Error {
    case fetchError
}

public class Clipboard: ClipboardEngine {
    
    /// Instance of a pasteboard
    private var pasteboard: PasteboardEngine!

    /// Returns the Clipboard object.
    ///
    /// - Parameter pasteboard: An PasteboardEngine object containing the object to work with system pasteboard.
    init(pasteboard: PasteboardEngine = NSPasteboard.general) {
        self.pasteboard = pasteboard
    }
    
    /// Fetch an object from the system pasteboard.
    ///
    /// - Returns: A tuple containing the data and the type of this data.
    /// - Throws: An error of type `ClipboardError`
    public func fetch() throws -> (Data, NSPasteboard.PasteboardType) {
        let pasteboardItem = pasteboard.getLast()

        if let type = pasteboardItem?.types.first,
           let data = pasteboardItem?.data(forType: type) {
            return (data, type)
        } else {
            throw ClipboardError.fetchError
        }
    }
    
    /// Set clipboard item to system pasteboard.
    ///
    /// - Parameter item: An ClipboardItem object containing the value for the representation specified by type.
    public func set(item: ClipboardItem) {
        pasteboard.clear()
        _ = pasteboard.write(object: item)
    }
    
    /// Clears the existing contents of the pasteboard
    public func clearContents() {
        pasteboard.clear()
    }
    
    /// Array contains pasteboard's supported types
    private let supportedTypes: [NSPasteboard.PasteboardType] = [.fileURL,
                                                                 .URL,
                                                                 .color,
                                                                 .fileContents,
                                                                 .font,
                                                                 .html,
                                                                 .multipleTextSelection,
                                                                 .pdf,
                                                                 .png,
                                                                 .rtf,
                                                                 .rtfd,
                                                                 .ruler,
                                                                 .sound,
                                                                 .string,
                                                                 .tabularText,
                                                                 .textFinderOptions,
                                                                 .tiff]
}