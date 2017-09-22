# Changelog

## [2.1.1](https://github.com/sahandnayebaziz/Hypertext/releases/tag/2.1.1)
September 22, 2017

#### Fixed
- Fixed an extension that was adding a `description` property to all types that conformed to `Renderable`, instead of just to `tag`, that was causing duplication in standard types like `String` and `Int`

thank you @briancprice for [#28](https://github.com/sahandnayebaziz/Hypertext/pull/28)

## [2.1.0](https://github.com/sahandnayebaziz/Hypertext/releases/tag/2.1.0)
January 21st, 2017

#### Added
- Custom tags now, by default, render their tags with HTML-appropriate hyphenation if given a camel case name.
```swift
public class myNewTag: tag {}

myNewTag().render()
// <my-new-tag/>
```
thank you @stupergenius for [#23](https://github.com/sahandnayebaziz/Hypertext/pull/23)

## [2.0.0](https://github.com/sahandnayebaziz/Hypertext/releases/tag/2.0.0)
November 9th, 2016

#### Improved
- Creating a custom tag is easier. The `name` and `isSelfClosing` attributes of  `tag` have been changed to computed properties. By default, `name` takes the name of the subclass and `isSelfClosing` returns false. To override either, like we do to create the `img` tag, is simple:
```swift
public class img : tag { 
  override public var isSelfClosing: Bool { 
    return true
  } 
}
```
  thank you @Evertt for [#6](https://github.com/sahandnayebaziz/Hypertext/pull/6) 
- Initializing a tag with both attributes and children is easier. The order of attributes and children has been flipped so that you can set the attributes first and then set the children off the end of the initializer. Initializing a tag with both attributes and children now looks like:
```swift
p(["class": "greeting"]) { "Well hello there..." }
```
  thank you @Evertt for [#10](https://github.com/sahandnayebaziz/Hypertext/pull/10) 
- Anything that is `Renderable` now also conforms to `CustomStringConvertible` so you can print and use `tag` subclasses and your own `Renderable` types in String outputs and see them rendered automatically.

thank you @Evertt for [#9](https://github.com/sahandnayebaziz/Hypertext/pull/9)/[#17](https://github.com/sahandnayebaziz/Hypertext/pull/17)

- The `Renderable` protocol's method for rendering formatted, indented HTML has a new signature takes an integer value that lets you specify the number of spaces to use when indenting. 

```swift
func render(startingWithSpaces: Int, indentingWithSpaces: Int) -> String
```

thank you @Evertt for [#9](https://github.com/sahandnayebaziz/Hypertext/pull/9)/[#18](https://github.com/sahandnayebaziz/Hypertext/pull/18)

#### Added
- A new class called `doctype` that can be used to render the most common HTML doctypes. To render a doctype: 
```swift
doctype(.html5).render()

// used in context
let document: Renderable = [
    doctype(.html5),
    html {[
        head {
            title { "Hello there" }
        },
        body { "blabla" }
    ]}
]
```

thank you @Evertt for [#16](https://github.com/sahandnayebaziz/Hypertext/pull/16)

---

## [1.0.1](https://github.com/sahandnayebaziz/Hypertext/releases/tag/1.0.1)
October 31st, 2016

#### Fixed
- `attributes` being optional, even though it was being initialized to an empty dictionary. It is now guaranteed to be there and still initialized empty. thank you @Evertt for [#7](https://github.com/sahandnayebaziz/Hypertext/pull/7) 

#### Updated
- code around rendering `children` in `tag` to use the nil-coalescing operator. thank you @Evertt for [#7](https://github.com/sahandnayebaziz/Hypertext/pull/7) 
