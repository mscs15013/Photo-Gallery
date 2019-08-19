//
//  PhotoGalleryTests.swift
//  PhotoGalleryTests
//
//  Created by Umair Ali on 19/08/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import XCTest
@testable import PhotoGallery

class PhotoGalleryTests: XCTestCase {
    
    var galleryViewModel: GalleryViewModel!
    var galleryVC: GalleryViewController!
    var photoTableview:  UITableView!
    
    override func setUp() {
        
        galleryViewModel = GalleryViewModel()
        galleryViewModel.photosAlbumSortedKeys = [1,2,3,4]
        galleryVC = GalleryViewController()
        
        photoTableview = UITableView()
        photoTableview.dataSource = galleryVC
        
        galleryVC.photosTableView = photoTableview
        galleryVC.galleryViewModel = galleryViewModel
    }
    
    override func tearDown() {
        galleryViewModel = nil
        galleryVC = nil
        photoTableview = nil
    }
    
    func testNumberOfSectionOfViewModel() {
        XCTAssert(galleryViewModel.numberOfSections() ==  galleryViewModel.photosAlbumSortedKeys.count)
    }
    
    func testTitleOfHeaderSection() {
        XCTAssert(galleryVC.tableView(photoTableview, titleForHeaderInSection: 0) == "Album - 1")
    }
}
