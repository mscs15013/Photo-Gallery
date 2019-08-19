//
//  ViewController+App.swift
//  PhotoGallery
//
//  Created by Umair Ali on 18/08/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showAlertWithTitle(_ title: String, andMessage message: String, confirmTitle: String, style: UIAlertController.Style = UIAlertController.Style.alert) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction.init(title: confirmTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
