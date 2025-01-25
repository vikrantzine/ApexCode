import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/WireDemoLWC.getAccountList';
const columns=[
    {label : 'Name', fieldName : 'Name'},
    {label : 'Account Record Id',fieldName : 'Id'},
];
export default class WireDemo extends LightningElement {
    @track columns=columns;
    @track data=[];
    @wire(getAccountList)
    wiredAccounts({data ,error}){
        if(data){
            this.data=data;
        }else if(error){
            console.log("Error Occured...")
        }
    }
}