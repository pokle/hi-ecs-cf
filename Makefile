

BUCKET ?= sample-cf-templates
STACK_NAME ?= ecs-cluster
KeyName ?= tush-on-the-laptop
VpcId ?= vpc-3017de54
SubnetId ?= subnet-114cd875,subnet-f169d587,subnet-5172d608

define	CF_PARMS
[\
	{"ParameterKey": "KeyName", "ParameterValue": "$(KeyName)"},\
	{"ParameterKey": "VpcId", "ParameterValue": "$(VpcId)"},\
	{"ParameterKey": "SubnetID", "ParameterValue": "$(SubnetId)"}\
]
endef

upload-template:
	aws s3 cp ecs.json s3://$(BUCKET)/ecs.json

create:
	aws cloudformation create-stack \
		--stack-name $(STACK_NAME) \
		--parameters '$(CF_PARMS)' \
		--capabilities CAPABILITY_IAM \
		--template-url https://s3-ap-southeast-2.amazonaws.com/sample-cf-templates/ecs.json
