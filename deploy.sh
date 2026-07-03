#!/usr/bin/env bash
# Deploy amrthabit.com: build, sync to S3, invalidate CloudFront.
# Uses the scoped IAM profile; see the aws skill / PROJECT_STRUCTURE.md.
set -euo pipefail
cd "$(dirname "$0")"

PROFILE=amrthabit-deploy
BUCKET=s3://amrthabit.com
DIST_ID=E2AOZ72PC8R9GV

npm run build

# hashed immutable assets: cache forever
aws s3 sync build/ "$BUCKET" --profile "$PROFILE" --delete \
  --cache-control "public,max-age=31536000,immutable" \
  --exclude "*" --include "_app/immutable/*"

# everything else (html, favicon, design/): always revalidate
aws s3 sync build/ "$BUCKET" --profile "$PROFILE" --delete \
  --cache-control "public,max-age=0,must-revalidate" \
  --exclude "_app/immutable/*"

# the origin serves exact keys, so /ar needs an extensionless copy of ar.html
aws s3 cp build/ar.html "$BUCKET/ar" --profile "$PROFILE" \
  --content-type "text/html; charset=utf-8" \
  --cache-control "public,max-age=0,must-revalidate"

aws cloudfront create-invalidation --profile "$PROFILE" \
  --distribution-id "$DIST_ID" --paths "/*" \
  --query "Invalidation.[Id,Status]" --output text

echo "deployed: https://amrthabit.com"
