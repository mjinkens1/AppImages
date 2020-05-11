//
//  CollectionViewItem.swift
//  App Images
//
//  Created by Matthew Jinkens on 5/10/20.
//  Copyright © 2020 Matthew Jinkens. All rights reserved.
//

import Foundation
import Cocoa
class CollectionViewItem: NSCollectionViewItem {

  var imageFile: ImageFile? {
    didSet {
      guard isViewLoaded else { return }
      if let imageFile = imageFile {
        imageView?.image = imageFile.thumbnail
        textField?.stringValue = imageFile.fileName
      } else {
        imageView?.image = nil
        textField?.stringValue = ""
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.wantsLayer = true
    view.layer?.backgroundColor = NSColor.lightGray.cgColor
  }
}
