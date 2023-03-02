//
//  Favorites.swift
//  snowSeeker
//
//  Created by Vladimir Vinageras on 04.12.2022.
//

import Foundation

class Favorites: ObservableObject{
    private var resorts: Set<String>
    private var saveKey = "Favorites"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                    resorts = decoded
                    return
                }
            }

            resorts = []
    }
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save(){
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(resorts) {
            UserDefaults.standard.set(data, forKey: saveKey)  }
    }
    
}




