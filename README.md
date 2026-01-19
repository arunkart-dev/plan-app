🗂️ Make Plan — Task & Roadmap Planner (Flutter)

Make Plan is a clean, minimalistic productivity app built with Flutter that helps users plan tasks, track progress, and follow structured roadmaps (Study, Career, Fitness).

The project follows clean UI principles, Provider-based state management, and a scalable folder structure, making it suitable for real-world applications and team collaboration.

✨ Features

✅ Create, edit, and manage tasks

⭐ Mark tasks as priority

📅 View task creation date & time

🧭 Roadmap flows (Study / Career / Fitness)

🤖 AI-powered Roadmap Assistant (Chat View)

🌙 Minimal & theme-aware UI

🧱 Clean architecture with Provider

🔐 Secure API handling (config excluded from repo)

🛠 Tech Stack

Framework: Flutter (Material 3)

Language: Dart

State Management: Provider

Architecture: MVVM-inspired

Date Formatting: intl

Platform: Android / iOS / Web (Flutter-supported)

📁 Project Structure
lib/
 ├── model/          # Data models
 ├── viewmodel/      # Providers & business logic
 ├── views/          # UI screens
 ├── widgets/        # Reusable UI components
 └── main.dart


🔐 Sensitive configuration files are intentionally excluded from version control.

🚀 Getting Started (Run Locally)
1️⃣ Prerequisites

Make sure you have:

Flutter SDK installed
👉 https://docs.flutter.dev/get-started/install

Android Studio / VS Code

Android Emulator or physical device

Check Flutter installation:

flutter doctor

2️⃣ Clone the Repository
git clone https://github.com/arunkart-dev/plan-app.git
cd plan-app

3️⃣ Install Dependencies
flutter pub get

4️⃣ Configure API / Secrets (Required)

This project uses a local config/ folder for API keys and sensitive data.

🔹 Create config folder
mkdir config

🔹 Create your config file

Example:

touch config/api_config.dart

class ApiConfig {
  static const String baseUrl = "YOUR_API_URL";
  static const String apiKey = "YOUR_API_KEY";
}


⚠️ config/ is ignored via .gitignore and will not be committed.

5️⃣ Run the App
flutter run


To run on a specific device:

flutter devices
flutter run -d <device_id>

🧪 Useful Flutter Commands
flutter clean
flutter pub get
flutter analyze
flutter run

🧠 Design Philosophy

Minimalistic & distraction-free UI

Focus on usability over visual noise

Clean separation of concerns

Scalable for future features (auth, cloud sync, notifications)

🔐 Security & Best Practices

✅ API keys are excluded from GitHub

✅ .gitignore properly configured

✅ No secrets committed

✅ Ready for team collaboration

📌 Future Improvements

🔔 Smart reminders & notifications

☁️ Cloud sync (Supabase / Firebase)

👤 User authentication

📊 Advanced analytics & insights

🎞️ Micro-interactions & animations

👨‍💻 Author

Arun
Flutter Developer Intern
GitHub: https://github.com/arunkart-dev

📄 License

This project is licensed for learning and personal use.
You are free to explore, modify, and build upon it.
