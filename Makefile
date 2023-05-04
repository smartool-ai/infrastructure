sam-package:
	sam package --region us-west-2 --template-file template.yaml \
		--s3-bucket infrastructure-${STAGE_NAME} \
		--s3-prefix api_builds --output-template-file packaged.yaml

sam-deploy:
	make sam-package

	sam deploy --region us-west-2 --no-fail-on-empty-changeset --template-file packaged.yaml \
		--stack-name JKBX-Infra-${STAGE_NAME} \
		--capabilities CAPABILITY_IAM \
		--parameter-overrides StageName=${STAGE_NAME}
