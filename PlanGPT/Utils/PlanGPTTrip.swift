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

    func createTrip(trip: Trip) -> String {
        var ref: DocumentReference? = nil
        var days: [Day] = trip.days
        ref = db.collection(COLLECTION_NAME).addDocument(data: [
            "title": trip.title,
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
        return ref?.documentID ?? ""
    }

    func fetchTrips() async throws -> [Trip] {
        let articleQuery = db.collection(COLLECTION_NAME)
            .order(by: "date", descending: true)
            .limit(to: PAGE_LIMIT)

        let querySnapshot = try await articleQuery.getDocuments()

        return try querySnapshot.documents.map {
            guard let title = $0.get("title") as? String,
                  let days = $0.get("days") as? [Day] else {
                throw TripServiceError.mismatchedDocumentError
            }
            
            return Trip(
                id: $0.documentID,
                title: title,
                days: days
            )
        }
    }
}
