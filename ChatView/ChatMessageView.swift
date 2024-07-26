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

	@Binding private var presenter: ChatPresenter

	init(_ message: ChatMessage, presenter: Binding<ChatPresenter>) {
		self.message = message
		_presenter = presenter
	}

	var body: some View {

		let readDate = presenter.readMarker?.date ?? .distantPast

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
		.opacity(message.date <= readDate ? 0.5 : 1)

	}

}
