import { LightningElement, track, wire } from 'lwc';
import getApplications from '@salesforce/apex/JobApplicationController.getApplications';
import updateStatus from '@salesforce/apex/JobApplicationController.updateStatus';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, onError } from 'lightning/empApi';
import { refreshApex } from '@salesforce/apex';

export default class JobApplicationCard extends LightningElement {

    @track applications = [];
    @track showModal = false;
    @track selectedRecordId;
    @track selectedStatus;

    wiredResult;
    channelName = '/event/Job_Status_Update__e';

    totalCount = 0;
    appliedCount = 0;
    interviewingCount = 0;
    offeredCount = 0;
    rejectedCount = 0;

    statusOptions = [
        { label: 'Applied', value: 'Applied' },
        { label: 'Interviewing', value: 'Interviewing' },
        { label: 'Offered', value: 'Offered' },
        { label: 'Rejected', value: 'Rejected' }
    ];

    @wire(getApplications)
    wiredApplications(result) {
        this.wiredResult = result;
        if (result.data) {
            this.prepareData(result.data);
        }
        if (result.error) {
            console.error(result.error);
        }
    }

    connectedCallback() {
        this.subscribeToPlatformEvent();
    }

    subscribeToPlatformEvent() {
        subscribe(this.channelName, -1, (response) => {
            refreshApex(this.wiredResult);
        });

        onError(error => {
            console.error('EMP API error: ', error);
        });
    }

    prepareData(data) {

        this.totalCount = data.length;
        this.appliedCount = 0;
        this.interviewingCount = 0;
        this.offeredCount = 0;
        this.rejectedCount = 0;

        this.applications = data.map(app => {

            if (app.Status__c === 'Applied') this.appliedCount++;
            if (app.Status__c === 'Interviewing') this.interviewingCount++;
            if (app.Status__c === 'Offered') this.offeredCount++;
            if (app.Status__c === 'Rejected') this.rejectedCount++;

            let statusClass = 'status-badge';
            if (app.Status__c === 'Applied') statusClass += ' badge-applied';
            if (app.Status__c === 'Interviewing') statusClass += ' badge-interview';
            if (app.Status__c === 'Offered') statusClass += ' badge-offered';
            if (app.Status__c === 'Rejected') statusClass += ' badge-rejected';

            return {
                ...app,
                Company__r: app.Company__r ? app.Company__r : { Name: '' },
                statusClass
            };
        });
    }

    openModal(event) {
        this.selectedRecordId = event.target.dataset.id;
        this.showModal = true;
    }

    closeModal() {
        this.showModal = false;
        this.selectedStatus = null;
    }

    handleStatusChange(event) {
        this.selectedStatus = event.detail.value;
    }

    updateStatus() {

        if (!this.selectedStatus) return;

        updateStatus({
            recordId: this.selectedRecordId,
            newStatus: this.selectedStatus
        })
        .then(() => {
            this.showToast('Success', 'Status updated successfully', 'success');
            this.showModal = false;
        })
        .catch(error => {

            let message = 'Error occurred';
            if (error.body && error.body.message) {
                message = error.body.message;
            }

            this.showToast('Error', message, 'error');
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}