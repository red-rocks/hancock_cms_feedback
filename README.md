# HancockCmsFeedback

### Remaded from [EnjoyCMSFeedback](https://github.com/enjoycreative/enjoy_cms_feedback)

Feedback system for [HancockCMS](https://github.com/red-rocks/hancock_cms).
Feedback form, AJAX, Mailer, custom fields, captcha support

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hancock_cms_feedback'
```

Then add this
```ruby
gem "recaptcha", require: "recaptcha/rails" # Recaptcha
```
before it for captcha you need. And configure it.

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hancock_cms_feedback

## Usage

Add in config/routes.rb

```ruby
  hancock_cms_feedback_routes
```
Then execute

    $ rails g hancock:feedback:config

and now you can edit config/initializers/hancock_feedback.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/red-rocks/hancock_cms_feedback.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
