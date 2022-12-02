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

    public struct ConsumerReviewData {
        public let averageRating: Double
        public let numberOfRatings: String
        public let consumerReviews: [ConsumerReview]
        public let numberOfRatingsDisplayString: String
        public let insufficientRatings: Bool
        public let numberOfReviews: String
        public let numberOfReviewsDisplayString: String
        public let googleReviewData: GoogleReviewData

        public struct ConsumerReview {
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

            public struct Reviewer {
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

        public struct GoogleReviewData {
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
