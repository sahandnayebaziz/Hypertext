# Changelog

## [1.0.1](https://github.com/sahandnayebaziz/Hypertext/releases)
October 31st, 2016

#### Fixed
- `attributes` being optional, even though it was being initialized to an empty dictionary. It is now guaranteed to be there and still initialized empty. thank you @Evertt for [#7](https://github.com/sahandnayebaziz/Hypertext/pull/7) 

#### Updated
- code around rendering `children` in `tag` to use the nil-coalescing operator. thank you @Evertt for [#7](https://github.com/sahandnayebaziz/Hypertext/pull/7) 
