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
- Xcode 8.0+
- Swift 3.0+
