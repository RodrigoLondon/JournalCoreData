//
//  Person.swift
//  Journal
//
//  Created by Lewis Jones on 11/07/2018.
//  Copyright © 2018 Lewis Jones. All rights reserved.
//

import Foundation



let workingDictionary: [String : Any] = ["nameKey": "Derek", "ageKey": 28, "favouriteMovie": "Zoolander"]
let brokenDictionary: [String : Any] = ["nameKey": "Steve", "ageKey": 2]


class Person {


    var name: String?
    var age: Int?
    var favouriteMovie: String?


    init(name: String, age: Int, favouriteMovie: String){
        self.name = name
        self.age = age
        self.favouriteMovie = favouriteMovie
    }

    // Failable initializer (init?)
   init?(dictionary: [String : Any]) {

   guard let name = dictionary["nameKey"] as? String,
    let age = dictionary["ageKey"] as? Int,
    let favouriteMovie = dictionary["favoriteMovie"] as? String
    else { return nil}

    self.name = name
    self.age = age
    self.favouriteMovie = favouriteMovie

  }
}
 let newPerson = Person(dictionary: workingDictionary)
 let newPerson2 = Person(dictionary: brokenDictionary)
