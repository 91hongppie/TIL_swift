//
//  ConversationViewModel.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/27/24.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp: String {
        let data = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: data)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
