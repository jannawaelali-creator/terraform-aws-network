import boto3
import json
import os

def lambda_handler(event, context):
    ses = boto3.client('ses', region_name='us-east-1')
    
    # get details from the S3 event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key    = event['Records'][0]['s3']['object']['key']
    
    # send email
    ses.send_email(
        Source      = os.environ['FROM_EMAIL'],
        Destination = {
            'ToAddresses': [os.environ['TO_EMAIL']]
        },
        Message = {
            'Subject': {
                'Data': 'Terraform State File Changed'
            },
            'Body': {
                'Text': {
                    'Data': f"""
Hello,

Your Terraform state file has been modified.

Bucket : {bucket}
File   : {key}

This means terraform apply was just run
and your infrastructure has changed.

Regards,
AWS Notification
                    """
                }
            }
        }
    )
    
    print(f"Email sent for change in {bucket}/{key}")
    
    return {
        'statusCode': 200,
        'body': json.dumps('Email sent successfully')
    }
