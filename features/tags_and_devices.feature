Feature: Tags and devices
Jive with the server, BABE!

Scenario: Pair device
When I have a device with id "xyzw" and a tag "abcd"
Then I HTTP PUT to http://sniffit.heroku.com/api/xyzw/linked_to/abcd

Scenario: Lost link
When I have a device with id "xyzw" and a paired tag "abcd"
And I lose the link to the tag
And the user confirms that the tag is lost
Then I HTTP PUT to http://sniffit.heroku.com/api/xyzw/lost_link_to/abcd

Scenario: Pick up broadcast
When I have a device located at 40.123, 60.123
And I pick up a broadcast from a tag with id "abcd"
Then I HTTP PUT to http://sniffit.heroku.com/api/abcd/found_at/40.123,60.123

Scenario: Ask server for lost tag (which has not yet been found)
When I have a device with id "xyzw" and a paired tag "abcd"
And I've lost the link to the tag
Then I poll HTTP GET http://sniffit.heroku.com/api/lost_tags/abcd
And I get a 404

Scenario: Ask server for lost tag (which has been found)
When I have a device with id "xyzw" and a paired tag "abcd"
And I've lost the link to the tag
And somebody does an HTTP PUT to http://sniffit.heroku.com/api/device_at/40.123/60.123/found/abcd
Then I poll HTTP GET http://sniffit.heroku.com/api/lost_tags/abcd
And I get a 200
And I see the geospatial data of the lost device in the response
