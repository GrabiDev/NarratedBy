#  Narrated By, or CoCoApp (Confetti Companion App)
macOS and iOS front-end for [FakeYou](https://fakeyou.com/) service.
Also my first Swift app, SwiftUI app, and my first mobile app.

## Origin
Once upon a time, roughly around Halloween 2022, the author of this app was going to a party.

A bit unusual, but this is what it was.

For the longest time, he did not know what to dress as for the party.
But one day, he was watching a BBC nature documentary and realised he should dress as a bird.

However, just dressing up as something is not enough, thought the author.
To provide full experience, he realised he needs someone to speak out for him in this warming world.

The bird needs a narrator.
And who is better at it than Sir David Attenborough?

The research into voice cloning started and due to the lack of time, an existing online solution from FakeYou has been selected rather than creating an AI model from scratch.
However to make it a smooth party experience, an easy way to access and generate inferences had to be found.

This was the push that made this app happen.

## Technical information
The app compiles as is on macOS Monterey (and probably Ventura too, not tested) and iOS 16.

The app provides the same functionality across platforms.
History of inferences persist app shutdowns.

Internet connection is required at all times.
Links to inferences are saved on the device, but the audio files are read from FakeYou storage.

All voice options, including the non-English language ones, will be fetched on app startup.
Languages are not being filtered at this point.
Finding the right voice a bit hard to navigate, but for the purpose of this app, it was not an MVP requirement.

Developed purely in XCode.

## Notes
This project is no longer maintained or developed.
