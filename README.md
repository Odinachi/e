
# E APP - Order Tracking Application

E APP is an intuitive Order tracking app developed using Flutter, Firebase, and Ably. This application provides users with a seamless experience in managing and tracking their orders. Users have the flexibility to sign up using their email address, Google account, or GitHub account and subsequently log in using the same methods.

## Features:

### User Authentication:
- **Sign Up:** Users can register by providing their email address, Google account, or GitHub account.
- **Login:** Users can access their accounts by logging in through their chosen authentication method.

### Order Management:
- **Simplified Order Creation:** Creating an order is streamlined and user-friendly. Simply click on the "+" icon on the home screen to initiate the process.
- **Efficient Testing:** For testing purposes, each stage of order creation and processing is optimized to take only 3 seconds to complete. This ensures quick validation and testing of the application's functionalities.

### Technology Stack:
- **Flutter:** Utilized for the frontend development, ensuring a smooth and responsive user interface across different platforms.
- **Firebase:** Integrated for user authentication, secure storage, and real-time database functionalities.
- **Ably:** Implemented for efficient real-time communication and data synchronization between users and the application.

## Installation:

### Prerequisites:
- Ensure you have Flutter installed. If not, refer to the official Flutter installation guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Set up Firebase for authentication and database services. Detailed instructions can be found in the Firebase documentation: [Firebase Documentation](https://firebase.google.com/docs)
- Flutter version 3.13.5 is required for this application.
- 
### Steps to Run the App:
1. Clone the repository:
   ```bash
   git clone https://github.com/Odinachi/e.git
   ```

2. Navigate to the project directory:
   ```bash
   cd e
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Configure Firebase:
    - Add your Firebase configuration files to the appropriate directories as per the Firebase documentation.

5. Run the app:
   ```bash
   flutter run
   ```

## Usage:

1. **Sign Up/Login:** Use your preferred method of authentication to create an account or log in.
2. **Creating an Order:** On the home screen, click on the "+" icon to start the order creation process.
3. **Testing Order Stages:** For testing purposes, note that each stage of order is optimized to take 3 seconds for quick validation and testing.


## Visuals
### Video
1. Google Auth Flow  [![Google auth flow](https://github.com/Odinachi/e/blob/dev/assets/video/1.mov)](https://github.com/Odinachi/e/blob/dev/assets/video/1.mov)

### Pictures

1. Auth Screen  ![alt text](./assets/images/5.png?raw=true)
2. Home Screen  ![alt text](./assets/images/1.png?raw=true)
3. Delivery Details  ![alt text](./assets/images/3.png?raw=true)
4. Delivery Details  ![alt text](./assets/images/4.png?raw=true)
5. Delivered!  ![alt text](./assets/images/2.png?raw=true)



