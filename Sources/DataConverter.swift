//
//  DataConverter.swift
//  Purse
//
//  Created by Harlan Kellaway on 4/30/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Converts objects to and from data.
public protocol DataConverter {
    
    /// Converts Encodable object to data.
    ///
    /// - Parameter object: Object.
    /// - Returns: Data.
    /// - Throws: Error when issue converting.
    func objectToData<T: Encodable>(_ object: T) throws -> Data
    
    /// Converts Decodable object from data.
    ///
    /// - Parameter data: Data.
    /// - Returns: Object.
    /// - Throws: Error when issue converting.
    func objectFromData<T: Decodable>(_ data: Data) throws -> T
    
}

/// Default Purse DataConverter.
/// - warning: Assumes data is in JSON format.
public struct PurseJSONDataConverter: DataConverter {
    
    // MARK: - Properties
    
    /// JSON decoder.
    public let jsonDecoder: JSONDecoder
    
    /// JSON encoder.
    public let jsonEncoder: JSONEncoder
    
    // MARK: - Init
    
    public init(jsonDecoder: JSONDecoder = JSONDecoder(),
                jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }
    
    // MARK: - Protocol conformance
    
    // MARK: DataConverter
    
    public func objectToData<T: Encodable>(_ object: T) throws -> Data{
        return try jsonEncoder.encode(object)
    }
    
    public func objectFromData<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
    
}
