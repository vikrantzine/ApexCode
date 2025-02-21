import { LightningElement, api, wire, track } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import getSObjectNames from '@salesforce/apex/WireSObjects.getSObjectNames';

export default class RecordUI extends NavigationMixin (LightningElement) {
    @track sObjectOptions = [];
    selectedSObjects;

    @wire(getSObjectNames)
    wiredSObjectNames({ error, data }) {
        if (data) {
            this.sObjectOptions = data.map(sObject => {
                return { label: sObject, value: sObject };
            });
        } 
        else if (error) {
            console.error('Error fetching SObject Names: ', error);
        }
    }

    handleSObjectChange(event) {
        this.selectedSObjects = event.detail.value;
    }
    createNewRecord(){
            if (!this.selectedSObjects) {
                alert('Please select an object from the combobox.');
                return;
            }
    
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: this.selectedSObjects,
                    actionName: 'new'
                }
            });
        }
}
