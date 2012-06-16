Feature: Tags and devices
Jive with the server, BABE!

Scenario: Pair device
When I have a device that wants to link to a tag "abcd"
Then I HTTP PUT to /api/abcd/linked

Scenario: Lost link
When I have a device linked to a tag "abcd"
And I lose sight of the tag at 40.123,60.123
And the user confirms that the tag is lost
Then I HTTP PUT to /api/abcd/lost_at/40.123,60.123

Scenario: Pick up broadcast
When I have a device located at 40.123,60.123
And I pick up a broadcast from a tag with id "abcd"
Then I HTTP PUT to /api/abcd/found_at/40.123,60.123

Scenario: Ask server for lost tag (which has not yet been found)
When I have a device linked to a tag "abcd"
And I've lost sight of the tag at 40.123,60.123
Then I poll HTTP GET /api/lost_tags/abcd
And I get a 404

Scenario: Ask server for lost tag (which has been found)
When I have a device linked to a tag "abcd"
And I've lost sight of the tag at 40.123,60.123
And somebody does an HTTP PUT to /api/abcd/found_at/40.123,60.123
Then I poll HTTP GET /api/lost_tags/abcd
And I get a 200
And I see the geospatial data of the lost device in the response
