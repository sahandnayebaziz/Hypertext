![header](header.jpg)

Compose valid HTML in Swift any way you want to.

### Usage

````swift

import Hypertext

title { "hello world." }.render()
// <title>hello world.</title>

head { title { "hello world." } }.render()
// <head><title>hello world.</title></head>

head { title { "hello world." } }.render(startingWithSpacesCount: 0)
// <head>
//   <title>
//     hello world.
//   </title>
// </head>

````



### Requirements
- Swift 3.0+

### Full usage

1. Rendering a tag

    ```swift

    div().render() 
    // <div></div>

    ```
    
2. Rendering a tag with child text

   ```swift
   
   div { "hello world." }.render()
   // <div>hello world.</div>
   
   ```
   
3. Rendering a tag with a child tag

   ```swift
   
   div { img() }.render()
   // <div><img/></div>
   
   ```
   
4. Rendering a tag with multiple child tags

   ```swift
   
   div { [img(), img(), img()] }.render()
   // <div><img/><img/><img/></div>
   
   ```
   
5. Rendering a tag with attributes

   ```swift
   
   link(attributes: ["rel": "stylesheet", "type":"text/css", "href":"./style.css"]).render()
   // <link rel="stylesheet" type="text/css" href="./style.css"/>
   
   ```

6. Rendering unminified, with newlines and two-space indentation

    ```swift
    
    head { title { "hello world." } }.render(startingWithSpacesCount: 0)
    // <head>
    //   <title>
    //     hello world.
    //   </title>
    // </head>
    
    ```
    
7. Rendering a tag in a novel way, any way you want to

   ```swift
   
   func createTitleTag(forPageNamed pageName: String) -> title {
     return title { "Hypertext - \(pageName)" }
   }
   
   head { createTitleTag(forPageNamed: "Documentation") }.render()
   // <head><title>Hypertext - Documentation</title></head>
   
   ```
   
8. Rendering a custom tag

   ```swift
   
   public class myNewTag: tag {
     override public init(setChildren: (() -> Renderable?)) {
       super.init(setChildren: setChildren)
       name = "myNewTag"
       isSelfClosing = true
     }
   }
   
   myNewTag().render()
   // <myNewTag/>
   
   ```
   
9. Rendering a custom type by adopting the protocol `Renderable`

   ```swift
   
   extension MyType: Renderable {
     public func render() -> String {

     }

     public func render(startingWithSpacesCount: Int) -> String {

     }
   }

   ```
