Planet Express.rb
=================

Planet Express, Inc. is an intergalactic email delivery <strike>company</strike>
lib built in Ruby. Is meant to be used with Silverpop mailing system, to provide
an easy way to send emails. We're using it with Rails 3 apps.

> "Our crew is replaceable. Your <strike>package</strike> email isn't."

**@MarioZaizar**

Usage
-----

You only need three things, the package, the destination and the data.

```
recipient  = 'mariozaizar@gmail.com'
package_id = 1807752
cargo      = {
  fist_name: 'Mario',
  last_name: 'Zaizar',
  bill_float_test_body: "<h1>Good news everyone!</h1><img src='http://goo.gl/XazeH'>"
}
```

Then create a new deliver, prepare the ship and deliver it!

```
job = PlanetExpress::Delivery.new
request   = job.prepare package_id, recipient, cargo
response  = job.deliver!
```

Silverpop API
-------------

We're using this <https://transact5.silverpop.com/XTMail> end point.

### Request:

```
<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
<XTMAILING>
  <CAMPAIGN_ID>1807752</CAMPAIGN_ID>
  <SHOW_ALL_SEND_DETAIL>true</SHOW_ALL_SEND_DETAIL>
  <SEND_AS_BATCH>false</SEND_AS_BATCH>
  <NO_RETRY_ON_FAILURE>false</NO_RETRY_ON_FAILURE>
  <RECIPIENT>
    <EMAIL>mariozaizar@gmail.com</EMAIL>
    <BODY_TYPE>HTML</BODY_TYPE>
    <PERSONALIZATION>
      <TAG_NAME>first_name</TAG_NAME>
      <VALUE><![CDATA[Mario]]></VALUE>
    </PERSONALIZATION>
    <PERSONALIZATION>
      <TAG_NAME>last_name</TAG_NAME>
      <VALUE><![CDATA[Zaizar]]></VALUE>
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