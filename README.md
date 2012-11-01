## S3 fileupload for rails

[![Build Status](https://secure.travis-ci.org/allen13/s3_fileupload_rails.png)](http://travis-ci.org/allen13/s3_fileupload_rails)

A file upload plugin that simplifies direct uploads to amazon s3 for rails. It is based on the awesome [jquery fileupload](https://github.com/blueimp/jQuery-File-Upload) project,Ryan Bates's railscasts [ep383 example](https://github.com/railscasts/383-uploading-to-amazon-s3/tree/master/gallery-jquery-fileupload) and pjambet's [blog post](http://pjambet.github.com/blog/direct-upload-to-s3/).

## Install

> Configure the S3 Bucket CORS settings to allow cross domain requests.

```xml
<CORSConfiguration>
  <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedHeader>*</AllowedHeader>
  </CORSRule>
</CORSConfiguration>
```

> Add to Gemfile and run bundle install

```ruby
gem 's3_fileupload_rails', git: 'https://github.com/allen13/s3_fileupload_rails'
```

> Mount Engine in routes.rb

```ruby
Rails.application.routes.draw do
  mount S3FileuploadRails::Engine => "/s3_fileupload_rails"
end
```