# PlanGPT

PlanGPT is an intinerary generator app which helps poeple plan and get the most ouf of their road trips

---

### Team names and roles

David Yang:<br />
- SwiftUI developer
- SwiftUI expert
- Mapkit expert
- Prompt Engineer
- Animation engineer

Kevin Gager<br />
- SwiftUI developer
- Firebase auth expert
- Prompt Engineer

Note: Due to a GitHub classroom login error, Garrett Miller is shown to be a part of the group. This is a mistake and Kevin is actually supposed to be there instead.

Matthew Martel<br />
- SwiftUI developer
- Graphic designer for App Icon
- API Expert, prompt engineer

Lucian Prinz<br />
- SwiftUI developer
- Firebase firestore expert
- Firebase auth expert
- Prompt Engineer

### Audience and their needs

Our audience was people who like to take road trips, explore new places, and try new things along the way.

### App Screenshots/Video/Demo

##### App Demo

https://user-images.githubusercontent.com/56782878/235765472-c2c83646-958a-4a0d-948f-61745e97ee2a.mp4



### Technology Highlights

- Utilized the OpenAI chat completion API with the gpt-3.5-turbo model in order to generate our route.
- Used FirebaseAuth to allow users to sign in using their Google account
- Used FirebaseFirestore to allow users to store and view their saved trips
- Utilized Apple's MapKit to provide a visual display of the route to the user with markers along the way


### Known Bugs

- Since we are asking OpenAI to return JSON data, sometimes it diverges from the prompt or says that it is unable to do the task. This is rare, but in case it happens we want it to be known that we are aware of it. This will likely result in a parse error which we handle and display to the user.

- There is a warning about modifying the state during view update which is casued by the MapView.swift file when updating the mapRegion. We researched it and couldn't find a reliable fix, and it also doesn't occur on all of our laptops so we are putting it as a known bug (even though its just a warning).

- This isn't really a bug but the AI will sometimes plan a route that goes off too far in one direction that doesn't always make sense. We have spent hours trying to engineer the prompt and we have it as best as we can. This is to be expected when dealing with generative models.


### Acknowledgements
- Professor Dondi
- OpenAI
- HackingWithSwift
