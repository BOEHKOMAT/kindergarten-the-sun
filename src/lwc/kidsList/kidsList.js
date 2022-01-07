/**
 * Created by Andrew on 26.12.2021.
 */

import {LightningElement, api, wire, track} from 'lwc';

import {createRecord} from 'lightning/uiRecordApi';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

import getRelatedKids from '@salesforce/apex/GroupController.getRelatedKids'

import VISIT_OBJECT from '@salesforce/schema/Visit__c'

const columns = [
    {
        label: 'Present',
        type: 'button-icon',
        initialWidth: 75,
        typeAttributes: {
            iconName: 'action:preview',
            title: 'Visit',
            variant: 'border-filled',
            alternativeText: 'Present'
        }
    },
    {label: 'Last Name', fieldName: 'LastName'},
    {label: 'First Name', fieldName: 'FirstName'},
    {label: 'Phone', fieldName: 'Phone', type: 'phone'},
];

export default class KidsList extends LightningElement {
    @api recordId;

    @wire(getRelatedKids, {groupId: '$recordId'}) kids;
    @wire(getObjectInfo, {objectApiName: VISIT_OBJECT}) visitObject;

    @track columns = columns;

    get kidReference() {
        return [this.visitObject.data.fields.Kid__c.apiName]
    }

    handleRowAction(event) {
        const row = event.detail.row;
        const fields = {};
        fields[this.kidReference] = row.Id;
        const recordInput = {apiName: VISIT_OBJECT.objectApiName, fields}
        createRecord(recordInput)
            .then(visit => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Visit created',
                        variant: 'success'
                    })
                )
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
}
