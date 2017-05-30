/*
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ExploreVenueResponse {
	public var suggestedFilters : SuggestedFilters?
	public var suggestedRadius : Int?
	public var headerLocation : String?
	public var headerFullLocation : String?
	public var headerLocationGranularity : String?
	public var query : String?
	public var totalResults : Int?
	public var suggestedBounds : SuggestedBounds?
	public var groups : Array<Group>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let response_list = Response.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Response Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [ExploreVenueResponse]
    {
        var models:[ExploreVenueResponse] = []
        for item in array
        {
            models.append(ExploreVenueResponse(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let response = Response(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Response Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["suggestedFilters"] != nil) { suggestedFilters = SuggestedFilters(dictionary: dictionary["suggestedFilters"] as! NSDictionary) }
		suggestedRadius = dictionary["suggestedRadius"] as? Int
		headerLocation = dictionary["headerLocation"] as? String
		headerFullLocation = dictionary["headerFullLocation"] as? String
		headerLocationGranularity = dictionary["headerLocationGranularity"] as? String
		query = dictionary["query"] as? String
		totalResults = dictionary["totalResults"] as? Int
		if (dictionary["suggestedBounds"] != nil) { suggestedBounds = SuggestedBounds(dictionary: dictionary["suggestedBounds"] as! NSDictionary) }
		if (dictionary["groups"] != nil) { groups = Group.modelsFromDictionaryArray(array: dictionary["groups"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.suggestedFilters?.dictionaryRepresentation(), forKey: "suggestedFilters")
		dictionary.setValue(self.suggestedRadius, forKey: "suggestedRadius")
		dictionary.setValue(self.headerLocation, forKey: "headerLocation")
		dictionary.setValue(self.headerFullLocation, forKey: "headerFullLocation")
		dictionary.setValue(self.headerLocationGranularity, forKey: "headerLocationGranularity")
		dictionary.setValue(self.query, forKey: "query")
		dictionary.setValue(self.totalResults, forKey: "totalResults")
		dictionary.setValue(self.suggestedBounds?.dictionaryRepresentation(), forKey: "suggestedBounds")

		return dictionary
	}

}
