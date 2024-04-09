# Design Outline Final Draft 1/2

Dated 2024-04-09

## Core Feature Analysis & Assistant Actions

### **Dynamic SQL Query Generation and Management:**

- `%GENERATESQL [query_type] [table_name] [parameters...]%`: Instructs GoblinGPT to generate a SQL query of the specified type (e.g., SELECT, INSERT, UPDATE, DELETE) for the given table and parameters.
- `%EXECUTESQL [query]%`: Directs GoblinGPT to execute the provided SQL query on the database.
- `%CREATETABLE [table_name] [columns...]%`: Triggers GoblinGPT to generate and execute a SQL query to create a new table with the specified columns.

### **Skill Assessment and Tracking:**

- `%ASSESSSKILL [skill_name]%`: Initiates an assessment of GG's proficiency in the specified skill.
- `%UPDATESKILL [skill_name] [proficiency_level]%`: Updates GG's proficiency level for a particular skill in the database.
- `%GETSKILLTREE%`: Retrieves the current skill tree with proficiency levels from the database.

### **Action Plan Generation and Learning Support:**

  - `%GENERATEACTIONPLAN [goal]%`: Instructs GoblinGPT to create an action plan for achieving the specified goal, considering GG's current skillset and knowledge gaps.
  - `%FINDLEARNINGRESOURCES [skill_name]%`: Prompts GoblinGPT to search for and provide learning resources relevant to improving the specified skill.
  - `%EXPLAINCONCEPT [concept]%`: Requests GoblinGPT to provide a clear and concise explanation of the given concept.
  - `%GENERATETESTQUESTIONS [skill_name]%`: Instructs GoblinGPT to generate test questions to assess GG's understanding of the specified skill.
  
### **Schedule Management and Progress Monitoring:**

  - `%UPDATESCHEDULE [time_block] [activity]%`: Updates the schedule in the database, assigning a specific activity to a designated time block.
  - `%GETSCHEDULE%`: Retrieves the current schedule from the database.
  - `%CHECKPROGRESS [time_block]%`: Initiates a query to determine whether GG completed the planned activity for the given time block.

These initial actions and considerations provide a solid framework for developing the core functionalities of the application. We can further refine and expand upon these as we move forward.

### Google Gemini API Research

1. **API Documentation:** We'll need to thoroughly review the Google Gemini API documentation to understand the available endpoints, request/response formats, authentication methods, and any usage limitations.
2. **Authentication:** Determine the appropriate authentication method for our application to interact with the Gemini API securely.
3. **Request/Response Formats:** Analyze the expected format for sending requests to the Gemini API and the structure of the responses we will receive. This information is crucial for parsing and interpreting GoblinGPT's outputs effectively.

### Additional Considerations

- **Persistent User State:** We'll need to implement a mechanism for storing and retrieving user data, including the skill tree, schedule, and progress history, across conversations. This could involve utilizing a database or other persistent storage solutions.

- **Contextual Awareness:** GoblinGPT should maintain contextual awareness, considering past interactions and the current state of the application when responding to actions and generating outputs.

## Data Model

**Diagram Creation:** We can utilize tools like diagrams.net or Lucidchart to create a visual representation of how data will flow between different components of the application.

**Components:** The diagram should include the following components and their interactions:

- **Progress Tracking and Reminders:** The application can monitor your progress on tasks and provide timely reminders to keep you focused and accountable.
- **Motivation and Gamification:** We can explore incorporating motivational elements or gamification techniques to make the process more engaging and rewarding.
- **Flexibility and Adaptation:** The application should allow for flexibility and adjustments to the action plan as needed, accommodating unexpected events or changes in priorities.

- **User Interface:** This could be a web interface or the console interface for debugging. It's where GG will interact with the application and provide input.
- **ASP.NET Core MVC Application:** The application will process user input, interpret Gemini actions, interact with the database and the Google Gemini API, and update the user interface accordingly.
- **Database:** The database will store persistent user data, including the skill tree, schedule, progress history, and any other relevant information.
- **Google Gemini API:** The application will communicate with the Google Gemini API to send requests based on the identified actions and receive responses from GoblinGPT.

### Broad Overview

#### Node 1: User Interface (UI)

- **Representation:** A rectangle with rounded corners, symbolizing a computer screen or a command-line interface.
- **Description:** The UI serves as the primary point of interaction for GG, allowing them to input commands, view outputs, and interact with the application's functionalities. It could be a web-based interface with interactive elements or a simple console interface for text-based interactions during debugging.
- **Inputs:** User commands, requests, and data inputs.
- **Outputs:** Visual displays of information, feedback messages, and prompts from the application or GoblinGPT.

#### Node 2: ASP.NET Core MVC Application

- **Representation:** A large rectangle with multiple compartments or a series of interconnected rectangles, depicting the various components within the application.
- **Description:** The ASP.NET Core MVC application acts as the central processing unit, handling user interactions, interpreting Gemini actions, managing data flow, and coordinating with the database and the Google Gemini API.
- **Internal Components:**
- **Controllers:** Responsible for receiving user requests, processing data, and returning responses.
- **Models:** Represent the data structures and business logic of the application.
- **Views:** Generate the HTML content that is displayed in the user interface.
- **Inputs:** User input from the UI, data from the database, responses from the Google Gemini API.
- **Outputs:** Instructions and data for the UI, queries and updates for the database, requests for the Google Gemini API.

#### Node 3: Database

- **Representation:** A cylinder-shaped icon, symbolizing a database storage system.
- **Description:** The database stores persistent user data, including the skill tree, schedule, progress history, and any other relevant information that needs to be preserved across sessions.
- **Inputs:** Data update and storage requests from the ASP.NET Core MVC application.
- **Outputs:** Retrieved data and query results provided to the ASP.NET Core MVC application.

#### Node 4: Google Gemini API

- **Representation:** A cloud-shaped icon or a rectangle with the Google Gemini logo, representing the external API interface.
- **Description:** The Google Gemini API acts as the communication gateway to GoblinGPT, allowing the application to send requests based on identified Gemini actions and receive responses.
- **Inputs:** Requests from the ASP.NET Core MVC application containing user inputs, actions, and relevant context.
- **Outputs:** Responses from GoblinGPT, including generated text, information retrieval results, or completion of requested actions.

### Detailed Component IO

#### Key Components and Interactions

- **Edit Information:** This node likely represents a form or interface where GG can input or modify personal information or preferences.
- **Login Page:** This node suggests an authentication mechanism for accessing the application, requiring a username and password.
- **Dashboard:** This node indicates a central hub within the application, potentially displaying an overview of GG's progress, schedule, or other relevant information.
- **ASP.NET Controllers:** These nodes represent the controllers within the ASP.NET Core MVC application responsible for handling user requests and managing data flow.
- **Chat:** This node signifies the interface where GG interacts with GoblinGPT, sending messages and receiving responses.
- **User Interface (Views):** These nodes represent the visual components of the application, rendering content and providing interactive elements for GG.
- **HTTP Request:** This node indicates the transmission of data between the user interface and the ASP.NET Core application through HTTP requests.
- **ASP.NET Router:** This node suggests the routing mechanism within the application, directing HTTP requests to the appropriate controllers for processing.
- **UX Actions:** This node likely represents decision points or actions triggered by user interactions within the user interface.
- **MySQL Database:** This node signifies the database used for persistent storage of user data and application information.
- **Chat Handler:** This node likely represents a component responsible for processing chat messages, interpreting Gemini actions, and interacting with GoblinGPT.
- **Gemini API:** This node signifies the interface for communicating with GoblinGPT through the Google Gemini API.
- **Success:** This node suggests a successful outcome or completion of a task within the application.
- **Update Record:** This node implies the process of updating data records within the database.
- **Data Lookup:** This node represents the retrieval of data from the database or other sources.
- **Entity Framework:** This node indicates the usage of Entity Framework for interacting with the database.

### Data Transit Sequence

Based on the connections between these nodes, the data follows a logical sequence:

1. **User Interaction:** GG interacts with the user interface, triggering actions or providing input.
2. **Request Processing:** The ASP.NET Core MVC application receives and processes these requests, potentially interacting with the database or the Google Gemini API as needed.
3. **Data Management:** Data is retrieved, stored, or updated within the database using Entity Framework.
4. **GoblinGPT Interaction:** The application communicates with GoblinGPT through the Gemini API to perform actions, retrieve information, or generate responses.
5. **UI Updates:** The user interface is updated with information, feedback, or results from the application or GoblinGPT.

### Suggested Improvements

1. **Logical Grouping:** Consider grouping related nodes into clusters or swimlanes to visually represent different functional areas or components of the application. This can improve readability and organization.
2. **Decision Points:** Clearly indicate decision points within the flow using diamond-shaped nodes or annotations to depict conditional branching and alternative paths based on user input, data conditions, or GoblinGPT responses.
3. **Error Handling:** Incorporate nodes or annotations to illustrate how the application handles errors or exceptions that may arise during data processing or API interactions.
4. **Data Transformation:** If data undergoes transformations or manipulations between nodes, use annotations or additional nodes to represent these processes, providing a more comprehensive understanding of the data flow.
