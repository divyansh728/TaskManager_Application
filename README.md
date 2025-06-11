# taskmanager_application

A simple Task Manager app built using Flutter, Bloc for state management, and Hive for local storage. The app supports creating, updating, deleting, and filtering tasks along with light/dark theme toggling.

## 🚀 Features

- Create, update, and delete tasks
- Mark tasks as completed or pending
- Filter tasks (All, Completed, Pending)
- Persist data locally using Hive
- Light/Dark theme toggle

## 📦 Dependencies

- `flutter_bloc`
- `hive`
- `hive_flutter`
- `path_provider` (implicitly used by Hive)

## 🛠️ Setup Instructions

### 1. Clone the repository


with this Url of GitHub:-
https://github.com/divyansh728/TaskManager_Application.git
cd task_manager_flutter


### 2. Install dependencies

flutter pub get


### 3. Generate Hive Adapters

Ensure the Task model has a @HiveType annotation and run:
flutter packages pub run build_runner build


<img width="297" alt="Screenshot 2025-06-11 at 10 34 32 PM" src="https://github.com/user-attachments/assets/05573e68-4150-4bf4-8a9d-191228ce8ef1" />

<img width="306" alt="Screenshot 2025-06-11 at 10 33 41 PM" src="https://github.com/user-attachments/assets/edf7b7c4-d29a-43b5-b1f6-1f45b668527a" />

<img width="309" alt="Screenshot 2025-06-11 at 10 34 02 PM" src="https://github.com/user-attachments/assets/63f51b11-517f-4d83-8910-9bfb249b9990" />

<img width="290" alt="Screenshot 2025-06-11 at 10 35 39 PM" src="https://github.com/user-attachments/assets/ce25bd72-8a8c-4248-b1de-0534f8f7d8f5" />

<img width="299" alt="Screenshot 2025-06-11 at 10 36 05 PM" src="https://github.com/user-attachments/assets/1a0a549d-2294-4e93-900c-0891797699d7" />

<img width="299" alt="Screenshot 2025-06-11 at 10 36 22 PM" src="https://github.com/user-attachments/assets/a7fb9f1d-37fa-4a76-b509-6d15008c6851" />










