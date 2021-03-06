# Subvalid

Subvalid decouples your validation logic from your object structure. With
Subvalid you can define different validation rules for different contexts. So
rather than defining validation on the object, and having it be _"objective"_,
you can define it in a separate class - so it's _"subjective"_. (as in **Sub**jective
**valid**ation).

Subvalid was extracted from a project at [Envato](http://envato.com) which
requires complex validation logic at each stage of an object's life cycle:
- Users upload videos. The videos are validated to make sure an actual
  video was uploaded (and not someone's university Powerpoint slides), that
framerate is good, resolution and codec is acceptable etc. Failure here would
reject the file straight away, and tell the user to try again with a new file.
- Next we generate thumbnails, resized preview videos etc. If anything fails
  validation here, it's a bug (wrong preview video size etc) - and we want to
alert developers.
- After the video is uploaded and processed, users would enter metadata: title,
  description, tags etc. If that fails - we still want to save the item, but
just leave it as _"incomplete"_, and allow the user to come back later and
complete it. Once this passes, the item is ready, and we submit it for review to
our internal review team.

All these steps are done asynchronously, so we need to capture the errors, save
them to a different field on the item, and carry on to report results back to
the user.

While
[ActiveModel::Validations](http://api.rubyonrails.org/classes/ActiveModel/Validations.html)
is great if you've got simple validation logic, it doesn't cut it for something
complex like this. When you have different validation for the same object at
each point in it's life cycle, you need something more flexible.

ActiveModel also hooks in pretty deep into
[ActiveRecord](http://guides.rubyonrails.org/active_record_validations.html).
It's main use case assume you're just wanting to prevent bad data hitting your
database - which isn't necessarily always the case.

We needed something more. So Subvalid was born.

And you can have the best of both worlds. Subvalid can exist alongside
ActiveModel. ActiveModel::Validations is great for ensuring data consistency,
and you can add it to your model classes as normal - and then write Subvalid
validator classes in addition to handle more complex nuanced validation logic.
Or do it all in Subvalid - up to you.

## Features
- Very simple, consistent API
- Validation logic is defined in separate _"Validator"_ classes completely
  decoupled from business logic
- Multiple validators can be defined for each piece of data in your system to be
  executed at different points
- Caller is in control. No magic happening under the hood
- Failing validation does not block saving to the database
- Does not add _anything_ at all to business objects. No including modules, no
  monkey patching, no object extension. Subvalid assumes POROs, but works with
anything. A key design goal is to **not** pollute the objects being validated at
all
- Supports nested validation on nested object structures - and nicely handles
  nested errors.
- DSL and API inspired by ActiveModel::Validations - just simplified and more
  consistent.

## Development Status [![travis ci build](https://api.travis-ci.org/envato/subvalid.svg)](https://travis-ci.org/envato/subvalid)

Subvalid is extracted from production code in use at Envato. However, it is undergoing early development, and APIs and features are almost certain to be in flux.

## Getting Started

Add this line to your application's Gemfile:

```ruby
gem 'subvalid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subvalid

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/subvalid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
