import { LightningElement, track } from 'lwc';
import getJobApplications from '@salesforce/apex/JobApplicationController.getJobApplications';
import getTotalCount from '@salesforce/apex/JobApplicationController.getTotalCount';
import getApplicationStats from '@salesforce/apex/JobApplicationController.getApplicationStats';
import updateStatus from '@salesforce/apex/JobApplicationController.updateStatus';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class JobApplicationCard extends LightningElement {

    @track applications = [];
    @track stats = {};
    @track searchKey = '';
    @track selectedStatus = 'All';

    pageSize = 5;
    currentPage = 1;
    totalRecords = 0;
    totalPages = 1;

    statusOptions = [
        { label: 'All', value: 'All' },
        { label: 'Applied', value: 'Applied' },
        { label: 'Interviewing', value: 'Interviewing' },
        { label: 'Offered', value: 'Offered' },
        { label: 'Rejected', value: 'Rejected' }
    ];

    connectedCallback() {
        this.loadAll();
    }

    loadAll() {
        this.loadData();
        this.loadStats();
    }

    loadData() {
        getJobApplications({
            searchKey: this.searchKey,
            statusFilter: this.selectedStatus,
            pageSize: this.pageSize,
            pageNumber: this.currentPage
        }).then(data => {
            this.applications = data.map(record => {
                return {
                    ...record,
                    formattedAppliedDate: record.CreatedDate
                        ? new Date(record.CreatedDate).toLocaleDateString()
                        : '',
                    formattedInterviewDate: record.Interview_Date__c
                        ? new Date(record.Interview_Date__c).toLocaleDateString()
                        : ''
                };
            });
        });

        getTotalCount({
            searchKey: this.searchKey,
            statusFilter: this.selectedStatus
        }).then(count => {
            this.totalRecords = count;
            this.totalPages = Math.ceil(count / this.pageSize);
        });
    }

    loadStats() {
        getApplicationStats().then(result => {
            this.stats = result;
        });
    }

    handleSearch(event) {
        this.searchKey = event.target.value;
        this.currentPage = 1;
        this.loadAll();
    }

    handleStatusFilter(event) {
        this.selectedStatus = event.detail.value;
        this.currentPage = 1;
        this.loadAll();
    }

    handlePrevious() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.loadData();
        }
    }

    handleNext() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
            this.loadData();
        }
    }

    get disablePrevious() {
        return this.currentPage === 1;
    }

    get disableNext() {
        return this.currentPage === this.totalPages;
    }

    get appliedWidth() {
        return `width:${this.stats.AppliedPercent || 0}%`;
    }

    get interviewingWidth() {
        return `width:${this.stats.InterviewingPercent || 0}%`;
    }

    get offeredWidth() {
        return `width:${this.stats.OfferedPercent || 0}%`;
    }

    get rejectedWidth() {
        return `width:${this.stats.RejectedPercent || 0}%`;
    }

    async openModal(event) {
        const recordId = event.currentTarget.dataset.id;

        const selected = this.applications.find(app => app.Id === recordId);

        const statusOrder = ['Applied', 'Interviewing', 'Offered', 'Rejected'];

        const currentIndex = statusOrder.indexOf(selected.Status__c);

        if (currentIndex === statusOrder.length - 1) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Cannot move status forward from final stage.',
                    variant: 'error'
                })
            );
            return;
        }

        const nextStatus = statusOrder[currentIndex + 1];

        try {
            await updateStatus({
                recordId: recordId,
                newStatus: nextStatus
            });

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Status updated successfully',
                    variant: 'success'
                })
            );

            this.loadAll();

        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
}