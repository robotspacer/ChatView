//
//  VisibilityTracker.swift
//  ChatView
//
//  Created by Mike on 7/24/24.
//

import SwiftUI

struct VisibilityTracker: ViewModifier {

	private var marker: MessageMarker

	@State private var presenter: ChatPresenter

	init(marker: MessageMarker, presenter: ChatPresenter) {
		self.marker = marker
		self.presenter = presenter
	}

	func body(content: Content) -> some View {
		content
		.onAppear {
			presenter.visibleMarkers.append(marker)
		}
		.onDisappear {
			presenter.visibleMarkers.removeAll { $0 == marker }
		}
	}

}

extension View {

	func trackVisibility(marker: MessageMarker,
		presenter: ChatPresenter) -> some View {
		modifier(VisibilityTracker(marker: marker, presenter: presenter))
	}

}
