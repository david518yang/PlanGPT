//
//  PlanGPTTrip.swift
//  PlanGPT
//
//  Created by David Yang on 4/27/23.
//
import Foundation
import Firebase
import FirebaseFirestore

let COLLECTION_NAME = "trips"
let PAGE_LIMIT = 20

enum TripServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

class PlanGPTTrip: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var error: Error?
    
    func createTrip(trip: Trip) {
        let days: [Day] = trip.days
        db.collection(COLLECTION_NAME).addDocument(data: [
            "title": trip.title,
            "userId": trip.userId,
            "days": days.map { day in
                return ["food": day.food,
                        "location":day.location,
                        "sightseeing":day.sightseeing]
            }
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
    }
    
    func fetchTrips(userId: String) async throws -> [Trip] {
        let tripQuery = db.collection(COLLECTION_NAME)
            .limit(to: PAGE_LIMIT)
            .whereField("userId", isEqualTo: userId)
                
        let querySnapshot = try await tripQuery.getDocuments()
        
        return try querySnapshot.documents.map {
            guard let title = $0.get("title") as? String,
                  let days = $0.get("days") as? [[String:String]] else {
                throw TripServiceError.mismatchedDocumentError
            }
            
            let daysArray = days.map { dayDictionary in
                return Day(day: 1, food: dayDictionary["food"] ?? "", location: dayDictionary["location"] ?? "", sightseeing: dayDictionary["sightseeing"] ?? "")
            }
                        
            return Trip(
                id: $0.documentID,
                title: title,
                days: daysArray,
                userId: userId
            )
        }
    }
}
