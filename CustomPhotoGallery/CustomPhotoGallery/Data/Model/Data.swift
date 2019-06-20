/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

struct Data: Codable {
	let id: String?
    let title: String?
	let description: String?
	let datetime: Int?
	let type: String?
	let animated: Bool?
	let width: Int?
	let height: Int?
	let size: Int?
	let views: Int?
    let bandwidth: Int?
	let vote: String?
	let favorite: Bool?
	let nsfw: String?
	let section: String?
	let account_url: String?
	let account_id: Int?
	let is_ad: Bool?
	let in_most_viral: Bool?
	let tags: [String]?
	let ad_type: Int?
	let ad_url: String?
	let in_gallery: Bool?
	let deletehash: String?
	let name: String?
	let link: String?

	enum CodingKeys: String, CodingKey {
		case id
		case title
		case description
		case datetime
		case type
		case animated
		case width
		case height
		case size
		case views
		case bandwidth
		case vote
		case favorite
		case nsfw
		case section
		case account_url
		case account_id
		case is_ad
		case in_most_viral
		case tags
		case ad_type
		case ad_url
		case in_gallery
		case deletehash
		case name
		case link
	}
}
