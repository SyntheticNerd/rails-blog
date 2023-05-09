# Notes on Rails

## Table of Content

- [Notes on Rails](#notes-on-rails)
  - [Table of Content](#table-of-content)
  - [Overview](#overview)
  - [Start a Rails app](#start-a-rails-app)
    - [Adding your first Route](#adding-your-first-route)
    - [Using your first Controller](#using-your-first-controller)
    - [Adding a custom controller](#adding-a-custom-controller)
    - [Adding a template](#adding-a-template)
  - [About the Rails file structure](#about-the-rails-file-structure)
    - [Inside of App](#inside-of-app)
  - [Adding more pages](#adding-more-pages)
    - [Working with Controllers](#working-with-controllers)
      - [More on Controllers](#more-on-controllers)
        - [Application Controller](#application-controller)
        - [Validating Routes with Controller](#validating-routes-with-controller)
    - [Working with Templates](#working-with-templates)
      - [The Difference between `<% %>` \& `<%= %>`](#the-difference-between-----)
      - [`for each` in Templates](#for-each-in-templates)
      - [Form Helpers](#form-helpers)
        - [Example Forms](#example-forms)
      - [Links](#links)
      - [Partials](#partials)
      - [Formatting time](#formatting-time)
  - [Rails naming conventions](#rails-naming-conventions)
  - [Creating a Scaffold from scratch](#creating-a-scaffold-from-scratch)
    - [Create Migration](#create-migration)
    - [Create Model](#create-model)
      - [Adding Validation to Models](#adding-validation-to-models)
    - [Adding associations to Models](#adding-associations-to-models)
      - [Many to Many Association](#many-to-many-association)
      - [Before Save](#before-save)
    - [Working with the Rails Console](#working-with-the-rails-console)
      - [Defining Restrictions](#defining-restrictions)
    - [More on Routes](#more-on-routes)
  - [Adding Authentication](#adding-authentication)
    - [How to do it WITHOUT Devise](#how-to-do-it-without-devise)
  - [DRY Ruby Practices](#dry-ruby-practices)
  - [ByBug now Ruby Debugger](#bybug-now-ruby-debugger)
    - [Simple Validation and Flash](#simple-validation-and-flash)
  - [Testing](#testing)
  - [Rails Magic](#rails-magic)
    - [\<model\>\_path](#model_path)
    - [Scaffold Generator](#scaffold-generator)
    - [Test Unit Scaffold](#test-unit-scaffold)
    - [Migration Generator](#migration-generator)
    - [Controller Generator](#controller-generator)
    - [Session](#session)
    - [Helper Method Tag](#helper-method-tag)
  - [Notes on Ruby](#notes-on-ruby)
  - [Will\_Paginate Gem](#will_paginate-gem)

## Overview

Rails is a backend framework for Ruby that uses the MVC practices

- (M)odels - Self explanatory these are the things we will interact with
- (V)iews - Make up the front end of the application
- (C)ontrollers - The brains behind your application dictates how models are used

## Start a Rails app

`rails new <project_name>`

**Are You Going to Use Bopotstrap** then plan ahead

`rails new <project_name> --css bootstrap`

There may be a small issue where there is an error in the `package.json` this is fixed by replaceing:
`app/javascript/*.* ` with `app/javascript/application.js`

```json
"build": "esbuild app/javascript/application.js --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
```

Now lets test start the server

`rails server` or `rails s` for short

Unless specified otherwise rails will boot on [localhost:3000](http://localhost:3000)
This will be the root route.

### Adding your first Route

[More on Routes](#more-on-routes)

In `config/routes.rb` is where we start our adventure
To configure our first route we need to point the `root` to once of our controllers.
The only controller we have is in `/app/controllers/application_controller.rb` so we will point to that one

```rb
# config/routes.rb
Rails.application.routes.draw do
  root 'application#hello'
end

```

We can specify a method/action in the application_controller to call after a `#` symbol `root 'application#hello'`

### Using your first Controller

Now we need a method/action in the application controller to handle our request
`/app/controllers/application_controller.rb`

We create a method/action inside of the controller that is called on the root route
this method/action will `render` a `html` document that sayd `Hello world!`

```rb
class ApplicationController < ActionController::Base
  def hello
    render html: 'Hello World!'
  end
end
```

Moving forward we will use templates `.erb` files to make pages dynamic

### Adding a custom controller

Lets says we start with `routes.rb` like this:

```rb
Rails.application.routes.draw do
 root 'pages#home'
end
```

We need to add a controller called `pages` and a action in that controller called `home`

Rails gives us a tool to `generate` a controller. In a terminal navigate to the root of your project folder.
`rails generate controller <name_of_controller>`

```cmd
rails generate controller pages_controller
```

This generated a bunch of files/folders; the ones we care about are:

- `app/controllers/pages_controller.rb`
- `app/views/pages` folder

In the `app/controllers/pages_controller.rb` file we need to define our `home` action

```rb
class PagesController < ApplicationController
  def home
  end
end
```

By convention this expects a home.erb template under the pages folder in your view in the new `app/views/pages` folder

### Adding a template

Now add a `home.html.erb` file to that `pages` folder and for now just type

```html
Hello world!
```

Start the server with `rails s` and you have your first template

Now all we need are some models

## About the Rails file structure

| File                   | Folder Purpose                                                                                                                                                                                                                                                            |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| app                    | Contains the controllers, models, views, helpers, mailers, channels, jobs, and assets for your application. You'll focus on this folder for the remainder of this guide.                                                                                                  |
| bin                    | Contains the rails script that starts your app and can contain other scripts you use to set up, update, deploy, or run your application.                                                                                                                                  |
| config                 | Contains configuration for your application's routes, database, and more. This is covered in more detail in Configuring Rails Applications.                                                                                                                               |
| config.ru              | Rack configuration for Rack-based servers used to start the application. For more information about Rack, see the Rack website.                                                                                                                                           |
| db                     | Contains your current database schema, as well as the database migrations.                                                                                                                                                                                                |
| Gemfile & Gemfile.lock | These files allow you to specify what gem dependencies are needed for your Rails application. These files are used by the Bundler gem. For more information about Bundler, see the Bundler website.                                                                       |
| lib                    | Extended modules for your application.                                                                                                                                                                                                                                    |
| log                    | Application log files.                                                                                                                                                                                                                                                    |
| public                 | Contains static files and compiled assets. When your app is running, this directory will be exposed as-is.                                                                                                                                                                |
| Rakefile               | This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing Rakefile, you should add your own tasks by adding files to the libtasks directory of your application. |
| README.md              | This is a brief instruction manual for your application. You should edit this file to tell others what your application does, how to set it up, and so on.                                                                                                                |
| storage                | Active Storage files for Disk Service. This is covered in Active Storage Overview.                                                                                                                                                                                        |
| test                   | Unit tests, fixtures, and other test apparatus. These are covered in Testing Rails Applications.                                                                                                                                                                          |
| tmp                    | Temporary files (like cache and pid files).                                                                                                                                                                                                                               |
| vendor                 | A place for all third-party code. In a typical Rails application this includes vendored gems.                                                                                                                                                                             |
| .gitattributes         | This file defines metadata for specific paths in a git repository. This metadata can be used by git and other tools to enhance their behavior. See the gitattributes documentation for more information.                                                                  |
| .gitignore             | This file tells git which files (or patterns) it should ignore. See GitHub - Ignoring files for more information about ignoring files.                                                                                                                                    |
| .ruby-version          | This file contains the default Ruby version.                                                                                                                                                                                                                              |

### Inside of App

| File        | Folder Purpose                                                          |
| ----------- | ----------------------------------------------------------------------- |
| assets      | This store things like images and styles                                |
| channels    | This is what makes real time communication possible                     |
| controllers | Thi si where controllers live                                           |
| helpers     | This is where helper function that generally assist with our views live |
| javascript  | this is where the javascript lives find the main application.js         |
| models      | This is where the models live                                           |
| views       | This is where are layout and views live                                 |

## Adding more pages

First we are going to add a page this will be a `get` request to a page at the route `about` and we will use the `pages` controller to render the page using the `about` action

```rb
Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
end
```

### Working with Controllers

Next jump over to the `pages_controller` and add

```rb
class PagesController < ApplicationController
  # By convention this expects a home.erb template under the pages folder in you views
  def home
  end

  def about
  end
end
```

**White Listing Parameters** `params.require(:article).permit(:title, :description)`: Will make them available to use

#### More on Controllers

We can set actions to be before or after controller regular actions.

Inside the controller we will set up a `private` section anything that falls under private are only available to actions inside the controller

```rb
before_action :set_article, only %i[show edit update destroy]
#...
private
def set_article
  @article = Article.find(params[:id])
end
```

We can use the `only` keyword to specify specific actions where the before actions will be called.
We can also use the `except` keyword to to prevent actions

##### Application Controller

In the application controller we can define methods that will then be available accross all other controller as long as they are inheriting from the ApplicationController

##### Validating Routes with Controller

### Working with Templates

Lastly in the `views/pages` add an `about.html.erb` template

#### The Difference between `<% %>` & `<%= %>`

- `<% %>` - Allows you to write Ruby code but does not evaluate it and therefore will not render it to the screen
- `<%= %>` = This evaluates Ruby code and renders to the screen

#### `for each` in Templates

We essentially use regular ruby with html in-between

```html.erb
<% @articles.each do |article| %>
  <tr>
    <td><%= article.title %></td>
    <td><%= article.description %></td>
    <td>
      <%= link_to 'Delete', '#' %>
    </td>
  </tr>
<% end %>
```

#### Form Helpers

[Form Helper Docs](https://guides.rubyonrails.org/form_helpers.html)

##### Example Forms

Create a blank form that will create and submit data to the article model as well as refresh on load

- Start with `form_with` then we define multiple properties of the to configure the forms behavior
- `scope: ` will allow us to define a model this form is a associated with based on the model the form will automatically associate form inputs with model fields and generate the appropriate request to submit the form and add an element to the database.

```html.erb
<%=  form_with scope: :article, url: articles_path, local: true, data: { turbo: false } do |f|%>
  <%# The functionality of this form ultimately relies on bad code we dont want to rely on the page refreshing to render the errors %>
  <%= f.label :title %> <br/>
  <%= f.text_field :title %> <br/>
  <%= f.label :description %> <br/>
  <%= f.text_area :description %> <br/>
  <p>
    <%= f.submit %>
  </p>
<% end %>
```

Minor conditional rendering can be done using a ternary operator in parentheses

```html.erb
<%= f.submit(@user.new_record? ? 'Sign up' : 'Update Account', class: "btn btn-primary mr-2") %>
```

#### Links

Standard

```html.erb
<%= link_to '<label>', '<route>' %>
```

[Model Linked?](https://guides.rubyonrails.org/layouts_and_rendering.html#rendering-by-default-convention-over-configuration-in-action)

```html.erb
<%= link_to "Show", article %>
<%= link_to "Edit", edit_article_path(book) %>
<%= link_to 'Delete', article, data: { turbo_method: :delete, turbo_confirm: "Are you sure?"} %>
<%= link_to "New article", new_article_path %>
```

#### Partials

We can create partials - sections of re-usable html

First create a file partial `_file-name.html.erb`

Then in the html you want to render the partial in you simply use the render keyword and relative file location
**note** you do not need the \_ when you are referencing the file in the render

```rb
<%= render 'file-name' %>
```

#### Formatting time

```html.erb
<td><%= time_ago_in_words(user.created_at) %></td>
```

## Rails naming conventions

- Model - Ex. article (singular, defining the characteristic of the model)
  - Article model file name: article.rb
  - Article model class name: Article
- Table - Ex. articles (plural)
- Controller -
- Views -

## Creating a Scaffold from scratch

Also see [Scaffold Generator](#scaffold-generator)

### Create Migration

To create a articles model we need to start by creating the migration

Generate a basic migration file in the terminal `rails generate migration <migration_name>`

```cmd
rails generate migration create_articles
```

This will generate a new migration file in the `db/migrate` folder
We have to use generate to make this file because rails will automatically prepend a time stamp to the file, later the order in which migration files run will matter.

We will simple add a string and call it title

```rb
class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
    end
  end
end
```

We can add default values with the default keyword

```rb
class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
```

Now we need to run migrate, keep in mind ruby will only run migration files that have not been run already.
To migrate run `rails db:migrate`

If you find you left something out you can always rollback the migration with `rails db:rollback` although this is not the preferred method of making this kind of fix because it could cause the db to be out of sync across multiple developers

The preferred way would be to make a new migration file and more over make sure time stamp is included in the migrations

To update a table already create we can add a column specify which table we want to add the column to, specify the name for that column, and lastly the data type.
To create a timestamp we will need to add the create_at and updated_at columns

```rb
class AddTimestamp < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
    add_column :articles, :user_id, :int
  end
end
```

With the new migration added we can run the migrations and the `articles` table will be updated.

### Create Model

Create the model in `app/models` don't forget the naming convention
In this example I create a file called `article.rb` in the models folder

All models will inherit from the `ApplicationRecord`

```rb
class Article < ApplicationRecord
end
```

This actually already will give us getters and setter
One way to access these are through the `rails console`, `rails c` for short

#### Adding Validation to Models

[Ruby Validation Docs](https://guides.rubyonrails.org/active_record_validations.html)

```rb
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitivity: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitivity: false },
                    format: { with: VALID_EMAIL_REGEX }
end
```

### Adding associations to Models

```rb
class User < ApplicationRecord
  has_many :articles
end
```

```rb
class Article < ApplicationRecord
  belongs_to :user
end
```

We can define the behavior of dependent models with the `dependent` keyword, for example if a blog User gets deleted all their articles should be deleted as well.

```rb
class User < ApplicationRecord
  has_many :articles, dependent: :destroy
end
```

#### Many to Many Association

[Docs](https://guides.rubyonrails.org/association_basics.html#choosing-between-has-many-through-and-has-and-belongs-to-many)

#### Before Save

```rb
class User < ApplicationRecord
  before_save { self.email = emsil.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitivity: false },
                    format: { with: VALID_EMAIL_REGEX }
end
```

### Working with the Rails Console

From the console we can make some basic queries on our database
Review of CRUD operations

- To see a list of all our articles

  ```rb
  Articles.all
  ```

- To CREATE an article

  ```rb
  Article.create(title: "first article", description: "description of first article")
  ```

- We can CREATE a object and assign it to a variable and then update it as we please

  ```rb
  article = Article.new #=> <Article:0x0 id: nil, title: nil, description: nil, created_at: nil, updated_at: nil>
  article.title = "Article 2" #=> "Article 2"
  article.title = "Article 2 Description"
  article # => #<Article:0x0 id: nil, title: "Article 2", description: "Article 2 Description", created_at: nil, updated_at: nil>
  ```

  We can see that this article has not yet hit the database because the created and id fields are still nil

- We can save the article to the database

  ```rb
  article.save
  ```

- We can of course create an article object and pre-populate it with fields

  - Now we have a pre-populated article we can then manipulate and save

  ```rb
  article = Article.new(title:"Article 3", description: "Article 3 Description")
  article.title = "Cool Article 3"
  article.save
  ```

- To READ an article given specific parameters like th `id` we use the `.find` attribute

  - Also `Article.first` or `Article.last`

  ```rb
  Article.find(2)
  #  =>
  #  <Article:0x0
  #  id: 2,
  #  title: "Article 2",
  #  description: "Description of second article",
  #  created_at: Sat, 29 Apr 2023 03:09:36.851517000 UTC +00:00,
  #  updated_at: Sat, 29 Apr 2023 03:09:36.851517000 UTC +00:00>
  #  irb(main):003:0>
  ```

- To UPDATE an article first you will need to grab it and assign it to a variable, update what you want on the variable and lastly call `.save`

  ```rb
  article Article.find(2)
  article.description = "New Article 2 Description"
  article.save
  ```

  - There is all the Update All option to update all the elements in a given table

    ```rb
    Article.update_all(user_id: User.first.id)
    ```

- To DELETE an article we simply get the article and call `.destroy` on it

  ```rb
  article = Article.last
  article.destroy
  ```

  To reload the console `reload!`
  To leave the Rails Console just type `exit`

- To TOGGLE a value and hit the database simply call `model.toggle!(:boolean_variable)`

**_Because we did not define any restriction in the article model we can define an article as what ever we want even an empty one and it can still be saved to the database this is not a behavior one usually wants_**

#### Defining Restrictions

```rb
class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end
```

[More on Validations](https://guides.rubyonrails.org/active_record_validations.html)

### More on Routes

```rb
Rails.application.routes.draw do
  root 'pages#index'
  get 'about', to: 'pages#about'
  resources :articles, only: [:show, :index]
end
```

- We can define a `root` route `root '<controller>:<action>'`
- We can define a `get` route `get '<route_name>', to: '<controller>#<action>'`
- I assume we can define a `post` route but more on that later
- `recourses`, these come from the database?

  - we specify a `controller` giving us access to all that controllers actions
    - if the controller is connected to a model in the database we get all the extra default routes
    - We can refine the routes with the `only` parameter which takes an array of ?symbols? for the action we actually want available

  ```rb
  resources :<controller>, only: [:<action1>, :<action2>]
  ```

  ```rb
  resources :articles, only: %i[show index new create edit update destroy]
  # %i = Non-interpolated Array of symbols, separated by whitespace
  ```

  **Note** using `%i[show index new create edit update destroy]` would be the same in this case as removing the only all together which would then include all the restful routes for the `:article`

## Adding Authentication

[Devise](https://rubygems.org/gems/devise)

### How to do it WITHOUT Devise

[Rails Secure Password Docs](https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)

- First uncomment bcrypt in your Gemfile and fun `bundle install`
- Access your user model and add `has_secure_password`
- Add the password digest field to the user table with a migration

  ```rb
  class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
      def change
        add_column :users, :password_digest, :string
      end
    end
  ```

  There is actually a lot to this **make notes later**

## DRY Ruby Practices

a.k.a. _Don't Repeat Yourself_

## ByBug now Ruby Debugger

We can put `bybug` anywhere in the application and it will stop the code and open a debugger console.
We can use the Ruby Debugger as of Ruby 7 and onward `binding.break`

Once we enter the debugger terminal we can perform a number of action

- `params` to review the parameters
- `continue` to continue the code

### Simple Validation and Flash

In our Controller we can add an if else to the create method that will help validate if the article is saved correctly

To let us know that we succeeded we can add a `flash`
There are two different flavors of flash that are usually used, `:notice` and `:alert`

- `:notice` Confirmation message
- `:alert` Error message

But it doesn't _really_ matter

```ruby
class ArticlesController < ApplicationController
  #....
  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      # redirect_to article_path(@article)
      flash[:notice] = 'Article was created successfully' # There are two types a flashs typically :notice, and "alert"
      redirect_to @article
    else
      puts @article.errors.full_messages
      render 'new'
    end
  end
end
```

In order to display the error message we then modify the page that is being rendered after we get the error i.e. 'new'

```html.erb
<% if @article.errors.any? %>
<h2>The following errors prevented the article from being saved</h2>
<ul>
  <% @article.errors.full_messages.each do |msg| %>
    <li><%= msg %></li>
  <% end %>
</ul>
<% end %>
```

Now we are going to display the `Flash` to indicate that the article was created successfully on the article page that is displayed upon creation

```html.erb
<% flash.each do |name, msg| %>
  <%= msg %>
<% end %>
```

## Testing

[Docs](https://guides.rubyonrails.org/testing.html)

To set up a test go to your `test` folder there you will find different folders for all the things you might test channels, controllers, helpers, etc...

Create a file called `<something>_test` this is where we will define our test classes. All test classes inherit from `ActiveSupport:TestCase`

```rb
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
end
```

When you're ready to run test in your terminal run `rails test` this will run all the tests in your application



## Rails Magic

### \<model>\_path

What is this magic

### Scaffold Generator

`rails generate scaffold <Name> <parameter>:<type>`

```cmd
rails generate scaffold Article title:string description:text
```

This will make changes for the database to run the changes run `rails db:migrate` in the terminal

We can check out new routes with `rails routes` or `rails routes --expanded`

### Test Unit Scaffold

`rails generate test_unit:scaffold category`

This creates all the basic tests needed to test a controllers routes

`rails generate integration_test create_category`

### Migration Generator

This is how we generate migrations which in turn generate models

`rails generate migration <migration_name>`

This will make changes for the database to run the changes run `rails db:migrate` in the terminal

### Controller Generator

`rails generate controller <name_of_controller>`

### Session

in the controller we can apparently;y use the session keyword to generate cookies?

```rb
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged In'
      redirect_to user
    else
      # Because we are not redirecting we need to use flash.now
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy; end
end
```

### Helper Method Tag

We can specify a method in our controller as a helper method giving our views access to it.
`helper_method :current_user`

## Notes on Ruby

- Define a constant with shout case `THIS_IS_A_CONSTANT`

## Will_Paginate Gem

[will_paginate github](https://github.com/mislav/will_paginate)

Add `gem 'will_paginate', '~> 3.3'` to the `gemfile`
