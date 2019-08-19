//
//  PhotoListingViewModel.swift
//  PhotoGallery
//
//  Created by Umair Ali on 18/08/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import Foundation
import UIKit

protocol DataSourceDelegate : class {
    func reloadView()
    func showError(title: String, message: String)
}

class GalleryViewModel {
    
    private let photosProvider = GalleryDataSource()
    weak var delegate: DataSourceDelegate?
    var photosAlbumSortedKeys = [Int16]()
    
    var photos =  Dictionary<Int16, [Photo]>(){
        didSet{
            photosAlbumSortedKeys = photos.keys.sorted()
            self.delegate?.reloadView()
        }
    }

    func fetchPhotos() {
            photosProvider.fetchPhotos(success: { [weak self] response in
                debugPrint("Number of photos: \(response.count)")
                self?.photos = Dictionary(grouping: response, by: {$0.albumId})
                
            }, failure: { error in
                self.delegate?.showError(title: "Error", message: error.localizedDescription)
            debugPrint("Unable to fetch photos: \(error.debugDescription)")
        })
    }
    
    func numberOfSections() -> Int {
        return photosAlbumSortedKeys.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return photos[photosAlbumSortedKeys[section]]?.count ?? 0
    }
    
    func titleForHeaderSection(section: Int) -> String {
         return String("Album - \(photosAlbumSortedKeys[section])")
    }
    
    func setDataOfTableViewCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        cell.textLabel?.text =  photos[photosAlbumSortedKeys[indexPath.section]]?[indexPath.row].title
        cell.detailTextLabel?.text =  photos[photosAlbumSortedKeys[indexPath.section]]?[indexPath.row].thumbnailUrl
        return cell
    }
}




