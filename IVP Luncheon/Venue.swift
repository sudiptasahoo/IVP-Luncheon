/*
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Venue {
	public var id : String?
	public var name : String?
	public var contact : Contact?
	public var location : Location?
	public var canonicalUrl : String?
	public var categories : Array<Categories>?
	public var verified : String?
	public var stats : Stats?
	public var url : String?
	public var price : Price?
	public var hasMenu : String?
	public var likes : Likes?
	public var dislike : String?
	public var ok : String?
	public var rating : Double?
	public var ratingColor : String?
	public var ratingSignals : Int?
	public var menu : Menu?
	public var allowMenuUrlEdit : String?
	public var beenHere : BeenHere?
	public var specials : Specials?
	public var photos : Photos?
	public var venuePage : VenuePage?
	public var reasons : Reasons?
	public var page : Page?
	public var hereNow : HereNow?
	public var createdAt : Int?
	public var tips : Tips?
	public var tags : Array<String>?
	public var shortUrl : String?
	public var timeZone : String?
	public var listed : Listed?
	public var phrases : Array<Phrases>?
	public var hours : Hours?
	public var popular : Popular?
	public var pageUpdates : PageUpdates?
	public var inbox : Inbox?
	public var venueChains : Array<String>?
	public var attributes : Attributes?
	public var bestPhoto : BestPhoto?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let venue_list = Venue.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Venue Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Venue]
    {
        var models:[Venue] = []
        for item in array
        {
            models.append(Venue(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let venue = Venue(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Venue Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		if (dictionary["contact"] != nil) { contact = Contact(dictionary: dictionary["contact"] as! NSDictionary) }
		if (dictionary["location"] != nil) { location = Location(dictionary: dictionary["location"] as! NSDictionary) }
		canonicalUrl = dictionary["canonicalUrl"] as? String
		if (dictionary["categories"] != nil) { categories = Categories.modelsFromDictionaryArray(array: dictionary["categories"] as! NSArray) }
		verified = dictionary["verified"] as? String
		if (dictionary["stats"] != nil) { stats = Stats(dictionary: dictionary["stats"] as! NSDictionary) }
		url = dictionary["url"] as? String
		if (dictionary["price"] != nil) { price = Price(dictionary: dictionary["price"] as! NSDictionary) }
		hasMenu = dictionary["hasMenu"] as? String
		if (dictionary["likes"] != nil) { likes = Likes(dictionary: dictionary["likes"] as! NSDictionary) }
		dislike = dictionary["dislike"] as? String
		ok = dictionary["ok"] as? String
		rating = dictionary["rating"] as? Double
		ratingColor = dictionary["ratingColor"] as? String
		ratingSignals = dictionary["ratingSignals"] as? Int
		if (dictionary["menu"] != nil) { menu = Menu(dictionary: dictionary["menu"] as! NSDictionary) }
		allowMenuUrlEdit = dictionary["allowMenuUrlEdit"] as? String
		if (dictionary["beenHere"] != nil) { beenHere = BeenHere(dictionary: dictionary["beenHere"] as! NSDictionary) }
		if (dictionary["specials"] != nil) { specials = Specials(dictionary: dictionary["specials"] as! NSDictionary) }
		if (dictionary["photos"] != nil) { photos = Photos(dictionary: dictionary["photos"] as! NSDictionary) }
		if (dictionary["venuePage"] != nil) { venuePage = VenuePage(dictionary: dictionary["venuePage"] as! NSDictionary) }
		if (dictionary["reasons"] != nil) { reasons = Reasons(dictionary: dictionary["reasons"] as! NSDictionary) }
		if (dictionary["page"] != nil) { page = Page(dictionary: dictionary["page"] as! NSDictionary) }
		if (dictionary["hereNow"] != nil) { hereNow = HereNow(dictionary: dictionary["hereNow"] as! NSDictionary) }
		createdAt = dictionary["createdAt"] as? Int
		if (dictionary["tips"] != nil) { tips = Tips(dictionary: dictionary["tips"] as! NSDictionary) }
		if (dictionary["tags"] != nil) { tags = dictionary["tags"] as! Array<String> }
		shortUrl = dictionary["shortUrl"] as? String
		timeZone = dictionary["timeZone"] as? String
		if (dictionary["listed"] != nil) { listed = Listed(dictionary: dictionary["listed"] as! NSDictionary) }
		if (dictionary["phrases"] != nil) { phrases = Phrases.modelsFromDictionaryArray(array: dictionary["phrases"] as! NSArray) }
		if (dictionary["hours"] != nil) { hours = Hours(dictionary: dictionary["hours"] as! NSDictionary) }
		if (dictionary["popular"] != nil) { popular = Popular(dictionary: dictionary["popular"] as! NSDictionary) }
		if (dictionary["pageUpdates"] != nil) { pageUpdates = PageUpdates(dictionary: dictionary["pageUpdates"] as! NSDictionary) }
		if (dictionary["inbox"] != nil) { inbox = Inbox(dictionary: dictionary["inbox"] as! NSDictionary) }
		//key missing
        //if (dictionary["venueChains"] != nil) { venueChains = VenueChains.modelsFromDictionaryArray(dictionary["venueChains"] as! NSArray) }
		if (dictionary["attributes"] != nil) { attributes = Attributes(dictionary: dictionary["attributes"] as! NSDictionary) }
		if (dictionary["bestPhoto"] != nil) { bestPhoto = BestPhoto(dictionary: dictionary["bestPhoto"] as! NSDictionary) }
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
		dictionary.setValue(self.canonicalUrl, forKey: "canonicalUrl")
		dictionary.setValue(self.verified, forKey: "verified")
		dictionary.setValue(self.stats?.dictionaryRepresentation(), forKey: "stats")
		dictionary.setValue(self.url, forKey: "url")
		dictionary.setValue(self.price?.dictionaryRepresentation(), forKey: "price")
		dictionary.setValue(self.hasMenu, forKey: "hasMenu")
		dictionary.setValue(self.likes?.dictionaryRepresentation(), forKey: "likes")
		dictionary.setValue(self.dislike, forKey: "dislike")
		dictionary.setValue(self.ok, forKey: "ok")
		dictionary.setValue(self.rating, forKey: "rating")
		dictionary.setValue(self.ratingColor, forKey: "ratingColor")
		dictionary.setValue(self.ratingSignals, forKey: "ratingSignals")
		dictionary.setValue(self.menu?.dictionaryRepresentation(), forKey: "menu")
		dictionary.setValue(self.allowMenuUrlEdit, forKey: "allowMenuUrlEdit")
		dictionary.setValue(self.beenHere?.dictionaryRepresentation(), forKey: "beenHere")
		dictionary.setValue(self.specials?.dictionaryRepresentation(), forKey: "specials")
		dictionary.setValue(self.photos?.dictionaryRepresentation(), forKey: "photos")
		dictionary.setValue(self.venuePage?.dictionaryRepresentation(), forKey: "venuePage")
		dictionary.setValue(self.reasons?.dictionaryRepresentation(), forKey: "reasons")
		dictionary.setValue(self.page?.dictionaryRepresentation(), forKey: "page")
		dictionary.setValue(self.hereNow?.dictionaryRepresentation(), forKey: "hereNow")
		dictionary.setValue(self.createdAt, forKey: "createdAt")
		dictionary.setValue(self.tips?.dictionaryRepresentation(), forKey: "tips")
		dictionary.setValue(self.shortUrl, forKey: "shortUrl")
		dictionary.setValue(self.timeZone, forKey: "timeZone")
		dictionary.setValue(self.listed?.dictionaryRepresentation(), forKey: "listed")
		dictionary.setValue(self.hours?.dictionaryRepresentation(), forKey: "hours")
		dictionary.setValue(self.popular?.dictionaryRepresentation(), forKey: "popular")
		dictionary.setValue(self.pageUpdates?.dictionaryRepresentation(), forKey: "pageUpdates")
		dictionary.setValue(self.inbox?.dictionaryRepresentation(), forKey: "inbox")
		dictionary.setValue(self.attributes?.dictionaryRepresentation(), forKey: "attributes")
		dictionary.setValue(self.bestPhoto?.dictionaryRepresentation(), forKey: "bestPhoto")

		return dictionary
	}

}
