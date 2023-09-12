//
//  PostText2.swift
//  RRM01
//
//  Created by william colglazier on 16/08/2023.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var detail: String
    var date: Date
    var time: String
    var price: String
    var phone: String
    var snap: String
    var gender: Int //Neg 1 = not selected, 0 = Male , 1 = Female, 2 = other
}


enum Gender: String {
    case unspecified = "unspecified"
    case Male = "Male"
    case female = "Female"
    case other = "other"
    
   static func getGender(val: Int) -> String {
        if val == -1{ return Gender.unspecified.rawValue}
        if val == 0{ return Gender.Male.rawValue}
        if val == 1{ return Gender.female.rawValue}
        if val == 2{ return Gender.other.rawValue}
        return "unspecified"
    }
}
