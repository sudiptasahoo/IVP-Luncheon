/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class BestPhoto {
	public var id : String?
	public var createdAt : Int?
	public var source : Source?
	public var prefix : String?
	public var suffix : String?
	public var width : Int?
	public var height : Int?
	public var visibility : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let bestPhoto_list = BestPhoto.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of BestPhoto Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [BestPhoto]
    {
        var models:[BestPhoto] = []
        for item in array
        {
            models.append(BestPhoto(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let bestPhoto = BestPhoto(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: BestPhoto Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		createdAt = dictionary["createdAt"] as? Int
		if (dictionary["source"] != nil) { source = Source(dictionary: dictionary["source"] as! NSDictionary) }
		prefix = dictionary["prefix"] as? String
		suffix = dictionary["suffix"] as? String
		width = dictionary["width"] as? Int
		height = dictionary["height"] as? Int
		visibility = dictionary["visibility"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.createdAt, forKey: "createdAt")
		dictionary.setValue(self.source?.dictionaryRepresentation(), forKey: "source")
		dictionary.setValue(self.prefix, forKey: "prefix")
		dictionary.setValue(self.suffix, forKey: "suffix")
		dictionary.setValue(self.width, forKey: "width")
		dictionary.setValue(self.height, forKey: "height")
		dictionary.setValue(self.visibility, forKey: "visibility")

		return dictionary
	}

}