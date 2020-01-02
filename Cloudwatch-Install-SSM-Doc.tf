
#Installation of cloudwatch agent in the instance

resource "aws_ssm_document" "Cloudwatch_Join" {
name    		= "Sandeep_Cloudwatch_Join"
document_type   = "Command"
content = <<DOC
{
   "schemaVersion":"2.2",
   "description":"A description of the document.",
  
   "mainSteps":[
      {
         "action":"aws:configurePackage",
         "name":"configurePackage",
          "inputs": {
                    "name": "AmazonCloudWatchAgent",
                    "action": "Install"        
          
         }
    
      }
   ]
}
DOC
}


#Association of instances to the document

resource "aws_ssm_association" "example1" {
  name = "${aws_ssm_document.Cloudwatch_Join.name}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.Flow-Test-Instance1.id}"]
  }
}

resource "aws_ssm_association" "example2" {
  name = "${aws_ssm_document.Cloudwatch_Join.name}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.Flow-Test-Instance3.id}"]
  }
}

resource "aws_ssm_association" "Sandeep-Manageagent1" {
  name = "${aws_ssm_document.Sandeep-Manageagent.name}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.Flow-Test-Instance3.id}"]
  }
}

