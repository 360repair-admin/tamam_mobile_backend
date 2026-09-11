# 🛡️ Faulty

A **lightweight Rails gem** to capture exceptions and save them directly into your own database.
Think of it as a **minimal, self-hosted Sentry/Bugsnag alternative** — built for Rails apps. 🚀

---

## 📦 Installation

Add to your `Gemfile`:

```ruby
gem "faulty"
```

Install the gem:

```bash
bundle install
```

---

## ⚙️ Setup

Generate and run the migration:

```bash
rails generate faulty:install
rails db:migrate
```

This creates the necessary database tables for storing error logs and events.

---

## 🔧 Configuration

Create an initializer (`config/initializers/faulty.rb`):

```ruby
Faulty.configure do |config|
  # Enable in specific environments
  config.enabled_environments = %w[development staging production]
end
```

---

## 🛠️ How it Works

1. **Rack Middleware** – Faulty hooks into your Rails stack automatically
2. **Automatic Logging** – Every unhandled exception is saved to the database
3. **Rails Console Access** – Explore logs anytime with ActiveRecord models

Access your error data:

```ruby
Faulty::Error.count
Faulty::Event.last
```

---

## ✋ Manual Capture

Need to catch something yourself? Use the capture method:

```ruby
begin
  dangerous_code
rescue => e
  Faulty.capture(e, context: { user_id: current_user.id })
end
```

You can also capture with additional context:

```ruby
Faulty.capture(exception, context: {
  user_id: current_user.id,
  controller: self.class.name,
  action: action_name,
  params: params.to_unsafe_h
})
```

---

## 🚨 Example Usage

**Controller action:**

```ruby
class PostsController < ApplicationController
  def index
    raise "Something went wrong!"
  end
end
```

**Check in Rails console:**

```ruby
# View the latest error
error = Faulty::Error.last
# => #<Faulty::Error id: 1, error_class: "RuntimeError", message: "Something went wrong!", ...>

# Get error details
error.message
# => "Something went wrong!"

error.error_class
# => "RuntimeError"

error.backtrace
# => ["app/controllers/posts_controller.rb:3:in `index'", ...]

# View all events of this error
error.events.count
# => 1
```

---

## 🗃️ Database Schema

Faulty creates two main tables:

### `faulty_errors`

Stores unique error types with their stack traces and metadata.

### `faulty_events`

Tracks each individual event of an error with timestamp and context.

---

## 🗺️ Roadmap

* ✅ Basic exception capture
* ✅ Save errors to database
* ✅ Manual error capture with context
* ⏳ Web dashboard (search & view logs)
* ⏳ Error grouping and deduplication
* ⏳ Notifications (Slack / Email integration)
* ⏳ Error resolution tracking
* ⏳ Performance metrics

---

## 📜 License

This project is built  **exclusively for internal use of 360Repair**
