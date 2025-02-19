# Recipe App

This is a SwiftUI-based recipe app that displays a list of recipes fetched from a remote API. The app uses MVVM architecture and leverages modern Swift concurrency with async/await. Unit tests have been written to ensure robustness in key areas, including networking, repository handling, and view model logic.

Steps to Run the App

## Open the Project:
	•	Open the .xcodeproj file in Xcode.	
 
 ## Run the App:
	•	Select your target simulator (or physical device).
	•	Press Cmd + R to build and run the app.
 ## Run Tests:
	•	To run the unit tests, press Cmd + U or go to Product > Test in the menu bar.

🎯 Focus Areas

Prioritized Areas
	1.	Efficient Networking & Caching
	•	Used Swift Concurrency (async/await) for non-blocking API calls.
	•	Implemented manual disk caching for images to reduce network bandwidth.
	2.	Clean MVVM Architecture with Dependency Injection
	•	Separated Networking, Repository, ViewModel, and View layers for testability.
	•	Used protocol-based dependency injection (DI) for mocking in unit tests.
	3.	Error Handling & Resilience
	•	Handled empty/malformed responses gracefully.
	•	Displayed loading indicators and appropriate error messages.
	4.	Unit Testing for Core Logic
	•	Validated API response handling.
	•	Ensured image caching works efficiently.
	•	Used mocking for network calls to prevent unnecessary API hits.

✅ Why these areas?
These are crucial for building a scalable, efficient, and testable SwiftUI app.


## Time Spent

I spent approximately 4 - 5 hours on this project. Here’s how the time was allocated:

	•	Setup & Architecture Planning
	•	Implementing the Core Features
	•	Network Layer
	•	Repository
	•	ViewModel
    •   ImageCache   
	•	SwiftUI Views
	•	Writing Unit Tests
	•	Final Testing & Debugging

⚖️ Trade-offs & Decisions

Key Trade-offs:
	1.	Image Loading & Caching Approach
✅ Chose manual disk caching (FileManager + NSCache) over URLCache
❌ Trade-off: More implementation complexity but greater control over cache expiration.
	2.	No Third-Party Libraries
✅ Chose pure SwiftUI + URLSession for networking
❌ Trade-off: Missing SDWebImageSwiftUI or Kingfisher for smoother image handling.
	3.	Focus on Core Features Over Animations
✅ Prioritized caching, networking, and error handling
❌ Trade-off: Did not add extra SwiftUI animations or fancy UI effects.
	4.	Unit Tests Instead of UI Tests
✅ Mocked API responses to validate logic
❌ Trade-off: Skipped UI/Integration tests for simplicity.


📉 Weakest Part of the Project
    •    No Persistent Recipe Data:
❌ The app does not store recipes persistently (e.g., CoreData or Realm).
✅ Solution: If needed, we could cache the JSON response in UserDefaults or a local database.
    •    Basic UI Design:
❌ The UI follows a minimalist SwiftUI design.
✅ Solution: Could enhance UI with animations or filtering features.
    •    Cache Cleanup Not Implemented:
❌ Images are cached indefinitely without automatic cleanup.
✅ Solution: Add time-based cleanup logic for old images.



ℹ️ Additional Information
    1.    API Response Handling
    •    The app properly handles:
    •    ✅ Valid API Data
    •    ✅ Empty API Response
    •    ✅ Malformed JSON Errors
    2.    Possible Enhancements:
    •    🔹 Offline Mode – Store recipe data locally.
    •    🔹 Favorites Feature – Allow users to save recipes.
    •    🔹 Recipe Sorting & Search – Improve usability.
    3.    Lessons Learned
    •    Swift Concurrency is powerful but requires careful UI updates (@MainActor).
    •    Manual disk caching provides flexibility but requires proper cache management.

	•	Concurrency: Swift concurrency (async/await) was used to fetch data from the API, making it easier to handle network operations in a non-blocking manner.
	•	Scalability: The project is built with scalability in mind, especially the network service, which can be reused in other feature modules or future API endpoints.


🚀 Final Thoughts

✅ Built a scalable, testable Recipe App using SwiftUI, MVVM, and DI.
✅ Implemented efficient image caching without third-party dependencies.
✅ Handled API errors gracefully and wrote solid unit tests.


📸 Screenshots

