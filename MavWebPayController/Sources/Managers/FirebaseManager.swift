//
//  FirebaseManager.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import RxSwift
import ObjectMapper

class FirebaseManager {
    
    static let shared: FirebaseManager = FirebaseManager()
    private init(){}
    
    public func objectListener<T>(entity: String)->PublishSubject<T> where T:BaseMappable{
        let publish = PublishSubject<T>()
        let db = Firestore.firestore()
       
        db.collection(entity).document(Auth.auth().currentUser?.uid ?? "").addSnapshotListener{ documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            if let data = document.data(){
                let mapper = Mapper<T>()
                if let value = mapper.map(JSON: data){
                    publish.onNext(value)
                }
            }
        }

        return publish
    }
    
}
