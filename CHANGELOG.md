Changelog
=========

### 1.0.0 Don't log as ERROR (let the host decide if is an error or not)
  - Decrease the logger level from "error" to "warn" when status == 2
  - Bump version to v1.0.0.

### 0.2.0 Make sure default personalizations (TIMESTAMP and EMAIL_TEMPLATE are uppercase)

### 0.1.6 Add more details when an error response is processed.

### 0.1.5 Removing some error loggers.

### 0.1.4 Misc

### 0.1.4 Fixing EOF error

### 0.1.3 Misc

- Don't use SSL by default: `http.use_ssl  = false`.
- Return the full response and log the response stats to logger.
- Indentation fixes

- Return full XML response.

### 0.1.2 Other typo with 0.1.1.
### 0.1.1 Typo with the new SAVE_COLUMNS feature.

### 0.1.0
- Including `<SAVE_COLUMNS>` inside the XML request.

> To save the personalization values in the Engage database,
> you must create the fields in your database and use the SAVE_COLUMN element
> for that XML tag.

```
<XTMAILING>
  <CAMPAIGN_ID>numeric CAMPAIGN id</CAMPAIGN_ID>
  <TRANSACTION_ID>TRANS-1234</TRANSACTION_ID>
  <SHOW_ALL_SEND_DETAIL>false</SHOW_ALL_SEND_DETAIL>
  <SEND_AS_BATCH>false</SEND_AS_BATCH>
  <NO_RETRY_ON_FAILURE >false</NO_RETRY_ON_FAILURE>
  <SAVE_COLUMNS>
    <COLUMN_NAME>ACCOUNT_ID</COLUMN_NAME>
  </SAVE_COLUMNS>
  <RECIPIENT>
    <EMAIL>person@domain.com</EMAIL>
    <BODY_TYPE>HTML</BODY_TYPE>
    <PERSONALIZATION>
      <TAG_NAME>ACCOUNT_ID</TAG_NAME>
      <VALUE>807</VALUE>
    </PERSONALIZATION>
    <PERSONALIZATION>
      <TAG_NAME>TRANSACT_MAIL_BODY</TAG_NAME>
      <VALUE><![CDATA[<p>Click this link: <a href="http://foo">link</a><p>]]></VALUE>
    </PERSONALIZATION>
  </RECIPIENT>
</XTMAILING>
```

### 0.0.8
- Removing log4r and use Rails.logger instead (fix for isssue #1)

### 0.0.7
- If Rails.logger exists use it, if not switch to log4r.

### 0.0.6
- Start using log4r instead of Logger.new (now logs are namespaced)
- Minor changes to README and documentation. Added Changelog and silverpop api.
- Adding name spaced exceptions to handle custom errors.

### 0.0.5
- Start using job.configure { } to change the Silverpop gateway url.
- Start using Pry instead of IRB.
- Start using Awesome Print instead of inspect.

### 0.0.4
- Minor changes to README and documentation.

### 0.0.3
- First usable version. Seems to be working.

### 0.0.2
- Adding a few clasess, still a mess.

### 0.0.1
- Empty gem using bundler's boilerplate.

TODO
----

- Include Yard for documentation http://yardoc.org
- Let change the gateway from the Class, instead from the instance
