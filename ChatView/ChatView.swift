//
//  ChatView.swift
//  ChatView
//
//  Created by Mike Piontek on 7/21/23.
//

import SwiftUI

@MainActor
struct ChatView: View {

	@State private var presenter = ChatPresenter()

	var body: some View {
		ScrollViewReader { scrollView in
			List {
				ForEach(presenter.messages) { message in
					messageRow(message)
				}
				footerView()
			}
			.onChange(of: presenter.messages) {
				autoScroll(scrollView)
			}
		}
		.listStyle(.inset)
		.navigationTitle("Chat")
		.toolbar {
			ToolbarItem {
				Button("Mark Read") {
					presenter.markRead()
				}
			}
		}
		.onAppear() {
			presenter.connect()
		}
	}

	@ViewBuilder
	func messageRow(_ message: ChatMessage) -> some View {
		let readDate = presenter.readMarker?.date ?? .distantPast
		ChatMessageView(message)
			.trackVisibility(marker: message.marker, presenter: presenter)
			.opacity(message.date <= readDate ? 0.5 : 1)
	}

	@ViewBuilder
	func footerView(separator: Bool = true) -> some View {
		Text(verbatim: "Count: \(presenter.messageCount)")
			.font(.footnote)
			.padding(.top, 8)
	}

	private func autoScroll(_ view: ScrollViewProxy) {
		guard let marker = presenter.lastMarker else { return }
		// withAnimation {
			view.scrollTo(marker, anchor: .top)
		// }
	}

}
