//
//  Photo+CoreDataClass.swift
//  
//
//  Created by Umair Ali on 18/08/2019.
//
//

import Foundation
import CoreData

@objc(Photo)

public class Photo: NSManagedObject, Decodable {
    
    @NSManaged public var albumId: Int16
    @NSManaged public var title: String
    @NSManaged public var thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case albumId
        case title
        case thumbnailUrl
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: Entities.photo, in: PersistenceService.context) else {
                fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: PersistenceService.context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try container.decodeIfPresent(Int16.self, forKey: .albumId) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? String.empty
        self.thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl) ?? String.empty
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: Entities.photo)
    }
    
}
