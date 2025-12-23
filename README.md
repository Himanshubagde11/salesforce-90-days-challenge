# salesforce-90-days-challenge
Tracking my hands-on Salesforce development journey: Apex, LWC, Flows, Integrations, and projects.
### Day 1
- Created a Salesforce Lightning App: My Recruitment App
- Added custom objects: Company & Job Application
- Added tabs and sample data
- Repo created to document daily progress

### Day 2
- Added custom fields on Company object (Industry, Company Size, Website, Headquarters)
- Added custom fields on Job Application object (Position Title, Status, Expected Salary, Notes, Interview Date)
- Created lookup relationship (Job Application → Company)
- Designed clean page layouts with proper sections
- Updated page layouts for both objects
- Added sample records and tested relationships

### Day 3 – Data Validation + Controls
- Added validation rules on Job Application:
  - Interview date cannot be in the past
  - Expected salary must be greater than zero
  - Position required when Status = Interviewing
- Marked important business fields as Required
- Created multiple List Views for Job Applications (Applied, Interviewing, Offered, Rejected)
- Filtered records to validate data quality

## Day 4 – Job Application Workflow & User Experience Enhancements

On Day 4, I focused on improving the Job Application workflow by enhancing usability, enforcing data quality, and guiding users through a structured hiring process.

### 1. Page Layout Optimization
- Cleaned and reorganized page layouts for both Company and Job Application objects.
- Grouped fields into meaningful sections such as:
  - Job Details
  - Compensation
  - Interview
  - Notes
- Removed unnecessary system fields from the main view to improve readability and user focus.

### 2. Validation Rules for Data Integrity
Implemented validation rules to ensure correct data entry:
- Prevented status progression to "Interviewing" unless Interview Date is filled.
- Made Company selection mandatory to avoid orphan Job Applications.
These rules simulate real-world business constraints commonly used in recruitment systems.

### 3. Salesforce Path Implementation
- Configured Salesforce Path on the Job Application object using the Status picklist.
- Defined stages: Applied → Interviewing → Offered → Rejected.
- Added Guidance for Success at each stage to assist users in understanding next actions.

### 4. Celebration & User Feedback
- Enabled Celebration for the final stage (Offered) to enhance user experience.
- This provides visual feedback and improves adoption for business users.

### 5. Kanban View for Recruiter Workflow
- Used Kanban view to visualize Job Applications by Status.
- Enabled drag-and-drop status updates, simulating how recruiters track candidates in real time.

### Outcome
This setup demonstrates how Salesforce can be used not just as a data storage system, but as a guided, process-driven application that improves efficiency, data quality, and user experience.

