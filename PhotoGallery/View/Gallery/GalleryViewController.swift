//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Umair Ali on 18/08/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

class GalleryViewController: AppViewController {
    
    @IBOutlet weak var photosTableView: UITableView!
    
    var galleryViewModel = GalleryViewModel()
    let cellIdentifier = "photoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryViewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = self.showActivityIndicator()
        galleryViewModel.fetchPhotos()
    }
}

extension GalleryViewController: DataSourceDelegate {
    func reloadView() {
        _ = self.dismissActivityIndicator()
        photosTableView.isHidden = false
        photosTableView.reloadData()
    }
    
    func showError(title: String, message: String) {
        self.showAlertWithTitle(title, andMessage: message, confirmTitle: "Ok")
    }
}

extension GalleryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return galleryViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   galleryViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return galleryViewModel.titleForHeaderSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        return galleryViewModel.setDataOfTableViewCell(cell: cell, indexPath: indexPath)
    }
}

