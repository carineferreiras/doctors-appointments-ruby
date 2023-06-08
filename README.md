Patient-Appointment-Doctors App

Welcome to the Patient-Appointment-Doctors App! This command-line interface (CLI) application, built using Ruby and ActiveRecord, allows users to schedule appointments with doctors. The app provides a simple and convenient way to manage appointments, patients, and doctors.

Features
The Patient-Appointment-Doctors App offers the following features:

Appointment Scheduling: Users can schedule appointments with doctors by selecting available time slots and providing their information.

Patient Management: The app allows users to create, view, and update patient records. Each patient has basic information like name, contact details, and medical history.

Doctor Management: Users can create, view, and update doctor profiles. Each doctor has details such as name, specialty, and contact information.

Database and Models
The app uses ActiveRecord to interact with a relational database. The following models are used:

Patient: The Patient model represents a patient and has attributes like name, contact information, and medical history. It has a one-to-many association with the Appointment model, allowing a patient to have multiple appointments.

Doctor: The Doctor model represents a doctor and includes attributes like name, specialty, and contact information. It has a one-to-many association with the Appointment model, allowing a doctor to have multiple appointments.

Appointment: The Appointment model serves as the join table between patients and doctors. It has attributes like appointment date, time, and additional details. It belongs to a patient and a doctor.

Installation and Usage
To set up and use the Patient-Appointment-Doctors App, follow these steps:

Install Ruby on your system if you haven't already. Visit the official Ruby website (https://www.ruby-lang.org) for installation instructions.

Install the required dependencies by running the following command:

shell
Copy code
gem install bundler
bundle install
Set up the database by running the following command to create the required tables:

shell
Copy code
rake db:migrate
You can use the Faker gem to generate sample data by running the following command:

shell
Copy code
rake db:seed
Start the app by running the following command:

shell
Copy code
ruby app.rb
Follow the on-screen prompts to navigate the app and schedule appointments. Use the provided commands to create, view, and update patient and doctor records.

Conclusion
The Patient-Appointment-Doctors App provides a simple and efficient way to schedule appointments and manage patient and doctor information. By leveraging ActiveRecord and adhering to good coding practices, the app offers a streamlined experience for users. Feel free to explore the code and customize it according to your needs. Enjoy using the Patient-Appointment-Doctors App!