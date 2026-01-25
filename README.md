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
## Day 28 Trigger Recursion Guard (Prevent Infinite Loops)

### Objective
Implement a recursion guard pattern in Salesforce Apex triggers to prevent infinite trigger execution caused by internal DML operations.

---

### Problem
Triggers can re-execute when:
- A trigger updates the same object
- Workflow / Flow / Process Builder updates the record
- Multiple trigger events fire in a single transaction

This can cause:
- Infinite loops
- Governor limit exceptions
- Data inconsistency

---

### Solution
Use a static variable as a recursion guard so trigger logic runs only once per transaction.

---

### Trigger Execution Control Class
```apex
public class TriggerExecutionControl {
    public static Boolean hasRun = false;
}
```
### Trigger Implementation
```apex
trigger JobApplicationTrigger on Job_Application__c (before insert, before update) {

    // Recursion Guard
    if (TriggerExecutionControl.hasRun) {
        return;
    }
    TriggerExecutionControl.hasRun = true;

    if (Trigger.isBefore && Trigger.isInsert) {
        JobApplicationTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        JobApplicationTriggerHandler.beforeUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }
}

```
### Trigger Handler Class
```apex
public class JobApplicationTriggerHandler {

    public static void beforeInsert(List<Job_Application__c> newList) {
        for (Job_Application__c app : newList) {
            if (app.Status__c == null) {
                app.Status__c = 'Applied';
            }
        }
    }

    public static void beforeUpdate(
        List<Job_Application__c> newList,
        Map<Id, Job_Application__c> oldMap
    ) {
        for (Job_Application__c newRec : newList) {
            Job_Application__c oldRec = oldMap.get(newRec.Id);

            if (newRec.Status__c != oldRec.Status__c) {
                System.debug(
                    'Status changed from ' +
                    oldRec.Status__c +
                    ' to ' +
                    newRec.Status__c
                );
            }
        }
    }
}
```
### Key Learnings
- Triggers can fire multiple times in one transaction
- Static variables persist for the full transaction
- Recursion guards prevent infinite loops
- Mandatory pattern for production-ready triggers
- Improves performance and stability

---
## Day 29 — Trigger Framework Refactor (Industry Standard)

### Objective
Refactor Apex Trigger and Handler to follow **industry-standard trigger framework**, eliminate compile/runtime errors, and make logic reusable, testable, and scalable.

---

### Problem Faced
- Compile errors due to direct usage of `Trigger` context inside handler class
- Method signature mismatches between Trigger and Handler
- Repeated execution and unpredictable behavior during insert/update

---

### Solution Implemented
Implemented a **proper Trigger → Handler architecture** where:
- Trigger only routes context
- Handler contains pure business logic
- No direct `Trigger` references inside handler methods

---

### Final Trigger (Router Only)

```apex
trigger JobApplicationTrigger on Job_Application__c (
    before insert,
    before update,
    after insert,
    after update
) {
    JobApplicationTriggerHandler.run(
        Trigger.new,
        Trigger.oldMap,
        Trigger.isBefore,
        Trigger.isAfter,
        Trigger.isInsert,
        Trigger.isUpdate
    );
}
```
### Trigger Handeler  
```apex
public class JobApplicationTriggerHandler {

    public static void run(
        List<Job_Application__c> newList,
        Map<Id, Job_Application__c> oldMap,
        Boolean isBefore,
        Boolean isAfter,
        Boolean isInsert,
        Boolean isUpdate
    ) {

        if (isBefore) {
            if (isInsert) {
                beforeInsert(newList);
            }
            if (isUpdate) {
                beforeUpdate(newList, oldMap);
            }
        }

        if (isAfter) {
            if (isInsert) {
                afterInsert(newList);
            }
            if (isUpdate) {
                afterUpdate(newList, oldMap);
            }
        }
    }

    private static void beforeInsert(List<Job_Application__c> newList) {
        for (Job_Application__c app : newList) {
            if (app.Status__c == null) {
                app.Status__c = 'Applied';
            }
        }
    }

    private static void beforeUpdate(
        List<Job_Application__c> newList,
        Map<Id, Job_Application__c> oldMap
    ) {
        for (Job_Application__c app : newList) {
            Job_Application__c oldRec = oldMap.get(app.Id);
            if (app.Status__c != oldRec.Status__c) {
                System.debug('Status changed');
            }
        }
    }

    private static void afterInsert(List<Job_Application__c> newList) {
        // future logic
    }

    private static void afterUpdate(
        List<Job_Application__c> newList,
        Map<Id, Job_Application__c> oldMap
    ) {
        // future logic
    }
}
```
### What I Learned
- Why handlers must not directly reference Trigger
- How to design a scalable trigger framework
- Importance of separating routing and business logic
- How real production Salesforce code is structured
---

# Day 30 — Apex Test Classes (Trigger Validation)

### Objective
Write meaningful Apex test classes to validate trigger behavior and ensure production-ready deployments.

---

### Why This Matters
In Salesforce, Apex code **cannot be deployed without tests**.  
More importantly, good test classes:
- Prove business logic works
- Catch edge cases early
- Protect code during future changes
- Are heavily evaluated in interviews

Coverage alone is not enough — **assertions matter**.

---

### What Was Tested

#### 1️⃣ Before Insert Logic
- Verified that `Status__c` is automatically set to **Applied** when not provided.
- Ensured trigger logic executes correctly during record creation.

#### 2️⃣ Before Update Logic
- Verified that status updates work correctly.
- Ensured trigger executes safely during update without errors.

---

### Test Class Implementation

```apex
@isTest
public class JobApplicationTriggerHandlerTest {

    @isTest
    static void testBeforeInsert() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Test Insert'
        );

        Test.startTest();
        insert app;
        Test.stopTest();

        Job_Application__c insertedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Applied',
            insertedApp.Status__c,
            'Status should default to Applied on insert'
        );
    }

    @isTest
    static void testBeforeUpdate() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Test Update',
            Status__c = 'Applied'
        );
        insert app;

        app.Status__c = 'Interviewing';

        Test.startTest();
        update app;
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Status should update correctly'
        );
    }
}
```
### Key Learnings

- Test classes validate behavior, not just coverage
- Test.startTest() and Test.stopTest() isolate execution
- Assertions are mandatory for meaningful tests
- Triggers must be tested for both insert and update paths
---
# Day 31 Apex Test Class & Trigger Coverage

### 🎯 Objective
Learn how to properly write and execute Apex test classes to validate trigger logic and ensure Salesforce deployment readiness.

---

### 🔍 What I Worked On
- Created a dedicated **Apex Test Class** for `JobApplicationTriggerHandler`
- Wrote test methods for:
  - `before insert` trigger logic
  - Default field value assignment
  - Bulk insert scenarios
- Executed tests using **Apex Test Execution**
- Verified trigger execution inside test context
- Ensured assertions validate actual business behavior
- Achieved required **code coverage (≥ 75%)**

---

### 🧠 Key Learnings
- Apex test methods must be written inside a class annotated with `@isTest`
- Every test runs in an isolated test context (no org data access)
- `Test.startTest()` and `Test.stopTest()` are essential for accurate execution
- Assertions (`System.assertEquals`) are mandatory — coverage alone is NOT enough
- Triggers must be tested via DML operations, not direct method calls
- Bulk testing is critical to avoid governor limit issues

---

### 🧪 Sample Test Logic (Simplified)

```apex
@isTest
public class JobApplicationTriggerHandlerTest {

    @isTest
    static void testBeforeInsert_DefaultStatus() {
        List<Job_Application__c> apps = new List<Job_Application__c>();

        for (Integer i = 0; i < 5; i++) {
            apps.add(new Job_Application__c(
                Name = 'Test Application ' + i
            ));
        }

        Test.startTest();
        insert apps;
        Test.stopTest();

        List<Job_Application__c> insertedApps = [
            SELECT Status__c FROM Job_Application__c
        ];

        for (Job_Application__c app : insertedApps) {
            System.assertEquals('Applied', app.Status__c);
        }
    }
}
```
### Outcome
- Trigger logic validated through tests
- No runtime or validation errors
- Production-ready Apex with verified behavior
- Strong foundation for deployment and interviews

---
# Day 32 Exception Handling in Apex

### 🎯 Objective
Implement proper exception handling in Apex to make trigger logic safer, more reliable, and production-ready.

---

### 🔍 What I Worked On
- Added `try–catch` blocks in trigger handler methods
- Handled `DmlException` separately to capture meaningful error details
- Logged clear debug messages to improve traceability
- Wrote test logic to intentionally trigger and validate exception scenarios

---

### 🧠 Why This Matters
In real Salesforce implementations:
- DML operations can fail due to validation rules, missing fields, or data integrity issues
- Unhandled exceptions break user transactions and reduce system reliability
- Proper exception handling ensures failures are predictable and debuggable

Exception handling is a critical part of writing maintainable and enterprise-grade Apex.

---

### 🧩 Sample Implementation

```apex
private static void beforeInsert(List<Job_Application__c> newList) {
    try {
        for (Job_Application__c app : newList) {
            if (app.Status__c == null) {
                app.Status__c = 'Applied';
            }
        }
    } catch (Exception e) {
        System.debug('Error in beforeInsert: ' + e.getMessage());
    }
}
```
```
public static void safeUpdate(List<Job_Application__c> apps) {
    try {
        update apps;
    } catch (DmlException e) {
        System.debug('DML Error: ' + e.getDmlMessage(0));
    }
}
```
### 🧪 Testing Exception Scenarios
```apex
@isTest
static void testExceptionHandling() {
    Job_Application__c app = new Job_Application__c();

    Test.startTest();
    try {
        insert app;
    } catch (DmlException e) {
        System.assert(
            e.getMessage().contains('Required fields are missing'),
            'Expected DML exception for missing required fields'
        );
    }
    Test.stopTest();
}
```
### ✅ Outcome

- Trigger logic now fails gracefully instead of crashing
- Errors are logged with meaningful messages
- Exception scenarios are explicitly tested
- Apex code is safer and more production-ready
---

# Day 33 Asynchronous Apex (@future) + Testing

### Objective
Learn how to implement asynchronous Apex using `@future` methods and validate async behavior through proper test execution.

---

### What I Worked On
- Implemented an `@future` method to process Job Application records asynchronously
- Passed record IDs as primitives to comply with async method requirements
- Updated records in a separate transaction without blocking the main flow
- Created a dedicated test class to validate async execution
- Used `Test.startTest()` and `Test.stopTest()` to force future method execution
- Verified data changes using assertions

---

### Key Learnings
- `@future` methods run in a separate transaction and cannot return values
- Only primitive data types (e.g., `Set<Id>`) are allowed as parameters
- Async code does not execute in tests unless wrapped with `Test.startTest()` and `Test.stopTest()`
- Validation rules still apply during async DML operations
- Proper test data must satisfy all business rules

---

### Future Method Implementation

```apex
public class JobApplicationAsyncService {

    @future
    public static void processApplications(Set<Id> applicationIds) {

        List<Job_Application__c> apps = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id IN :applicationIds
        ];

        for (Job_Application__c app : apps) {
            app.Status__c = 'Interviewing';
        }

        if (!apps.isEmpty()) {
            update apps;
        }
    }
}
```
### Test Class for Async Apex
```apex
@isTest
public class JobApplicationAsyncServiceTest {

    @isTest
    static void testFutureMethod() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Future Test App',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Software Engineer',
            Expected_salary__c = 30000
        );
        insert app;

        Set<Id> ids = new Set<Id>{ app.Id };

        Test.startTest();
        JobApplicationAsyncService.processApplications(ids);
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Future method should update status'
        );
    }
}
```
### Outcome

- Asynchronous logic executed successfully
- Future method behavior validated through tests
- No runtime or validation errors
- Production-ready async Apex with proper test coverage
---

# Day 34 Queueable Apex (Asynchronous Processing)

### Objective
Implement Queueable Apex to perform asynchronous processing in a scalable, production-ready way and validate its behavior using proper test classes.

---

### What I Worked On
- Implemented a Queueable Apex class to process Job Application records asynchronously
- Passed record IDs using a constructor for clean data handling
- Updated records in a separate transaction without blocking the main process
- Enqueued the job using `System.enqueueJob`
- Created and executed a dedicated test class for Queueable Apex
- Verified async execution using `Test.startTest()` and `Test.stopTest()`

---

### Why Queueable Apex
Compared to `@future`, Queueable Apex:
- Supports chaining of jobs
- Allows passing complex data structures via constructors
- Provides better control and readability
- Is the preferred async pattern in real Salesforce projects

---

### Queueable Apex Implementation

```apex
public class JobApplicationQueueable implements Queueable {

    private Set<Id> applicationIds;

    public JobApplicationQueueable(Set<Id> applicationIds) {
        this.applicationIds = applicationIds;
    }

    public void execute(QueueableContext context) {

        List<Job_Application__c> apps = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id IN :applicationIds
        ];

        for (Job_Application__c app : apps) {
            app.Status__c = 'Interviewing';
        }

        if (!apps.isEmpty()) {
            update apps;
        }
    }
}
```
### Test Class for Queueable Apex
```apex
@isTest
public class JobApplicationQueueableTest {

    @isTest
    static void testQueueableJob() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Queueable Test',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Developer',
            Expected_salary__c = 30000
        );
        insert app;

        Set<Id> ids = new Set<Id>{ app.Id };

        Test.startTest();
        System.enqueueJob(new JobApplicationQueueable(ids));
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Queueable job should update status correctly'
        );
    }
}
```
### Outcome

- Queueable job executed successfully
- Asynchronous logic validated through test class
- No runtime or validation errors
- Production-ready async Apex implementation
---

# Day 35 Queueable Apex Chaining with Recursion Control

### Objective
Implement Queueable Apex with chaining **without causing infinite recursion or stack depth errors**, and validate behavior using tests.

---

## Queueable Apex Implementation

```apex
public class JobApplicationQueueable implements Queueable {

    private Set<Id> applicationIds;
    private static Boolean hasRun = false; // recursion guard

    public JobApplicationQueueable(Set<Id> ids) {
        this.applicationIds = ids;
    }

    public void execute(QueueableContext context) {

        // Prevent infinite queueable chaining
        if (hasRun) {
            return;
        }
        hasRun = true;

        List<Job_Application__c> apps = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id IN :applicationIds
        ];

        for (Job_Application__c app : apps) {
            app.Status__c = 'Interviewing';
        }

        if (!apps.isEmpty()) {
            update apps;
        }
    }
}
```
### Queueable Test Class
```apex
@isTest
public class JobApplicationQueueableTest {

    @isTest
    static void testQueueableExecution() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Queueable Test',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Developer',
            Expected_salary__c = 30000
        );
        insert app;

        Test.startTest();
        System.enqueueJob(
            new JobApplicationQueueable(new Set<Id>{ app.Id })
        );
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c
        );
    }
}
```
## Key Learnings

- Queueable jobs must use recursion guards
- Chaining without conditions leads to System.AsyncException: Maximum stack depth
- Always validate async logic using Test.startTest() / Test.stopTest()
- Defensive coding is mandatory for production-ready Apex
---

# Day 36 Batch Apex Testing & Execution Control

### Objective
Implement and successfully test **Batch Apex execution** while handling Salesforce test limitations related to `executeBatch`.

---

### What I Worked On
- Built and tested a **Batch Apex class** for processing `Job_Application__c` records.
- Faced and resolved the common Salesforce testing error:
  > *No more than one executeBatch can be called from within a test method*
- Learned how **batch size and iterable size** directly affect test execution.
- Ensured only **one batch execution** occurs during tests.

---

### Key Learnings
- In test context, Salesforce allows **only ONE `executeBatch()` call**.
- If `start()` returns more records than the batch size → Salesforce internally triggers multiple executions → test fails.
- Solution:
  - Control test data size
  - Match iterable size with batch size
- Batch tests must be **predictable and controlled**, not “realistic scale”.

---

### Sample Batch Test Code (Final Working Version)

```apex
@isTest
public class JobApplicationBatchTest {

    @isTest
    static void testBatchExecution() {

        // Create minimal test data
        List<Job_Application__c> apps = new List<Job_Application__c>();
        for (Integer i = 0; i < 5; i++) {
            apps.add(new Job_Application__c(
                Name = 'Batch Test ' + i,
                Status__c = 'Applied'
            ));
        }
        insert apps;

        Test.startTest();
        // Batch size matches iterable size → single execution
        Database.executeBatch(new JobApplicationBatch(), 5);
        Test.stopTest();

        // Verify outcome
        List<Job_Application__c> updatedApps = [
            SELECT Status__c
            FROM Job_Application__c
        ];

        for (Job_Application__c app : updatedApps) {
            System.assertNotEquals(null, app.Status__c);
        }
    }
}
```
---
# Day 37  Schedulable Apex (Automating Batch Jobs)

### Objective
Implement **Schedulable Apex** to automate Batch Apex execution using cron expressions and validate scheduler behavior through Apex tests.

---

## What I Worked On
- Created a **Schedulable Apex** class to trigger Batch Apex automatically
- Scheduled Batch execution using **cron expressions**
- Learned how Salesforce handles scheduled jobs internally
- Wrote and executed a **test class for Schedulable Apex**
- Validated job registration using `CronTrigger`

---

## Schedulable Apex Implementation

```apex
global class JobApplicationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        Database.executeBatch(new JobApplicationBatch(), 1);
    }
}
```
## Purpose

- Separates when the job runs (Scheduler)
- From what the job does (Batch Apex)
- This is the standard enterprise pattern in Salesforce

## Scheduling the Job (Execute Anonymous)
```apex
String cronExp = '0 0 2 * * ?'; // Runs daily at 2 AM

System.schedule(
    'Daily Job Application Batch',
    cronExp,
    new JobApplicationScheduler()
);
```
## Test Class for Schedulable Apex
```apex
@isTest
public class JobApplicationSchedulerTest {

    @isTest
    static void testScheduler() {

        Test.startTest();
        String jobId = System.schedule(
            'Test Scheduler Job',
            '0 0 0 1 1 ? 2050',
            new JobApplicationScheduler()
        );
        Test.stopTest();

        CronTrigger ct = [
            SELECT Id, CronExpression, TimesTriggered
            FROM CronTrigger
            WHERE Id = :jobId
        ];

        System.assertEquals(0, ct.TimesTriggered);
    }
}
```
## Key Learnings

- Schedulable Apex is used to automate Batch or Queueable jobs
- Cron expressions define when a job runs
- Scheduled jobs must be tested by validating job registration, not execution timing
- Batch + Scheduler is a common production pattern

## Concepts Covered

- Schedulable Apex
- Cron expressions
- Batch automation
- Apex scheduler testing
- Salesforce async architecture
---
# Day 38 Stateful Batch Apex (Final, Tested & Working)

##  Overview
Today’s focus was on **Stateful Batch Apex** and **writing a correct test class** that respects Salesforce’s testing constraints.

This task involved fixing one of the most common (and tricky) Apex errors:
>  *No more than one executeBatch can be called from within a test method*

After restructuring the batch and test logic correctly, the batch executed successfully and all tests passed.

---

##  Key Concepts Implemented
- `Database.Batchable<SObject>`
- `Database.Stateful`
- Controlled batch size for testing
- Proper `Test.startTest()` / `Test.stopTest()`
- Safe aggregation using stateful variables

---

##  Batch Apex Class (Stateful)

```apex
public class JobApplicationStatefulBatch
    implements Database.Batchable<SObject>, Database.Stateful {

    public Integer processedCount = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Status__c FROM Job_Application__c WHERE Status__c = \'Applied\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Job_Application__c> scope) {
        for (Job_Application__c app : scope) {
            app.Status__c = 'Interviewing';
            processedCount++;
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Total Records Processed: ' + processedCount);
    }
}
```
## Test Class (Correct & Passing)
```apex
@isTest
public class JobApplicationStatefulBatchTest {

    @isTest
    static void testStatefulBatch() {

        // Test Data
        List<Job_Application__c> apps = new List<Job_Application__c>();
        for (Integer i = 0; i < 5; i++) {
            apps.add(new Job_Application__c(
                Name = 'Batch App ' + i,
                Status__c = 'Applied',
                Interview_Date__c = Date.today().addDays(1),
                Position__c = 'Developer',
                Expected_salary__c = 30000
            ));
        }
        insert apps;

        Test.startTest();
        Database.executeBatch(new JobApplicationStatefulBatch(), 5);
        Test.stopTest();

        // Verification
        Integer countUpdated = [
            SELECT COUNT()
            FROM Job_Application__c
            WHERE Status__c = 'Interviewing'
        ];

        System.assertEquals(5, countUpdated, 'All records should be updated');
    }
}
```
## Outcome

- Stateful variable preserved across batch executions
- Single executeBatch() invocation in test
- Clean PASS in Application Test Execution
- Production-safe batch pattern
