////
////  CoreDataManager.swift
////  banquemisr.challenge05
////
////  Created by Mohamed Nagi on 24/01/2025.
////
//
//
//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    let persistentContainer: NSPersistentContainer
//
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "LocalResultsEntity") // Replace with your Core Data model name
//        persistentContainer.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Unable to initialize Core Data \(error)")
//            }
//        }
//    }
//
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save context: \(error)")
//            }
//        }
//    }
//    
//    func saveResults(models: [ResultsModel]) {
//        let context = CoreDataManager.shared.context
//
//        models.forEach { model in
//            let entity = LocalResultsEntity(context: context)
//            entity.id = Int64(model.id)
//            entity.posterPath = model.posterPath
//            entity.releaseDate = model.releaseDate
//            entity.title = model.title
//        }
//
//        CoreDataManager.shared.saveContext()
//        print("saved ")
//    }
//    
//    func fetchResults() -> [ResultsModel] {
//        let context = CoreDataManager.shared.context
//        let fetchRequest: NSFetchRequest<LocalResultsEntity> = LocalResultsEntity.fetchRequest()
//
//        do {
//            let entities = try context.fetch(fetchRequest)
//            print("returned \(entities)")
//            return entities.map { entity in
//                ResultsModel(
//                    id: Int(entity.id),
//                    posterPath: entity.posterPath ?? "",
//                    releaseDate: entity.releaseDate ?? "",
//                    title: entity.title ?? ""
//                )
//            }
//            
//        } catch {
//            print("Failed to fetch results: \(error)")
//            return []
//        }
//    }
//
//
//}
