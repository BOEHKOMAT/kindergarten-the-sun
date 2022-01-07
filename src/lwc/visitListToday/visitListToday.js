/**
 * Created by Andrew on 07.01.2022.
 */

import {LightningElement, api, track, wire} from 'lwc';
import getGroupVisitsToday from '@salesforce/apex/VisitController.getGroupVisitsToday'

const columns = [
    {label: 'Kid', fieldName: 'Kid__c'},
    // {label: 'Parent', fieldName: 'Parent__c',editable:true},
    {
        label: 'Parent', fieldName: 'Parent__c', type: 'lookup', typeAttributes: {
            placeholder: 'Select Parent',
            uniqueId: { fieldName: 'Kid__c' }, //pass Id of current record to lookup for context
            object: "Contact",
            icon: "standard:contact",
            label: "Contact",
            displayFields: "LastName, FirstName",
            displayFormat: "LastName FirstName",
            filters: "Child__c = Kid__c",
            valueId: { fieldName: 'Parent__c' } // binding Parent Id of current item in row to autopopulate value on load.
        }
    },
    {label: 'Date', fieldName: 'CreatedDate'}
];

export default class VisitListToday extends LightningElement {
    columns=columns;
    @track rowOffset=0
    @api recordId;

    @wire(getGroupVisitsToday, {groupId: '$recordId'})
    visits;

}