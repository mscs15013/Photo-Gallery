//
//  AppViewController.swift
//  PhotoGallery
//
//  Created by Umair Ali on 18/08/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit
import JGProgressHUD

class AppViewController: UIViewController {
    private var progressView: JGProgressHUD?
}

extension AppViewController {
    
    func showActivityIndicator(style: JGProgressHUDStyle = .dark, text: String = "Loading...") -> Bool {
        
        if progressView == nil {
            progressView = JGProgressHUD(style: style)
            progressView?.textLabel.text = text
            progressView?.show(in: self.view, animated: true)
            return true
        }
        return false
    }
    
    func dismissActivityIndicator() -> Bool {
        if progressView != nil {
            progressView?.dismiss(animated: true)
            progressView = nil
            return true
        }
        return false
    }
}


