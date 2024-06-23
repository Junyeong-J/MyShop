//
//  NetworkError.swift
//  MyShopping
//
//  Created by 전준영 on 6/23/24.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case custonError(message: String)
}
