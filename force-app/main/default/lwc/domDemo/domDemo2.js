import { LightningElement } from 'lwc';

export default class Demo2 extends LightningElement {
    text = '';  // Initial text is empty

    handleChange(event) {
        this.text = event.target.value;  // Update text with the input's value
    }
}