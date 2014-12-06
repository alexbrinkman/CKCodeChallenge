CK DEV PROJECT README
=====================

At a minimum, use Ruby 2.0, Rails 4.1,  SQL DB of your choice.

This app uses the Rotten Tomatoes API and presents 3 pages (see attachments).
		1) Welcome/Home
		2) Last Weekend's Box Office Results
		3) Future Box Office Rankings


Demonstrate use of API
-----------------------

You will need:
Rotten Tomatoes API key and account (to view their docs).  If you do not have an account, use this one, which goes through Mashery.com:

 login url: https://secure.mashery.com/login/developer.rottentomatoes.com/
	username: ckrusssch
	password: i7PNH1flziMx
		APIKEY: bbbv6grs52qsvyerxqstj7zr

	NOTE: You're limited to 5 requests per second and 10000 per day. You don't need to write code to enforce these limits, but please don't exceed them  ;-)


TASKS
-----

__Get, Save and Display last weekend's box office__
Using the (http://developer.rottentomatoes.com "Rotten Tomatoes API"), get the top N movies for this week's box office and present them on a page.  "N" should be a dropdown list of (5,10,15,20,25) defaulting to 10.

Validate that N is within range.

Save the data to DB table(s). The schema is up to you, but minimally, persist these API data elements:
poster thumbnail (url)
title
year
mpaa_rating
critics rating
critics score
audience_rating
audience_score
link to movie details
link_to reviews

Display the box office results page. See attached example. It's not necessary to reproduce this layout verbatim, but you must include all the displayed elements. Use http://developer.rottentomatoes.com/docs/read/Brand_Guidelines "Tomatoes Display Guidelines" to indicate critic and audience scores and show images. That also means follow their guidelines re: image sizes (you can ignore linkbacks).



__Create sample Box Office Data__
Create 3 weeks of [possible] future box office data by adjusting the ranking of the movies. A simple random number (within range and unique) is fine. Present the box office results in a table adding columns for last weekend's ranking and 3 future weeks.  The table should contain at a minimum, title, 3 future weeks rankings.  See attached example.



__Other considerations__

Auth/Auth (authentication/authorization) is not necessary.

CSS, HTML, and Test code are equal parts of your solution code.

Error Handling and reporting (demo logging if you have time).

Timeout for external requests.

Navigation.

Example pages are not necessarily complete solutions. Make adjustments as you see fit. (This is not a tricky statement. Change them or not. Both are fine.)

This effort is intended to provide CK staff, with actual code. Your solution to a problem. We're interested in its thoroughness accuracy, and general style. The problem is simple. It's not a logic test, client interaction test, or anything tricky. Just implement a solution as you normally would and get it back to us. You can ask us questions (thru email), but feel free to fill-in missing ideas on your own. Again, it's about code.

__Delivery__
You can deliver your solution to us via a github project, an email attachemnt, or other means that require very minimal effort for us to unpack, view the source and execute your app. (Most of us at CK use Macs)

Questions and delivery should be sent to:
russ@commercekitchen.com
ack@commercekitchen.com


