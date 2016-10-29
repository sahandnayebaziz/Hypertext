//
//  Hypertext.swift
//  Hypertext
//
//  Created by Sahand Nayebaziz on 10/29/16.
//  Copyright © 2016 Sahand Nayebaziz. All rights reserved.
//

protocol Renderable {
    func render() -> String
    func render(startingWithSpacesCount: Int) -> String
}

extension CustomStringConvertible {
    func render() -> String {
        return String(describing: self)
    }
    
    func render(startingWithSpacesCount: Int) -> String {
        return String(repeating: " ", count: startingWithSpacesCount) + render()
    }
}

extension String: Renderable {}
extension Int: Renderable {}
extension Double: Renderable {}
extension Float: Renderable {}

extension Array: Renderable {
    func render() -> String {
        return self.reduce("") { renderedSoFar, item in
            guard let renderableItem = item as? Renderable else {
                print("Tried to render an item in an array that does not conform to Renderable.")
                return renderedSoFar
            }
            return renderedSoFar + renderableItem.render()
        }
    }
    
    func render(startingWithSpacesCount: Int) -> String {
        return self.reduce("") { renderedSoFar, item in
            guard let renderableItem = item as? Renderable else {
                print("Tried to render an item in an array that does not conform to Renderable.")
                return renderedSoFar
            }
            return renderedSoFar + (renderedSoFar != "" ? "\n" : "") + renderableItem.render(startingWithSpacesCount: startingWithSpacesCount)
        }
    }
}

class tag: Renderable {
    var name: String? = nil
    var isSelfClosing: Bool = false
    var children: Renderable? = nil
    var attributes: [String: String]? = [:]
    
    init(setChildren: (() -> Renderable)) {
        self.children = setChildren()
    }
    
    convenience init() {
        self.init { return "" }
    }
    
    convenience init(attributes: [String: String]) {
        self.init { return "" }
        self.attributes = attributes
    }
    
    convenience init(setChildren: (() -> Renderable), attributes: [String: String]) {
        self.init(setChildren: setChildren)
        self.attributes = attributes
    }
    
    func render() -> String {
        guard let name = name else {
            fatalError("You must give a tag a name in your initializer. Take a look at the readme for an example showing how to create a custom tag.")
        }
        
        if isSelfClosing {
            return "<\(name)\(renderAttributes())/>"
        } else {
            return "<\(name)\(renderAttributes())>\(children != nil ? children!.render() : "")</\(name)>"
        }
    }
    
    func render(startingWithSpacesCount: Int) -> String {
        guard let name = name else {
            fatalError("You must give a tag a name in your initializer. Take a look at the readme for an example showing how to create a custom tag.")
        }
        
        let leadingSpaces = String(repeating: " ", count: startingWithSpacesCount)
        if isSelfClosing {
            return "\(leadingSpaces)<\(name)\(renderAttributes())/>"
        } else {
            return "\(leadingSpaces)<\(name)\(renderAttributes())>\(children != nil ? "\n\(children!.render(startingWithSpacesCount: startingWithSpacesCount + 2))\n" : "")\(leadingSpaces)</\(name)>"
        }
    }
    
    func renderAttributes() -> String {
        guard let attributes = attributes else {
            return ""
        }
        
        return attributes.keys.reduce("") { renderedSoFar, attributeKey in
            return "\(renderedSoFar) \(attributeKey)=\"\(attributes[attributeKey]!)\""
        }
    }
}

class head: tag {
    override init(setChildren: (() -> Renderable)) {
        super.init(setChildren: setChildren)
        name = "head"
    }
}

class div: tag {
    override init(setChildren: (() -> Renderable)) {
        super.init(setChildren: setChildren)
        name = "div"
    }
}

class title: tag {
    override init(setChildren: (() -> Renderable)) {
        super.init(setChildren: setChildren)
        name = "title"
    }
}

class img: tag {
    override init(setChildren: (() -> Renderable)) {
        super.init(setChildren: setChildren)
        name = "img"
        isSelfClosing = true
    }
}

class link: tag {
    override init(setChildren: (() -> Renderable)) {
        super.init(setChildren: setChildren)
        name = "link"
        isSelfClosing = true
    }
}

class meta: tag {
    override init(setChildren: (() -> Renderable)) {
        super.init(setChildren: setChildren)
        name = "meta"
        isSelfClosing = true
    }
}

