//
//  NotificationsModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class NotificationsModel: Codable {
    let status: Bool?
    let data: [Datum]?
    
    
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let title: String?
        let content: String?
        let isRead, userID, orderID: Int?
        let reservationID: Int?
        let fromUserID: Int?
        let type, notifyType: String?
        let isActive: Int?
        let createdAt, updatedAt, fromUserName: String?
        let fromUserAvatar: String?
        let time, date, ago: String?
        let status: String?
        enum CodingKeys: String, CodingKey {
            case id, content
            case title
            case isRead = "is_read"
            case userID = "user_id"
            case orderID = "order_id"
            case reservationID = "reservation_id"
            case fromUserID = "from_user_id"
            case type
            case notifyType = "notify_type"
            case isActive = "is_active"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case fromUserName = "from_user_name"
            case fromUserAvatar = "from_user_avatar"
            case time, date, ago
            case status
        }
    }

}
