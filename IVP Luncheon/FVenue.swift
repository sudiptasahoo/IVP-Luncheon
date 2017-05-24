/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class FVenue {
	public var id : String?
	public var name : String?
	public var contact : Contact?
	public var location : Location?
	public var categories : Array<Categories>?
	public var verified : String?
	public var stats : Stats?
	public var beenHere : BeenHere?
	public var specials : Specials?
	public var hereNow : HereNow?
	public var referralId : String?
	public var venueChains : Array<String>?
	public var hasPerk : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [FVenue]
    {
        var models:[FVenue] = []
        for item in array
        {
            models.append(FVenue(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		if (dictionary["contact"] != nil) { contact = Contact(dictionary: dictionary["contact"] as! NSDictionary) }
		if (dictionary["location"] != nil) { location = Location(dictionary: dictionary["location"] as! NSDictionary) }
		if (dictionary["categories"] != nil) { categories = Categories.modelsFromDictionaryArray(dictionary["categories"] as! NSArray) }
		verified = dictionary["verified"] as? String
		if (dictionary["stats"] != nil) { stats = Stats(dictionary: dictionary["stats"] as! NSDictionary) }
		if (dictionary["beenHere"] != nil) { beenHere = BeenHere(dictionary: dictionary["beenHere"] as! NSDictionary) }
		if (dictionary["specials"] != nil) { specials = Specials(dictionary: dictionary["specials"] as! NSDictionary) }
		if (dictionary["hereNow"] != nil) { hereNow = HereNow(dictionary: dictionary["hereNow"] as! NSDictionary) }
		referralId = dictionary["referralId"] as? String
		if (dictionary["venueChains"] != nil) { venueChains = VenueChains.modelsFromDictionaryArray(dictionary["venueChains"] as! NSArray) }
		hasPerk = dictionary["hasPerk"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.contact?.dictionaryRepresentation(), forKey: "contact")
		dictionary.setValue(self.location?.dictionaryRepresentation(), forKey: "location")
		dictionary.setValue(self.verified, forKey: "verified")
		dictionary.setValue(self.stats?.dictionaryRepresentation(), forKey: "stats")
		dictionary.setValue(self.beenHere?.dictionaryRepresentation(), forKey: "beenHere")
		dictionary.setValue(self.specials?.dictionaryRepresentation(), forKey: "specials")
		dictionary.setValue(self.hereNow?.dictionaryRepresentation(), forKey: "hereNow")
		dictionary.setValue(self.referralId, forKey: "referralId")
		dictionary.setValue(self.hasPerk, forKey: "hasPerk")

		return dictionary
	}

}
