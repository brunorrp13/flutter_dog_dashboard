# 🐾 Flutter Dog Dashboard

A feature-rich Flutter app for managing dogs and their owners. Track dog info, owner details, and photos, with a clean and interactive UI built with Riverpod and Hive.

---

## 📦 Features

🐶 Dog Management

Add, edit, and delete dogs

Track dog name, photo, and country of origin

👤 Owner Management

Add, edit, and delete owner names and photos

Inline editing with TextFields and edit/save buttons

📸 Photo Integration

Select dog photos from a modal

Capture owner photos via camera

🌍 Country Selector

Dropdown to select dog’s country of origin (fetched from GraphQL API)

💾 Persistence

Store dog and owner data locally using Hive

🔄 Reset & Refresh

Reset form fields with a refresh button

Real-time updates reflected in the UI

🧪 Error Handling

Input validation with inline error messages

🔧 Tech Stack
Area	Package / Technology
State Mgmt	Riverpod

Local Storage	Hive

Camera	camera

GraphQL	graphql_flutter

UI	Material Design, Responsive Layouts

---
## 📱 Screenshots
<img width="409" height="885" alt="image" src="https://github.com/user-attachments/assets/293ea63b-1cbe-4dbb-8587-0d5a29347ba5" />
<img width="409" height="885" alt="image" src="https://github.com/user-attachments/assets/c29286ee-ce66-4884-b6b2-b70ab8f0c64a" />

---

## 🚀 Getting Started
1. Prerequisites

Flutter 3.10+

Dart 3.x

Android/iOS emulator or real device with camera

2. Install Dependencies
flutter pub get

3. Run the App
flutter run

📝 Notes

Dog and owner photos are persisted locally.

You can reset form fields with the refresh button.

Inline editing ensures a smooth experience for updating dog and owner info.

Error messages guide users for required fields like dog name, owner name, photos, and country selection.# flutter_dog_dashboard
