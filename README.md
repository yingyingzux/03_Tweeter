# Project 3 - *Tweeter*

**Tweeter** is a basic twitter app to read and compose tweets from the [Twitter API](https://apps.twitter.com/).

Time spent: **25.5** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow.
- [x] User can view last 20 tweets from their home timeline.
- [x] The current signed in user will be persisted across restarts.
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting should increment the retweet and favorite count. **--Yingying: works well on details page, but wasn't able to get row number on cells in tweet list page**'
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. **--Yingying: only did unfavorite**
- [ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client. **--Yingying: half-baked.. keep hitting rate limit with this**

The following **additional** features are implemented:

- [x] Display "Name Retweeted" on top of the tweet content in home timeline just like the way Twitter does.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. App permission seems weird. I made it "read and write" in the beginning and it didn't let me post new tweet. After changed to Read, write and access direct message, then I can. I think this may be due to not logout or clean Simulator sessions.sss
2. There's no reply_count in tweet JSON that we retrieve back, but it exists in the Tweet Object on the Twitter dev site.
3. I had a hard time getting the row number out of clicked cell.
4. I got a 404 for retweet func, I checked all places and not sure why it was not working. I think it should be very similar to how the favorite func was written.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://raw.githubusercontent.com/yzhanghearsay/03_Tweeter/master/03%20Tweeter/tweeter.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://raw.githubusercontent.com/yzhanghearsay/03_Tweeter/master/03%20Tweeter/tweeter-additional.png' title='screenshot' width='686' alt='screenshot'>

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

Copyright [2017] [Yingying Zhang]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
