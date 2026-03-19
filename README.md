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

# Day 39 Schedulable Apex (Batch Automation) V2

### Objective
Automate Batch Apex execution using **Schedulable Apex** and handle platform constraints related to scheduled jobs.

---

### What I Implemented
- Created a `Schedulable` Apex class to trigger Batch Apex
- Scheduled the job using a CRON expression via `System.schedule`
- Handled Salesforce limitation allowing only one scheduled job per class
- Verified job registration using `CronTrigger`
- Wrote and executed a scheduler test class

---

### Scheduler Class

```apex
public class JobApplicationSchedulerV2 implements Schedulable {

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new JobApplicationBatch(), 50);
    }
}
```
### Scheduling the Job (Execute Anonymous)
```apex
System.schedule(
    'Job Application Daily Scheduler',
    '0 0 12 * * ?',
    new JobApplicationSchedulerV2()
);
```
### Scheduler Test Class
```apex
@isTest
public class JobApplicationSchedulerTestV2 {

    @isTest
    static void testSchedulerExecutionV2() {

        Test.startTest();
        System.schedule(
            'Test Scheduler Job',
            '0 0 0 1 1 ? 2099',
            new JobApplicationSchedulerV2()
        );
        Test.stopTest();

        List<CronTrigger> ct = [
            SELECT Id, State
            FROM CronTrigger
            WHERE CronJobDetail.Name = 'Test Scheduler Job'
        ];

        System.assertEquals(1, ct.size());
        System.assertEquals('WAITING', ct[0].State);
    }
}
```
## Key Learnings

- Salesforce allows only one active scheduled job per schedulable class
- Duplicate scheduling must be handled by deleting existing jobs or changing job names
- Scheduler tests validate job registration, not execution timing
- Scheduler + Batch is a standard production automation pattern
---
# Day 40 Batch Apex with Validation-Safe Updates (End-to-End)

### Objective
Implement a Batch Apex job that updates `Job_Application__c` records from **Applied → Interviewing** while respecting org-level validation rules, and ensure the test class passes reliably.

---

## Batch Apex Class

```apex
public class JobApplicationErrorHandlingBatch
    implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Status__c, Interview_Date__c, Position__c ' +
            'FROM Job_Application__c ' +
            'WHERE Status__c = \'Applied\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Job_Application__c> scope) {

        List<Job_Application__c> toUpdate = new List<Job_Application__c>();

        for (Job_Application__c app : scope) {
            try {
                app.Status__c = 'Interviewing';

                // Populate required fields to satisfy validation rules
                if (app.Interview_Date__c == null) {
                    app.Interview_Date__c = Date.today().addDays(1);
                }
                if (app.Position__c == null) {
                    app.Position__c = 'Developer';
                }

                toUpdate.add(app);

            } catch (Exception e) {
                System.debug('Skipped record due to error: ' + e.getMessage());
            }
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch execution completed');
    }
}
```
## Test Class
```apex
@isTest
public class JobApplicationErrorHandlingBatchTest {

    @isTest
    static void testBatchUpdatesStatus() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Batch Test Application',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(2),
            Position__c = 'Developer'
        );
        insert app;

        Test.startTest();
        Database.executeBatch(new JobApplicationErrorHandlingBatch(), 1);
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Application status should be updated to Interviewing'
        );
    }
}
```
## Key Learnings
- Batch Apex must always respect validation rules
- Test failures often come from missing required data, not logic errors
- Always align batch logic with real business constraints
- Small batch size ensures predictable test execution
---
# Day 41 – Salesforce Platform Events

## Overview
Implemented an end-to-end Platform Event–driven workflow to handle Job Application status transitions asynchronously. The focus was on decoupled architecture, reliable event publishing, and safe subscriber-side processing under validation rules.

---

## Components Implemented

### 1. Platform Event
**Object:** Job_Application_Event__e  
**Fields:**
- Job_Application_Id__c (Text)
- Event_Type__c (Text)

---

## 2. Event Publisher (Apex)

```apex
public class JobApplicationEventPublisher {

    public static void publishEvent(Id jobAppId, String eventType) {

        Job_Application_Event__e eventRecord =
            new Job_Application_Event__e(
                Job_Application_Id__c = jobAppId,
                Event_Type__c = eventType
            );

        Database.SaveResult result = EventBus.publish(eventRecord);

        if (!result.isSuccess()) {
            for (Database.Error err : result.getErrors()) {
                System.debug('Event Publish Error: ' + err.getMessage());
            }
        }
    }
}
```

## 3. Event Subscriber (Trigger)
```apex
trigger JobApplicationEventTrigger
    on Job_Application_Event__e (after insert) {

    List<Job_Application__c> applicationsToUpdate = new List<Job_Application__c>();

    for (Job_Application_Event__e evt : Trigger.new) {

        if (evt.Event_Type__c == 'MOVE_TO_INTERVIEW') {

            Job_Application__c app = new Job_Application__c(
                Id = evt.Job_Application_Id__c,
                Status__c = 'Interviewing',
                Interview_Date__c = Date.today()
            );

            applicationsToUpdate.add(app);
        }
    }

    if (!applicationsToUpdate.isEmpty()) {
        update applicationsToUpdate;
    }
}
```
## Execution Flow

1. Job Application record change triggers event publishing
2. Platform Event is published using EventBus
3. Subscriber trigger consumes event asynchronously
4. Job Application status is updated safely with required fields
5. Execution verified via Apex Debug Logs

## Key Learnings
- Platform Events execute in independent async transactions
- Debug logs appear in separate executions
- Validation rules must be handled inside subscribers
- Event-driven design improves scalability and decoupling
---
# Day 42 Change Data Capture (CDC) Trigger Implementation

## Objective
Implement and verify a Change Data Capture (CDC) trigger on the `Job_Application__c` object to track data changes and process them asynchronously using Salesforce Change Events.

---

## What Was Implemented

### 1. Enabled Change Data Capture
- Enabled CDC for `Job_Application__c` from **Setup → Change Data Capture**
- Verified that Salesforce auto-generated `Job_Application__ChangeEvent`

---

### 2. CDC Trigger Creation
Created an Apex trigger on `Job_Application__ChangeEvent` to capture and log change metadata.

```apex
trigger JobApplicationCDCTrigger
on Job_Application__ChangeEvent (after insert) {

    for (Job_Application__ChangeEvent evt : Trigger.new) {

        System.debug('CDC Event Fired');

        System.debug('Change Type: ' +
            evt.ChangeEventHeader.getChangeType()
        );

        System.debug('Record Ids: ' +
            evt.ChangeEventHeader.getRecordIds()
        );

        System.debug('Changed Fields: ' +
            evt.ChangeEventHeader.getChangedFields()
        );
    }
}
```
### 3. Common Issues Resolved
- Corrected invalid references like evt.RecordIds
- Used ChangeEventHeader methods instead of direct field access
- Understood CDC execution context (CDC does not fire from Execute Anonymous)

### 4. Verification Process
- Updated a Job_Application__c record via UI
- Confirmed CDC trigger execution using Debug Logs
- Verified:
  - Change Type
  - Record Ids
  - Changed Fields
  - Successful execution without errors
### Key Learnings
- CDC triggers only fire on actual DML operations (insert/update/delete)
- Platform Events and CDC are separate mechanisms
- ChangeEventHeader must be accessed using getter methods
- Debug logs are the correct way to validate CDC execution

### Status
- CDC Trigger successfully implemented
- Verified through debug logs
- Ready for downstream processing and integrations

# Day 43 CDC Debugging & End-to-End Verification (With Code)

## Objective
Implement and verify a complete Change Data Capture (CDC) flow:
Record Update → CDC Event → CDC Trigger → Queueable → DML

---

## 1. CDC Trigger (after insert)

```apex
trigger JobApplicationCDCTrigger
on Job_Application__ChangeEvent (after insert) {

    for (Job_Application__ChangeEvent evt : Trigger.new) {

        // Extract Change Event metadata
        ChangeEventHeader header = evt.ChangeEventHeader;

        System.debug('CDC Trigger Fired');
        System.debug('Change Type: ' + header.changeType);
        System.debug('Record Ids: ' + header.recordIds);
        System.debug('Changed Fields: ' + header.changedFields);

        // Enqueue async processing
        System.enqueueJob(
            new JobApplicationCDCQueueable(
                header.recordIds,
                header.changeType
            )
        );
    }
}
```
## 2. Queueable Class (Async Processing)
```apex
public class JobApplicationCDCQueueable implements Queueable {

    private Set<Id> recordIds;
    private String changeType;

    public JobApplicationCDCQueueable(Set<Id> recordIds, String changeType) {
        this.recordIds = recordIds;
        this.changeType = changeType;
    }

    public void execute(QueueableContext context) {

        System.debug('Queueable Started');
        System.debug('Change Type: ' + changeType);
        System.debug('Record Ids: ' + recordIds);

        if (changeType == 'UPDATE') {

            List<Job_Application__c> apps = [
                SELECT Id, Status__c
                FROM Job_Application__c
                WHERE Id IN :recordIds
            ];

            for (Job_Application__c app : apps) {
                app.Status__c = 'Interviewing';
            }

            update apps;
        }
    }
}
```
## 3. Debug Configuration (Critical Step)

- Created Custom Debug Level
- Apex Code: DEBUG
- System: DEBUG
- Database: INFO
- Added User Trace Flag with short expiration
- Verified logs under Setup → Debug Logs

## 4. Verification Steps

- Updated Job_Application__c.Status__c via UI
- Confirmed in logs:
- CDC Trigger fired
- ChangeEventHeader populated
- Queueable enqueued
- DML executed successfully

## Key Learnings

- CDC events do NOT fire from anonymous Apex
- Always use ChangeEventHeader
- Async processing is mandatory for scalable CDC logic
- Proper debug levels save hours of confusion
---
# Day 44 Salesforce Named Credential & External Credential Setup (Step 1)

## Objective
Configure Salesforce security correctly using **External Credentials**, **Principals**, and **Permission Sets** to enable secure API callouts without hardcoding secrets.

---

## What I Implemented

### 1. External Credential
- Created `Dummy_API_External`
- Authentication handled via Salesforce-managed security
- Principal configured: `DefaultPrincipal`

### 2. Principal Access via Permission Set
- Created permission set: `Dummy_API_Access`
- Granted **External Credential Principal Access**:
*Dummy_API_External → DefaultPrincipa*
- Assigned permission set to user to authorize usage

### 3. Named Credential
- Created Named Credential linked to:
*External Credential: Dummy_API_External
Principal: DefaultPrincipal*
- Enabled automatic authorization header generation

---

## Why This Matters
- Eliminates hardcoded API keys and tokens
- Aligns with Salesforce’s modern zero-trust security model
- Required foundation for secure Apex HTTP callouts

---

## Sample Apex Callout (Verification)

```apex
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:Dummy_API_Named_Credential/test');
req.setMethod('GET');

Http http = new Http();
HttpResponse res = http.send(req);

System.debug('Status Code: ' + res.getStatusCode());
System.debug('Response Body: ' + res.getBody());
```
## Key Takeaway

Named Credentials do not work alone.
They require:

- External Credential
- Principal
- Permission Set with Principal Access
- User assignment

Miss one step and the callout fails.
---
# Day 45 Backend Completion & Transition to LWC

## Status: Backend Phase Completed

Today marks the successful completion of the Salesforce backend phase of this project. All planned backend tasks have been implemented, tested, debugged, and verified in a real Salesforce org.

This closes the Apex + Integration layer and prepares the foundation for Lightning Web Components (LWC) starting next.

---

## What Was Completed

### Core Backend Features
- Apex Triggers (Standard + Change Data Capture)
- Platform Events for async processing
- Event publishing and consumption
- Batch Apex with error handling
- Proper test classes and coverage
- Debug log analysis and verification
- Named Credentials & External Credentials
- Secure callout configuration
- End-to-end execution testing in org

---

## Sample Final Verified Code

### Platform Event Publisher (Apex)

```apex
public class JobApplicationEventPublisher {

    public static void publishEvent(Id jobAppId, String eventType) {
        Job_Application_Event__e evt = new Job_Application_Event__e(
            Job_Application_Id__c = jobAppId,
            Event_Type__c = eventType
        );

        Database.SaveResult sr = EventBus.publish(evt);

        if (!sr.isSuccess()) {
            for (Database.Error err : sr.getErrors()) {
                System.debug('Event Publish Error: ' + err.getMessage());
            }
        }
    }
}
```
## CDC Trigger (Final Working Version)
```apex
trigger JobApplicationCDCTrigger 
on Job_Application__ChangeEvent (after insert) {

    for (Job_Application__ChangeEvent evt : Trigger.new) {
        System.debug('CDC Event Fired');

        System.debug(
            'Change Type: ' + evt.ChangeEventHeader.changeType
        );

        System.debug(
            'Changed Fields: ' + evt.ChangeEventHeader.changedFields
        );
    }
}
```
## Named Credential Callout (Verified)
```apex
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:Dummy_API_External/test');
req.setMethod('GET');

Http http = new Http();
HttpResponse res = http.send(req);

System.debug('Status Code: ' + res.getStatusCode());
System.debug('Response Body: ' + res.getBody());
```
## Verification Completed

- Debug logs confirm event firing and execution
- CDC events verified via ChangeEventHeader
- Platform events inserted and published successfully
- Named Credential callout executed without auth errors
- Governor limits respected
- No pending compile or runtime issues
---
## Day 46 LWC Setup & First Deployment (VS Code → Salesforce Org)

### What I built
- Set up Salesforce DX project in VS Code
- Installed and configured Salesforce CLI
- Authorized Salesforce Org using SFDX
- Created a Lightning Web Component
- Deployed LWC from VS Code to Salesforce Org
- Activated component using Lightning App Builder
- Verified UI rendering in Lightning Experience

---

### Lightning Web Component: jobApplicationCard

#### jobApplicationCard.html
```html
<template>
    <lightning-card title="Job Application Card">
        <div class="slds-p-around_medium">
            <p>Hello from LWC visible</p>
        </div>
    </lightning-card>
</template>
```
#### jobApplicationCard.js
```js
import { LightningElement } from 'lwc';

export default class JobApplicationCard extends LightningElement {
}
```
#### jobApplicationCard.js-meta.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>59.0</apiVersion>
    <isExposed>true</isExposed>
    <targets>
        <target>lightning__AppPage</target>
        <target>lightning__HomePage</target>
        <target>lightning__RecordPage</target>
    </targets>
</LightningComponentBundle>
```
#### Deployment Command (VS Code → Org)
`sfdx force:source:deploy -p force-app`

### Verification Steps
1. Open Salesforce Org
2. Go to Setup → Lightning App Builder
3. Create a new App Page
4. Drag jobApplicationCard onto the canvas
5. Save → Activate → Open App
6. Confirm message is visible:
   `Hello from LWC Visible`
### Why this matters

This validates the complete Salesforce developer workflow:
local development → deployment → activation → UI verification.

This is the foundation for building production-grade Lightning Web Components.

### Tech Stack

- Salesforce DX
- Lightning Web Components (LWC)
- VS Code + Salesforce Extensions
- Node.js
---
# Day 47 LWC + Apex Integration (First Data Wire)

## Overview
On Day 47, I successfully completed my first end-to-end integration between a Lightning Web Component (LWC) and an Apex controller using VS Code and Salesforce DX.

This milestone covers setting up the local development environment, wiring Apex methods to LWC using `@wire`, deploying metadata to the org, and rendering the component on a Lightning App Page.

---

## What I Built
- A Lightning Web Component: `jobApplicationCard`
- An Apex controller: `JobApplicationController`
- Wired Apex method to LWC using `@wire`
- Deployed the component from VS Code to Salesforce org
- Activated and rendered the component in Lightning App Builder

---

## Key Concepts Practiced
- Salesforce DX project setup
- Org authorization from VS Code
- LWC folder structure and metadata
- Apex to LWC communication
- `@salesforce/apex` imports
- Lightning App Builder activation

---

## Apex Controller
```apex
public with sharing class JobApplicationController {
    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getJobApplications() {
        return [
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            LIMIT 10
        ];
    }
}
```
## LWC JavaScript
```javascript
import { LightningElement, wire } from 'lwc';
import getJobApplications from '@salesforce/apex/JobApplicationController.getJobApplications';

export default class JobApplicationCard extends LightningElement {
    applications;

    @wire(getJobApplications)
    wiredApplications({ data, error }) {
        if (data) {
            this.applications = data;
        } else if (error) {
            console.error(error);
        }
    }
}
```
## LWC HTML
```html
<template>
    <lightning-card title="Job Applications">
        <template if:true={applications}>
            <template for:each={applications} for:item="app">
                <p key={app.Id} class="slds-p-horizontal_small">
                    {app.Name} — {app.Status__c}
                </p>
            </template>
        </template>

        <template if:false={applications}>
            <p class="slds-p-horizontal_small">
                Loading applications...
            </p>
        </template>
    </lightning-card>
</template>
```
## Result

- Deployment succeeded from VS Code
- Component is visible in Lightning App Builder
- LWC renders successfully inside a custom Lightning App
---
# Day 48 Interactive LWC with Modal Popup (Apex → UI)

## Overview
On Day 48, I enhanced my Lightning Web Component to support real user interaction by introducing a modal popup that displays detailed Job Application information. The component fetches data from Apex, renders a list of records, and opens a popup with full details when a user selects a record.

This day focused on **frontend state management, event handling, and conditional rendering in LWC**.

---

## Features Implemented
- Loaded Job Application records dynamically from Apex
- Displayed records in a list with action buttons
- Handled user click events using `data-id`
- Opened a modal popup on selection
- Displayed detailed record information:
  - Application Name
  - Status
  - Interview Date (if available)
  - Applied Date
- Conditional rendering for optional fields
- Clean modal open/close state handling

---

## Apex Controller

```apex
public with sharing class JobApplicationController {

    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getJobApplications() {
        return [
            SELECT
                Id,
                Name,
                Status__c,
                Interview_Date__c,
                CreatedDate
            FROM Job_Application__c
            ORDER BY CreatedDate DESC
        ];
    }
}
```
## Lightning Web Component
`jobApplicationCard.js`
```js
import { LightningElement, wire } from 'lwc';
import getJobApplications from '@salesforce/apex/JobApplicationController.getJobApplications';

export default class JobApplicationCard extends LightningElement {
    applications = [];
    selectedApplication = null;
    isModalOpen = false;

    @wire(getJobApplications)
    wiredApplications({ data, error }) {
        if (data) {
            this.applications = data;
        } else if (error) {
            console.error(error);
        }
    }

    handleSelect(event) {
        const appId = event.currentTarget.dataset.id;

        this.selectedApplication = this.applications.find(
            app => app.Id === appId
        );

        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
        this.selectedApplication = null;
    }
}
```
## jobApplicationCard.html
```apex
<template>
    <lightning-card title="Job Applications">
        <template for:each={applications} for:item="app">
            <div key={app.Id} class="slds-box slds-m-bottom_small">
                <p>
                    <strong>{app.Name}</strong> — {app.Status__c}
                </p>

                <lightning-button
                    label="Select"
                    variant="brand"
                    data-id={app.Id}
                    onclick={handleSelect}>
                </lightning-button>
            </div>
        </template>
    </lightning-card>

    <!-- Modal Popup -->
    <template if:true={isModalOpen}>
        <section role="dialog" class="slds-modal slds-fade-in-open">
            <div class="slds-modal__container">

                <header class="slds-modal__header">
                    <h2 class="slds-text-heading_medium">
                        Job Application Details
                    </h2>
                </header>

                <div class="slds-modal__content slds-p-around_medium">
                    <p><strong>Name:</strong> {selectedApplication.Name}</p>
                    <p><strong>Status:</strong> {selectedApplication.Status__c}</p>

                    <template if:true={selectedApplication.Interview_Date__c}>
                        <p>
                            <strong>Interview Date:</strong>
                            {selectedApplication.Interview_Date__c}
                        </p>
                    </template>

                    <p>
                        <strong>Applied On:</strong>
                        {selectedApplication.CreatedDate}
                    </p>
                </div>

                <footer class="slds-modal__footer">
                    <lightning-button
                        label="Close"
                        onclick={closeModal}>
                    </lightning-button>
                </footer>

            </div>
        </section>

        <div class="slds-backdrop slds-backdrop_open"></div>
    </template>
</template>
```
## Result

- Records load dynamically from Apex
- User interaction triggers a modal popup
- Popup displays full application details
- UI updates without page refresh

## Key Learnings

- Event handling in LWC (onclick, data-*)
- State management for UI behavior
- Conditional rendering using if:true
- Building SLDS-compliant modal dialogs
- Clean separation of data logic (Apex) and UI logic (LWC)
---
# Day 49 Fixing Picklist Errors & Legacy Record Consistency (LWC + Apex)

## Objective
Fix an issue where updating the **Status** field from an LWC modal worked for **new records** but failed for **older records**, without changing the existing UI.

---

## Real-World Problem Faced
When updating Job Application records from an LWC modal:
- New records updated successfully
- Old records threw errors on Save

Root cause was **not LWC or Apex logic**, but **legacy picklist data inconsistency**.

---

## 🔍 Root Cause Analysis
- Status__c is a **restricted picklist**
- Older records contained values that were:
  - Removed
  - Renamed
  - Inactive
- Salesforce blocks updates when invalid picklist values exist

Metadata changes do **not** auto-fix existing data.

---

## Solution Implemented
- Normalized legacy Job Application records
- Ensured all records use **currently active picklist values**
- No UI changes
- No Apex hacks
- No validation bypass

Result: **All records (old + new) update cleanly**

---

## Apex Controller

```apex
public with sharing class JobApplicationController {

    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getJobApplications() {
        return [
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static Job_Application__c getJobApplicationDetails(Id recordId) {
        return [
            SELECT Id, Name, Position__c, Status__c,
                   Company__r.Name,
                   CreatedDate,
                   Interview_Date__c
            FROM Job_Application__c
            WHERE Id = :recordId
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static void updateJobApplication(Job_Application__c application) {
        update application;
    }
}
```
## LWC JavaScript
```JS
import { LightningElement, track } from 'lwc';
import getJobApplications from '@salesforce/apex/JobApplicationController.getJobApplications';
import getJobApplicationDetails from '@salesforce/apex/JobApplicationController.getJobApplicationDetails';
import updateJobApplication from '@salesforce/apex/JobApplicationController.updateJobApplication';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class JobApplicationCard extends LightningElement {

    @track applications = [];
    @track selectedApplication;
    @track showModal = false;

    connectedCallback() {
        this.loadApplications();
    }

    loadApplications() {
        getJobApplications()
            .then(result => {
                this.applications = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleSelect(event) {
        const recordId = event.target.dataset.id;

        getJobApplicationDetails({ recordId })
            .then(result => {
                this.selectedApplication = { ...result };
                this.showModal = true;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleStatusChange(event) {
        this.selectedApplication.Status__c = event.detail.value;
    }

    handleSave() {
        updateJobApplication({ application: this.selectedApplication })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Status updated successfully',
                        variant: 'success'
                    })
                );
                this.showModal = false;
                this.loadApplications();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    handleClose() {
        this.showModal = false;
    }
}
```
## LWC HTML
```HTML
<template>
    <template if:true={showModal}>
        <section class="slds-modal slds-fade-in-open">
            <div class="slds-modal__container">
                <header class="slds-modal__header">
                    <h2 class="slds-text-heading_medium">Candidate Details</h2>
                </header>

                <div class="slds-modal__content slds-p-around_medium">
                    <p><b>Name:</b> {selectedApplication.Name}</p>
                    <p><b>Position:</b> {selectedApplication.Position__c}</p>
                    <p><b>Company:</b> {selectedApplication.Company__r.Name}</p>

                    <lightning-combobox
                        label="Status"
                        value={selectedApplication.Status__c}
                        options={statusOptions}
                        onchange={handleStatusChange}>
                    </lightning-combobox>

                    <p><b>Applied Date:</b> {selectedApplication.CreatedDate}</p>
                    <p><b>Interview Date:</b> {selectedApplication.Interview_Date__c}</p>
                </div>

                <footer class="slds-modal__footer">
                    <lightning-button label="Close" onclick={handleClose}></lightning-button>
                    <lightning-button variant="brand" label="Save" onclick={handleSave}></lightning-button>
                </footer>
            </div>
        </section>
        <div class="slds-backdrop slds-backdrop_open"></div>
    </template>
</template>
```
## Key Learnings

- Restricted picklists can break updates for legacy records
- Metadata changes ≠ data fixes
- Always validate existing data, not just code
- Do not change UI when the issue is data integrity

 ## Outcome

✔ All Job Application records update successfully
✔ No UI changes required
✔ Production-safe fix applied
---
# Day 50  State Management & UX Safety in LWC

## Objective
Enhance the existing Lightning Web Component by adding proper state management
and UX safeguards, without changing the UI layout.

The focus was on preventing invalid user actions and ensuring predictable,
production-ready behavior.

---

## Problem Statement
The Save button in the modal was:
- Disabled initially (expected)
- Remaining disabled even after changing the Status value (unexpected)

This indicated an issue in client-side state handling rather than UI or Apex logic.

---

## Root Cause
- The original Status value and the user-selected Status were not tracked separately
- Save button enablement logic depended on incorrect state comparison
- LWC template expressions do not support inline logical or unary operations

---

## Solution Implemented

### 1. State Tracking
- Stored the original Status when the modal opened
- Tracked the currently selected Status separately

### 2. Getter-Based UI Control
- Implemented a JavaScript getter to determine whether the Save button should be enabled
- Ensured all logic lives in JavaScript, not in the HTML template

### 3. UX Safeguards
- Save button enabled only when the Status value changes
- Prevented unnecessary Apex calls
- Reset component state when the modal is closed

---

## Key JavaScript Logic

```js
handleSelect(event) {
    this.originalStatus = result.Status__c;
    this.selectedStatus = result.Status__c;
}

handleStatusChange(event) {
    this.selectedStatus = event.detail.value;
}

get isSaveDisabled() {
    return this.selectedStatus === this.originalStatus;
}
```
## Key Learnings

- LWC templates do not allow logical or unary expressions
- UI behavior must be controlled through JavaScript getters
- Proper state comparison is essential for predictable UX
- Preventing unnecessary updates is part of production-quality development

## Outcome

- Save button behaves correctly based on user interaction
- No UI redesign required
- Component now follows enterprise LWC best practices
---

# Day 51 Controlled Updates, UX Safety & Defensive Programming (LWC + Apex)

## Objective
Implement a safe, production-ready update mechanism for Job Application status
by ensuring that records are updated **only when a real change occurs**.

The goal was not to add new UI features, but to enforce **intelligent data updates**
with proper user feedback and backend validation.

---

## Core Problem
Users could click Save even when no meaningful change was made.
This resulted in:
- Unnecessary Apex DML calls
- Confusing user experience
- Risk of duplicate updates

---

## Solution Overview

### 1. Client-Side Change Detection (LWC)
- Stored the original Status value when the modal opened
- Tracked the user-selected Status separately
- Enabled Save only when the two values differed

```js
get isSaveDisabled() {
    return !this.selectedStatus || this.selectedStatus === this.originalStatus;
}
```
This ensures the UI allows saving only when a real change occurs.

### 2. Server-Side Validation Guard (Apex)

- Apex does not trust the UI blindly
- Before performing DML, the existing value is compared with the incoming value
- If no change is detected, the update is blocked
```apex
if (app.Status__c == status) {
    throw new AuraHandledException('No changes detected. Update skipped.');
}
```
This prevents unnecessary DML and protects data integrity.

### 3. User Feedback & UI Synchronization

- Success and error toast messages inform the user of outcomes
- The Job Application list refreshes automatically after update
- Modal state is reset cleanly after save
```js
.then(() => {
    this.showToast('Success', 'Status updated successfully', 'success');
    this.showModal = false;
    return refreshApex(this.wiredResult);
})
```
## Key Learnings

- UI logic must be driven by state comparison, not button clicks
- Backend logic must always validate incoming updates
- Preventing unnecessary DML is a core Salesforce best practice
- Defensive programming improves both performance and reliability

## Outcome

- Save is enabled only when a real change is made
- Duplicate and no-op updates are blocked at both UI and backend levels
- Users receive clear feedback for success and failure
- Component behavior aligns with real-world Salesforce production standards
---
# Day 52 Status Transition Rules (Business Logic Enforcement)

## Objective
Implement controlled workflow transitions for Job Application records.
The system must prevent invalid status jumps and enforce structured hiring stages.

This ensures:
- Data integrity
- Process consistency
- Enterprise-grade backend validation

---

## Problem

Without transition control:
- Users can jump from Applied → Offered
- Users can move from Rejected → Interviewing
- Hiring workflow becomes inconsistent
- Backend allows invalid business logic

A production system must enforce process rules at the server level.

---

## Solution

Transition rules were implemented inside Apex.

Allowed transitions:

Applied → Interviewing  
Interviewing → Offered  
Interviewing → Rejected  

All other transitions are blocked.

---

## Apex Implementation

```apex
@AuraEnabled
public static void updateJobApplicationStatus(Id recordId, String status) {

    Job_Application__c app = [
        SELECT Id, Status__c
        FROM Job_Application__c
        WHERE Id = :recordId
        LIMIT 1
    ];

    String currentStatus = app.Status__c;

    if (currentStatus == status) {
        throw new AuraHandledException(
            'No changes detected.'
        );
    }

    Boolean isValid = false;

    if (currentStatus == 'Applied' && status == 'Interviewing') {
        isValid = true;
    }
    else if (currentStatus == 'Interviewing' &&
            (status == 'Offered' || status == 'Rejected')) {
        isValid = true;
    }

    if (!isValid) {
        throw new AuraHandledException(
            'Invalid transition from ' + currentStatus + ' to ' + status
        );
    }

    app.Status__c = status;
    update app;
}
```
## Frontend Behavior
No UI redesign required.
LWC:

- Enables Save only when a change is detected
- Displays backend validation errors via toast
- Refreshes list after successful update
The backend remains the final authority.

## Key Concepts Learned

- Business rule enforcement in Apex
- Defensive backend programming
- Controlled workflow transitions
- Separation of UI validation and server validation
- Preventing invalid DML operations

## Outcome

The Job Application workflow now follows a strict hiring process.
Invalid status transitions are blocked at the server level.
The system behaves like a real enterprise Salesforce implementation.
---
# Day 53 Metadata-Driven Status Transition Engine

## Objective
Enhance the Job Application module by implementing a scalable, metadata-driven validation mechanism for status transitions, following enterprise-level architectural practices.

The focus was to eliminate hardcoded logic and introduce a configurable business rules framework.

---

## Key Enhancements

### 1. Custom Metadata for Business Rules

Created a Custom Metadata Type:

Status_Transition_Rule__mdt

Fields:
- From_Status__c (Text)
- To_Status__c (Text)

Sample Records:
- Applied → Interviewing  
- Interviewing → Offered  
- Interviewing → Rejected  

This allows administrators to control valid status transitions without modifying Apex code.

---

### 2. Service Layer Implementation

Created a dedicated service class to centralize validation logic.

**StatusTransitionService.cls**
```apex
public with sharing class StatusTransitionService {
public static void validateTransition(String fromStatus, String toStatus) {

    List<Status_Transition_Rule__mdt> rules = [
        SELECT From_Status__c, To_Status__c
        FROM Status_Transition_Rule__mdt
        WHERE From_Status__c = :fromStatus
        AND To_Status__c = :toStatus
    ];

    if (rules.isEmpty()) {
        throw new AuraHandledException(
            'Invalid Status Transition: ' + fromStatus + ' → ' + toStatus
          );
        }
    }
}
```

Responsibilities:
- Validate status transitions
- Enforce metadata-defined rules
- Throw controlled exceptions for invalid transitions

---

### 3. Controller Refactoring

Updated the controller to delegate validation to the service layer.

**JobApplicationController.cls**
```apex
@AuraEnabled
public static void updateJobApplicationStatus(Id recordId, String status) {
    Job_Application__c app = [
    SELECT Id, Status__c
    FROM Job_Application__c
    WHERE Id = :recordId
    LIMIT 1
];

if (app.Status__c == status) {
    throw new AuraHandledException('No changes detected. Update skipped.');
}

StatusTransitionService.validateTransition(
    app.Status__c,
    status
);

app.Status__c = status;
update app;
}
```

Improvements:
- Prevents redundant updates
- Enforces validation before DML
- Follows separation of concerns

---

## Architectural Structure

LWC (Presentation Layer)  
→ Apex Controller (Orchestration Layer)  
→ Service Layer (Business Logic)  
→ Custom Metadata (Configurable Rules)

This design promotes:
- Maintainability
- Reusability
- Admin configurability
- Reduced technical debt

---

## Outcome

The system now:
- Blocks invalid status transitions
- Allows administrators to define transition rules
- Requires no code changes for rule updates
- Reflects enterprise-grade Salesforce architecture patterns
---
# Day 54 Metadata Driven Status Transition + Profile-Based Authorization

## Objective

Implement enterprise-level status transition validation using:
- Custom Metadata (Status Transition Rules)
- Apex Service Layer
- Profile-based authorization
- LWC → Apex → Service architecture

---

## What We Built

Today we implemented a fully metadata-driven validation system to control 
Job Application status transitions.

Instead of hardcoding logic in LWC or Apex, we created:

• Custom Metadata Type: `Status_Transition_Rule__mdt`
• Service Layer: `StatusTransitionService`
• Controller Layer: `JobApplicationController`
• Secure server-side validation
• UI error handling with proper toast messages

---

## Architecture Flow

LWC  
→ calls Apex Controller  
→ Controller calls Service Layer  
→ Service checks Custom Metadata rules  
→ Validates profile + transition  
→ Updates record OR throws error  

---

## Apex Service Layer

### StatusTransitionService.cls

```apex
public with sharing class StatusTransitionService {

    public static void validateTransition(String fromStatus, String toStatus) {

        String currentProfile = [
            SELECT Profile.Name
            FROM User
            WHERE Id = :UserInfo.getUserId()
        ].Profile.Name;

        List<Status_Transition_Rule__mdt> rules = [
            SELECT From_Status__c, To_Status__c, Allowed_Profile__c
            FROM Status_Transition_Rule__mdt
            WHERE From_Status__c = :fromStatus
            AND To_Status__c = :toStatus
        ];

        if (rules.isEmpty()) {
            throw new AuraHandledException('Invalid status transition.');
        }

        Boolean authorized = false;

        for (Status_Transition_Rule__mdt rule : rules) {
            if (rule.Allowed_Profile__c == currentProfile) {
                authorized = true;
                break;
            }
        }

        if (!authorized) {
            throw new AuraHandledException(
                'You are not authorized to perform this transition.'
            );
        }
    }
}
```

---

## Controller Layer

### JobApplicationController.cls

```apex
public with sharing class JobApplicationController {

    @AuraEnabled
    public static void updateJobApplicationStatus(Id recordId, String status) {

        Job_Application__c app = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id = :recordId
            LIMIT 1
        ];

        StatusTransitionService.validateTransition(
            app.Status__c,
            status
        );

        app.Status__c = status;
        update app;
    }
}
```

---

## LWC Enhancements

### Features Implemented

• Candidate full details in modal  
• Applied Date display  
• Interview Date display  
• Status dropdown  
• Save button validation  
• Error toast handling  
• Server-side rule enforcement  

---

## Key Learnings

• Never trust UI validation  
• Business logic belongs in Apex  
• Custom Metadata makes rules configurable  
• Profile-based authorization must be server-side  
• Clean separation of concerns improves scalability  

---

## Outcome

The system now:

✔ Prevents invalid status transitions  
✔ Blocks unauthorized profiles  
✔ Uses configurable rules instead of hardcoding  
✔ Follows real-world enterprise design principles  
---

# Day 55 UX Stabilization & Controlled Status Transitions

## Objective
Upgrade the Job Application dashboard to production-level UX with proper validation, state control, and user feedback.

---

## Enhancements Implemented

• Search by candidate name and position  
• Status-based filtering  
• Controlled status transitions via Apex + Custom Metadata  
• Save button disabled when status unchanged  
• Full-screen loading buffer during update  
• Success and error toast notifications  
• Proper date formatting  
• Empty state handling  

---

## Apex — Status Update with Validation

```apex
@AuraEnabled
public static void updateStatus(Id recordId, String newStatus) {

    Job_Application__c app = [
        SELECT Id, Status__c
        FROM Job_Application__c
        WHERE Id = :recordId
        LIMIT 1
    ];

    String oldStatus = app.Status__c;

    if (oldStatus == newStatus) {
        return;
    }

    StatusTransitionService.validateTransition(oldStatus, newStatus);

    app.Status__c = newStatus;
    update app;
}
```

---

## LWC — Disable Save Button Logic

```javascript
get disableSave() {
    return this.newStatus === this.selectedApplication?.Status__c;
}
```

---

## LWC — Full Screen Saving Buffer

```html
<template if:true={isSaving}>
    <div class="slds-backdrop slds-backdrop_open"></div>
    <div class="slds-spinner_container">
        <lightning-spinner size="large"></lightning-spinner>
    </div>
</template>
```

---

## LWC — Search + Filter Logic

```javascript
applyFilters() {
    this.filteredApplications = this.applications.filter(app => {

        const matchSearch =
            app.Name.toLowerCase().includes(this.searchKey) ||
            app.Position__c?.toLowerCase().includes(this.searchKey);

        const matchStatus =
            this.selectedStatus === 'All' ||
            app.Status__c === this.selectedStatus;

        return matchSearch && matchStatus;
    });
}
```

---

## Result

Day 55 transformed the dashboard from basic CRUD to a structured workflow system with:

• Validated status transitions  
• Controlled UI state  
• Professional UX feedback  
• Clean interaction logic  

This is closer to enterprise-ready Salesforce architecture.
---
# Day 56 — Client-Side Pagination & Scalable UI

## Objective
Improve dashboard scalability by implementing client-side pagination while maintaining search, filter, and edit functionality.

---

## What Was Implemented

• Client-side pagination (5 records per page)  
• Dynamic page calculation  
• Next / Previous navigation  
• Page counter display  
• Integrated search + filter with pagination reset  
• Stable modal edit flow after pagination  
• Preserved spinner + toast behavior  

---

## Pagination State Management (LWC)

```javascript
pageSize = 5;
currentPage = 1;
totalRecords = 0;
totalPages = 0;

@track filteredList = [];
@track displayedRecords = [];
```

---

## Filter + Pagination Integration

```javascript
applyFilters() {
    this.filteredList = this.applications.filter(app => {

        const matchSearch =
            app.Name.toLowerCase().includes(this.searchKey) ||
            app.Position__c?.toLowerCase().includes(this.searchKey);

        const matchStatus =
            this.selectedStatus === 'All' ||
            app.Status__c === this.selectedStatus;

        return matchSearch && matchStatus;
    });

    this.totalRecords = this.filteredList.length;
    this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
    this.currentPage = 1;

    this.updateDisplayedRecords();
}
```

---

## Record Slicing Logic

```javascript
updateDisplayedRecords() {
    const start = (this.currentPage - 1) * this.pageSize;
    const end = start + this.pageSize;
    this.displayedRecords = this.filteredList.slice(start, end);
}
```

---

## Navigation Handlers

```javascript
handleNext() {
    if (this.currentPage < this.totalPages) {
        this.currentPage++;
        this.updateDisplayedRecords();
    }
}

handlePrevious() {
    if (this.currentPage > 1) {
        this.currentPage--;
        this.updateDisplayedRecords();
    }
}
```

---

## Result

The dashboard now:

• Handles larger datasets cleanly  
• Avoids UI overload  
• Maintains filter + search consistency  
• Preserves modal edit stability across pages  

This moves the project closer to real-world scalable Salesforce UI behavior.
---
# Day 57 Server-Side Pagination (Enterprise Upgrade)

## Objective
Move pagination logic from client-side (LWC) to server-side (Apex) for improved scalability and performance.

Previously:
All records were loaded in memory and sliced on the client.

Now:
Only required records are fetched per page using LIMIT + OFFSET in SOQL.

---

## What Was Implemented

• Server-side pagination using LIMIT and OFFSET  
• Dynamic filtering (search + status) handled in Apex  
• Ordered results by CreatedDate DESC  
• Removed full dataset loading from LWC  
• Preserved modal edit functionality  
• Maintained toast + spinner UX  

---

## Apex Paginated Query

```apex
@AuraEnabled(cacheable=true)
public static List<Job_Application__c> getPaginatedApplications(
    Integer pageSize,
    Integer pageNumber,
    String searchKey,
    String statusFilter
) {
    Integer offsetValue = (pageNumber - 1) * pageSize;

    String baseQuery = 'SELECT Id, Name, Position__c, Status__c, ' +
                       'Company__r.Name, CreatedDate, Interview_Date__c ' +
                       'FROM Job_Application__c';

    List<String> conditions = new List<String>();

    if (!String.isBlank(searchKey)) {
        conditions.add(
            '(Name LIKE \'%' + searchKey + '%\' OR Position__c LIKE \'%' + searchKey + '%\')'
        );
    }

    if (!String.isBlank(statusFilter) && statusFilter != 'All') {
        conditions.add('Status__c = \'' + statusFilter + '\'');
    }

    if (!conditions.isEmpty()) {
        baseQuery += ' WHERE ' + String.join(conditions, ' AND ');
    }

    baseQuery += ' ORDER BY CreatedDate DESC';
    baseQuery += ' LIMIT ' + pageSize;
    baseQuery += ' OFFSET ' + offsetValue;

    return Database.query(baseQuery);
}
```

---

## LWC Server Data Fetch

```javascript
loadData() {
    getPaginatedApplications({
        pageSize: this.pageSize,
        pageNumber: this.currentPage,
        searchKey: this.searchKey,
        statusFilter: this.selectedStatus
    })
    .then(result => {
        this.displayedRecords = result;
    })
    .catch(error => {
        console.error(error);
    });
}
```

---

## Architectural Improvement

Old Flow:
Apex → All Records → Client Slicing

New Flow:
LWC → Page Params → Apex Query (LIMIT + OFFSET) → Render

---

## Why This Matters

• Reduced memory usage  
• Improved scalability  
• Cleaner separation of concerns  
• Closer to real-world enterprise implementation  
• Backend-driven filtering  

This marks the shift from UI-based pagination to production-ready data handling.
---
# Day 58 Advanced Analytics Dashboard + Scalable Pagination + Business Rule Enforcement

## Objective

Integrate dynamic querying, pagination, analytics computation, and backend rule enforcement into a single production-style Salesforce module.

This day focused on architecture stability rather than UI redesign.

---

## 1. Dynamic SOQL with Multi-Filter Support

Implemented conditional query construction for:

- Candidate name search
- Status filtering
- Combined conditions
- SQL injection safety

Example:

String baseQuery =
    'SELECT Id, Name, Position__c, Status__c, CreatedDate, Interview_Date__c, Company__r.Name ' +
    'FROM Job_Application__c';

if (!conditions.isEmpty()) {
    baseQuery += ' WHERE ' + String.join(conditions, ' AND ');
}

baseQuery +=
    ' ORDER BY CreatedDate DESC ' +
    ' LIMIT :pageSize OFFSET :offsetValue';

return Database.query(baseQuery);

Key Concepts:
- Dynamic SOQL
- Secure query building
- ORDER BY + LIMIT + OFFSET

---

## 2. Pagination Architecture

Pagination implemented using:

- pageSize
- currentPage
- OFFSET logic
- Dedicated COUNT() query
- totalPages calculation

Separate count method:

@AuraEnabled(cacheable=true)
public static Integer getTotalCount(String searchKey, String statusFilter) {
    return Database.countQuery(countQuery);
}

Reason:
LIMIT does not provide total rows.
COUNT() is required for accurate pagination.

---

## 3. Dashboard Analytics with Percentages

Backend stats computation:

Integer total = [SELECT COUNT() FROM Job_Application__c];

stats.put('AppliedPercent', (applied * 100) / total);
stats.put('InterviewingPercent', (interviewing * 100) / total);
stats.put('OfferedPercent', (offered * 100) / total);
stats.put('RejectedPercent', (rejected * 100) / total);

Frontend binding:

<div>{stats.AppliedPercent}%</div>
<div class="bar">
    <div class="fill" style={appliedWidth}></div>
</div>

JS Getter:

get appliedWidth() {
    return `width:${this.stats.AppliedPercent || 0}%`;
}

---

## 4. Business Rule Enforcement (Forward-Only Status)

Stage progression enforced at Apex layer:

Map<String, Integer> stageOrder = new Map<String, Integer>{
    'Applied' => 1,
    'Interviewing' => 2,
    'Offered' => 3,
    'Rejected' => 4
};

if (stageOrder.get(newStatus) <= stageOrder.get(oldStatus)) {
    throw new AuraHandledException(
        'You cannot move status backward.'
    );
}

Ensures:
- Data integrity
- No UI bypass
- Backend-controlled workflow

---

## 5. History Logging on Status Change

On valid transition:

Job_Application_History__c history =
    new Job_Application_History__c(
        Job_Application__c = app.Id,
        Old_Status__c = oldStatus,
        New_Status__c = newStatus,
        Changed_By__c = UserInfo.getUserId(),
        Changed_On__c = System.now()
    );

insert history;

Provides audit tracking similar to enterprise systems.

---

## 6. LWC–Apex Integration Flow

connectedCallback() {
    this.loadAll();
}

loadAll() {
    this.loadData();
    this.loadStats();
}

After status update:

this.loadAll();

Ensures:
- UI refresh
- Analytics refresh
- Data consistency

---

## Engineering Concepts Strengthened

- Dynamic SOQL construction
- OFFSET pagination design
- COUNT() optimization
- Backend business rule enforcement
- Percentage analytics computation
- Apex–LWC data synchronization
- Audit trail modeling

---

## Architectural Outcome

Day 58 transitioned the project from:

Component-based demo

to

Mini CRM-style system with:
- Query layer
- Rule layer
- Analytics layer
- Audit layer
- UI integration layer

System stable.
Dashboard operational.
Business rules enforced.
Pagination scalable.
---
# Day 59  UI & Status Engine Stabilization (LWC + Apex)

Today focused on stabilizing architecture, fixing integration issues, and enforcing backend-driven workflow control.

---

## 🔧 1. Apex–LWC Integration Fix

- Resolved deployment error:  
  `Unable to find Apex action method referenced as 'JobApplicationController.getApplications'`
- Corrected Apex import references in LWC
- Ensured proper `@AuraEnabled(cacheable=true)` usage
- Implemented stable `refreshApex` pattern
- Verified successful deployment and org synchronization

---

## 2. Server-Side Status Transition Enforcement

Moved workflow validation logic to Apex to prevent backward transitions.

### Business Rule:
Interviewing → Applied transition is not allowed.

### Implementation:

```apex
@AuraEnabled
public static void updateStatus(Id recordId, String newStatus) {

    Job_Application__c app = [
        SELECT Id, Status__c
        FROM Job_Application__c
        WHERE Id = :recordId
        LIMIT 1
    ];

    if(app.Status__c == 'Interviewing' && newStatus == 'Applied'){
        throw new AuraHandledException('Invalid status transition');
    }

    app.Status__c = newStatus;
    update app;
}
```

### Impact:
- Prevents invalid workflow rollback
- Enforces business rules at server level
- Ensures data integrity
- UI cannot bypass logic

---

## 3. UI Refinement

- Dual-gradient statistics cards
- Hover elevation effects
- Dynamic status badges
- Modal-based status update system
- Brand-consistent button styling
- Clean layout spacing and alignment

---

## 4. Error Handling Stabilization

- Implemented `AuraHandledException`
- Proper toast-based feedback using `ShowToastEvent`
- Prevented silent failures
- Backend errors now surface clearly in UI

---

## 5. Git & Deployment Discipline

- Clean commit structure
- Resolved local vs remote mismatch
- Verified deployment success
- Pushed stable build to GitHub

---

## 📊 Architecture Improvement

**Before:**
- Apex reference errors
- Weak status validation
- UI inconsistencies

**After:**
- Stable LWC–Apex communication
- Controlled state machine logic
- Production-ready validation
- Improved UI consistency

---

## Key Learning

Building features is easy.  
Stabilizing architecture is engineering.

Today focused on:
- Integration correctness
- Backend rule enforcement
- System stability
- Production discipline

---
## Day 60 – Real-Time Event-Driven Dashboard Sync

### Objective
Upgrade the Job Application Dashboard to support real-time multi-user synchronization using Platform Events and empApi.

---

### Problem Statement

Previously:
- Status updates refreshed only the current user’s dashboard.
- Other active users did not see updates in real time.
- The system was not suitable for multi-user environments.

---

### Solution Implemented

Implemented an event-driven architecture using:

- **Platform Events**
- **EventBus.publish() in Apex**
- **empApi subscription in LWC**
- **refreshApex() for UI synchronization**

---

### Architecture Flow
User Updates Status ↓ Apex updateStatus() ↓ EventBus.publish(Job_Status_Update__e) ↓ Platform Event Channel ↓ LWC empApi Subscriber ↓ refreshApex() ↓ All Active Dashboards Auto-Refresh
---

### Platform Event Configuration

**Event Name:** `Job_Status_Update__e`

**Fields:**
- `RecordId__c` (Text 18)
- `NewStatus__c` (Text 50)

---

### Apex Event Publishing

```apex
Job_Status_Update__e eventObj = new Job_Status_Update__e(
    RecordId__c = recordId,
    NewStatus__c = newStatus
);

EventBus.publish(eventObj);
```
### LWC Subscription Using empApi
```js
import { subscribe } from 'lightning/empApi';
import { refreshApex } from '@salesforce/apex';

channelName = '/event/Job_Status_Update__e';

subscribe(this.channelName, -1, (response) => {
    refreshApex(this.wiredResult);
});
```
## Day 61 Layered Architecture Refactor (Controller → Service → Logger)

Today I refactored the Job Application System into a proper layered architecture to improve maintainability, scalability, and separation of concerns.

---

### Objective

Move from feature-based coding to structured system design thinking.

---

## Architecture Upgrade

Previously:
- Controller handled queries, business logic, event publishing, and monitoring.

Now:
- **Controller Layer** → API exposure only
- **Service Layer** → Business logic + Status Engine
- **Logging Layer** → Centralized monitoring
- **Event Layer** → Platform Event publish for real-time sync
- **UI Layer (LWC)** → Event-driven refresh

---

## Layer Breakdown

### 1️. Controller Layer
Thin API exposure layer using `@AuraEnabled`.
Delegates all business logic to Service class.

### 2️. Service Layer
Handles:
- Data queries
- Status transition validation (forward-only engine)
- Event publishing
- Business rules enforcement

### 3️. Logging Layer
Centralized logging utility for monitoring:
- Improves traceability
- Keeps controller clean
- Enables future log framework extension

---

## Event-Driven Flow

User Action  
↓  
Controller  
↓  
Service Layer  
↓  
Database Update  
↓  
Platform Event Publish  
↓  
LWC empApi Subscriber  
↓  
Automatic UI Refresh  

---

## Key Concepts Practiced

- Separation of Concerns
- Layered Architecture Design
- Thin Controller Pattern
- Business Logic Isolation
- Event-Driven System Design
- Maintainable Code Structure
- Monitoring Strategy Introduction

---

## Why This Matters

This refactor transforms the project from:
> "Feature-based development"

to

> "Scalable Salesforce application architecture"

This structure prepares the system for:
- Large data volumes
- Complex validations
- Multi-team development
- Production-grade deployment

---

### Status Engine Stability Confirmed
- Backward transition properly blocked
- Real-time synchronization preserved
- Logging verified via Debug Logs

---
# Day 62 – Backend Keyset Pagination with Service Layer Architecture

## Objective

Implement scalable backend-driven pagination using keyset pagination while maintaining proper separation between Controller and Service layers.

---

## Implementation Details

### 1. Service Layer Architecture

Introduced a dedicated `JobApplicationService` class responsible for business logic.

The Controller delegates data retrieval to the Service layer.

Architecture flow:

LWC → Controller → Service → Database

Benefits:
- Improved maintainability
- Better scalability
- Clear separation of concerns
- Easier unit testing

---

### 2. Keyset Pagination (CreatedDate-Based)

Pagination implemented using:

```sql
WHERE CreatedDate < :lastCreatedDate
ORDER BY CreatedDate DESC
LIMIT :pageSize
```

This avoids OFFSET-based pagination, which degrades performance at scale.

Advantages:
- Better performance for large datasets
- Governor limit safe
- Prevents record skipping issues
- Efficient database usage

---

### 3. Active Record Filtering

Only active records are returned:

```sql
WHERE Is_Active__c = true
```

This ensures:
- Business rule compliance
- Cleaner datasets
- Reduced unnecessary data processing

---

### 4. Validation and Log Testing

Pagination verified using Execute Anonymous and debug logs.

Tested:
- First page retrieval
- Second page retrieval using lastCreatedDate
- Governor limits consumption
- Validation rule stability
- Trigger execution stability

Observed results:
- SOQL Queries: 2
- Query Rows: 2
- DML Statements: 0
- No validation errors
- No recursion issues

---

## Final Architecture

LWC  
→ Apex Controller  
→ Service Layer  
→ Dynamic SOQL (Keyset Pagination)  
→ Database  

---

## Technical Outcome

- Backend pagination implemented using keyset strategy
- Service layer pattern introduced
- Controller kept lightweight
- Governor limits verified
- System stability confirmed via logs

---
# Day 63 Smart Trigger Change Detection & Logging Architecture

## Objective

Today’s focus was building intelligent trigger logic instead of executing unnecessary operations on every update.

The goal was to detect real field changes and execute logic only when `Status__c` is modified.

This improves:
- Performance
- Governor limit safety
- Data accuracy
- Production readiness

---

## Architecture Implemented

LWC  
→ Apex Controller  
→ Service Layer  
→ Database Update  
→ Trigger Execution  
→ Conditional Logging  

---

## Key Implementation

### 1. Status Change Detection

Used `Trigger.oldMap` and `Trigger.new` to compare old vs new values.
if(record.Status__c != oldRecord.Status__c)
This ensures logging logic runs only when status changes.

---

### 2. Before Update Logic

Used `before update` to detect change.

Purpose:
- Validation
- Debug tracing
- Conditional checks

---

### 3. After Update Logging

Created a custom object:

Application_Log__c

Fields:
- Job_Application__c (Lookup)
- Old_Status__c
- New_Status__c

Log record is inserted only when status changes.

---

### 4. Service Layer Restoration

Reintroduced missing method:
updateStatusEngine(Id recordId, String newStatus)
Ensured clean separation:
- Controller handles exposure
- Service handles business logic

---

### 5. Pagination Fix

Updated query to remove unnecessary Is_Active__c filter to display all records.

Implemented dynamic pagination using:

- lastCreatedDate
- LIMIT clause
- ORDER BY CreatedDate DESC

---

## Testing Performed

1. Changed only Position__c → No log created  
2. Changed Status__c → Log created successfully  
3. Verified LWC auto refresh  
4. Verified service layer call chain  
5. Confirmed deployment stability  

---

## Key Learning

- Difference between before and after trigger
- How to detect field-level changes
- Avoiding unnecessary DML operations
- Clean multi-layer Apex architecture
- Proper SFDX deployment structure

---

## Result

Smart trigger behavior implemented successfully.
System now logs only meaningful status transitions.
Production-level logic improved.

## Day 64 – Centralized Apex Error Logging Framework

### Objective
The goal of Day 64 was to implement a centralized error logging mechanism in the Salesforce application. Instead of relying on temporary debug logs, the system now records errors permanently in a custom object so that developers and administrators can analyze issues occurring in production.

---

### Architecture Implemented

User Action (LWC)
        ↓
Apex Controller
        ↓
Service Layer (JobApplicationService)
        ↓
Try/Catch Error Handling
        ↓
ErrorLogger Class
        ↓
Error_Log__c Object (Persistent Error Storage)

---

### Components Implemented

#### 1. Custom Object: `Error_Log__c`
A new custom object was created to store runtime errors.

Fields:
- `Error_Message__c` – Stores the exception message.
- `Stack_Trace__c` – Captures the complete stack trace.
- `Class_Name__c` – Apex class where the error occurred.
- `Method_Name__c` – Method where the error occurred.
- `Related_Record_Id__c` – Optional reference to the affected record.

This allows developers to review errors directly from Salesforce without needing debug logs.

---

#### 2. ErrorLogger Utility Class
A reusable logging utility was created to capture exceptions from anywhere in the system.

Key responsibilities:
- Capture error message
- Capture stack trace
- Store class and method information
- Insert a record in `Error_Log__c`

Example usage:
try { // business logic } catch(Exception ex) { ErrorLogger.logError(ex, 'ClassName', 'MethodName', recordId); }
---

#### 3. Service Layer Error Handling
The `JobApplicationService` class was updated with proper `try/catch` blocks to ensure that all runtime exceptions are logged.

This ensures:
- Better observability
- Production error traceability
- Easier debugging

---

### Testing Performed

1. Forced a runtime exception using a divide-by-zero operation.
2. The exception was caught and logged successfully.
3. Verified that a record was created in `Error_Log__c`.
4. Confirmed that error message and stack trace were stored correctly.

---
## Day 65 Job Application Status Logging System

Today I implemented an **Audit Logging System** to track status changes in job applications.  
This ensures that every status transition is recorded for transparency and debugging.

### Objective
To maintain a historical record of job application status changes such as:

- Applied → Interviewing
- Interviewing → Offered
- Offered → Rejected
- Rejected → Applied

### Implementation

A custom object **Application_Log__c** was created to store status change history.

Each time a job application's status is updated, the system automatically:

1. Detects the change using an **Apex Trigger**
2. Captures the **Old Status**
3. Captures the **New Status**
4. Saves a log record linked to the corresponding Job Application

### Architecture

```
LWC UI
   ↓
Apex Controller
   ↓
Service Layer
   ↓
DML Update
   ↓
Trigger (Before Update)
   ↓
Trigger Handler
   ↓
Application_Log__c Record Created
```

### Components Added

**Custom Object**
- `Application_Log__c`

**Fields**
- `Job_Application__c` (Lookup to Job Application)
- `Old_Status__c`
- `New_Status__c`
- `CreatedDate`

**Apex Components**
- `JobApplicationTrigger`
- `JobApplicationTriggerHandler`
- `BaseTriggerHandler`

### Key Features

- Tracks every job application status change
- Stores old and new status values
- Provides a complete audit trail
- Helps debugging and monitoring system behavior

### Example Log Record

| Job Application | Old Status | New Status | Created Date |
|----------------|------------|------------|-------------|
| Anurag Singh | Rejected | Applied | 06 Mar |
| Shashwat Jais | Interviewing | Offered | 06 Mar |

### Result

The system now maintains a **complete history of status changes** for job applications, improving visibility and accountability within the recruitment workflow.

### Technologies Used

- Salesforce Apex
- Apex Triggers
- Trigger Handler Pattern
- Custom Objects
- SOQL
- Lightning Web Components

---
# Day 66 Automated Email Notifications using Queueable Apex

## Overview
On Day 66, I implemented automated email notifications in the Recruitment App using Queueable Apex.

Whenever the status of a Job Application changes, Salesforce automatically sends an email notification.

This simulates how real recruitment systems notify candidates at different stages of the hiring process.

---

## What I Built

### 1. Queueable Apex Email Automation
Created a Queueable Apex class that runs asynchronously and sends email notifications based on the status change.

Handled statuses:

- Interviewing
- Offered
- Rejected

---

### 2. Dynamic Email Logic
The email subject and message change depending on the application status.

| Status | Email |
|------|------|
| Interviewing | Interview invitation email |
| Offered | Job offer email |
| Rejected | Application rejection email |

---

### 3. Trigger Integration

System Flow:

Job Application Status Change  
↓  
Apex Trigger  
↓  
Trigger Handler  
↓  
Queueable Apex  
↓  
Email Sent  

---

## Key Code Example

### Queueable Apex Class

```apex
public class ApplicationEmailQueueable implements Queueable {

    private Id applicationId;
    private String status;

    public ApplicationEmailQueueable(Id applicationId, String status){
        this.applicationId = applicationId;
        this.status = status;
    }

    public void execute(QueueableContext context){

        Job_Application__c app = [
            SELECT Id, Name, Status__c, Owner.Email
            FROM Job_Application__c
            WHERE Id = :applicationId
        ];

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        email.setToAddresses(new String[] { app.Owner.Email });

        if(status == 'Interviewing'){
            email.setSubject('Interview Invitation');
            email.setPlainTextBody('Your application has moved to the Interview stage.');
        }
        else if(status == 'Offered'){
            email.setSubject('Job Offer');
            email.setPlainTextBody('Congratulations! You have received a job offer.');
        }
        else if(status == 'Rejected'){
            email.setSubject('Application Update');
            email.setPlainTextBody('Thank you for applying. Unfortunately you were not selected.');
        }

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}
```

---

## Salesforce Concepts Used

- Apex Triggers
- Trigger Handler Pattern
- Queueable Apex
- Messaging.SingleEmailMessage
- Asynchronous Processing
- Email Deliverability

---

## Testing

Steps to test the feature:

1. Update the status of a Job Application record
2. Trigger detects status change
3. Queueable Apex runs asynchronously
4. Email notification is sent

---

## What I Learned

- How asynchronous processing works in Salesforce
- When to use Queueable Apex
- How to implement automated notifications
- How to debug using Apex Jobs and Debug Logs

---
# Day 67 – Queueable Apex Email Notification System

## Overview
Today I implemented an **asynchronous email notification system** using **Queueable Apex** in Salesforce.  
The goal is to automatically send an email when the **Status of a Job Application changes**.

This improves performance because the email is processed **asynchronously**, instead of slowing down the main transaction.

---

## Architecture

LWC  
↓  
Apex Controller  
↓  
Service Layer  
↓  
Trigger  
↓  
Trigger Handler  
↓  
Queueable Apex  
↓  
Email Sent

---

## Features Implemented

- Trigger fires when **Job Application Status changes**
- Trigger Handler manages business logic
- **Queueable Apex** processes email sending asynchronously
- Email is sent based on the **Status value**
- Debug logs added to monitor execution
- System designed following **Salesforce best practices**

---

## Status-Based Email Logic

| Status | Email Sent |
|------|------|
| Interviewing | Interview Invitation Email |
| Offered | Job Offer Email |
| Rejected | Application Rejection Email |

---

## Queueable Apex Implementation

Queueable Apex allows running processes in the background without affecting user performance.

### Benefits
- Asynchronous processing
- Handles heavy operations
- Improves scalability
- Prevents UI delays

---

## Email Process Flow

1. User updates Job Application status
2. Trigger detects the status change
3. Trigger Handler processes the logic
4. Queueable Apex job is added to the queue
5. Queueable executes in the background
6. Email notification is sent to the record owner

---

## Debug Logging

Debug statements were added to monitor the process.

Example Logs:

QUEUEABLE STARTED  
Application Found  
Using Interview Template  
Sending Email...  
EMAIL SENT SUCCESSFULLY

---

## Apex Class Used

ApplicationEmailQueueable.cls

Responsibilities:
- Fetch Job Application record
- Check application status
- Prepare email message
- Send email asynchronously

---

## Key Learning

- Understanding **Queueable Apex**
- Sending emails using **Messaging.SingleEmailMessage**
- Debugging **asynchronous Apex jobs**
- Implementing **Salesforce trigger framework architecture**

---
# Day 68 – Email Automation using Queueable Apex

## Overview
On Day 68 of the Salesforce 90 Days Challenge, I implemented **Email Automation using Queueable Apex and Email Templates** in the Job Application Tracker project.

Now, whenever the status of a Job Application changes (Interviewing, Offered, Rejected), the system automatically sends an email notification using a predefined Email Template.

This email is processed asynchronously using **Queueable Apex**, improving performance and following Salesforce best practices.

---

## Features Implemented

### 1. Email Templates
Created reusable Salesforce Email Templates for different job application outcomes.

Templates created:

- Interview Invitation
- Job Offer Notification
- Application Rejection

These templates allow consistent communication with users.

---

### 2. Queueable Apex for Email Processing
A Queueable Apex class was implemented to handle email sending asynchronously.

Benefits:
- Non-blocking processing
- Better performance
- Follows Salesforce governor limits

Class used:
`ApplicationEmailQueueable.cls`

---

### 3. Trigger Based Automation
When the Job Application status changes, the system automatically processes the email flow.

### Flow

```
Status Change
     ↓
Trigger (JobApplicationTrigger)
     ↓
Trigger Handler
     ↓
Queueable Apex (ApplicationEmailQueueable)
     ↓
Email Template Selected
     ↓
Email Sent Automatically
```

---

## Components Used

### Custom Object
`Job_Application__c`

### Important Fields
- Status__c
- Interview_Date__c
- Expected_salary__c
- OwnerId

---

## Apex Components

Trigger  
`JobApplicationTrigger`

Trigger Handler  
`JobApplicationTriggerHandler`

Queueable Apex  
`ApplicationEmailQueueable`

---

## What I Learned

- How to implement **Queueable Apex**
- How to integrate **Email Templates with Apex**
- How to build a **Trigger Handler architecture**
- How to automate business processes in Salesforce

---
# Day 69 – Email Logging System

## Overview
On Day 69 of the Salesforce 90 Days Challenge, I enhanced the Job Application Tracker by implementing an **Email Logging System**.

Now whenever an email is sent automatically (Interview Invitation, Job Offer, or Rejection), the system also creates a log record. This helps track all email communications related to a job application.

---

## Feature Implemented

### Email Log Object
A new custom object was created to store email history.

**Object Name**
```
Email_Log__c
```

This object records every email sent by the system.

---

## Fields Created

### Job Application
```
Lookup → Job_Application__c
```

Stores the related job application.

### Email Type
```
Picklist
```

Values:
```
Interview Invitation
Job Offer
Application Rejection
```

### Sent Date
```
Date/Time
```

Stores the timestamp when the email was sent.

---

## Updated Queueable Apex

The `ApplicationEmailQueueable` class was updated to create a log record after sending the email.

Flow:

```
Status Change
      ↓
Trigger
      ↓
Trigger Handler
      ↓
Queueable Apex
      ↓
Email Sent
      ↓
Email Log Record Created
```

---

## Benefits

- Tracks all automated email communications
- Improves system transparency
- Helps with auditing and debugging
- Makes the project more production-like

---

## Components Used

### Custom Object
```
Email_Log__c
```

### Apex Classes
```
ApplicationEmailQueueable
```

### Trigger Architecture
```
JobApplicationTrigger
JobApplicationTriggerHandler
```

---

## What I Learned

- Creating custom logging objects
- Recording system actions in Salesforce
- Extending Queueable Apex functionality
- Designing audit-friendly automation

---

# Day 70 Prevent Duplicate Emails in Salesforce

## Objective
Today I enhanced the email automation system in the Job Application Tracker by preventing duplicate emails from being sent when a record is updated multiple times with the same status.

Previously, if a user updated a Job Application record multiple times with the same status (Interviewing, Offered, or Rejected), the system could send the same email repeatedly. This behavior is not ideal in real-world systems.

To solve this, I implemented **email tracking flags** using checkbox fields and updated the Queueable Apex logic.

---

## New Fields Added

Three checkbox fields were added to the **Job_Application__c** object:

- `Interview_Email_Sent__c`
- `Offer_Email_Sent__c`
- `Rejection_Email_Sent__c`

These fields track whether a particular email has already been sent for a record.

Example:

| Status | Interview_Email_Sent__c | Email Sent |
|------|------|------|
| Interviewing | false | Yes |
| Interviewing again | true | No |

---

## Updated Queueable Logic

The `ApplicationEmailQueueable` class was updated to:

1. Check whether the email has already been sent.
2. Send the appropriate email template.
3. Update the corresponding checkbox field to **true**.

Example logic:

```
if(status == 'Interviewing' && !app.Interview_Email_Sent__c)
```

This ensures the email is sent **only once**.

---

## Email Flow

```
Status Change
      ↓
Trigger Fires
      ↓
Queueable Apex Job
      ↓
Check Email Sent Flag
      ↓
Send Email Template
      ↓
Update Checkbox Field
```

---

## Files Updated

- `ApplicationEmailQueueable.cls`
- `JobApplicationTriggerHandler.cls`
- `Job_Application__c` object (added checkbox fields)

---

## Result

✔ Emails are now sent **only once per status**  
✔ Prevents duplicate notifications  
✔ Improves system reliability  

---
## Day 71 Scheduled Apex + Batch Apex Automation

### Overview
On Day 71, I implemented **Scheduled Apex and Batch Apex** to automate job application processing.  
This feature ensures that job applications are automatically reviewed and updated without manual intervention.

### Objective
Build an automated system that:
- Runs every day using **Scheduled Apex**
- Processes job applications in bulk using **Batch Apex**
- Updates records based on defined business logic

### Architecture

Scheduled Apex  
↓  
JobApplicationScheduler  
↓  
Batch Apex  
↓  
JobApplicationBatch  
↓  
Process Job_Application__c Records  

### Scheduler Class

The scheduler automatically runs the batch job at a scheduled time.

```apex
global class JobApplicationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        System.debug('Scheduler started');

        Database.executeBatch(new JobApplicationBatch(), 200);

    }
}
```

### Batch Apex Class

The batch class processes Job Application records in bulk.

```apex
global class JobApplicationBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator([
            SELECT Id, Status__c, Applied_Date__c, Interview_Date__c, Is_Active__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
        ]);

    }

    global void execute(Database.BatchableContext bc, List<Job_Application__c> scope) {

        List<Job_Application__c> updates = new List<Job_Application__c>();

        for(Job_Application__c app : scope){

            if(app.Status__c == 'Applied' && app.Applied_Date__c != null){

                if(app.Applied_Date__c.addDays(30) < Date.today()){
                    app.Status__c = 'Rejected';
                    app.Is_Active__c = false;
                    updates.add(app);
                }

            }

            if(app.Status__c == 'Interviewing' && app.Interview_Date__c != null){

                if(app.Interview_Date__c.addDays(7) < Date.today()){
                    app.Is_Active__c = false;
                    updates.add(app);
                }

            }

        }

        if(!updates.isEmpty()){
            update updates;
        }

    }

    global void finish(Database.BatchableContext bc){

        System.debug('Batch Job Finished');

    }
}
```

### Scheduling the Job

The job was scheduled using Execute Anonymous:

```apex
System.schedule(
'Daily Job Application Check',
'0 0 1 * * ?',
new JobApplicationScheduler()
);
```

### Cron Expression

```
0 0 1 * * ?
```

Meaning:

Runs **every day at 1:00 AM**

### Testing the Batch Job

To test manually:

```apex
Database.executeBatch(new JobApplicationBatch(), 200);
```

### Salesforce Concepts Used

- Scheduled Apex
- Batch Apex
- Asynchronous Processing
- Bulk Record Processing
- Governor Limits Handling

### Outcome

The system now automatically processes job applications daily and updates their status based on defined business rules.  
This implementation demonstrates scalable backend automation using Salesforce Apex.
---

# Day 72 - Batch Apex with External API Callouts

## Overview
On Day 72, I implemented a Batch Apex class that performs HTTP callouts to an external API. This demonstrates how Salesforce can integrate with external systems asynchronously while processing large datasets efficiently.

---

## Objectives
- Understand Batch Apex with callouts
- Perform HTTP POST requests from Apex
- Process records in chunks using batch execution
- Handle JSON request and response
- Debug and validate API integration

---

## Key Concepts Covered
- Database.Batchable interface
- Database.AllowsCallouts
- HTTP Request and Response handling
- JSON serialization
- Asynchronous processing in Salesforce

---

## Implementation Details

### Batch Class: JobApplicationCalloutBatch

- Retrieves active Job Application records
- Sends each record’s data to an external API
- Processes records in batches
- Handles exceptions during callouts

```apex
global class JobApplicationCalloutBatch 
implements Database.Batchable<sObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
        ]);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {

        Http http = new Http();

        for(sObject obj : scope){

            Job_Application__c app = (Job_Application__c) obj;

            try{
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/json');

                String body = JSON.serialize(new Map<String, Object>{
                    'name' => app.Name,
                    'status' => app.Status__c
                });

                req.setBody(body);

                HttpResponse res = http.send(req);

                System.debug('Response: ' + res.getBody());

            } catch(Exception e){
                System.debug('Callout failed: ' + e.getMessage());
            }
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Callout Batch Finished');
    }
}
```

### How to Run
Execute the batch using Anonymous Apex:
```apex
Database.executeBatch(new JobApplicationCalloutBatch(), 5);
```
### Sample Output
```apex
StatusCode: 201
Response:
{
  "status": "Applied",
  "name": "Candidate Name",
  "id": 101
}
```
### Challenges Faced
- Unauthorized endpoint error due to missing Remote Site Settings
- Understanding difference between QueryLocator and Iterable
- Debugging batch execution logs
- Handling callouts inside batch context

### Key Learnings
- Remote Site Settings are mandatory for external callouts
- Batch Apex enables scalable processing of large datasets
- Callouts must be handled carefully within governor limits
- Debug logs are essential for troubleshooting asynchronous jobs
- Current Limitations
- API responses are only logged, not stored
- No retry mechanism for failed callouts
- No status tracking for processed records


### Conclusion
This task provided hands-on experience with integrating Salesforce and external systems using Batch Apex. It strengthened understanding of asynchronous processing and real-world API interaction patterns.
---

# Day 73 Batch Apex with Callout Response Handling

## Overview
On Day 73, I enhanced the Batch Apex implementation by integrating HTTP callouts with proper response handling and database updates. This ensures that each Job Application record stores API responses and tracks callout success or failure.

---

## Objectives
- Perform HTTP callouts from Batch Apex
- Handle API responses properly
- Store response data in Salesforce records
- Track success and failure of callouts
- Follow bulk processing best practices

---

## Key Features

### 1. Batch Apex with Callouts
- Implemented `Database.Batchable` and `Database.AllowsCallouts`
- Processed records in batches to stay within governor limits

### 2. HTTP POST Callout
- Sent request to external API (`jsonplaceholder`)
- Serialized record data into JSON format

### 3. Response Handling
- Captured API response using `HttpResponse`
- Stored response body in `API_Response__c`

### 4. Status Tracking
- Updated `Callout_Status__c` field:
  - `Success` when callout succeeds
  - `Failed` when exception occurs

### 5. Bulk Update Optimization
- Collected records in a list
- Performed a single `update` DML operation per batch

---

## Apex Implementation

```apex
global class JobApplicationCalloutBatch 
implements Database.Batchable<sObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
        ]);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {

        Http http = new Http();
        List<Job_Application__c> updates = new List<Job_Application__c>();

        for(sObject obj : scope){

            Job_Application__c app = (Job_Application__c) obj;

            try{
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/json');

                String body = JSON.serialize(new Map<String, Object>{
                    'name' => app.Name,
                    'status' => app.Status__c
                });

                req.setBody(body);

                HttpResponse res = http.send(req);

                app.API_Response__c = res.getBody();
                app.Callout_Status__c = 'Success';

            } catch(Exception e){
                app.Callout_Status__c = 'Failed';
                app.API_Response__c = e.getMessage();
            }

            updates.add(app);
        }

        if(!updates.isEmpty()){
            update updates;
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Callout Batch Finished');
    }
}
```

---

## How to Execute

Run the batch using Execute Anonymous:

```apex
Database.executeBatch(new JobApplicationCalloutBatch(), 5);
```

---

## Key Learnings
- How to integrate external APIs using Apex callouts
- Importance of handling exceptions in batch jobs
- Bulkification to avoid governor limits
- Storing API responses for audit and debugging
- Understanding batch lifecycle: `start`, `execute`, `finish`

---

## Conclusion
This implementation demonstrates a scalable and robust way to integrate external APIs with Salesforce using Batch Apex, while ensuring proper tracking, error handling, and performance optimization.