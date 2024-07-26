//
//  ChatPresenter.swift
//  ChatView
//
//  Created by Mike Piontek on 4/11/24.
//

import SwiftUI

@Observable
@MainActor
public class ChatPresenter: NSObject {

	@ObservationIgnored
	private static let updateInterval: TimeInterval = 0.05

	public private(set) var messages: [ChatMessage] = []

	@ObservationIgnored
	public var visibleMarkers: [MessageMarker] = []

	public private(set) var readMarker: MessageMarker? = nil

	@ObservationIgnored
	public var lastMarker: MessageMarker? {
		return messages.last?.marker
	}

	public var messageCount: Int {
		return messages.count
	}

	public func connect() {
		startTimer()
	}

	public func disconnect() {
		stopTimer()
	}

	public func message(id: String) -> ChatMessage? {
		return messages.first { $0.id == id }
	}

	public func markRead(id: String) {
		guard let message = message(id: id) else {
			return
		}
		readMarker = message.marker
	}

	public func markRead() {
		let markers = visibleMarkers
		let marker = markers.max { $0.date < $1.date }
		guard let marker else { return }
        readMarker = marker
	}

	@ObservationIgnored
	private var timer: Timer?

	private func startTimer() {
		stopTimer()
		let timer = Timer(timeInterval: ChatPresenter.updateInterval, repeats: true) {
			[weak self] timer in
			guard let self else { return }
			Task {
				await self.createMessage()
			}
		}
		RunLoop.main.add(timer, forMode: .default)
		self.timer = timer
	}

	private func stopTimer() {
		timer?.invalidate()
	}

	private func createMessage() async {
		if Bool.random() == false {
			return
		}
		var messages = self.messages
		messages.append(ChatMessage())
		self.messages = messages // .suffix(1000)
	}

}
