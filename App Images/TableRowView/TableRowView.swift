//
//  TableRowView.swift
//  App Images
//
//  Created by Matthew Jinkens on 5/10/20.
//  Copyright © 2020 Matthew Jinkens. All rights reserved.
//

import Foundation
import Cocoa

class TableRowView: NSTableRowView {

override func drawSelection(in dirtyRect: NSRect) {
    if selectionHighlightStyle != .none {
        let selectionRect = bounds.insetBy(dx: 0, dy: 0)
        NSColor.unemphasizedSelectedContentBackgroundColor.setFill()
        selectionRect.fill()
    }
  }
}
