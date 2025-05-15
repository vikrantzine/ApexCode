import { LightningElement, api, track } from 'lwc';
import getRecords from '@salesforce/apex/WireSObjects.getRecords';

export default class RecordTable extends LightningElement {
    @api sObjectName;
    @api selectedFields;
    @track records = [];
    @track columns = [];

    fetchRecords() {
        if (!this.selectedFields.length) {
            alert('Please select fields.');
            return;
        }

        getRecords({ sObjectName: this.sObjectName, fieldNames: this.selectedFields })
            .then((data) => {
                this.records = data;
                this.columns = this.selectedFields.map((field) => ({
                    label: field,
                    fieldName: field,
                    type: 'text'
                }));
            })
            .catch((error) => {
                console.error('Error Fetching Records:', error);
            });
    }
}