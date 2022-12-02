//
//  StoreRatingsCarousel.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

// StoreRatingCTADisplayModule.swift in Cx
public struct StoreRatingsCarousel: LegoContent {

    public let maxNumberOfStars: Int
    public let consumerReviewData: ConsumerReviewData

    public struct ConsumerReviewData: Hashable {
        public let averageRating: Double
        public let numberOfRatings: String
        public let consumerReviews: [ConsumerReview]
        public let numberOfRatingsDisplayString: String
        public let insufficientRatings: Bool
        public let numberOfReviews: String
        public let numberOfReviewsDisplayString: String
        public let googleReviewData: GoogleReviewData

        public struct ConsumerReview: Hashable {
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

            public struct Reviewer: Hashable {
                public let displayName: String
                public let description: String
//                public let profileImage: Image // fix because stub has empty URL string, which will break decoding
                public let isVerified: Bool
                public let categoryHighlightTag: String

                init(reviewer: ResponseContent.ConsumerReviewData.ConsumerReview.Reviewer) {
                    displayName = reviewer.displayName
                    description = reviewer.description
                    isVerified = reviewer.isVerified
                    categoryHighlightTag = reviewer.categoryHighlightTag
                }
            }

            init(consumerReview: ResponseContent.ConsumerReviewData.ConsumerReview) {
                id = consumerReview.id
                reviewerDisplayName = consumerReview.reviewerDisplayName
                starRating = consumerReview.starRating
                reviewedAt = consumerReview.reviewedAt
                reviewText = consumerReview.reviewText
                isVerified = consumerReview.isVerified
                experience = consumerReview.experience
                reviewSource = consumerReview.reviewSource
                reviewerData = .init(reviewer: consumerReview.reviewerData)
                consumerReviewSource = consumerReview.consumerReviewSource
                markedUpReviewText = consumerReview.markedUpReviewText
            }
        }

        public struct GoogleReviewData: Hashable {
            public let averageRating: Double
            public let numberOfRatings: String
            public let numberOfRatingsDisplayString: String

            init(googleReviewData: ResponseContent.ConsumerReviewData.GoogleReviewData) {
                averageRating = googleReviewData.averageRating
                numberOfRatings = googleReviewData.numberOfRatings
                numberOfRatingsDisplayString = googleReviewData.numberOfRatingsDisplayString
            }
        }

        init(consumerReviewData: ResponseContent.ConsumerReviewData) {
            averageRating = consumerReviewData.averageRating
            numberOfRatings = consumerReviewData.numberOfRatings
            consumerReviews = consumerReviewData.consumerReviews.map(ConsumerReview.init)
            numberOfRatingsDisplayString = consumerReviewData.numberOfRatingsDisplayString
            insufficientRatings = consumerReviewData.insufficientRatings
            numberOfReviews = consumerReviewData.numberOfReviews
            numberOfReviewsDisplayString = consumerReviewData.numberOfReviewsDisplayString
            googleReviewData = .init(googleReviewData: consumerReviewData.googleReviewData)
        }
    }

}

extension LegoIdentifier {

    public static let storeRatingsCarousel = LegoIdentifier(name: "cx.ox.store.ratings_carousel")

}

extension StoreRatingsCarousel {

    public struct ResponseContent: LegoResponseContent {

        public let maxNumberOfStars: Int
        public let consumerReviewData: ConsumerReviewData

        public enum CodingKeys: String, CodingKey {
            case maxNumberOfStars = "max_num_stars"
            case consumerReviewData = "consumer_review_data"
        }

        public struct ConsumerReviewData: Codable, Hashable {
            public let averageRating: Double
            public let numberOfRatings: String
            public let consumerReviews: [ConsumerReview]
            public let numberOfRatingsDisplayString: String
            public let insufficientRatings: Bool
            public let numberOfReviews: String
            public let numberOfReviewsDisplayString: String
            public let googleReviewData: GoogleReviewData

            public struct ConsumerReview: Codable, Hashable {
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

                public struct Reviewer: Codable, Hashable {
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

            public struct GoogleReviewData: Codable, Hashable {
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

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        maxNumberOfStars = responseContent.maxNumberOfStars
        consumerReviewData = .init(consumerReviewData: responseContent.consumerReviewData)
    }

}
