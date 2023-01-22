//
//  CategoryEntity+CoreDataProperties.swift
//  MyWallet
//
//  Created by Arafat Hossain on 22/1/23.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var imageName: String?
    @NSManaged public var color: ColorEntity?
    @NSManaged public var subCategories: NSSet?

    public var wrappedName: String {
        name ?? "unknown"
    }
    
    public var wrappedImgaeName: String {
        imageName ?? "questionmark"
    }
    
    public var subcategoryArray: [SubCategoryEntity] {
        let set = subCategories as? Set<SubCategoryEntity> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for subCategories
extension CategoryEntity {

    @objc(addSubCategoriesObject:)
    @NSManaged public func addToSubCategories(_ value: SubCategoryEntity)

    @objc(removeSubCategoriesObject:)
    @NSManaged public func removeFromSubCategories(_ value: SubCategoryEntity)

    @objc(addSubCategories:)
    @NSManaged public func addToSubCategories(_ values: NSSet)

    @objc(removeSubCategories:)
    @NSManaged public func removeFromSubCategories(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
