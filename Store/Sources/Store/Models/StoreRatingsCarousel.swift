//
//  StoreRatingsCarousel.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

public struct StoreRatingsCarousel: LegoContent {

    public let maxNumberOfStars: Int
    public let consumerReviewData: ConsumerReviewData

    public enum CodingKeys: String, CodingKey {
        case maxNumberOfStars = "max_num_stars"
        case consumerReviewData = "consumer_review_data"
    }

    public struct ConsumerReviewData: Codable {
        public let averageRating: Double
        public let numberOfRatings: String
        public let consumerReviews: [ConsumerReview]
        public let numberOfRatingsDisplayString: String
        public let insufficientRatings: Bool
        public let numberOfReviews: String
        public let numberOfReviewsDisplayString: String
        public let googleReviewData: GoogleReviewData

        public struct ConsumerReview: Codable {
            public let id: UUID
            public let reviewerDisplayName: String
            public let starRating: Int
            public let reviewedAt: String // TODO: Change to Date and parse
            public let reviewText: String
            public let isVerified: Bool
            public let experience: String
            public let reviewSource: String
            public let reviewerData: Reviewer
            public let consumerReviewSource: String
            public let markedUpReviewText: String

            private enum CodingKeys: String, CodingKey {
                case id = "consumer_review_uuid"
                case reviewerDisplayName = "reviewer_display_name"
                case starRating = "star_rating"
                case reviewedAt = "reviewed_at"
                case reviewText = "review_text"
                case isVerified = "is_verified"
                case experience
                case reviewSource = "review_source"
                case reviewerData = "reviewer_data"
                case consumerReviewSource = "consumer_review_source"
                case markedUpReviewText = "marked_up_review_text"
            }

            public struct Reviewer: Codable {
                public let displayName: String
                public let description: String
//                public let profileImage: Image // fix because stub has empty URL string, which will break decoding
                public let isVerified: Bool
                public let categoryHighlightTag: String

                private enum CodingKeys: String, CodingKey {
                    case displayName = "display_name"
                    case description
//                    case profileImage = "profile_image"
                    case isVerified = "is_verified"
                    case categoryHighlightTag = "category_highlight_tag"
                }
            }
        }

        public struct GoogleReviewData: Codable {
            public let averageRating: Double
            public let numberOfRatings: String
            public let numberOfRatingsDisplayString: String

            private enum CodingKeys: String, CodingKey {
                case averageRating = "avg_rating"
                case numberOfRatings = "num_ratings"
                case numberOfRatingsDisplayString = "num_ratings_display_string"
            }
        }

        private enum CodingKeys: String, CodingKey {
            case averageRating = "avg_rating"
            case numberOfRatings = "num_ratings"
            case consumerReviews = "consumer_reviews"
            case numberOfRatingsDisplayString = "num_ratings_display_string"
            case insufficientRatings = "insufficient_ratings"
            case numberOfReviews = "num_reviews"
            case numberOfReviewsDisplayString = "num_reviews_display_string"
            case googleReviewData = "google_review_data"
        }
    }

}

extension LegoContentIdentifier {

    public static let storeRatingsCarousel = LegoContentIdentifier(name: "cx.ox.store.ratings_carousel")

}
