require 's3_direct_upload'


S3DirectUpload.config do |c|
  c.access_key_id = AWS_ACCESS_KEY_S3       # your access key id
  c.secret_access_key = AWS_SECRET_KEY_S3   # your secret access key
  c.bucket = AWS_S3_BUCKET              # your bucket name
  c.region = AWS_REGION_S3             # region prefix of your bucket url. This is _required_ for the non-default AWS region, eg. "s3-eu-west-1"
  c.url = AWS_S3_BASE_URL                # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end



#Rails.application.config.middleware.use JQuery::FileUpload::Rails::Middleware

