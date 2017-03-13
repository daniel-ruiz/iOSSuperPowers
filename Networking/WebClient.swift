//
//  WebClient.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

public enum WebClientError: Error {
	case badStatus(Int, Data)
	case other(Error)
}

/// Generic web client.
public final class WebClient {

	/// The parameters that will be appended to all requests.
	public let defaultParameters: [String: String]

	private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)

	/// Creates a new web client with the specified default parameters.
	public init(defaultParameters: [String: String] = [:]) {
		self.defaultParameters = defaultParameters
	}

	/// Loads the content of the specified resource.
	public func load<M>(resource: Resource<M>) -> Observable<M> {
		let r = resource.addingParameters(defaultParameters).request
		return session.data(request: r).map { try resource.decode($0) }
	}
}

private extension URLSession {

	func data(request: URLRequest) -> Observable<Data> {

		return Observable.create { observer in
			let task = self.dataTask(with: request) { data, response, error in

				if let error = error {
					observer.onError(WebClientError.other(error))
				} else {
					guard let httpResponse = response as? HTTPURLResponse else {
						fatalError("Unsupported protocol")
					}

					if 200 ..< 300 ~= httpResponse.statusCode {
						observer.onNext(data ?? Data())
						observer.onCompleted()
					} else {
						observer.onError(WebClientError.badStatus(httpResponse.statusCode, data ?? Data()))
					}
				}
			}

			task.resume()

			return Disposables.create {
				task.cancel()
			}
		}
	}
}
