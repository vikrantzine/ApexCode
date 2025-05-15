import { LightningElement, api, wire, track } from 'lwc';
import getFieldsOfSobject from '@salesforce/apex/WireSObjects.getFieldsOfSobject';

export default class FieldSelector extends LightningElement {
    @api sObjectName;
    @track fields = [];
    @track selectedFields = [];

    @wire(getFieldsOfSobject, { sObjectName: '$sObjectName' })
    wiredFields({ error, data }) {
        if (data) {
            this.fields = data;
        } else if (error) {
            console.error('Error Fetching Fields:', error);
        }
    }

    handleFieldSelection(event) {
        this.selectedFields = event.detail.value;
        this.dispatchEvent(new CustomEvent('fieldsselected', {
            detail: { fields: this.selectedFields }
        }));
    }
}