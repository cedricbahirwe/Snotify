//
//  SNErrors.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 14/07/2022.
//

import Foundation

public enum SNErrors: Error {
    case genericError
    case internetError
    case timeout
    case localUserNotFound
    case dataBaseError
    case apiError(code: Int, message: String, reason: String)
    case retryError(message: String, retryAction: () -> Void)
    case unauthorized
    case userNotFound
    case invalidUser
    case parseData
    case noDataFound
}
