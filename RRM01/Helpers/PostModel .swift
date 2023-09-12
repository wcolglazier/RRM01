//
//  PostModel .swift
//  RRM01
//
//  Created by william colglazier on 16/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PostModel: ObservableObject {
  @Published var posts = [Post]()
  
  private var db = Firestore.firestore()
    init(){
        self.fetchData()
    }
    
    
  
  func fetchData() {
    db.collection("posts").addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
          
      }

      self.posts = documents.map { queryDocumentSnapshot -> Post in
        let data = queryDocumentSnapshot.data()
        let detail = data["detail"] as? String ?? ""
        let time = data["time"] as? String ?? ""
        let price = data["price"] as? String ?? ""
        let phone = data["phone"] as? String ?? ""
        let gender = data["gender"] as? Int ?? -1
        let snap = data["snap"] as? String ?? ""
          _ = data["date"] as? String ?? ""
        

          return Post(id: .init(), detail: detail, date: Date(), time: time, price: price, phone: phone, snap: snap, gender: gender)
      }
    }
  }
    
    
    
    
    func add(post: Post){
        do{
      //      try db.collection("posts").addDocument(from: post)
        } catch {
            print("error adding post")
        }
    }
    
    
    
    
    
}
