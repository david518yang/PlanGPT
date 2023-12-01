# PlanGPT: Your AI-Powered Travel Companion
PlanGPT, a SwiftUI app, uses OpenAI's GPT-3.5-turbo to create personalized travel itineraries. Input your destinations and trip length, and get a detailed plan with an interactive map, daily local food and sightseeing suggestions, all savable in a Google Firebase Firestore database. Planning your next journey has never been easier!

## Description

PlanGPT is an innovative travel itinerary application, built using SwiftUI, that leverages the power of OpenAI's GPT-3.5-turbo model to create personalized trip plans. Designed for both casual tourists and avid travelers, this app simplifies the process of planning a journey from start to finish

The primary feature of PlanGPT is its ability to generate a detailed trip itinerary based on user inputs. Users start by specifying their start location, end destination, and the desired number of days for their trip. Once these details are provided, PlanGPT utilizes the advanced capabilities of the GPT-3.5-turbo API to craft a unique and comprehensive travel plan.

Each generated itinerary is visually represented through an interactive map, powered by Apple's MapKit. This map neatly displays all the planned locations and stops, offering users a clear and engaging overview of their journey. The map functionality enhances user experience by allowing them to visualize their route and explore their destinations before the trip begins.

For each day of the trip, PlanGPT provides a day card that includes a local eatery or restaurant for each day, ensuring travelers can enjoy the best culinary experiences the area has to offer, and a sightseeing attraction, allowing users to explore significant landmarks, cultural sites, or hidden gems.

A standout feature of PlanGPT is the ability to save planned itineraries. When a user decides to save a trip, the details are securely stored in a Google Firebase Firestore database. Each user has a specific folder in the database, ensuring their data is organized and easily retrievable. This feature is particularly useful for users who like to plan ahead or need to revisit their itineraries for future reference.

## Usage

1. Sign in with Google
2. Enter a start location, end destination, and the desired number of days of the trip
3. Click Plan Trip, and wait for the API to generate the trip
4. Click to View Trip, then see the route of the trip on a map, along with detailed date cards for each day, with a Food and Sightseeing destination for each day
5. Save Trip if desired, to store in a user-specific database on Firestore

## Acknowledgment

Professor Dondi Dionisio

## Features

- AI Itinerary Planning: Uses OpenAI's GPT-3.5-turbo for custom travel plans.
- Interactive Maps: Displays routes and stops via Apple's MapKit.
- Daily Activity Suggestions: Offers local food and sightseeing options.
- Save and Retrieve Trips: Stores itineraries in Google Firebase Firestore.
- User-Friendly Interface: Simple and intuitive design for easy navigation.

## Technology Highlights

- Front End in SwiftUI
- Utilized the OpenAI chat completion API with the gpt-3.5-turbo model in order to generate our route.
- Used FirebaseAuth to allow users to sign in using their Google account
- Used FirebaseFirestore to allow users to store and view their saved trips
- Utilized Apple's MapKit to provide a visual display of the route to the user with markers along the way


## Screenshots/Demo

#### App Demo
https://user-images.githubusercontent.com/56782878/235765472-c2c83646-958a-4a0d-948f-61745e97ee2a.mp4
