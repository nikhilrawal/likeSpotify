# Spotify Clone App

This project is a Spotify-like music streaming application built using Flutter. It features a highly appealing UI with various screens and functionalities. The app integrates with Firebase for backend services, including authentication and data fetching. It maintains state using the Bloc pattern and follows a clean Flutter architecture.

## Features

- **Appealing UI**: The app has a visually appealing user interface with smooth animations and transitions.
- **Multiple Screens**: The app includes various screens such as Home, Profile, Song Player, Authentication, and more.
- **Authentication**: Users can sign up, sign in, and manage their profiles using Firebase Authentication.
- **State Management**: The app uses the Bloc pattern for state management, ensuring a predictable and maintainable state.
- **Firebase Integration**: The app fetches data from Firebase Firestore and uses Firebase Storage for storing media files.
- **Clean Architecture**: The project follows a clean architecture, making it easy to scale and maintain.
- **Song Playback**: Users can play, pause, and skip songs.
- **Favorites**: Users can add songs to their favorites.

## Video Demonstration

Watch the video demonstration of the app to see it in action:

[SpotifyApp Video Demonstration](https://vimeo.com/1049101254/5cb85d5539)

## Screenshots

<div style="display: flex; flex-wrap: wrap; gap: 10px; justify-content: space-between;">
  <img src="assets/spotisc/01.jpg" alt="Screenshot 1" width="240" height="500">
  <img src="assets/spotisc/02.jpg" alt="Screenshot 2" width="240" height="500">
  <img src="assets/spotisc/03.jpg" alt="Screenshot 3" width="240" height="500">
  <img src="assets/spotisc/04.jpg" alt="Screenshot 4" width="240" height="500">
  <img src="assets/spotisc/05.jpg" alt="Screenshot 5" width="240" height="500">
  <img src="assets/spotisc/06.jpg" alt="Screenshot 6" width="240" height="500">
</div>

## Workflow

1. **User Authentication**: 
   - Users can sign up or log in using their email and password.
   - Firebase Authentication handles the authentication process.

2. **Home Screen**:
   - Displays a list of recommended songs and playlists.
   - Users can browse through different categories and genres.

3. **Song Player**:
   - Users can play, pause, and skip songs.
   - The player displays song details and album art.

4. **State Management**:
   - The app uses the Bloc pattern to manage the state of the application.
   - Ensures a predictable and maintainable state throughout the app.

5. **Data Fetching**:
   - The app fetches data from Firebase Firestore for songs, playlists, and user information.
   - Firebase Storage is used for storing and retrieving media files.

6. **Clean Architecture**:
   - The project follows a clean architecture, separating the UI, business logic, and data layers.
   - Makes the codebase easy to maintain and scale.

## Technologies Used

- **Flutter**: The framework used for building the app.
- **Dart**: The programming language used with Flutter.
- **Firebase Authentication**: For user authentication.
- **Firebase Firestore**: For storing and retrieving data.
- **Firebase Storage**: For storing media files.
- **Bloc Pattern**: For state management.
- **Provider**: For dependency injection.
- **HTTP**: For making network requests.
- **Equatable**: For value equality in Dart objects.
- **Flutter Widgets**: For building the UI components.