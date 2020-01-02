provider "aws" {
   region = "eu-west-3"
}
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "voicevaultdev-dashboard_Shubham"

  dashboard_body = <<EOF
{
   "widgets": [
       {
          "type":"metric",
          "x":0,
          "y":0,
          "width":12,
          "height":6,
          "properties":{
             "metrics":[
                [
                   "AWS/EC2",
                   "CPUUtilization",
                   "InstanceId",
                   "i-XXXXXXXXXXXXX"
                ],
                  [
                   "AWS/EC2",
                   "CPUUtilization",
                   "InstanceId",
                   "i-XXXXXXXXXXXXX"
                ]
             ],
             "period":300,
             "stat":"Average",
             "region":"eu-central-1",
             "title":"EC2 Instance CPU"
          }
       },
                  {
          "type":"metric",
          "x":0,
          "y":7,
          "width":12,
          "height":6,
          "properties":{
             "metrics":[
                [
                   "CWAgent",
                   "LogicalDisk % Free Space",
                   "InstanceId",
                   "i-XXXXXXXXXXXXX",
                   "ImageId",
                   "ami-XXXXXXXXXXXXX",
                   "InstanceType",
                   "t3.xlarge",
                   "objectname",
                   "LogicalDisk",
                   "instance",
                   "C:"
                ],
                  [
                   "CWAgent",
                   "LogicalDisk % Free Space",
                   "InstanceId",
                   "i-XXXXXXXXXXXXX",
                   "ImageId",
                   "ami-XXXXXXXXXXXXX",
                   "InstanceType",
                   "t3.xlarge",
                   "objectname",
                   "LogicalDisk",
                   "instance",
                   "C:"
                ]
             ],
             "period":300,
             "stat":"Average",
             "region":"eu-central-1",
             "title":"EC2 custom Logic disk Space"
          }
       }
   ]
}
EOF
}
