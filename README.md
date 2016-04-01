# [gra-pwr.net](http://gra-pwr.net)

## About

![](doc/gra-pwr.gif?raw=true)

This web application is an app aimed at university students preparing for multiple-choice examinations.

Application is created and maintained by Scientific Circle in Wrocław University of Technology: [Koło Naukowe Tworzenia Aplikacji Webowych](http://monterail.com/pwr) and supported by [Monterail](http://monterail.com/).

## Technology

- Ruby on Rails 4.x
- AngularJS 1.x
- PostgreSQL

## Development setup

```
# Fork and clone the repository
$ cd infish

# Create .env file in root directory with those required settings.
# You can use my "test" Facebook APP or create your own in:
# https://developers.facebook.com/apps/
FACEBOOK_APP_ID=210494695962395
FACEBOOK_APP_SECRET=30191632a2f83c5bb84b5fe7fbb8c17f

$ bundle install
$ bundle exec rake db:create db:migrate db:seed
$ bundle exec rails server

# Log in with Facebook
# Optionally, you can assign yourself to Exam created in seed
$ bundle exec rails console
> User.order(created_at: :asc).last.user_exams.create!(exam: Exam.first)
```

## Contributing

If you've never contributed to OpenSource project on GitHub, read [this guide](https://guides.github.com/activities/contributing-to-open-source/).

In short - there should be some [open issues](https://github.com/hodak/infish/issues) that you might want to work on, or you can create your own issue.

When an issue description is not clear enough to start working on it or you have other questions - please comment on the issue and ping issue author if possible.

Fork a project, work on it and, when done, open pull request and ping [@hodak](https://github.com/hodak/) - somebody will do a code review and feature validation and, finally, merge changes to master branch.

If you have any questions don't hesitate to ask!

### Development tips

- Use `uuid` instead of `integer` for IDs
- Follow [Monterail's development guidelines](https://github.com/monterail/guidelines)

### Deployment

Most of you won't have to deploy the app, but if you do remember that:

- We use Ansible for server provisioning (see `ansible/` directory)
- We use Capistrano for deployment
- When you `FORCE_SSL` you must generate SSL certificate on server with [Let's Encrypt](https://letsencrypt.org/howitworks/)


