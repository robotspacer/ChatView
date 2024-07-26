//
//  MessageMarker.swift
//  ChatView
//
//  Created by Mike Piontek on 4/17/24.
//

import Foundation

/// Identifies a message in a list, with the date it was posted. This is used
/// to keep track of messages on screen. The date makes it possible to quickly
/// determine the most recent message.

public struct MessageMarker: Identifiable, Hashable {

	public let id: String

	public let date: Date

}

public extension ChatMessage {

	var marker: MessageMarker {
		return MessageMarker(id: id, date: date)
	}

}
