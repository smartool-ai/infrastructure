# Infrastructure
This is the home for the infrastructure layer hosted on AWS and utilizing SAM to generate Cloudformation templates.

Deployments/Updates of stacks should be done through CI/CD for Production environments always.

Any sensitive secrets/tokens should be passed via environment variables and never hardcoded into sam template.

