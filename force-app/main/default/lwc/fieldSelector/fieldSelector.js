import { LightningElement, api, track } from 'lwc';
import getFieldsOfSobject from '@salesforce/apex/WireSObjects.getFieldsOfSobject';

export default class FieldSelector extends LightningElement {
    @api objectName;
    @track fields = [];
    @track selectedFields = [];
    showRecords = false;

    connectedCallback() {
        getFieldsOfSobject({ sObjectName: this.objectName })
            .then(fieldList => {
                this.fields = fieldList;
            })
            .catch(error => {
                console.error('Error fetching fields:', error);
            });
    }

    handleFieldSelection(event) {
        this.selectedFields = event.detail.value;
    }

    handleShowData() {
        if (!this.selectedFields.length) {
            alert('Please select fields');
            return;
        }
        this.showRecords = true;
    }
}
