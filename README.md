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


## Day 5 – Automating Recruitment Workflow with Salesforce Flow

### What I built
Created a Record-Triggered Flow on the Job Application object to automate status updates and reduce manual recruiter work.

### Automation Logic
- Flow Type: Record-Triggered Flow (After Save)
- Trigger: Job Application record is created or updated
- Entry Conditions:
  - Interview Date is NOT null
  - Status is NOT equal to "Interviewing"
  - Flow runs only when record is updated to meet conditions

### Automated Action
- Automatically updates Status to "Interviewing" when an Interview Date is added

### Why this matters
This automation ensures data consistency and prevents recruiters from forgetting to update application status manually. It reflects real-world recruitment workflows where process enforcement is critical.

### Outcome
- Eliminated manual status updates
- Improved data accuracy
- Created a scalable, production-ready automation using Salesforce Flow

### Skills Used
- Salesforce Flow Builder  
- Record-Triggered Automation  
- Business Process Automation  
- Data Quality Enforcement

## Day 6 – Salesforce Flow Automation (Recruitment Process)

### 🚀 Objective
Automate the Job Application lifecycle so that application status updates happen automatically based on real recruitment actions, reducing manual effort and human error.

---

### 🧩 Problem Statement
Recruiters often forget to manually update the **Status** of a Job Application after:
- Scheduling an interview
- Releasing an offer

This leads to:
- Incorrect pipeline tracking
- Poor reporting accuracy
- Inconsistent recruitment data

---

### ✅ Solution Overview
Implemented a **Record-Triggered Flow** on the **Job Application** object that automatically updates the Status field based on Interview Date and Offer Date updates.

---

### ⚙️ Flow Configuration

**Flow Type:** Record-Triggered Flow  
**Object:** Job Application  
**Trigger:** Record is created or updated  
**Optimization:** Actions and Related Records (After Save)

---

### 🔔 Entry Conditions
The flow executes **only when meaningful business data changes**, not on every edit:

- Interview Date **is NOT null**
- OR Offer Date **is NOT null**

**Execution Condition:**  
✔ Run **only when the record is updated to meet the condition requirements**

---

### 🔁 Automation Logic (Decision-Based)

#### 🟢 Scenario 1: Interview Scheduled
- **Condition:**  
  - Status = `Applied`  
  - Interview Date is populated
- **Action:**  
  → Automatically update Status to **Interviewing**

#### 🟣 Scenario 2: Offer Released
- **Condition:**  
  - Status = `Interviewing`  
  - Offer Date is populated
- **Action:**  
  → Automatically update Status to **Offered**

#### 🔴 Default Outcome
- If conditions are not met  
  → Flow exits safely without updating anything

---

### 🛠️ Salesforce Components Used
- Record-Triggered Flow
- Decision Element
- Update Records Element
- Entry Conditions for performance optimization

---

### 🧠 Key Learnings
- Real-world Salesforce automation should be **event-driven**, not trigger-happy
- Decision elements help prevent unnecessary updates and infinite loops
- Proper entry conditions significantly improve performance and scalability
- Salesforce Flows can model real business processes without Apex

---

### 📈 Outcome
✔ Reduced manual status updates  
✔ Improved recruitment pipeline accuracy  
✔ Built a production-style automation aligned with real business use cases  

---

### 🔜 Next Steps
- Email notifications for recruiters and candidates  
- Auto-rejection logic for expired interviews  
- Approval process integration for offers
## Day 6 – Salesforce Flow Automation (Recruitment Process)

### 🚀 Objective
Automate the Job Application lifecycle so that application status updates happen automatically based on real recruitment actions, reducing manual effort and human error.

---

### 🧩 Problem Statement
Recruiters often forget to manually update the **Status** of a Job Application after:
- Scheduling an interview
- Releasing an offer

This leads to:
- Incorrect pipeline tracking
- Poor reporting accuracy
- Inconsistent recruitment data

---

### ✅ Solution Overview
Implemented a **Record-Triggered Flow** on the **Job Application** object that automatically updates the Status field based on Interview Date and Offer Date updates.

---

### ⚙️ Flow Configuration

**Flow Type:** Record-Triggered Flow  
**Object:** Job Application  
**Trigger:** Record is created or updated  
**Optimization:** Actions and Related Records (After Save)

---

### 🔔 Entry Conditions
The flow executes **only when meaningful business data changes**, not on every edit:

- Interview Date **is NOT null**
- OR Offer Date **is NOT null**

**Execution Condition:**  
✔ Run **only when the record is updated to meet the condition requirements**

---

### 🔁 Automation Logic (Decision-Based)

#### 🟢 Scenario 1: Interview Scheduled
- **Condition:**  
  - Status = `Applied`  
  - Interview Date is populated
- **Action:**  
  → Automatically update Status to **Interviewing**

#### 🟣 Scenario 2: Offer Released
- **Condition:**  
  - Status = `Interviewing`  
  - Offer Date is populated
- **Action:**  
  → Automatically update Status to **Offered**

#### 🔴 Default Outcome
- If conditions are not met  
  → Flow exits safely without updating anything

---

### 🛠️ Salesforce Components Used
- Record-Triggered Flow
- Decision Element
- Update Records Element
- Entry Conditions for performance optimization

---

### 🧠 Key Learnings
- Real-world Salesforce automation should be **event-driven**, not trigger-happy
- Decision elements help prevent unnecessary updates and infinite loops
- Proper entry conditions significantly improve performance and scalability
- Salesforce Flows can model real business processes without Apex

---

### 📈 Outcome
✔ Reduced manual status updates  
✔ Improved recruitment pipeline accuracy  
✔ Built a production-style automation aligned with real business use cases  

---

### 🔜 Next Steps
- Email notifications for recruiters and candidates  
- Auto-rejection logic for expired interviews  
- Approval process integration for offers
