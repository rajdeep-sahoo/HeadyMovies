//
//  Defaults.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 26/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

class Default {

    private enum DefaultString: String {
        case sortSelected
    }
    
    private init() {}
    
    static let shared = Default()
    
    var sortSelected: String {
        get {
            return UserDefaults.standard.string(forKey: DefaultString.sortSelected.rawValue) ?? SortType.Popularity.rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultString.sortSelected.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}

