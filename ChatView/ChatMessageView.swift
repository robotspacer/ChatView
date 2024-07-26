//
//  ChatMessageView.swift
//  ChatView
//
//  Created by Mike Piontek on 7/25/24.
//

import SwiftUI

@MainActor
struct ChatMessageView: View {

	private var message: ChatMessage

	init(_ message: ChatMessage) {
		self.message = message
	}

	var body: some View {
		HStack(alignment: .center) {
			VStack(alignment: .leading) {
				Text(verbatim: message.chatter)
					.font(.caption.weight(.semibold))
				Text(LocalizedStringKey(stringLiteral: message.text))
			}
		}
		.id(message.marker)
		#if os(macOS)
		.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
		.listRowInsets(EdgeInsets())
		#endif
	}

}
