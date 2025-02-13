import { LightningElement, wire, track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getSObjectNames from '@salesforce/apex/WireSObjects.getSObjectNames';
import getFieldsOfSobject from '@salesforce/apex/WireSObjects.getFieldsOfSobject';
import getRecords from '@salesforce/apex/WireSObjects.getRecords';

export default class RecordsUI extends NavigationMixin (LightningElement) {
    @track sObjectOptions=[];
    @track fields=[];
    @track selectedFields=[];
    @track records=[];
    @track columns=[];
    selectedSObjects;
    
    @wire(getSObjectNames)
    wiredSObjectNames({error, data}){
        if(data){
            this.sObjectOptions=data.map((sObject)=>{
                return {label:sObject , value:sObject};
            });
        }
        else if(error){
            console.error('Error Fetching Sobject Names...'+error);
        }
    }
    handleSObjectChange(event){
        this.selectedSObjects=event.detail.value;
        this.selectedFields=[];
        this.records=[];
        this.columns=[];

        getFieldsOfSobject({sObjectName:this.selectedSObjects})
        .then((fieldList)=>
            {this.fields=fieldList})
        .catch((error)=>{
            console.error('Error Fetching fields:',error);
        });
    }
    handleFieldSelectionEvent(event){
        this.selectedFields=[...event.detail.value];
    }
    fetchRecords(){
        if(!this.selectedFields.length){
            alert('Please Select Field');
            return;
        }
        getRecords({sObjectName:this.selectedSObjects, fieldNames:this.selectedFields})
        .then((data)=>{
            this.records=data;
            this.columns=this.selectedFields.map((field)=>{
                let fieldLabel=this.fields.find(f=>f.value===field)?.label||field;
                return{
                    label:fieldLabel,
                fieldName:field,
                type:'text'
                };
            });
        }).catch((error)=>{
            console.error('Error Fetching Records:',error);
        });
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