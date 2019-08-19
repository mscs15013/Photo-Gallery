//
//  PhotoProvider.swift
//  PhotoGallery
//
//  Created by Umair Ali on 18/08/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import Foundation
import CoreData

class GalleryDataSource {
    
    let request = AppRequest("https://jsonplaceholder.typicode.com/photos", .get)
    
    func isPhotosLocallyStore() -> Bool {
        let context = PersistenceService.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.photo)
        do {
            let count = try context.count(for: fetchRequest)
            debugPrint("Number of Photos:\(count)")
            return count > 0
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    func fetchPhotos(success: @escaping (_ photos: [Photo]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        if isPhotosLocallyStore() {
            fetchFromCoreData(success: { photos in
                debugPrint("Photos fetch from CoreData")
                success(photos)
            }, failure: { error in
                failure(error)
            })
        } else {
            fetchFromServer(success: { photos in
                debugPrint("Photos fetch from Server")
                success(photos)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    func fetchFromCoreData(success: @escaping (_ photos: [Photo]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        do {
            let photos = try PersistenceService.context.fetch(fetchRequest)
            success(photos)
        } catch {
            failure(error as NSError)
        }
    }
    
    func fetchFromServer(success: @escaping (_ photos: [Photo]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        WebServiceManager.sendAPICall(request: request, parameters: nil, success: { response in
            success(response)
        }, failure: { error in
            failure(error)
        })
    }
}
