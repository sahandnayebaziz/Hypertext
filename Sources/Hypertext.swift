//
//  Hypertext.swift
//  Hypertext
//
//  Created by Sahand Nayebaziz on 10/29/16.
//  Copyright © 2016 Sahand Nayebaziz. All rights reserved.
//

import Foundation

public protocol Renderable: CustomStringConvertible {
    func render() -> String
    func render(startingWithSpaces: Int, indentingWithSpaces: Int) -> String
}

public extension CustomStringConvertible {
    public func render() -> String {
        return String(describing: self)
    }
    
    public func render(startingWithSpaces: Int, indentingWithSpaces: Int) -> String {
        return String(repeating: " ", count: startingWithSpaces) + render()
    }
}

public extension Renderable {
    var description: String {
        return render()
    }
}

extension String: Renderable {}
extension Int: Renderable {}
extension Double: Renderable {}
extension Float: Renderable {}

extension Array: Renderable {
    public func render() -> String {
        return self.reduce("") { renderedSoFar, item in
            guard let renderableItem = item as? Renderable else {
                print("Tried to render an item in an array that does not conform to Renderable.")
                return renderedSoFar
            }
            return renderedSoFar + renderableItem.render()
        }
    }
    
    public func render(startingWithSpaces: Int, indentingWithSpaces: Int) -> String {
        return self.reduce("") { renderedSoFar, item in
            guard let renderableItem = item as? Renderable else {
                print("Tried to render an item in an array that does not conform to Renderable.")
                return renderedSoFar
            }
            return renderedSoFar + (renderedSoFar != "" ? "\n" : "") + renderableItem.render(startingWithSpaces: startingWithSpaces, indentingWithSpaces: indentingWithSpaces)
        }
    }
}

enum TagFormatter {
    static func dashed(_ tag: String) -> String {
        return delimited(tag, delimiter: "-")
    }
    static func snaked(_ tag: String) -> String {
        return delimited(tag, delimiter: "_")
    }
    
    static private func delimited(_ tag: String, delimiter: String) -> String {
        let range = NSMakeRange(0, tag.characters.count)
        let pattern = "(.)(?=[A-Z])"
        #if !os(Linux)
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        #else
        let regex = try! RegularExpression(pattern: pattern, options: [])
        #endif
        return regex.stringByReplacingMatches(in: tag, options: [], range: range, withTemplate: "$1\(delimiter)").lowercased()
    }
}

open class tag: Renderable {
    open var isSelfClosing: Bool { return false }
    open var name: String {
        let typeName = String(describing: type(of: self))
        return TagFormatter.dashed(typeName)
    }

    public var children: Renderable? = nil
    public var attributes: [String: String] = [:]

    public init(_ attributes: [String: String] = [:], setChildren: (() -> Renderable?) = { nil }) {
        self.attributes = attributes
        self.children   = setChildren()
    }

    public func render() -> String {
        if isSelfClosing {
            return "<\(name)\(renderAttributes())/>"
        } else {
            return "<\(name)\(renderAttributes())>\(children?.render() ?? "")</\(name)>"
        }
    }

    public func render(startingWithSpaces: Int, indentingWithSpaces: Int) -> String {
        let leadingSpaces = String(repeating: " ", count: startingWithSpaces)
        if isSelfClosing {
            return "\(leadingSpaces)<\(name)\(renderAttributes())/>"
        }
        
        guard let children = children else {
            return "\(leadingSpaces)<\(name)\(renderAttributes())></\(name)>"
        }
        
        return "\(leadingSpaces)<\(name)\(renderAttributes())>\("\n\(children.render(startingWithSpaces: startingWithSpaces + indentingWithSpaces, indentingWithSpaces: indentingWithSpaces))\n")\(leadingSpaces)</\(name)>"
    }

    private func renderAttributes() -> String {
        return attributes.keys.reduce("") { renderedSoFar, attributeKey in
            return "\(renderedSoFar) \(attributeKey)=\"\(attributes[attributeKey]!)\""
        }
    }
}
