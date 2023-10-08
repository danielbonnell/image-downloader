## CHANGELOG

## [0.1.0] - 08.10.2023 - Initial release

### Changes

- Add ImageDownloader::Client class with encapsulated logic for parsing input URLs, fetching images, and logging errors to the console.
- Set up unit tests for common scenarios.
- Configure additional Rubocop settings.
- Add initial inline and README documentation. 
- Add rake task for using gem from the command line.

### Breaking Changes

### Release Notes

This is a proof-of-concept gem for downloading images from a list of URLs supplied in a text file. It is "theoretically" suitable for use in a production environment, however there are serious limitations that should be considered before using it in a production environment. It is designed to gracefully handle some simple common edge cases (e.g. non-200 HTTP status codes, invalid URLs, etc), however there are many additional edge cases when fetching remote resources over the internet that should be properly handled before using it in production. Some examples include handling HTTP redirects, malicious files that appear to be images (e.g. files with a mismatched MIME type) but aren't, etc. This proof-of-concept lacks certain safeguards that are advisable in a production environment, such as limiting the maximum-allowed file size or number of files that can be downloaded. Additionally, there may be security concerns that should be addressed before implementing it in a production environment, such as only allowing resources to be fetched over SSL, adding a list of allowed/trusted hosts, etc. Finally, this proof-of-concept was designed with some simple error handling/logging built in, however in a production setting it would be advisable to log errors to an external monitoring tool (e.g. DataDog) and to store images remotely (e.g. AWS S3) rather than to the local disk.