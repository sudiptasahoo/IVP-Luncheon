/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Hours {
	public var status : String?
	public var isOpen : String?
	public var isLocalHoliday : String?
	public var timeframes : Array<Timeframes>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let hours_list = Hours.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Hours Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Hours]
    {
        var models:[Hours] = []
        for item in array
        {
            models.append(Hours(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let hours = Hours(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Hours Instance.
*/
	required public init?(dictionary: NSDictionary) {

		status = dictionary["status"] as? String
		isOpen = dictionary["isOpen"] as? String
		isLocalHoliday = dictionary["isLocalHoliday"] as? String
		if (dictionary["timeframes"] != nil) { timeframes = Timeframes.modelsFromDictionaryArray(array: dictionary["timeframes"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.isOpen, forKey: "isOpen")
		dictionary.setValue(self.isLocalHoliday, forKey: "isLocalHoliday")

		return dictionary
	}

}
