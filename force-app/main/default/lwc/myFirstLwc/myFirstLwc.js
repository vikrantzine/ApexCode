import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MyFirstLwc extends LightningElement {
    myTitle="Vikrant Zine";
    
    connectedCallback(){
        let callMyFunction=this.myFunction(10,2);
        window.alert("callMyFunction"+callMyFunction);
    }

    myFunction(dividend,divivsor){
        return(dividend/divivsor);
    }
}