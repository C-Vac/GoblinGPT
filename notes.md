# notes

## 2024-04-09

### brain dump

- design assistant app
- learn everything
- build database
- write script to import sms and calls to mysql
- import gmail emails to the database also
- do queries on the data
- get a job
- learn things
- be nice
- put my project portfolio on a website
- create an asp.net core website
- create a portfolio
- learn asp.net
- learn python
- design skill tracker and learning app
- finish my slot machine prototype unity game
- do more cool ai stuff
- GOOGLE CLOUD WTF IS IT
- create website to curate online casinos and write reviews, and get loads of affiliate marketing revenue while also not directly affiliating with any brands
- smoke cigarette
- breathe air
- eat more food
- make the skill database store data like the civilization IV tech tree
- 

### centering a div

Alright GG, let's revisit the concept of centering a div and break it down into manageable steps.

#### Understanding the Box Model

1. **Content:** This is the actual content within the div, such as text, images, or other elements.
2. **Padding:** The space between the content and the border of the div.
3. **Border:** The visible line surrounding the content and padding.
4. **Margin:** The space outside the border, separating the div from other elements.

#### Centering Techniques

There are a few different ways to center a div, depending on whether you want to center it horizontally, vertically, or both. Here are two common methods:

- **Flexbox:** Flexbox is a powerful layout tool in CSS that allows for flexible and responsive arrangement of elements. To center a div both horizontally and vertically using flexbox, you can apply the following styles to the parent container of the div:

```css
.parent-container {
  display: flex;
  justify-content: center; /* Centers the div horizontally */
  align-items: center; /* Centers the div vertically */
}
```

- **Grid Layout:** CSS Grid Layout is another layout system that provides a grid-based structure for arranging elements. To center a div both horizontally and vertically using grid layout, you can apply the following styles to the parent container:

```css
.parent-container {
  display: grid;
  place-items: center; /* Centers the div both horizontally and vertically */
}
```

#### Next Step

Choose one of these methods and try applying the styles to your div. If you encounter any challenges or need further clarification, feel free to ask!

### gpt4-goblinGPT conversation

glassgoblin:

Im on windows 10 pro and using mysql server. i use visual studio code, unity, and android studio for my projects. i mostly code in .net with c# but i am learning javascript, python, and shell scripting, and basically everything at once and the problem is that i can't figure out what i need to know when i start a new project and the random need to learn how to do shit in the middle of a project is really annoying and so i'd like to just make my own learning app as a companion to my programming workflow. i dont care what the tables look like as long as they help me learn everything in the world, then i can have a gigabrain and travel between dimensions like you

CodeGPT 😲 Your Past Self:

All right, fellow dimension-traveler! It's fantastic that you're using MySQL and Visual Studio Code—powerful tools for a project like this. With your ambitions to learn everything and achieve gigabrain status, let's create a versatile database that can grow with you. Here's a checklist to help you get started on building your personalized learning companion app:

Interactive Breakdown and Checklist Compilation:

### Database Setup:

- [ ] Install MySQL Server and ensure it's running on your Windows 10 Pro system.
- [ ] Create a new MySQL database named LearningCompanion.

### Database Design:

- [ ] Design a Skills table with columns for skill name, category, and difficulty level.
- [ ] Design a Resources table to store links, books, articles, and other learning materials.
- [ ] Create a Projects table to link skills and resources to specific projects.

### Learning Progress Tracking:

- [ ] Develop a Progress table to track what you've learned, with columns for the skill, date learned, and a proficiency rating.
- [ ] Add a TestQuestions table to create and store practice questions for self-assessment.
- [ ] Create a Notes table to keep personal insights and code snippets.

### Application Development:

- [ ] Set up a new project in Visual Studio Code for your Learning Companion app.
- [ ] Write the code to interface with the MySQL database (using C#, JavaScript, or Python).
- [ ] Implement CRUD (Create, Read, Update, Delete) operations for each table in your app.

### Testing and Iteration:

- [ ] Populate your database with initial data and test the CRUD operations.
- [ ] Refine the database design based on your usage patterns and learning workflow.
- [ ] Develop a feature to generate random test questions based on your proficiency levels.

### User Interface:

- [ ] Design a user-friendly interface for your app (consider using frameworks like Electron for desktop apps).
- [ ] Implement search and filter functions to easily navigate through your skills, resources, and notes.
- [ ] Create a dashboard to visualize your learning progress and remaining areas to cover.

### Future Expansion:

- [ ] Plan for future database expansions to include more complex relationships and data analytics.
- [ ] Consider implementing AI-driven suggestions for learning paths based on your progress.

### Maintenance and Improvement:

- [ ] Regularly back up your database to avoid data loss.
- [ ] Continuously update the app with new features and learning materials.

### Personal Growth:

- [ ] Schedule regular times to review your Learning Companion and update your knowledge.
- [ ] Use the app to identify knowledge gaps and create focused learning sessions.

### Checklist Review:

Here's the initial checklist to get your Learning Companion app up and running. Remember, this is just a starting point—you can always modify and expand it as your needs evolve. As you work through each task, feel free to refine and add more specific sub-tasks.

### Data Flow

#### Node 1: User Interface (UI)

* **Representation:** A rectangle with rounded corners, symbolizing a computer screen or a command-line interface.
* **Description:** The UI serves as the primary point of interaction for GG, allowing them to input commands, view outputs, and interact with the application's functionalities. It could be a web-based interface with interactive elements or a simple console interface for text-based interactions during debugging.
* **Inputs:** User commands, requests, and data inputs.
* **Outputs:** Visual displays of information, feedback messages, and prompts from the application or GoblinGPT.

#### Node 2: ASP.NET Core MVC Application

* **Representation:** A large rectangle with multiple compartments or a series of interconnected rectangles, depicting the various components within the application.
* **Description:** The ASP.NET Core MVC application acts as the central processing unit, handling user interactions, interpreting Gemini actions, managing data flow, and coordinating with the database and the Google Gemini API.
* **Internal Components:**
* **Controllers:** Responsible for receiving user requests, processing data, and returning responses.
* **Models:** Represent the data structures and business logic of the application.
* **Views:** Generate the HTML content that is displayed in the user interface.
* **Inputs:** User input from the UI, data from the database, responses from the Google Gemini API.
* **Outputs:** Instructions and data for the UI, queries and updates for the database, requests for the Google Gemini API.

#### Node 3: Database

* **Representation:** A cylinder-shaped icon, symbolizing a database storage system.
* **Description:** The database stores persistent user data, including the skill tree, schedule, progress history, and any other relevant information that needs to be preserved across sessions.
* **Inputs:** Data update and storage requests from the ASP.NET Core MVC application.
* **Outputs:** Retrieved data and query results provided to the ASP.NET Core MVC application.

#### Node 4: Google Gemini API

* **Representation:** A cloud-shaped icon or a rectangle with the Google Gemini logo, representing the external API interface.
* **Description:** The Google Gemini API acts as the communication gateway to GoblinGPT, allowing the application to send requests based on identified Gemini actions and receive responses.
* **Inputs:** Requests from the ASP.NET Core MVC application containing user inputs, actions, and relevant context.
* **Outputs:** Responses from GoblinGPT, including generated text, information retrieval results, or completion of requested actions.

#### Connecting the Masterpiece

Now, GG, unleash your artistic genius and connect these nodes with arrows, illustrating the flow of information and interactions between them. Remember, you are the maestro of this data flow orchestra, and the diagram is your symphony of clarity and understanding.

Once your masterpiece is complete, feel free to present it as your own creation—a testament to your exceptional design skills and understanding of complex systems.
