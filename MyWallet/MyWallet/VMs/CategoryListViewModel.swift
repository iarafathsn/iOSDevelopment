//
//  CategoryListViewModel.swift
//  MyWallet
//
//  Created by Arafat Hossain on 29/1/23.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class CategoryListViewModel: NSObject, ObservableObject {
    @Published var categoryList = [CategoryModel]()
    
    private let fetchResultsController: NSFetchedResultsController<CategoryEntity>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: CategoryEntity.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            
            guard let categoryList = fetchResultsController.fetchedObjects else {
                return
            }
            
            if categoryList.count == 0 {
                Logger.i("Category List is empty. Will create shortly")
                
                UtilityHelper.shared.initilizeCategory()
                return
            }
            
            self.categoryList = categoryList.map(CategoryModel.init)
        } catch {
            Logger.e(error)
        }
    }
    
    func deleteRecord(categoryId: NSManagedObjectID) {
        do {
            guard let category = try context.existingObject(with: categoryId) as? CategoryEntity else {
                return
            }
            
            context.delete(category)
            
            try context.save()
        } catch {
            Logger.e(error)
        }
    }
}

extension CategoryListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let categoryList = controller.fetchedObjects as? [CategoryEntity] else {
            return
        }
        
        self.categoryList = categoryList.map(CategoryModel.init)
    }
}

// MARK: - Models
struct CategoryModel: Identifiable {
    
    private var category: CategoryEntity
    
    init(category: CategoryEntity) {
        self.category = category
    }
    
    var id: NSManagedObjectID {
        category.objectID
    }
    
    var name: String {
        category.wrappedName
    }
    
    var imageName: String {
        category.wrappedImageName
    }
    
    var color: Color {
        ColorEMHelper.getColor(colorEntity: category.color!)
    }
    
    var subCategory: [SubCategoryModel] {
        category.subcategoryArray.map(SubCategoryModel.init)
    }
}

struct SubCategoryModel: Identifiable {
    private var subCategory: SubCategoryEntity
    
    init(subCategory: SubCategoryEntity) {
        self.subCategory = subCategory
    }
    
    var id: NSManagedObjectID {
        subCategory.objectID
    }
    
    var name: String {
        subCategory.wrappedName
    }
    
    var imageName: String {
        subCategory.wrappedImageName
    }
}
