# codebeamer_documentation_engine

Connecting some raw generic web pages on top of a codebeamer server.

It shows a hierarchical view on  meta data which could be stored for documentation and staging purposes.

Recommended start of app:

```
flutter run -d chrome --web-renderer html --web-port=12345
```
Please maintain settings and parameters first hand in file _"lib/config/configuration.dart"_:

|Parameter|Meaning/Purpose|
|---------|---------------|
|REST_User|User on codebeamer server with REST access permission and permission to access ALL projects|
|REST_Password|Password of this person|
|REST_URL_Prefix|codebeamer's URL prefix to identify a REST call against specific API version|
|documentationProjectID|The project ID where project documentation data needs to go, the codebeamer template ZIP file is part of this deployment (see assets folder)|
|associcationName|the name of association for relationships like project --> tracker --> field|
|trackers|<p>A map to adress the documentation trackers in documentation project (see above)</p><p>**Project** Tracker ID for tracker keeping project documentation</p><p>**Tracker** Tracker ID for tracker keeping tracker documentation</p><p>**Field** Tracker ID for tracker keeping field documentation</p><p>**Option** Tracker ID for tracker keeping option documentation</p>|
|baseURL|<p>**homeServer** URL of codebeamer source server which projects should be documented</p><p>**documentationServer** URL of codebeamer server dealing as target for documentation data</p>|
|documentationProjectID | **not implemented yet**<p>Target project as target for all documentation details of a codebeamer server<p>|
|associcationRole| Association which represents the child (see next) role when linking details in documentation project<p>|
|associcationName |see above<p>|
|maxPageSize|Value how many items are downloaded from server when dealing with large data sets (Max: 500)<p>|
|aboutText|Text to be shown when pressing about button (legal stuff)|
|...headings|Column headings when showing tabular data, like for projects, trackers, work items, etc.|
|...topics|Sub-topics available for selected data context:<p>- topic: Headline<p>- icon: Nice addition for headline<p>- widget: Which widget has be shown when sub-topic has been selected<p>- subTitle: Header what kind of data is shown by "widget"<p>|
|||
