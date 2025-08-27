//
//  RealmManager.swift
//  RealmImageAddress
//
//  Created by Jun Jong Eck on 8/8/25.
//

import RealmSwift
import SwiftUI

class RealmManager : ObservableObject { // ObservableObject는 메모리에 존재
    private var realm: Realm?
    
    @Published var contacts: [Contact] = []
    
    init() {
        do{
            realm = try Realm()
            fetchContacts()
        }catch{
            print("Error Initializing Realm: \(error)")
        }
    }
    
    func fetchContacts() {
        guard let realm = realm else { return }
        let results = realm.objects(Contact.self) // 모델 Contact 의 모든것을 다 가져와라
        contacts = Array(results) // Arrary에 넣어준다.
        // Return이 없다. View에서 직접 가져와야한다.
        
        
    }
    
    func addContact(_ contact: Contact){
        guard let realm = realm else { return }
        do{
            try realm.write {
                realm.add(contact)
            }
            fetchContacts()
        }catch{
            print("Error adding contact: \(error)")
        }
    }
    
    func updateContact(_ contact: Contact, with newContact: Contact){
        guard let realm = realm else { return }
        do{
            try realm.write {
                contact.name = newContact.name
                contact.phone = newContact.phone
                contact.address = newContact.address
                contact.relation = newContact.relation
                contact.imageData = newContact.imageData
                
            }
            fetchContacts()
        }catch {
            print("Error updating contact: \(error)")
        }
    }
    
    func deleteContact(_ contact: Contact){
        guard let realm = realm else { return }
        do{
            try realm.write {
                realm.delete(contact)
            }
            fetchContacts()
        }catch{
            print("Error deleting contact: \(error)")
        }
    }

}
