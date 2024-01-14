//
//  ReuseIdentifying.swift
//  Diary
//
//  Created by Kiseok on 2024/01/05.
//

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
