//
//  Constants.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/9/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation

var todoList:[String]?
var notesList:[String]?

func saveData(todoList:[String]) {
    UserDefaults.standard.set(todoList, forKey: "todoList")
    
}

func fetchData(key: String) -> [String]? {
    if let todo = UserDefaults.standard.array(forKey: key) as? [String] {
        return todo
    }
    else {
        return nil
    }
}
