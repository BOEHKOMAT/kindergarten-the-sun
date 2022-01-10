/**
 * Created by Andrew on 09.01.2022.
 */

import {LightningElement, api, wire, track} from 'lwc'
import getTopKid from '@salesforce/apex/GroupController.getTopKid'


export default class TopKids extends LightningElement {
    @api recordId;

    @wire(getTopKid, {groupId: '$recordId', month: true})
    topMonth;

    @wire(getTopKid, {groupId: '$recordId', month: false})
    topWeek;
}