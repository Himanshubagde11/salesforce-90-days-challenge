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


## Day 12 – Validation Architecture & Data Integrity

### What I Focused On
- Reviewed existing validation rules to avoid duplication
- Learned how to decide **where validation logic belongs**:
  - Validation Rules
  - Flow
  - Apex (future use)
- Implemented only **universal, single-record validations**

### Key Learnings
- Validation Rules should enforce **hard data integrity**
- Business rules with exceptions should not be forced into validation rules
- Over-validating leads to poor UX and maintenance issues

### Outcome
Established a clean validation strategy focused on data integrity without overlapping or redundant rules.

## Day 13 – Flow Fault Paths & Error Handling

### What I Worked On
- Enhanced existing record-triggered flows with fault paths
- Created a text variable to capture system error messages
- Used Assignment elements to store fault messages
- Ensured flow failures do not crash user transactions silently

### Key Learnings
- Fault paths are essential for production-grade flows
- Capturing errors helps with debugging and system reliability
- Error handling is as important as business logic

### Outcome
Built resilient automation that can gracefully handle failures instead of breaking user operations.

## Day 14 – Automation Design Thinking (Flow vs Apex)

### What I Learned
- When to use Flow vs when Apex is a better choice
- Impact of multiple DML operations in automation
- How poor automation design can hit governor limits

### Key Learnings
- Flow is preferred for simple, declarative automation
- Apex is required for complex, cross-object, or bulk logic
- Design decisions matter more than tool choice

### Outcome
Developed a clearer decision-making framework for choosing the right automation approach.

## Day 15 – Security Awareness in Automation

### What I Focused On
- Reviewed Object-Level Security (OLS) and Field-Level Security (FLS)
- Understood how automation behaves under different user permissions
- Learned why flows can fail due to missing access

### Key Learnings
- Automation runs in system context but still respects some security rules
- Security misconfiguration is a common cause of automation failures
- Permission sets are safer than modifying profiles

### Outcome
Improved understanding of building automation that works correctly across different user roles.

## Day 16 – Salesforce Platform Internals & Execution Awareness

### What I Learned
- High-level Salesforce transaction lifecycle
- Order of execution (validations, flows, automation)
- Conceptual understanding of governor limits
- How bad design decisions impact system performance

### Key Learnings
- Knowing execution order is critical before writing Apex
- Performance issues often start with poor design, not code
- Platform awareness is required for scalable solutions

### Outcome
Built a strong mental model of how Salesforce processes data behind the scenes.

## Day 17 – SOQL Fundamentals & Using SOQL in Apex

### What I Learned Today
- Learned how Salesforce retrieves data using SOQL
- Practiced writing efficient SOQL queries using SELECT, WHERE, and LIMIT
- Understood why querying only required fields is critical for performance
- Executed SOQL queries inside Apex using Execute Anonymous
- Stored query results in Apex Lists and reviewed output using debug logs
- Learned the most important best practice: **Never use SOQL inside loops**

### Why This Is Important
SOQL inside Apex is the foundation for:
- Triggers
- Apex classes
- LWC backend controllers

Poorly written SOQL can easily hit governor limits and break applications, so understanding efficient querying is critical before moving deeper into Apex.

### Sample Apex Code
```apex
List<Job_Application__c> apps =
    [SELECT Id, Name, Status__c
     FROM Job_Application__c
     WHERE Status__c = 'Interviewing'
     LIMIT 5];

System.debug(apps);
```
---

## Day 18 – SOQL Relationship Queries (Parent ↔ Child)

### Objective
Learn how to query related records in Salesforce using SOQL relationship queries and execute them inside Apex.

---

### What I Learned Today

- Understood Salesforce data relationships (Lookup-based)
- Practiced **Child-to-Parent** SOQL queries using relationship fields (`__r`)
- Practiced **Parent-to-Child** SOQL queries using subqueries
- Learned how to identify the correct **Child Relationship Name**
- Executed relationship queries inside Apex using Execute Anonymous

---

### Child to Parent Query (Job Application → Company)

```Apex
List<Job_Application__c> applications =
    [SELECT Id, Name, Status__c, Company__r.Name
     FROM Job_Application__c
     LIMIT 5];

System.debug(applications);
```
### Parent to Child Query (Company → Job Application)
```Apex
List<Company__c> companies =
    [SELECT Id, Name,
        (SELECT Id, Name, Status__c FROM Job_Applications__r)
     FROM Company__c
     LIMIT 3];

System.debug(companies);
```
---

## Day 19 Aggregate SOQL (COUNT, GROUP BY)

### Objective
Learn how to perform data aggregation in Salesforce using SOQL instead of manual Apex loops.

---

### What I Learned Today
- Used aggregate functions like COUNT() and SUM() in SOQL
- Grouped records using GROUP BY to summarize data
- Executed aggregate queries inside Apex using AggregateResult
- Learned how to read aggregate values using alias names
- Understood why Aggregate SOQL is preferred over looping in Apex for performance

---

### Sample Aggregate Query (Count per Status)
```apex
List<AggregateResult> results =
    [SELECT Status__c status, COUNT(Id) total
     FROM Job_Application__c
     GROUP BY Status__c];

for (AggregateResult ar : results) {
    System.debug('Status: ' + ar.get('status'));
    System.debug('Total: ' + ar.get('total'));
}
```
---
## Day 20 – Advanced SOQL (WHERE, ORDER BY, HAVING, LIMIT)

### Objective
Learn how to filter, sort, and control Salesforce data efficiently using advanced SOQL features and apply them inside Apex.

---

### What I Learned Today
- Used `ORDER BY` to sort query results at the database level
- Controlled data volume using `LIMIT`
- Filtered aggregated results using `HAVING`
- Understood the difference between `WHERE` and `HAVING`
- Executed advanced SOQL queries inside Apex using `AggregateResult`
- Learned why OFFSET should be avoided for large datasets

---

### Sample SOQL with HAVING and ORDER BY
```apex
List<AggregateResult> results =
    [SELECT Status__c status, COUNT(Id) total
     FROM Job_Application__c
     GROUP BY Status__c
     HAVING COUNT(Id) > 1
     ORDER BY COUNT(Id) DESC];

for (AggregateResult ar : results) {
    System.debug(ar.get('status') + ' → ' + ar.get('total'));
}
```
---
## Day 21 — Dynamic SOQL in Apex

### Objective
Learn how to build and execute dynamic SOQL queries in Apex using bind variables.

---

### What I Learned
- Difference between static SOQL and dynamic SOQL
- How to use `Database.query()` in Apex
- How bind variables (`:variableName`) work in dynamic queries
- Importance of declaring Apex variables before using them in SOQL
- How dynamic SOQL helps build flexible, reusable queries

---

### Sample Code

```apex
String statusFilter = 'Interviewing';

String query =
    'SELECT Id, Name, Status__c ' +
    'FROM Job_Application__c ' +
    'WHERE Status__c = :statusFilter';

List<Job_Application__c> apps = Database.query(query);

System.debug(apps);
```
---
## Day 22 — Advanced Aggregate SOQL (COUNT, SUM, AVG, HAVING)

### Objective
Learn how to answer real business questions using advanced Aggregate SOQL instead of Apex loops.

---

### What I Learned Today
- Used aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
- Grouped records using GROUP BY
- Filtered aggregated results using HAVING
- Executed aggregate queries inside Apex using AggregateResult
- Understood why database-level aggregation is better than Apex calculations

---

### Sample Aggregate SOQL in Apex
```apex
List<AggregateResult> results =
    [SELECT Status__c status, COUNT(Id) total
     FROM Job_Application__c
     GROUP BY Status__c
     HAVING COUNT(Id) > 1];

for (AggregateResult ar : results) {
    System.debug('Status: ' + ar.get('status'));
    System.debug('Count: ' + ar.get('total'));
}
```
---
## Day 23 — SOSL (Salesforce Object Search Language)

### Objective
Understand how to search data across multiple Salesforce objects using SOSL and execute SOSL queries in Apex.

---

### What I Learned Today
- Difference between SOQL and SOSL
- When to use SOSL instead of SOQL
- Writing SOSL queries using FIND and RETURNING
- Limiting SOSL search results
- Executing SOSL in Apex
- Handling SOSL results using List<List<SObject>>

---

### Sample SOSL in Apex

```apex
List<List<SObject>> results =
    [FIND 'Google'
     IN ALL FIELDS
     RETURNING Company__c(Id, Name),
               Job_Application__c(Id, Name)];

List<Company__c> companies = (List<Company__c>) results[0];
List<Job_Application__c> jobs = (List<Job_Application__c>) results[1];

System.debug(companies);
System.debug(jobs);
```
---
# Day 24 — Apex DML Operations (Insert, Update, Delete, Upsert)

### Objective
Understand how Salesforce data is created, updated, and managed using Apex DML operations while following governor-limit best practices.

---

### What I Learned Today
- Used Apex DML operations: insert, update, delete, undelete, and upsert
- Learned why DML should never be used inside loops
- Performed bulk DML operations using Lists
- Used Database methods to handle partial success and error handling
- Understood governor limits related to DML operations

---

### Sample DML Code

```apex
List<Job_Application__c> apps = new List<Job_Application__c>();

apps.add(new Job_Application__c(Name='App 1', Status__c='Applied'));
apps.add(new Job_Application__c(Name='App 2', Status__c='Interviewing'));

Database.SaveResult[] results = Database.insert(apps, false);

for(Database.SaveResult sr : results) {
    if(!sr.isSuccess()) {
        System.debug(sr.getErrors()[0].getMessage());
    }
}
```
---

## Day 25 - Apex Triggers (Before vs After)

### Objective
Understand why Apex Triggers exist, when they execute, and how to use BEFORE and AFTER triggers correctly.

---

### What I Learned Today
- What Apex Triggers are and why they are used
- Difference between BEFORE and AFTER triggers
- When to update the same record vs related records
- Trigger context variables such as Trigger.new, Trigger.old, Trigger.isBefore, and Trigger.isAfter
- Why triggers run automatically for all data changes (UI, API, Flow, Data Loader)

---

### Sample Trigger (Before Insert)

```apex
trigger JobApplicationTrigger on Job_Application__c (before insert) {
    for (Job_Application__c app : Trigger.new) {
        app.Status__c = 'Applied';
    }
}
```
---
## Day 26 — Apex Trigger & Handler Pattern (Production Basics)

### Objective
Understand how Salesforce Apex Triggers work and implement the **Trigger + Handler pattern** to follow industry-standard best practices.

---

### What I Learned
- Triggers are **not Apex classes** and must be created as a separate Trigger component.
- Business logic should **never be written directly inside triggers**.
- Triggers should act as a dispatcher and delegate logic to a **Handler class**.
- Salesforce enforces separation of concerns for scalability and maintainability.
- How to debug common Apex compile-time errors like:
  - `Unexpected token 'trigger'`
  - `Cannot save a trigger during a class save`

---

### Trigger Implementation
```apex
trigger JobApplicationTrigger on Job_Application__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        JobApplicationTriggerHandler.beforeInsert(Trigger.new);
    }
}
```
### Trigger Handler Class
```apex
public class JobApplicationTriggerHandler {

    public static void beforeInsert(List<Job_Application__c> newApplications) {
        for (Job_Application__c app : newApplications) {
            if (app.Status__c == null) {
                app.Status__c = 'Applied';
            }
        }
    }
}
```
---
## Day 27 — Apex Bulkification & Governor Limits

### Objective
Learn how to write **production-ready Apex triggers** that safely handle **bulk data operations** without hitting Salesforce governor limits.

---

### Problem Statement
Salesforce enforces strict governor limits:
- Max **100 SOQL queries**
- Max **150 DML statements** per transaction

Triggers often fail in production when:
- SOQL queries are placed **inside loops**
- Code works for 1 record but fails for bulk inserts/updates

---

### Key Concepts Learned
- Why triggers always execute in **bulk context**
- Why **SOQL/DML inside loops** is dangerous
- How to use **Set** to collect record IDs
- How to use **Map<Id, SObject>** for fast lookups
- How to design **bulk-safe trigger handlers**

---

### Implementation (Bulk-Safe Pattern)

#### Step 1️ Collect related record IDs
```apex
Set<Id> companyIds = new Set<Id>();

for (Job_Application__c app : newRecords) {
    if (app.Company__c != null) {
        companyIds.add(app.Company__c);
    }
}
```
#### Step 2 Query Releted Record Once
```apex
Map<Id, Company__c> companyMap = new Map<Id, Company__c>(
    [SELECT Id, Name FROM Company__c WHERE Id IN :companyIds]
);
```
####  Step 3 Apply business logic using map
```apex
for (Job_Application__c app : newRecords) {
    Company__c comp = companyMap.get(app.Company__c);
    if (comp != null) {
        // Business logic here
    }
}
```
### Bulk Test (Execute Anonymous)
```apex
List<Job_Application__c> apps = new List<Job_Application__c>();

for (Integer i = 0; i < 50; i++) {
    apps.add(new Job_Application__c(
        Name = 'Bulk App ' + i,
        Status__c = 'Applied'
    ));
}

insert apps;
```
---
