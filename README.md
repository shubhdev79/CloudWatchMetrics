# CloudWatchMetrics
CloudWatch Metrics, Alarms &amp; Dashboard Creation


# Creation of Custom Metrics, Alarms & Configuration of CloudWatch Dashboard through Terraform.

Roles : Policies :
.* AmazonCloudWatchAgentAdminPolicy
.* AmazonCloudWatchAgentServerPolicy  [Must Attach Policies in Our Role for Windows Instances]

**1. Installing CW Agent on Windows : Through SSM [Server Should be in Managed Instances]**

 **2. Creating Config file through WIZARD.exe - > ProgramData -> CloudWatchAgent -> Configs (File Should Present)**
-> Creating Parameter Store, to use it for running on other servers. [Document Name - AmazonCloudWatchManageAgent]
[Running Para-Store Manually, as we are facing an issue for givin inputs to the Value]

 **3.After above steps done, wait for 5-10 minutes to custom metrics to appear. Will be available as 'CWAgent' - Custom NameSpace.**

**4. Once above configuration done & CWAgent appeared in cloudWatch.**
-> Create Dashboard
-> Create SNS Topic
-> Create Alarms

![alt text](https://github.com/shubhdev79/CloudWatchMetrics/blob/master/CWMetrics.png)
