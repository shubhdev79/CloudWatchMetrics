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
                   "i-0ed95c492126cb6ec"
                ],
                  [
                   "AWS/EC2",
                   "CPUUtilization",
                   "InstanceId",
                   "i-0ed95c492126cb6ec"
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
                   "i-0ed95c492126cb6ec",
                   "ImageId",
                   "ami-01ce756cc8a299d0a",
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
                   "i-0ed95c492126cb6ec",
                   "ImageId",
                   "ami-01ce756cc8a299d0a",
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
