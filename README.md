# Project 4 - *Tweeter*

Time spent: **17** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Hamburger menu
- [x] Dragging anywhere in the view should reveal the menu.
- [x] The menu should include links to your profile, the home timeline, and the mentions view.
- [x] The menu can look similar to the example or feel free to take liberty with the UI.
- [x] Profile page
- [x] Contains the user header view
- [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline
- [x] Tapping on a user image should bring up that user's profile page

The following **optional** features are implemented:

- [ ] Profile Page
- [ ] Implement the paging view for the user description.
- [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
- [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
- [ ] Long press on tab bar to bring up Account view with animation
- [ ] Tap account to switch to
- [x] Include a plus button to Add an Account **Yingying: half baked.. can display login screen but not able to add a new account"
- [ ] Swipe to delete an account


The following **additional** features are implemented:

- [X] Display current user on top of menu

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. iOS Simulator suddenly didn't take any clicks. Had to restart XCode several times, clean projects and force quit Xcode again. Finally worked but I had no idea how I fixed it..
2. XCode treats auto layout in a weird way. Adding any constraint made that view stick to top left. I solved it this time by removing the cell completely and adding all views from scratch.
3. If I want to click on an image to perform segue, I need to add a tap gesture recognizer. Because there are many table view cells, I need an array of tap recognizers to capture the tap action. Image user interaction needs to be enabled.
4. Spent quite a long time trying to figure how to pass User object from Home Timeline to Profile page, and realized I can get user info from tweets.


## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/yzhanghearsay/03_Tweeter/blob/master/03%20Tweeter/tweeter-redux.gif?raw=true' title='Video Walkthrough' width='' alt='Video Walkthrough' />

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
