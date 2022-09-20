//
//  AddTargetHandler.swift
//  TodoIntent
//
//  Created by user on 16.02.2022.
//

import Foundation
import Intents
import CoreData
//import ToDoList

class AddTargetHandler: NSObject, AddTargetIntentHandling {
    func handle(intent: AddTargetIntent, completion: @escaping (AddTargetIntentResponse) -> ()) {
        guard let name = intent.name else {
            completion(AddTargetIntentResponse(code: AddTargetIntentResponseCode.failure, userActivity: nil))
            return
        }
        let dataController = DataController()
        dataController.addData(text: name)
        
        completion(AddTargetIntentResponse.success(name: name))
    }
    
    func resolveName(for intent: AddTargetIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let name = intent.name else {
            completion(INStringResolutionResult.needsValue())
            return
        }
        
        completion(INStringResolutionResult.success(with: name))
    }
}
