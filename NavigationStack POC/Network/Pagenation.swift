//
//  Pagenation.swift
//  NobyLynkDriver
//
//  Created by Youssef on 4/10/21.
//

import Foundation

class Pagenation {
    
    static func canPagenat(isLoading: Bool, lastPage: Int?, current: Int, index: Int, count: Int) -> Bool {
        guard !isLoading else { return false }
        guard let lastPage = lastPage else { return false }
        print("000000")
        guard lastPage > current else { return false }
        guard index == count - 2 else { return false }
        return true
    }
}
