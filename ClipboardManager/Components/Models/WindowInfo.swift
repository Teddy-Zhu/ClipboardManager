//
//  WindowInfo.swift
//  ClipboardManager
//
//  Created by Никита Васильев on 05/12/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

public protocol Window {
    /// A NSImage value that contains the icon of application.
    var icon: NSImage? { get }
    
    var iconPath: String? { get }
    
    /// A String value that contains the application name.
    var applicationName: String? { get }
}

public struct WindowInfo: Window {
    public let iconPath: String?
    
    public let icon: NSImage?
    
    public let applicationName: String?
}
