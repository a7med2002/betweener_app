# 🔗 Betweener App

A modern Flutter-based social networking app that allows users to share and manage their personal links through customizable profiles and scannable QR codes.  
Built with clean architecture, provider-based state management, and RESTful API integration.

---

## 📌 Project Overview

**Betweener** is a social platform designed for seamless connection through personalized link profiles.  
Each user has a unique account with editable links, a QR code for quick sharing, and the ability to discover and follow other users.

The app ensures smooth user experiences with persistent login, dynamic data updates, and responsive design optimized for all devices.

---

## 🧩 Tech Stack & Dependencies

- 🐦 **Flutter (Dart)** – Cross-platform app framework  
- 🧠 **Provider** – State management  
- 🌐 **HTTP** – REST API handling  
- 💾 **Shared Preferences** – Local persistence for user sessions  
- 📱 **QR Flutter** – QR code generation  
- ✉️ **Email Validator** – Email input validation  
- 🧩 **Flutter SVG** – Vector graphics and icons  
- 🔄 **Slidable** – Swipe actions for link management  
- 🎞️ **Lottie / Animated Assets** – Interactive animations 

---

## 🧱 Architecture

The project follows a **Provider-based architecture** with a clear separation of concerns:

| Layer | Description |
|--------|--------------|
| **Models** | Define data structures (User, Link, etc.) and handle JSON serialization/deserialization. |
| **Providers** | Manage application state (Auth, User, Links) using `ChangeNotifier` and the Provider package. |
| **Repositories** | Handle API communication (AuthRepository, UserRepository, LinkRepository). |
| **Core Helpers** | Contain reusable utilities such as constants, API responses, and shared preference helpers. |
| **Views (Features)** | Organized by functionality — includes Authentication, Home, Search, Profile, and Onboarding screens. |
| **Widgets** | Reusable UI components (buttons, form fields, link cards, etc.). |

---

## ✨ Core Features

- 🔐 **User Authentication**
  - Register & login with API integration  
  - Secure token storage using `SharedPreferences`  

- 👤 **User Profile**
  - Displays name, email, and QR code  
  - Auto-loads saved session data  

- 🔗 **Link Management**
  - Add, update, and delete custom links  
  - Real-time refresh after CRUD operations  

- 🔍 **User Search**
  - Search for other users by name  
  - View friend profiles and follow/unfollow  

- 🤝 **Follow System**
  - Follow/unfollow users dynamically  
  - Check follow status in real-time  

- 📸 **QR Code**
  - Generate and scan QR for quick profile sharing  

- 💾 **Persistent Storage**
  - Automatically loads saved user session on app startup   

---

## 🚀 How to Run the Project

1. **Clone the repository**  
- git clone https://github.com/a7med2002/betweener_app.git

2. **Install dependencies** 
- flutter pub get

3. **Run the app**
- flutter run

---

## 🖼️ Screenshots

![app_view1](assets/imgs/view1.png)

![app_view2](assets/imgs/view2.png)

![app_view3](assets/imgs/view3.png)

![app_view4](assets/imgs/view4.png)

---

## 📦 Download APK  

You can download the latest version of the **Betweener App** APK directly from Google Drive:  

👉 [**Download Betweener App (APK)**](https://drive.google.com/file/d/1YAwn4lzxc3xYpiii38NTtt3W8YL3MelA/view?usp=sharing)  

---

## 🌐 Social Links
- 👨‍💻 Developer: [ِAhmed Meqdad]
- 📧 Email: [ahmd2002mqdad@gamil.com]
- 💼 LinkedIn: [linkedin.com/in/ahmed-meqdad](https://www.linkedin.com/in/ahmedmeqdad0)