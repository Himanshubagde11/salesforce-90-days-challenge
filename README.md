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

## Day 6 – Salesforce Flow Automation (Recruitment Workflow)

Implemented a production-style record-triggered Flow to automate Job Application status transitions based on real recruitment events.

### What was done
- Built a Record-Triggered Flow on the Job Application object
- Configured selective entry conditions so the flow runs only when:
  - Interview Date is added, or
  - Offer Date is added
- Used Decision elements to control valid status transitions:
  - Applied → Interviewing (when Interview Date is populated)
  - Interviewing → Offered (when Offer Date is populated)
- Ensured the flow exits safely when conditions are not met
- Prevented unnecessary executions and infinite loops by validating current status

### Why this matters
This automation removes manual dependency on recruiters to update application status, improves data accuracy, and reflects a real-world recruitment lifecycle instead of demo-level automation.

### Key learning
Effective Salesforce automation should be event-driven, selective, and controlled. Status changes should be driven by meaningful business actions, not by every record edit.


## Day 7 – Email Automation with Salesforce Flow

### What I Built
Implemented email automation for a recruitment workflow using Salesforce Flow.

### Key Work
- Created **Classic Email Templates** for:
  - Interview Scheduled
  - Offer Released
- Configured **Email Alerts** on the Job Application object
- Built a **Record-Triggered Flow** to:
  - Auto-update application status (Applied → Interviewing → Offered)
  - Trigger email alerts when Interview Date or Offer Date is added
- Passed **Triggering Record ID** correctly to Email Alerts

### Outcome
- Recruiters receive instant notifications
- Status updates are fully automated
- No manual follow-ups required

### Learnings
- Email Alerts require Classic Email Templates
- Correct merge field syntax `{! }` is critical
- Flows should trigger only on meaningful business events


# Day 8 – Advanced Salesforce Flow: Status Automation with Email Alerts

## Overview
Built an advanced Record-Triggered Flow on the Job Application object to automate recruitment stages and notifications in Salesforce.

## What This Flow Does
- Automatically updates Job Application status based on business logic
- Sends Interview Scheduled email when Interview Date is added
- Sends Offer Released email when Offer Date is added
- Prevents duplicate emails using boolean flags
- Ensures emails are sent only once per stage

## Flow Logic
1. Trigger: Job Application record is created or updated
2. Decision Element:
   - If Status = Applied AND Interview Email not sent
     → Update Status to Interviewing
     → Send Interview Scheduled Email
     → Mark Interview Email as Sent
   - If Status = Interviewing AND Offer Email not sent
     → Update Status to Offered
     → Send Offer Released Email
     → Mark Offer Email as Sent
3. Default path ends flow safely

## Key Salesforce Features Used
- Record-Triggered Flow
- Decision Elements
- Update Records
- Email Alerts
- Boolean Flags to prevent re-triggering

## Why This Matters
This flow follows real-world Salesforce best practices:
- No duplicate emails
- Idempotent automation
- Production-ready logic

## Status
✅ Completed and tested


# Day 9 – User Acceptance Testing (UAT)
**Project:** Recruitment Automation using Salesforce Flow

## Objective
Validate that the recruitment automation works as expected from a business user perspective, ensuring correct status updates and email notifications without duplication.

## UAT Scope
Testing was performed on the Job Application object covering:
- Interview scheduling automation
- Offer release automation
- Email notifications
- Duplicate email prevention logic

## Test Scenarios & Results

### Scenario 1: Interview Scheduled
**Given**
- Job Application Status = Applied
- Interview Date is added
- Interview Email Sent = False

**When**
- The record is saved

**Then**
- Status updates to Interviewing
- Interview Scheduled email is sent
- Interview Email Sent flag updates to True

**Result:** Pass

---

### Scenario 2: Prevent Duplicate Interview Email
**Given**
- Interview Email Sent = True

**When**
- Interview Date is updated again

**Then**
- No duplicate email is sent

**Result:** Pass

---

### Scenario 3: Offer Released
**Given**
- Job Application Status = Interviewing
- Offer Date is added
- Offer Email Sent = False

**When**
- The record is saved

**Then**
- Status updates to Offered
- Offer Released email is sent
- Offer Email Sent flag updates to True

**Result:** Pass

---

### Scenario 4: Prevent Duplicate Offer Email
**Given**
- Offer Email Sent = True

**When**
- Offer Date is updated again

**Then**
- No duplicate email is sent

**Result:** Pass

---

## Validation Summary
- All automation executed only once per condition
- Decision logic correctly controlled flow execution
- Email notifications triggered only when required
- Data integrity maintained across updates

## Conclusion
All UAT scenarios passed successfully.  
The recruitment automation meets business requirements and is ready for production use.

## Tools & Features Used
- Salesforce Record-Triggered Flow
- Decision Elements
- Update Records
- Email Alerts
- Custom Boolean Fields

**Status:** UAT Completed and Approved

# Day 10 – Salesforce Reports, Dashboards & Flow Monitoring

## What I Built
- Created recruitment reports for pipeline visibility
- Designed a management-level dashboard
- Reviewed Flow execution and error monitoring

## Reports Created
- Job Applications by Status
- Interview Pipeline
- Offer Tracker

## Dashboard
- Recruitment Overview Dashboard displaying real-time hiring data

## Monitoring
- Reviewed Paused and Failed Flow Interviews
- Validated flow execution after automation runs

## Key Learning
Automation is incomplete without reporting and monitoring.  
Visibility and reliability are critical for real-world Salesforce implementations.


# 📅 Day 11 – Security, Error Handling & Production Readiness

## 🔍 Objective
Strengthen the Recruitment Management application by implementing security controls,
error handling, access management, and UAT validation to make the solution production-ready.

---

## ✅ Key Implementations

### 🔐 Security Configuration
- Implemented Object-Level Security (OLS) for Job Application object
- Configured Field-Level Security (FLS) to protect sensitive fields
- Validated access using different user profiles

---

### 🧠 Flow Error Handling (Advanced)
- Added Fault Paths to critical Flow actions
- Captured system errors using Flow global variables
- Stored error messages in a custom variable for debugging and audit tracking
- Ensured graceful failure without breaking user transactions

---

### 📊 Dashboards & Access Control
- Built Recruitment Overview Dashboard
- Organized dashboards into a dedicated folder
- Configured folder-level sharing
- Verified access by logging in as another user (OrgFarm EPIC)

---

### 🧪 UAT & Optimization Review
- Performed User Acceptance Testing (UAT) for all automation scenarios
- Reviewed Flow DML operations for optimization
- Ensured no recursion or governor limit risks

---

## 🛠 Salesforce Features Used
- Record-Triggered Flows
- Decision Elements
- Fault Paths & Assignments
- Object-Level & Field-Level Security
- Reports & Dashboards
- Folder Sharing & Access Validation

---

## 📌 Outcome
The application is now secure, error-resilient, and production-ready,
aligned with real-world Salesforce implementation standards.
