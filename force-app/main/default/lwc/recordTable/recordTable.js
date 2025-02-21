import { LightningElement, api, track } from 'lwc';
import getRecords from '@salesforce/apex/WireSObjects.getRecords';

export default class RecordTable extends LightningElement {
    @api objectName;
    @api selectedFields;
    @track records = [];
    @track columns = [];

    connectedCallback() {
        this.fetchRecords();
    }

    fetchRecords() {
        if (!this.selectedFields.length) return;

        getRecords({ sObjectName: this.objectName, fieldNames: this.selectedFields })
            .then(data => {
                this.records = data;
                this.columns = this.selectedFields.map(field => {
                    return { label: field, fieldName: field, type: 'text' };
                });
            })
            .catch(error => {
                console.error('Error fetching records:', error);
            });
    }
}