//
//  Hypertext.swift
//  Hypertext
//
//  Created by Sahand Nayebaziz on 10/29/16.
//  Copyright © 2016 Sahand Nayebaziz. All rights reserved.
//

public protocol Renderable {
    func render() -> String
    func render(startingWithSpacesCount: Int) -> String
}

extension CustomStringConvertible {
    public func render() -> String {
        return String(describing: self)
    }

    public func render(startingWithSpacesCount: Int) -> String {
        return String(repeating: " ", count: startingWithSpacesCount) + render()
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

    public func render(startingWithSpacesCount: Int) -> String {
        return self.reduce("") { renderedSoFar, item in
            guard let renderableItem = item as? Renderable else {
                print("Tried to render an item in an array that does not conform to Renderable.")
                return renderedSoFar
            }
            return renderedSoFar + (renderedSoFar != "" ? "\n" : "") + renderableItem.render(startingWithSpacesCount: startingWithSpacesCount)
        }
    }
}

open class tag: Renderable {
    public var name: String? = nil
    public var isSelfClosing: Bool = false
    public var children: Renderable? = nil
    public var attributes: [String: String] = [:]

    public init(setChildren: (() -> Renderable?)) {
        self.children = setChildren()
    }

    public convenience init() {
        self.init { nil }
    }

    public convenience init(attributes: [String: String]) {
        self.init { nil }
        self.attributes = attributes
    }

    public convenience init(setChildren: (() -> Renderable?), attributes: [String: String]) {
        self.init(setChildren: setChildren)
        self.attributes = attributes
    }

    public func render() -> String {
        guard let name = name else {
            fatalError("You must give a tag a name in your initializer. Take a look at the readme for an example showing how to create a custom tag.")
        }

        if isSelfClosing {
            return "<\(name)\(renderAttributes())/>"
        } else {
            return "<\(name)\(renderAttributes())>\(children?.render() ?? "")</\(name)>"
        }
    }

    public func render(startingWithSpacesCount: Int) -> String {
        guard let name = name else {
            fatalError("You must give a tag a name in your initializer. Take a look at the readme for an example showing how to create a custom tag.")
        }

        let leadingSpaces = String(repeating: " ", count: startingWithSpacesCount)
        if isSelfClosing {
            return "\(leadingSpaces)<\(name)\(renderAttributes())/>"
        } else {
            guard let children = children else {
                return "\(leadingSpaces)<\(name)\(renderAttributes())></\(name)>"
            }
            return "\(leadingSpaces)<\(name)\(renderAttributes())>\("\n\(children.render(startingWithSpacesCount: startingWithSpacesCount + 2))\n")\(leadingSpaces)</\(name)>"
        }
    }

    private func renderAttributes() -> String {
        return attributes.keys.reduce("") { renderedSoFar, attributeKey in
            return "\(renderedSoFar) \(attributeKey)=\"\(attributes[attributeKey]!)\""
        }
    }
}
