# JadminBoard

JadminBoard is a quick way to get an admin area setup in your rails application.

For now there is no gem, so installing is a matter of downloading the code, unzipping it in the root of your rails application.

`/home/User/Sites/myapp`

We believe all people can use this package, but the choices made are mainly to support our own needs. It is just nice to share. Maybe you can just use it for inspiration.

## Installing

Installing may feel a bit much. Don't worry, the steps are easy.

### Gems

Install the following gems, or add them to your Gemfile:

```
gem 'devise'
gem "twitter-bootstrap-rails"
gem "therubyracer"
gem "less-rails"
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'compass'
gem 'compass-rails'
 
```

For now, first install devise, find that out please :).

### Routes
Add the following to your `routes.rb` file:

```
  devise_for :admins, :controllers => { 
    :sessions => "admin/admin_sessions", 
    :passwords => "admin/admin_passwords", 
    :confirmations => "admin/admin_confirmations", 
    :unlocks => "admin/admin_unlocks", 
    :registrations => "admin/admin_registrations" 
  }

  namespace :admin do
    match 'dashboard' => "admins#dashboard"
  end

```

You might find it curious that `devise for :admin` is not in the `:admin` namespace. The reason for this is that this way we can use `current_admin` in all areas of the app rather than just backstage. Also, moving it into the namespace, sadly, won't make it 'just work' as you'd expect.

### Devise inititalizer

In the devise initializer (`config/inititalizers/devise.rb`).

Set:
```
config.scoped_views = true	
```

This way we can use different devise views for different authenticator models. For example, you want to have Devise for 'normal' users, this way the admin will have a different 'forgot password' view than the user.

### Asset pipeline
Make sure that your main `application.css` and `application.js` files don't include your bootstrap styles and code.

### Migrations
```
class DeviseCreateAdmins < ActiveRecord::Migration
  def change
    create_table(:admins) do |t|
    
      ## Make things personal
      t.string :name, :null => false, :default => "Administrator"
    
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token


      t.timestamps
    end

    add_index :admins, :email,                :unique => true
    add_index :admins, :reset_password_token, :unique => true
    add_index :admins, :confirmation_token,   :unique => true
    add_index :admins, :unlock_token,         :unique => true
    # add_index :admins, :authentication_token, :unique => true
  end
end
```