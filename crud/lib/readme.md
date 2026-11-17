# SMS Center Design

## SMSCenter Page

- Check permission: SMS permissions, Battery Optimization Disable
- Start SMS Listener to listen income SMSs
- Start SMS Background Task to process income SMSs
- Manual query Inbox SMSs to put to queue to be processed

## SMSService

- SMS Listener methods
- SMS Inbox query method

## SMSPersistentQueue

- enqueue/mark complete/markfailed income sms
- fetch income sms for processing

## SMSBackgroundTask

- setup a periodic task running in background: call SMSQueueWorker
- manage background task: start/stop

## SMSQueueWorker

- process queued income sms

## SMSPermissionHelper

- help to disable Battery Optimization so that the app can be run long in background

## SMS Permissions

- using telephony packages and settings in AndroidManifest.xml

## SMSParser

- a helper class to parse SMS to identify if it is a OTP message, get monetary amounts
