//
//  HypertextTests.swift
//  HypertextTests
//
//  Created by Sahand Nayebaziz on 10/29/16.
//  Copyright © 2016 Sahand Nayebaziz. All rights reserved.
//

import XCTest
@testable import Hypertext

class HypertextTests: XCTestCase {
    
    func testCanRenderString() {
        let expected = "hello world."
        let actual = "hello world.".render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderIntRenderable() {
        let expected = "<div>2</div>"
        let actual = div { 2 }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderDoubleRenderable() {
        let expected = "<div>2.0</div>"
        let actual = div { 2.0 }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderFloatRenderable() {
        let expected = "<div>2.0</div>"
        let actual = div { Float(2.0) }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTag() {
        let expected = "<title></title>"
        let actual = title().render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderSelfClosingTag() {
        let expected = "<img/>"
        let actual = img().render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagWithStringChild() {
        let expected = "<title>hello world.</title>"
        let actual = title { "hello world." }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderSelfClosingTagWithoutRenderingChild() {
        let expected = "<img/>"
        let actual = img { "hello world." }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagWithChildTag() {
        let expected = "<div><img/></div>"
        let actual = div { img() }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagWithMultipleChildTags() {
        let expected = "<div><img/><img/><img/></div>"
        let actual = div { [img(), img(), img()] }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagWithChildWithNestedChild() {
        let expected = "<div><div><img/></div></div>"
        let actual = div { div { img() } }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagWithChildWithNestedChildAbusingRender() {
        let expected = "<div><div><img/></div></div>"
        let actual = div { div { img().render() }.render() }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagWithManyNestedChildren() {
        let expected = "<div><div><div><div><div><div><div><div></div></div></div></div></div></div></div></div>"
        let actual = div { div { div { div { div { div { div { div() } } } } } } }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderAttributesOnTag() {
        let expected = "<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\"/>"
        let actual = link(attributes: ["rel": "stylesheet", "type":"text/css", "href":"./style.css"]).render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderAttributesOnNestedTag() {
        let expected = "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\"/></head>"
        let actual = head { link(attributes: ["rel": "stylesheet", "type":"text/css", "href":"./style.css"]) }.render()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagsWithFormatting() {
        let expected = "<head>\n  <title>\n    hello world.\n  </title>\n</head>"
        let actual = head { title { "hello world." } }.render(startingWithSpacesCount: 0)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testCanRenderTagsWithFormattingWithMultipleSiblings() {
        let expected = "<div>\n  <img/>\n  <img/>\n  <img/>\n  <h1></h1>\n</div>"
        let actual = div { [ img(), img(), img(), h1() ] }.render(startingWithSpacesCount: 0)
        
        XCTAssertEqual(expected, actual)
    }
}
