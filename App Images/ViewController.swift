//
//  ViewController.swift
//  App Images
//
//  Created by Matthew Jinkens on 5/9/20.
//  Copyright © 2020 Matthew Jinkens. All rights reserved.
//
import Foundation
import Cocoa

class ViewController: NSViewController {
    
    var staticCellViews = [NSView?]()
    let imageDirectoryLoader = ImageDirectoryLoader()
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var mainProgress: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainProgress.startAnimation(self)
        tableView.delegate = self
        tableView.dataSource = self
        let staticCellIDs = ["iOSHeading", "iOSIcons", "iOSImages", "AndroidHeading", "AndroidIcons", "AndroidImages"]
        
        self.staticCellViews = staticCellIDs.map({ (value: String) -> NSView? in
            let viewID = NSUserInterfaceItemIdentifier(rawValue: value)
            let view = tableView.makeView(withIdentifier: viewID, owner: self)
            return view
        })
        
        let initialFolderUrl = URL(fileURLWithPath: "/Library/Desktop Pictures", isDirectory: true)
        imageDirectoryLoader.loadDataForFolderWithUrl(initialFolderUrl)
        configureCollectionView()
        tableView.selectRowIndexes(IndexSet.init([1]), byExtendingSelection: false)
    }
    
    func loadDataForNewFolderWithUrl(_ folderURL: URL) {
      imageDirectoryLoader.loadDataForFolderWithUrl(folderURL)
    }
    
    
    fileprivate func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        collectionView.collectionViewLayout = flowLayout
        view.wantsLayer = true
    }
}

extension ViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return 6
  }
}

extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = self.staticCellViews[row]
        return view
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
          return TableRowView()
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if (row == 0 || row == 3) {
            return false
        }
        return true
    }
}

extension ViewController : NSCollectionViewDataSource {
  
  func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return imageDirectoryLoader.numberOfSections
  }
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageDirectoryLoader.numberOfItemsInSection(section)
  }
  
  func collectionView(_ itemForRepresentedObjectAtcollectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {

    let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)
    guard let collectionViewItem = item as? CollectionViewItem else {return item}
    let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
    collectionViewItem.imageFile = imageFile
    return item
  }
  
}
