//
//  ContentType.swift
//

import Foundation

enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
    case formdata = "multipart/form-data; boundary="
}
