Silverpop API
-------------

We're using this <https://transact5.silverpop.com/XTMail> end point.

### Request:

```
<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
<XTMAILING>
  <CAMPAIGN_ID>792430</CAMPAIGN_ID>
  <SHOW_ALL_SEND_DETAIL>true</SHOW_ALL_SEND_DETAIL>
  <SEND_AS_BATCH>false</SEND_AS_BATCH>
  <NO_RETRY_ON_FAILURE>false</NO_RETRY_ON_FAILURE>
  <SAVE_COLUMNS>
    <COLUMN_NAME>first_name</COLUMN_NAME>
  </SAVE_COLUMNS>
  <RECIPIENT>
    <EMAIL>mariozaizar@gmail.com</EMAIL>
    <BODY_TYPE>HTML</BODY_TYPE>
    <PERSONALIZATION>
      <TAG_NAME>data</TAG_NAME>
      <VALUE><![CDATA[{:first_name=>\"Mario Alberto\"}]]></VALUE>
    </PERSONALIZATION>
  </RECIPIENT>
</XTMAILING>
```

### Response:

Succcess:

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<XTMAILING_RESPONSE>
  <CAMPAIGN_ID>1807752</CAMPAIGN_ID>
  <RECIPIENTS_RECEIVED>1</RECIPIENTS_RECEIVED>
  <EMAILS_SENT>1</EMAILS_SENT>
  <NUMBER_ERRORS>0</NUMBER_ERRORS>
  <STATUS>0</STATUS>
  <ERROR_CODE></ERROR_CODE>
  <ERROR_STRING></ERROR_STRING>
</XTMAILING_RESPONSE>
```

When something is wrong:

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<XTMAILING_RESPONSE>
  <CAMPAIGN_ID>1807752</CAMPAIGN_ID>
  <RECIPIENTS_RECEIVED>1</RECIPIENTS_RECEIVED>
  <EMAILS_SENT>0</EMAILS_SENT>
  <NUMBER_ERRORS>1</NUMBER_ERRORS>
  <STATUS>2</STATUS>
  <ERROR_CODE>2</ERROR_CODE>
  <ERROR_STRING>something wrong!</ERROR_STRING>
</XTMAILING_RESPONSE>
```

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<XTMAILING_RESPONSE>
  <CAMPAIGN_ID>4914098</CAMPAIGN_ID>
  <RECIPIENTS_RECEIVED>1</RECIPIENTS_RECEIVED>
  <EMAILS_SENT>0</EMAILS_SENT>
  <NUMBER_ERRORS>1</NUMBER_ERRORS>
  <STATUS>2</STATUS>
  <ERROR_CODE>0</ERROR_CODE>
  <ERROR_STRING></ERROR_STRING>
  <RECIPIENT_DETAIL>
    <EMAIL>user_email</EMAIL>
    <SEND_STATUS>1</SEND_STATUS>
    <ERROR_CODE>4</ERROR_CODE>
    <ERROR_STRING>invalid email address user_email</ERROR_STRING>
  </RECIPIENT_DETAIL>
</XTMAILING_RESPONSE>
```
