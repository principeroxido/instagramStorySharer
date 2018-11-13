# instagramStorySharer
Instagram Story Sharer contains the code for share image to Instagram Stories.

## Usage

The code contains methods for sharing the following contents:
+ Background image and sticker image
```swift
func shareToInstagramStories(backgroundImageName:String, stickerImageName:String, contentUrl:String?) -> NSError?
func shareToInstagramStories(backgroundImage:UIImage, stickerImage:UIImage, contentUrl:String?) -> NSError?     
```
+ Background video and sticker image
```swift
func shareToInstagramStories(backgroundVideoName:String, stickerImageName:String, contentUrl:String?) -> NSError?
func shareToInstagramStories(backgroundVideo:Data, stickerImage:Data, contentUrl:String?) -> NSError?     
```
+ Background gradient and sticker image
```swift
func shareToInstagramStories(topColor:UIColor, bottomColor:UIColor, stickerImageName:String, contentUrl:String?) -> NSError?
func shareToInstagramStories(topColorHexString:String, bottomColorHexString:String, stickerImage:Data, contentUrl:String?) -> NSError?    
```

## Tools
The code as one extension of UIColor to obtain the hex string to use in the background gradient methods
```swift
    var hex: String
```

Also there is a methot to obtain a view as image and use it as a sticker
```swift
   func asImage() -> UIImage
```