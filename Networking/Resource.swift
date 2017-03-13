//
//  Resource.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

/// The request method for a resource.
///
/// - GET: Requests information for a resource.
public enum Method: String {
	case GET = "GET"
}

/// Represents an Internet resource.
public struct Resource<M> {

	/// The request method.
	public let method: Method

	/// The request URL.
	public let url: URL

	/// The request parameters.
	public let parameters: [String: String]

	/// How to decode responses.
	public let decode: (Data) throws -> M

	/// The corresponding URL request.
	public var request: URLRequest {
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = parameters.map(URLQueryItem.init)

		var request = URLRequest(url: components.url!)
		request.httpMethod = method.rawValue

		return request
	}

	public init(method: Method = .GET, url: URL, parameters: [String: String] = [:], decode: @escaping (Data) throws -> M) {
		self.method = method
		self.url = url
		self.parameters = parameters
		self.decode = decode
	}

	/// Returns a resource made by adding the specified parameters to this `Resource`.
	public func addingParameters(_ parameters: [String: String]) -> Resource<M> {
		guard parameters.count > 0 else {
			return self
		}

		var newParameters = self.parameters
		parameters.forEach { newParameters.updateValue($1, forKey: $0) }

		return Resource(method: self.method, url: self.url, parameters: newParameters, decode: self.decode)
	}
}
