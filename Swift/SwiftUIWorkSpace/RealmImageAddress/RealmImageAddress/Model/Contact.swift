//
//  Contact.swift
//  RealmImageAddress
//
//  Created by Jun Jong Eck on 8/8/25.
//

import RealmSwift
import UIKit

class Contact: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId // Int와 String을 같이 쓰기 위해 ObjectId를 썼다.
    @Persisted var name: String = ""
    @Persisted var phone: String = ""
    @Persisted var address: String = ""
    @Persisted var relation: String = ""
    @Persisted var imageData: Data? = nil
}

