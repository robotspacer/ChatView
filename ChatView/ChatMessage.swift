//
//  ChatMessage.swift
//  ChatView
//
//  Created by Mike Piontek on 3/7/24.
//

import Foundation

public struct ChatMessage: Identifiable, Equatable {

	enum ParseError: Error {
		case missingEvent
		case missingChatMessage
		case missingID
		case unexpectedType(String)
	}

	public let id: String

	public let date: Date

	public let chatter: String

	public let text: String

	init() {

		let id = UUID().uuidString
		let text: String
		let random = Int.random(in: 1..<10)

		switch random {
			case 1: text = "Hey there I am chatting in chat"
			case 2: text = "I think you should check out this cool link at https://robotspacer.tv there's a lot of cool stuff there"
			case 3: text = "Hi chat"
			case 4: text = "I have something to say"
			case 5: text = "I don't have anything to say"
			case 6: text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
			case 7: text = "Oh no"
			case 8: text = "RIP"
			case 9: text = "What's up I just got here did I miss anything cool?"
			default: text = "This is the a default message"
		}

		self.id = id
		self.date = .now
		self.chatter = "Username"
		self.text = text

	}

	public static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
		return lhs.id == rhs.id
	}

}
