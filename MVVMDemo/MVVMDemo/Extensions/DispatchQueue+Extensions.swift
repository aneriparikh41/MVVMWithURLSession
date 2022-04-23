//
//  DispatchQueue+Extensions.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import Foundation

extension DispatchQueue {
    static func executeOnMain(_ completion: @escaping () -> ()) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
