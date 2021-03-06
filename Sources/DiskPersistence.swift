//
//  DiskPersistence.swift
//  Purse
//
// Copyright (c) 2018 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

/// Persists objects to disk.
public protocol DiskPersistence {
    
    /// Persists an object conforming to Encodable to disk as a JSON file.
    ///
    /// - Parameters:
    ///   - object: Object to persist.
    ///   - directory: Directory type to persist to.
    ///   - fileName: File name to use.
    /// - Throws: Error if issue persisting.
    func persist<T: Encodable>(_ object: T, to directory: Purse.Directory, fileName: FileName) throws
    
    /// Retrieves Decodable object from disk.
    /// Object is expected to be represented as JSON.
    ///
    /// - Parameters:
    ///   - directory: Directory object was persisted to.
    ///   - fileName: File name used for JSON representation of object.
    ///   - objectType: Type of object.
    /// - Returns: Object retrieved from disk.
    /// - Throws: Error if issue retrieving object.s
    func retrieve<T: Decodable>(from directory: Purse.Directory, fileName: FileName, as objectType: T.Type) throws -> T
    
}
