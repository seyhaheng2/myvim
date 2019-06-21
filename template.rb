require "fileutils"
require "shellwords"

def create_file
  # Remove Application CSS
  run "mkdir app/views/devise"
  run "mkdir app/views/devise/registrations"
  run "mkdir app/views/devise/sessions"
  run "mkdir app/views/devise/passwords"
  run "rm app/assets/stylesheets/application.css"
  run "touch app/assets/stylesheets/application.scss"
  run "rm app/assets/javascripts/application.js"
  run "touch app/assets/javascripts/application.coffee"
  run "rm app/views/layouts/application.html.erb"
  run "touch app/views/layouts/application.html.haml"
  run "touch app/views/layouts/application.html.haml"
  run "touch app/views/layouts/_navigation.html.haml"
  run "touch app/views/layouts/_message.html.erb"
  run "touch config/initializers/gravatar.rb"
  run "touch app/views/devise/passwords/new.haml"
  insert_into_file(
    "app/views/devise/passwords/new.haml",
    ".flex.center
  = simple_form_for(resource, as: resource_name, url: password_path(resource_name), html: {class: 'join-login-container', method: :post }) do |f|
    = f.error_notification
    .join-login_header_title
      %span Forgot your password?
    .form-inputs
      = f.input :email, required: true, autofocus: true
    .form-actions
      = f.button :submit, 'Send password reset email', class: 'btn--block btn--style'
    .create-account
      = link_to 'Log in to', new_session_path(resource_name)
      %span{style: 'color: #0089C7;'} or
      = link_to 'Create a new Account', new_registration_path(resource_name)", after: ""
  )

  run "touch app/views/devise/registrations/new.html.haml"
insert_into_file(
  "app/views/devise/registrations/new.html.haml",
  ".flex.center
  = simple_form_for(resource, as: resource_name, url: registration_path(resource_name), html: {class: 'join-login-container'}) do |f|
    = f.error_notification
    .join-login_header_title
      %span Create account with
    .form-inputs
      = f.input :email, required: true, autofocus: true
      = f.input :password, required: true
      = f.input :password_confirmation, required: true
      %br
    .form-actions
      = f.button :submit, 'Sign up', class: 'btn--block btn--style'

    .join-login_social-divider
      .join-login_social-divider_text
        OR CONNECT WITH

    .create-account
      = link_to 'Log in to', new_session_path(resource_name)
", after: ""
)
run "touch app/views/devise/sessions/new.html.haml"
insert_into_file(
  "app/views/devise/sessions/new.html.haml",
  ".flex.center
  = simple_form_for(resource, as: resource_name, url: session_path(resource_name), html: {class: 'join-login-container'}) do |f|
    .join-login_header_title
      %span Log in to
    .form-inputs
      = f.input :email, required: false, autofocus: true
      = f.input :password, required: false
      .join-login_reset-password-link.join-login_underlined-link
        = link_to 'Forgot your password?', new_password_path(resource_name)
      -# = f.input :remember_me, as: :boolean, class: 'flex' if devise_mapping.rememberable?
    .form-actions
      = f.button :submit, 'Log in', class: 'btn--block btn--style'
    .join-login_social-divider
      .join-login_social-divider_text
        OR CONNECT WITH

    .create-account
      = link_to 'Create account with US', new_registration_path(resource_name)", after: ""
)

  run "touch config/initializers/simple_form.rb"
  insert_into_file(
  "config/initializers/simple_form.rb",
    "SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :default, class: :input,
    hint_class: :field_with_hint, error_class: :field_with_errors, valid_class: :field_without_errors do |b|
    ## Extensions enabled by default
    # Any of these extensions can be disabled for a
    # given input by passing: `f.input EXTENSION_NAME => false`.
    # You can make any of these extensions optional by
    # renaming `b.use` to `b.optional`.

    # Determines whether to use HTML5 (:email, :url, ...)
    # and required attributes
    b.use :html5

    # Calculates placeholders automatically from I18n
    # You can also pass a string as f.input placeholder: 'Placeholder'
    b.use :placeholder

    ## Optional extensions
    # They are disabled unless you pass `f.input EXTENSION_NAME => true`
    # to the input. If so, they will retrieve the values from the model
    # if any exists. If you want to enable any of those
    # extensions by default, you can change `b.optional` to `b.use`.

    # Calculates maxlength from length validations for string inputs
    # and/or database column lengths
    b.optional :maxlength

    # Calculate minlength from length validations for string inputs
    b.optional :minlength

    # Calculates pattern from format validations for string inputs
    b.optional :pattern

    # Calculates min and max from length validations for numeric inputs
    b.optional :min_max

    # Calculates readonly automatically from readonly attributes
    b.optional :readonly

    ## Inputs
    # b.use :input, class: 'input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }

    ## full_messages_for
    # If you want to display the full error message for the attribute, you can
    # use the component :full_error, like:
    #
    # b.use :full_error, wrap_with: { tag: :span, class: :error }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn--primary'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  # config.error_method = :first

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  # ID to add for error notification helper.
  # config.error_notification_id = nil

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span.
  # config.item_wrapper_tag = :span

  # You can define a class to use in all item wrappers. Defaulting to none.
  # config.item_wrapper_class = nil

  # How the label text should be generated altogether with the required text.

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the default class to be used on forms. Can be overriden
  # with `html: { :class }`. Defaulting to none.
  # config.default_form_class = nil

  # You can define which elements should obtain additional classes
  # config.generate_additional_classes_for = [:wrapper, :label, :input]

  # Whether attributes are required by default (or not). Default is true.
  # config.required_by_default = true

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :mounted_as, :file?, :public_filename, :attached? ]

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = { string: :prepend }

  # Namespaces where SimpleForm should look for custom input classes that
  # override default inputs.
  # config.custom_inputs_namespaces << 'CustomInputs'

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # When false, do not use translations for labels.
  # config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache SimpleForm inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for inputs
  config.input_class = 'input-text'

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  # config.include_default_input_wrapper_class = true

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'

  # Defines validation classes to the input_field. By default it's nil.
  # config.input_field_valid_class = 'is-valid'
  # config.input_field_error_class = 'is-invalid'
end
",after: ""
  )
  run "mkdir app/assets/fonts"
  run "mkdir vendor/assets"
  run "mkdir app/assets/stylesheets/global"
  run "mkdir app/assets/javascripts/global"
  run "mkdir app/assets/stylesheets/home"
  run "mkdir app/views/home"
  run "mkdir vendor/assets/stylesheets"
  run "mkdir vendor/assets/javascripts"
  run "mkdir vendor/assets/images"

  run "touch app/assets/javascripts/namespace.coffee"
  run "touch app/assets/javascripts/common.coffee"
  run "touch app/assets/javascripts/util.coffee"
  run "touch app/assets/javascripts/initializer.coffee"
  run "touch app/assets/stylesheets/global/font.scss"
  run "touch app/assets/stylesheets/home/index.scss"
  run "touch app/assets/stylesheets/global/header.scss"
  run "touch app/assets/stylesheets/global/form.scss"
  insert_into_file(
    "app/assets/stylesheets/global/form.scss",
    "abbr{
  display: none;
}
.error_notification{
  color: #BD0015;
  text-align: center;
}
span.error{
  color: #BD0015;
  float: right;
}
.join-login-container {
  font-family: 'Open Sans', Arial, sans-serif;
  font-size: 14px;
  font-weight: regular;
  line-height: 21px;
  width: 400px;
  padding: 48px 38px;
  overflow: auto;
  box-sizing: border-box;
  background-color: #ffffff;
  text-align: left;
}
.join-login_header_title{
  position: relative;
  left: 50%;
  margin-left: -108px;
  width: 216px;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: white;
  text-align: center;
  text-transform: uppercase;
  font-weight: 600;
  color: #999999;
  margin-bottom: 20px;
}
.input .optional{
  margin-bottom: 10px;
}
.input.email{
  margin-bottom: 10px;
}
.input.password{
  margin-bottom: 10px;
}
.input label{
  box-sizing: border-box;
  margin-bottom: 10px;
  font-size: 17px;
  font-weight: 600;
  display: block;
  color: #4a4a4a;
  font-size: 14px;
  font-family: 'Open Sans', Arial, sans-serif;
  line-height: 21px;
}
input.input-text{
  background: #fff;
  display: inline-block;
  box-sizing: border-box;
  height: 40px;
  padding-left: 14px;
  padding-right: 14px;
  font-size: 14px;
  color: #4a4a4a;
  border: 1px solid #e7e7e7;
  overflow: hidden;
  white-space: nowrap;
  -webkit-border-radius: 4px;
  -moz-border-radius: 4px;
  border-radius: 4px;
  outline: 0;
  width: 100%;
}
input.input-text:focus{
  border-color: #4482FF;
  outline: 0;
  -webkit-box-shadow: 0 0 0 2px rgba(136, 138, 140, 0.32);
  box-shadow: 0 0 0 2px rgba(136, 138, 140, 0.32);
}
.join-login_reset-password-link.join-login_underlined-link {
  display: inline-block;
  margin-bottom: 16px;
  font-weight: 400;
  a{
    display: inline-block;
    padding-bottom: 1px;
    border-bottom: 1px solid #cecece;
    font-weight: 500;
    color: #333333;
    text-decoration: none;
  }
}
.btn--style {
  display: inline-block;
  vertical-align: baseline;
  box-sizing: border-box;
  padding-right: 20px;
  padding-left: 20px;
  min-width: 60px;
  border: 1px solid #cecece;
  -webkit-border-radius: 4px;
  -moz-border-radius: 4px;
  border-radius: 4px;
  background-color: #e7e7e7;
  font-family: 'Open Sans', Arial, sans-serif;
  font-size: 17px;
  color: #4a4a4a;
  line-height: 38px;
  text-align: center;
  text-decoration: none;
  transition: background .2s linear;
  cursor: pointer;
}
.btn--primary {
  border: none;
  background-color: #2186ca;
  line-height: 40px;
  color: #ffffff;
}
.btn--block{
  display: block;
  width: 100%;
}
.join-login_social-divider{
  height: 10px;
    margin-top: 10px;
    margin-bottom: 20px;
    border-bottom: 2px solid #cecece;
}
.join-login_social-divider_text{
  position: relative;
  left: 50%;
  margin-left: -108px;
  width: 216px;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: white;
  text-align: center;
  text-transform: uppercase;
  font-weight: 600;
  color: #999999;
}
.create-account{
  margin-top: 24px;
  text-align: center;
  a{
    display: inline-block;
    padding-bottom: 1px;
    border-bottom: 1px solid #cecece;
    font-weight: 600;
    color: #333333;
    text-decoration: none;
  }
}",
    after: ""
    )
  insert_into_file(
    "app/assets/stylesheets/global/header.scss",
".global-search-form .search-input::-webkit-input-placeholder,
.global-search-form .search-input::-moz-placeholder,
.global-search-form .search-input:-ms-input-placeholder {
  color: #edf0f1;
}
.global-search-form .search-input:focus::-webkit-input-placeholder,
.global-search-form .search-input:focus::-moz-placeholder,
.global-search-form .search-input:focus:-ms-input-placeholder {
  color: #58585A;
}
.global-search-form .search-input::-ms-clear {
  display: none;
}

.site-navigation {
  box-sizing: border-box;
  z-index: 1010;
  font-family: Roboto, Arial, sans-serif;
  font-size: 14px;
  color: #4a4a4a;
  .global-nav {
    height: 60px;
    z-index: 1010;
    background-color: #323436;
    min-width: 1090px;
    .nav-fluid-container {
      width: 100%;
      height: 100%;
      margin: 0;
      padding: 0 35px 0 24px;
      box-sizing: border-box;
      .nav-brand{
        width: 160px;
        margin-right: auto;
        line-height: 0;
      }
      .nav-wrapper{
        .nav-control{
          -webkit-padding-start: 45px;
          li.global-nav-menu{
            list-style-type: none;
            margin-right: 40px;
            a{
              color: #BABCBD;
              font-weight: 500;
              text-decoration: none;
            }
            .nav-link{
              position: relative;
              max-width: 200px;
              padding: 20px 0;
              overflow: hidden;
              white-space: nowrap;
              text-overflow: ellipsis;
              font-size: 16px;
              line-height: 20px;
              white-space: nowrap;
            }
            &:hover{
              padding-bottom: 8px;
              margin-bottom: -9px;
              border-bottom: 2px solid #ffffff;
              .nav-link{
                color: #fff;
                font-weight: 500;
              }
            }
          }
          li.global-nav-menu:last-of-type{
            margin-right: 0;
          }
          li.global-nav-menu.is-active a{
            color: #fff;
            font-weight: 600;
            &:hover{
              color: #fff;
              font-weight: 600;
            }
          }
        }
      }
      .search-menu{
        min-width: 405px;
        max-width: 420px;
        .search-menu-control{
          width: 100%;
          .global-search-form {
            width: 100%;
            .nav-search-icon {
              display: inline-block;
              height: 16px;
              width: 16px;
              margin-left: 20px;
            }
            .icon-search {
              position: absolute;
            }
            .icon-search:after {
              display: block;
              width: 100%;
              height: 100%;
              content: url(search-menu.svg);
            }
            .search-input {
              -webkit-border-radius: 2px;
              -moz-border-radius: 2px;
              border-radius: 2px;
              width: 100%;
              height: 30px;
              border: none;
              padding: 5px 28px 5px 50px;
              color: #EDF0F1;
              background-color: #434648;
              outline: none;
              font-weight: 500;
              &:focus{
                background-color: #fff;
                color: #434648;
              }
            }
          }
          .is-focused{
            .icon-search {
              position: absolute;
            }
            .icon-search:after {
              display: block;
              width: 100%;
              height: 100%;
              content: url(search.svg);
            }
          }

        }
      }
      ul.global-nav-login{
        li.global-nav-button{
          a{
            text-decoration: none;
          }
          .nav-link-login{
            border-left: 1px solid #58585A;
            padding: 11px 20px;
            font-size: 16px;
            line-height: 18px;
            &:hover:after{
              position: relative;
              top: 8px;
              content: '';
              display: block;
              margin-bottom: -2px;
              border-bottom: 2px solid #ffffff;
            }
          }
          .nav-link-join{
            width: 60px;
            height: 32px;
            border-radius: 2px;
            background-color: #FF7F32;
            &:hover{
              background-color: #e5722d;
            }
          }
          a{
            color: #fff;
            box-sizing: border-box;
            font-weight: 500;
          }
        }
      }
      ul.global-nav-mobile{
        display: none;
        li.nav-mobile{
          list-style-type: none;
          display: inline-block;
          a{
            padding: 18px 29px;
            font-size: 16px;
            line-height: 18px;
          }
          .mobile-menu-hambuger{
            padding-right: 0px;
            padding-left: 0px;
          }
        }
      }
    }
  }
}

@media only screen and (max-width: 1300px) {
  .site-navigation .global-nav {
    min-width: 100%;
    .nav-fluid-container .search-menu {
      min-width: 235px;
    }
  }
}
@media only screen and (max-width: 1200px) {
  .site-navigation .global-nav .nav-fluid-container {
    .nav-wrapper .nav-control {
      -webkit-padding-start: 0px;
      li.global-nav-menu {
        margin-right: 25px;
      }
    }
    .search-menu {
      min-width: 145px;
      margin-right: 30px;
      margin-left: 30px;
    }
  }
}
@media only screen and (max-width: 1100px) {
  .site-navigation .global-nav {
    width: 100%;
    .nav-fluid-container .nav-wrapper .nav-control li.global-nav-menu {
      margin-right: 42px;
    }
  }
}
@media only screen and (max-width: 1000px) {
  .search-menu{
    display: none;
  }
}
@media only screen and (max-width: 960px) {
  .search-menu-open .nav-brand{
    display: none;
  }
  .search-menu{
    display: block;
  }
  .site-navigation .global-nav .nav-fluid-container {
    .search-menu {
      position: absolute;
      right: -1192px;
      .search-menu-control .global-search-form .nav-search-icon{
        display: none;
      }
    }
    .is-active {
      position: absolute;
      right: 90px;
      .search-menu-control{
        .global-search-form {
          width: 100%;
          .nav-search-icon{
            display: block;
          }
        }
      }
    }
  }

  .site-navigation .global-nav .nav-fluid-container .is-active .global-search-mobile:after {
    content: url(close.svg);
    position: absolute;
    right: -68px;
    top: 22px;
    cursor: pointer;
  }
  .nav-wrapper{
    display: none;
  }
  .global-nav-login{
    display: none;
  }
  .site-navigation .global-nav .nav-fluid-container ul.global-nav-mobile {
    display: block;
    position: absolute;
    right: 28px;
    top: 8px;
  }
  .search-menu-open .site-navigation .global-nav .nav-fluid-container {
    ul.global-nav-mobile {
      display: none;
    }
  }
  .search-menu {
    flex-basis: 100%;
    min-width: 0;
    max-width: 100%;
    margin: 0 0 10px;
    padding: 0;
    .search-menu-control{
      margin: 10px 35px;
      .global-search-form {
        right: 0;
        left: 100%;
        overflow: hidden;
        transition: width 0.25s, left 0.25s, opacity 0.25s;
      }
    }
  }
  .site-navigation .global-nav .nav-fluid-container {
    .search-menu {
      min-width: 90%;
      margin-right: 0px;
      margin-left: 0px;
    }
  }
  .site-navigation .global-nav .nav-fluid-container {
    .search-menu .search-menu-control .global-search-form {
      width: 0;
    }
    .is-active .search-menu-control .global-search-form {
    width: 100%;
    }
  }
}

@media only screen and (max-width: 768px) {
  .site-navigation .global-nav .nav-fluid-container .search-menu {
    min-width: 90%;
  }
  .search-menu-control {
    margin: 10px 0px 0px 28px;
  }
}
@media only screen and (max-width: 600px) {
  .site-navigation .global-nav .nav-fluid-container .search-menu {
    min-width: 85%;
  }
}
@media only screen and (max-width: 500px) {
  .site-navigation .global-nav .nav-fluid-container .search-menu {
    min-width: 80%;
  }
}",after: ""
  )

  run "touch app/views/home/index.html.haml"
  run "touch app/controllers/home_controller.rb"
  insert_into_file(
    "app/controllers/home_controller.rb",
    "class HomeController < ApplicationController
  def index
  end
end",
    after: ""
  )

    insert_into_file(
    "config/initializers/gravatar.rb",
    "GravatarImageTag.configure do |config|
  config.default_image = 'mm'
  config.secure        = true
end",
    after: ""
  )

    insert_into_file(
    "app/controllers/application_controller.rb",
    "\n\n\tbefore_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_meta_tags, if: -> {request.get?}

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      edit_user_registration_path
    else
      root_path
    end
  end

  def prepare_meta_tags(options={})
    site_name   = 'www.google.com'
    description = ''
    image       = options[:image] || 'your-default-image-url'
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       description,
      image:       image,
      description: description,
      keywords:    %w[bootstrap3 navbar bootstrap4 bootstrap template form free theme html],
      twitter: {
        url: current_url,
        site_name: site_name,
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end",
    after: "class ApplicationController < ActionController::Base"
  )

  run "touch app/assets/stylesheets/global/body.scss"
  run "touch app/assets/stylesheets/global/flex.scss"
  insert_into_file(
    "app/assets/stylesheets/home/index.scss",
    "body[id='home_index']{}",after: ""
  )
  insert_into_file(
    "app/assets/stylesheets/global/flex.scss",
    ".flex {
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;

	&.start {
		-webkit-box-pack: start;
		-webkit-justify-content: flex-start;
		-ms-flex-pack: start;
		justify-content: flex-start;
	}

	&.center {
		-webkit-box-pack: center;
		-webkit-justify-content: center;
		-ms-flex-pack: center;
		justify-content: center;
	}

	&.end {
		-webkit-box-pack: end;
		-webkit-justify-content: flex-end;
		-ms-flex-pack: end;
		justify-content: flex-end;
	}

	&.around {
		-webkit-justify-content: space-around;
		-ms-flex-pack: distribute;
		justify-content: space-around;
	}

	&.between {
		-webkit-box-pack: justify;
		-webkit-justify-content: space-between;
		-ms-flex-pack: justify;
		justify-content: space-between;
	}

	&.top {
		-webkit-box-align: start;
		-webkit-align-items: flex-start;
		-ms-flex-align: start;
		align-items: flex-start;
	}

	&.middle {
		-webkit-box-align: center;
		-webkit-align-items: center;
		-ms-flex-align: center;
		align-items: center;
	}

	&.bottom {
		-webkit-box-align: end;
		-webkit-align-items: flex-end;
		-ms-flex-align: end;
		align-items: flex-end;
	}

	&.stretch {
		-webkit-box-align: stretch;
		-webkit-align-items: stretch;
		-ms-flex-align: stretch;
		align-items: stretch;
	}

	&.baseline {
		-webkit-box-align: baseline;
		-webkit-align-items: baseline;
		-ms-flex-align: baseline;
		align-items: baseline;
	}

	&.flex0 {
		-webkit-box-flex: 0;
		-webkit-flex: 0 auto;
		-ms-flex: 0 auto;
		flex: 0 auto;
	}

	&.full {
		-webkit-box-flex: 1;
		-webkit-flex: 1;
		-ms-flex: 1;
		flex: 1;
	}

}

.vertical {
	-webkit-box-orient: vertical;
	-webkit-box-direction: normal;
	-webkit-flex-direction: column;
	-ms-flex-direction: column;
	flex-direction: column;
}

.horizontal {
	-webkit-box-orient: horizontal;
	-webkit-box-direction: normal;
	-webkit-flex-direction: row;
	-ms-flex-direction: row;
	flex-direction: row;
}

.v-reverse {
	-webkit-box-orient: vertical;
	-webkit-box-direction: reverse;
	-webkit-flex-direction: column-reverse;
	-ms-flex-direction: column-reverse;
	flex-direction: column-reverse;
}

.h-reverse {
	-webkit-box-orient: horizontal;
	-webkit-box-direction: reverse;
	-webkit-flex-direction: row-reverse;
	-ms-flex-direction: row-reverse;
	flex-direction: row-reverse;
}

.left {
	float: left;
}

.right {
	float: right;
}", after: ""
  )
  insert_into_file(
    "app/assets/stylesheets/global/body.scss",
    "html {
  font-family: sans-serif;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%
}

body {
  margin: 0
}

article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
main,
menu,
nav,
section,
summary {
  display: block
}

audio,
canvas,
progress,
video {
  display: inline-block;
  vertical-align: baseline
}

audio:not([controls]) {
  display: none;
  height: 0
}

[hidden],
template {
  display: none
}

a {
  background-color: transparent
}

a:active,
a:hover {
  outline: 0
}

abbr[title] {
  border-bottom: 1px dotted
}

b,
strong {
  font-weight: 700
}

h1 {
  font-size: 2em;
  margin: .67em 0
}

mark {
  background: #ff0;
  color: #000
}

small {
  font-size: 80%
}

sub,
sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
  vertical-align: baseline
}

img {
  border: 0
}

svg:not(:root) {
  overflow: hidden
}

figure {
  margin: 1em 40px
}

hr {
  -webkit-box-sizing: content-box;
  box-sizing: content-box;
  height: 0
}

pre {
  overflow: auto
}

code,
kbd,
pre,
samp {
  font-family: monospace, monospace;
  font-size: 1em
}

button,
input,
optgroup,
select,
textarea {
  color: inherit;
  font: inherit;
  margin: 0
}

button {
  overflow: visible
}

button,
select {
  text-transform: none
}

button,
html input[type=button],
input[type=reset],
input[type=submit] {
  -webkit-appearance: button;
  cursor: pointer
}

button[disabled],
html input[disabled] {
  cursor: default
}

button::-moz-focus-inner,
input::-moz-focus-inner {
  border: 0;
  padding: 0
}

input {
  line-height: normal
}

input[type=checkbox],
input[type=radio] {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  padding: 0
}

input[type=number]::-webkit-inner-spin-button,
input[type=number]::-webkit-outer-spin-button {
  height: auto
}

input[type=search] {
  -webkit-appearance: none;
  -webkit-box-sizing: content-box;
  box-sizing: content-box
}

input[type=search]::-webkit-search-cancel-button,
input[type=search]::-webkit-search-decoration {
  -webkit-appearance: none
}

fieldset {
  border: none;
  margin: 0;
  padding: 0
}

legend {
  border: 0;
  padding: 0
}

textarea {
  overflow: auto
}

optgroup {
  font-weight: 700
}

table {
  border-collapse: collapse;
  border-spacing: 0
}

td,
th {
  padding: 0
}

:root {
  --x-height-multiplier: 0;
  --baseline-multiplier: 0
}


@font-face {
  font-family: Cambria;
  src: local('Arial'), local('Helvetica');
  unicode-range: U+2500-259F
}

@-ms-viewport {
  width: device-width
}

body {
  font-family: medium-content-sans-serif-font, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  letter-spacing: 0;
  font-weight: 400;
  font-style: normal;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  -moz-font-feature-settings: 'liga' on;
  color: rgba(0, 0, 0, .84);
  line-height: 1.4
}", after: "")
  run "touch app/assets/stylesheets/home/index.scss"

end

def add_gems
  gem 'devise', '~> 4.4.3'
  gem 'devise_masquerade', '~> 0.6.0'
  gem 'font-awesome-sass', '~> 4.7'
  gem 'gravatar_image_tag', github: 'mdeering/gravatar_image_tag'
  gem 'jquery-rails', '~> 4.3.1'
  gem 'foreman', '~> 0.84.0'
  gem 'omniauth-facebook', '~> 4.0'
  gem 'omniauth-twitter', '~> 1.4'
  gem 'omniauth-github', '~> 1.3'
  gem 'carrierwave', '~> 1.2.2'

  "group :development do
    gem 'capistrano', '~> 3.9', '>= 3.9.1'
    gem 'capistrano-rails', '~> 1.2'
    gem 'capistrano-passenger', '~> 0.2.0'
    gem 'capistrano-rbenv', '~> 2.1'
    gem 'capistrano-rails-collection'
    gem 'capistrano-rails-logs-tail'
    gem 'pry'
  end"

  gem 'friendly_id', '~>5.2.3'
  gem 'impressionist', '~> 1.6.0'
  gem 'active_link_to', '~> 1.0.5'
  gem 'toastr-rails', '~> 1.0.3'
  # gem 'activeadmin'
  # gem 'active_skin'
  # gem "active_admin-sortable_tree"
  # gem 'activeadmin_addons'
  gem 'better_errors', '~> 2.4.0'
  gem 'acts-as-taggable-on', '~> 5.0'
  gem 'ckeditor', '~> 4.2.4'
  gem 'kaminari', '~> 1.1.1'
  gem 'sitemap_generator', '~> 6.0.1'
  gem 'meta-tags', '~> 2.9.0'
  gem 'pg_search', '~> 2.1.2'
  gem 'mini_magick', '~> 4.8.0'
  gem 'pundit', '~> 1.1.0'
  gem 'faker', '~> 1.8.7'
  gem 'jquery-rails', '~> 4.3.1'
  gem 'haml-rails', '~> 1.0.0'
  gem 'simple_form', '~> 4.0.0'
end

def add_assets

  insert_into_file(
    "app/views/layouts/application.html.haml",
    "!!!
%html
  %head
    = display_meta_tags
    %meta{:name => 'viewport', :content => 'width=device-width, initial-scale=1.0'}
    = csrf_meta_tags
    = stylesheet_link_tag    'application'
    = javascript_include_tag 'application'
  #{%q(%body{ id: "#{controller_name}_#{params[:action]}" })}
    = render 'layouts/navigation'
    = render 'layouts/message'
    = yield",
    after: ""
  )
  insert_into_file(
    "app/views/layouts/_navigation.html.haml",
    "%header.site-navigation
  %nav.global-nav.flex.middle
    .flex.nav-fluid-container.between
      = link_to root_path, class: 'flex nav-brand' do
        = image_tag 'logo.svg'
      .search-menu.flex.middle
        .search-menu-control
          %i.global-search-mobile
          %form.global-search-form.flex.middle
            %span.icon-search.nav-search-icon
            %input.search-input{type: 'text', placeholder: 'Find answers, products, resources' }
      .nav-wrapper.flex.middle
        %ul.nav-control.flex
          %li.global-nav-menu.is-active
            = link_to 'Community', root_path, class: 'nav-link'
          %li.global-nav-menu
            = link_to 'Tools & Apps', root_path, class: 'nav-link'
          %li.global-nav-menu
            = link_to 'Learn', root_path, class: 'nav-link'
          %li.global-nav-menu
            = link_to 'Product Reviews', root_path, class: 'nav-link'
      %ul.global-nav-login.flex.middle
        %li.global-nav-button.flex.middle
          - if current_user
            = link_to 'Log out', destroy_user_session_path, method: :delete, class: 'nav-link-login'
          - else
            = link_to 'Log in', new_user_session_path, class: 'nav-link-login'
            = link_to 'Join', new_user_registration_path, class: 'nav-link-join flex middle center'
      %ul.global-nav-mobile.flex.middle
        %li.nav-mobile.flex.middle
          = link_to '#', class: 'mobile-menu-search' do
            = image_tag 'search-menu.svg'
          = link_to '#', class: 'mobile-menu-hambuger' do
            = image_tag 'hambuger.svg'",
    after: "")
  insert_into_file(
    "app/views/layouts/_message.html.erb",
    "<% unless flash.empty? %>
  <script type='text/javascript'>
    <% flash.each do |f| %>
    <% type = f[0].to_s.gsub('alert', 'error').gsub('notice','info') %>
    toastr['<%= type %>']('<%=f[1]%>')
    <% end %>
  </script>
  <% end %>",
    after: ""
  )

  insert_into_file(
    "app/assets/javascripts/application.coffee",
    "#= require activestorage\n#= require rails-ujs\n#= require jquery\n#= require jquery_ujs\n#= require toastr\n\n#= require namespace\n#= require common\n#= require util\n#= require initializer\n
toastr.options =
  'positionClass': 'toast-bottom-right'
    ",
    after: ""
  )
  insert_into_file(
    "app/assets/javascripts/common.coffee",
    "RailsApp.Common =
  init: ->
    @_initImageUploader()
    @_onFocus()
    @_onSearchBox()

  _initImageUploader: ->
    $.each $('.fl-wrap'), (index, uploader)->
      uploader = $(uploader)
      #{%q(input = uploader.find("input[type='file']"))}
      imageHolder = uploader.find('img')

      input.on 'change', (e)->
        reader = new FileReader
        reader.onload = (e)->
          imageHolder.attr('src', e.target.result)

        file = @files[0]
        reader.readAsDataURL file

      imageHolder.click ->
        input.click()

  _onFocus: ->
    $('.search-input').on 'focus blur', ->
      $(this).parent().toggleClass 'is-focused'

  _onSearchBox: ->
    $('.mobile-menu-search').click ->
      $('.search-menu-control').parent().addClass('is-active')
      $('body').addClass('search-menu-open')
    $('body').on 'click', '.global-search-mobile', ->
      if $('body').hasClass('search-menu-open')
        $('.search-menu').removeClass 'is-active'
        $('body').removeClass 'search-menu-open'",
    after: ""
  )
  insert_into_file(
    "app/assets/javascripts/initializer.coffee",
    "RailsApp.Initializer =
  exec: (pageName) ->
    if pageName && RailsApp[pageName]
      RailsApp[pageName]['init']()

  currentPage: ->
    return '' unless $('body').attr('id')

    bodyIds     = $('body').attr('id').split('_')
    pageName    = ''
    for bodyId in bodyIds
      pageName += RailsApp.Util.capitalize(bodyId)
    pageName

  init: ->
    RailsApp.Initializer.exec('Common')
    if @currentPage()
      RailsApp.Initializer.exec(@currentPage())

$(document).on 'ready page:load', ->
  RailsApp.Initializer.init()",
    after: ""
  )
  insert_into_file(
    "app/assets/javascripts/namespace.coffee",
    "window.RailsApp = {}",
    after: ""
  )
  insert_into_file(
    "app/assets/javascripts/util.coffee",
    "RailsApp.Util =
  capitalize: (value) ->
    value.replace /(^|\s)([a-z])/g, (m, p1, p2) ->
      p1 + p2.toUpperCase()",
    after: ""
  )

  # Add Scss
  insert_into_file(
    "app/assets/stylesheets/application.scss",
    "@import 'font-awesome';\n@import 'toastr';\n\n@import 'https://fonts.googleapis.com/css?family=Roboto:400,500,700&amp;subset=latin,latin-ext';\n@import 'https://fonts.googleapis.com/icon?family=Material+Icons';\n@import url('https://fonts.googleapis.com/css?family=Open+Sans:400,600,600i|Roboto|Angkor|Bayon|Chenla|Dangrek|Fasthand|Freehand|Hanuman|Kdam+Thmor|Koulen|Preahvihear|Taprom');\n\n@import 'home/index.scss';\n@import 'global/*';",
    after: ""
  )
  insert_into_file(
    "app/assets/stylesheets/global/font.scss",
    "/* latin */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 400;
  font-style: italic;
  src: url('charter-400-italic.woff') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* rest */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 400;
  font-style: italic;
  src: url('charter-400-italic.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* rest */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 400;
  font-style: normal;
  src: url('charter-400-normal.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* latin */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 400;
  font-style: normal;
  src: url('data:font/opentype;base64,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') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* latin */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 700;
  font-style: italic;
  src: url('charter-700-italic.woff') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* rest */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 700;
  font-style: italic;
  src: url('charter-700-italic.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* latin */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 700;
  font-style: normal;
  src: url('charter-700-normal.woff') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* rest */

@font-face {
  font-family: 'medium-content-serif-font';
  font-weight: 700;
  font-style: normal;
  src: url('charter-700-normal.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* latin */

@font-face {
  font-family: 'medium-content-slab-serif-font';
  font-weight: 300;
  font-style: italic;
  src: url('marat-sans-300-italic.woff') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* rest */

@font-face {
  font-family: 'medium-content-slab-serif-font';
  font-weight: 300;
  font-style: italic;
  src: url('marat-sans-300-italic.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* rest */

@font-face {
  font-family: 'medium-content-sans-serif-font';
  font-weight: 400;
  font-style: normal;
  src: url('marat-sans-400-normal.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* latin */

@font-face {
  font-family: 'medium-content-sans-serif-font';
  font-weight: 400;
  font-style: normal;
  src: url('data:font/opentype;base64,d09GRgABAAAAACP4AA0AAAAAPkwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHUE9TAAAZrAAACWsAABig3xTXdUdTVUIAACMYAAAA3QAAAX41JDWOT1MvMgAAGLAAAABTAAAAYHhRPVtjbWFwAAAZBAAAAGwAAACSQ/FjK2dhc3AAABmkAAAACAAAAAj//wAEZ2x5ZgAAATAAABTHAAAezBEpcAFoZWFkAAAXAAAAADYAAAA2/JdmmWhoZWEAABiQAAAAHwAAACQHFQLwaG10eAAAFzgAAAFVAAAB3NbYFN1sb2NhAAAWFAAAAOwAAADwwILJDm1heHAAABX4AAAAHAAAACAAhgCZbmFtZQAAGXAAAAAfAAAAIAAjCJtwb3N0AAAZkAAAABMAAAAg/7gAMnjalVkFYNtI1p4nNbYDNcsKNA4osRx0Ytlxgw6T3dhumJMyt1lul3nbg94yXWmZmelf6jIzHy0zc5T/jaQ0bvewu7Jlzcz3+M2nCWGIkxD4AxMkGSSLECkg6IWAEJCUS9Irl15QLhZ/3eEOuavctUl1qc1JrfmV+WG8WpJaUyNJUXdVaij17rvv9m30XYv/8OtuGNu4kbCkZOYauJ+5muQQN/EQEgQH7y8Fv68i4Jc4J/D6UhA5h+QEzq7Tc4Lfle9ziVwdsHacaISS1qSRnshAqKo9omsyFLrnMT3dw4urzoOSYk9R2YcFhWLxmfaJxFey2jqaehPbWua1VfHFhfOeZ7Ka6iKjhlhUv8fptt9n8MGinGLrHfoyQhKIe+YfzM3MOtRuPuHQcpGQAPDAelEHIdflq7B5/T4hl7Mn/ObJmbDJK5/uOKWlqamptbGxqQkeiLtnxp3Te5itl0WH+3eOyH/bfMghm3XxPwiQEniAnMxcjrKJTZT0teYBMzzw/vs4UjMzCR7mUZKMKqJX0EO8EewO8HiWTi5ZWtrf1HS8M/rer+/GnBuv+fYagisSZibJj+oKXqwDdFzACXadz4Nz+0uXLpncpUzd6Iy9++t7aLcT8uB05mSUrcc1JmJTdDBBgNdLYoBP0L4fsPfan8s42Rgxnpwh37kyr/X01ryV8PWZZ1pjDUVFDbFta9NPPDF9LaE6Ex9cAJdTDQJ+wS9hTCVO4PZu3RreutV3fsP5+D+dJ8ycRu4mB1OreZQilK8cW/G67j0c8ZJnwAvpOIIIOZwXyDPhMH0+8z25gRxKknAFDYDkdWAsNmUIeRkZea6k3CpByFwgUGz7zFsQZG5RsG08a3+37R+JzL0Z002EQZSf4SamA/WzKTj+WSBRi+dXo0tWDw9PLh9cs2aD7pzTf7fjzD+evqP1vXfeobqlIbyJaSY6rA2LXgxIlnsvSLqnCt4ebNs8fQ/RZmxn2kgGzvBXBCpUUF6/T5Bep0ePpJ3aEhpbxnTqVi7u7xtuHJxp2bKou3m8W29NSXc0dfaGRpd1hgwdFNE08w0ch4guGlOH5EVIl5Cr99eBeoNxVoARV/kSct3JdtfSqbZgVlasv9w9bK0yLG2O9tZ3RPv+eGpWUhNTU+l1s436YJmQ1+wM+DpqirrMhvrgwEolLt/DzUwLMVLvo/NmAyj4hbujN10YisVCRy2E0xPlk15+ufmUU3CFG/U7AzsGP6cfamXL4QQ9WqwoJCVz7lWbTmoOZkPxR9Y8zx3bt2WjHg3B5Vbwd+zS7R5fS7TY3MJ0YmyyUboGpOPsDlHSgiRoAeM5Ifc7T/U6f2ZGdSChYDiyeH3vwKqbz+eSkj6ura2cSnWUBRZ/XjkWja098rAdD0Iz9SM682QmqMTOloOZxXa9IX8Ah70F33XWTc/QzoTyb8Tc4NHX2BZs/rmgYWPaJ563q1aWMkKuETQ9dXbHWf2ro7GhXk/FmsHBVVUZNVJ5VYY7Z76tqOiQBbUjJYF2KNQVRjt7u0KRIp25TVo81BsrbzvU65Ok7FJHosl/TJk0UjriJwz69Du4CjVJIbmohzegxpy6gvWj7ICgqTLrlY/QEcEyT3X15sRNWy2G/JGOAeqQmy6wQ1aqo7x6UW2lr1Z+tXnDpsqJrtjaLYfveRClhNAnD8KNWFEcSlHQFBtt9EP9GcpNS8/NTU/PWW5OT8/OxgsOTc8VvLm58kPmbF92tg9xarCWX4KTEce4Hw6Lhd0/C5CBFQ4d2to1tNQJkErigB1wG9HTbMvnE7gEfSV0OeSPgHfcNrE7fKzh2C5CJZAt2FWW0D6ldoV8vGpgTL4Ixra0tFzc0nIAGnAJYr4/PwA75JscwMsfOcARh2ef+QUGmSOxWvMQT6zT+33xlWQCfs4FxyaZOXO2iU9KjMZMQf1AZ0d3a1cCa0pNdWY7HNl3bkuan5xmXGDLtHSEFlTXtgdrhoq2XG9ylmVllVFZ0Zkg288chDa0Yx/n4yNnZPCHKBhhX14rqaQX8TYTtDRTA4/3oreiFrRfzCnmgcHb33n/mque5IoXeasCSTpDsFJq7el2lUXcJYYa49l/yswurtu97fTbbrgwdFJBs6NKKs5fXud89a47P3rmsrLBSFlBmVBeW1nbNk9q54S05Sc+lJUxFT39yvsvOO/2Oyp9RiYnd4GTMLTfMjnMYehVC60cySaIgt6G+4LLA4Jel/RezzsDNV/WXtN772I9wDwA5rDpbTfcAJ9/+63NoNMlEIxalBB4j5nCfHaQHNo70VRaVngJLDdrJsupFosuIXrFhBhduvnVdbUDPYsmiiwWfjQqZvQxU9a8ZYPlwsG3g/BOWUNTERgehOLKhQ4zUXcIphijmkpIPh/nVNw7Z31YAe+3pkytPvH0C45+JL3F3NY0sGz5YFPbzWmhwWvPP/OaCzN9/s2HH3FsgMYN7a5FnROJbU5jnSBqKhZB9M5jGw659JrWxpMPHSma6GWmXM0PXrEjdNjxO8t4AorNd+H6ZLo6h8uhbRQ/o7BM/nx6GlKZqc57O18OaTOvVSRpM/E/SxRG5e+BkWWc93in/KlmXz3atwDto3srp9Pr/pmR8NmquzODVT2n7Nx9wpNpzebOlpF1Bw9OrD2l85PCNP6y3WddTe084ojNJxJVOuOc1RPl4yXgZ7Qb3N3d8mvMlPwLJExvB0F+G2f3EkKuwtmsOrsXzZ7eTmDm25kacgm1QWUefhyz65yF5UU9jQ9X+CZiTPr011P75C3AmdgrckBAWYgTqAhILMD1MySluzvlAc65+ldIgUr5UZT+xnupBfIr8p3aWrgO1yZounKoZTJq8GaYjrYi8l4czVLz1JEFFJhmLOv3Yc/UswKL5ebIBLbVteESHYPZyuj2rHFF02CeXn9xw2V6wzxIQ5leqzUlxWGCp9HuO/kiayEne+FZW5G1JFXu1GzwoSQ1M8DBSy5qsQAUnrNEV0FqUvI8XSwkP0m/ETFqynVzcAnivU3vZA9hlHiux3gm070zIZ6LxNU9RE68YMcJJ53352MGVq4eGlq1Junas8+59rKzz7spfNyWI4486vAtxxE1W+EN1Gg+SVWz1Qk0X4VckbPEldX5hYXV3KJvfWZb9mB3SU4HM8Ukp5Qc9BD8wBR9ChWtHbxF3YkHmHNRs3TioprFkxcnK3kDShfzwD9Rs6uo2u10FTs4a6K7tH6yOfEArQfLHQWZqclstam9b84AVf/PFP35uGrTY+jSgOqvqn/xZEnHaOcTK9+1pl1alBNiplJdmzpi8+V3oVW+iyl+Cw5pQAMoJ/keHkf9Bfp+obVRsRRUM+ZKhdd2dXfH/EOqW1piA90HjfWO6FoTFy6U6tu7egcOXnHzWfz6QKmr3JkTDkeGQ42p3iK/q8i/ICvUODRBgGYiPId666nWAu5KguX+u+HJuxmxs3P6dZqVIYxyuporAVoVijr0hhav6Ar1N0RjzYvzq7aeVp33d9guHzUaXjQCJ8lTG8oXLSonqgyGVXxDJDYur9lnnxg4Xw+QAKDf1f8CZlm2I0GnM9jgr7QmiR1bL4PrcvZfF48gsGoX17O7ftc3zrKIxbAn952kA3o3b7L798OnMfQpy2xD/CajYDSmJ8PjcgVnMhozTfAgZvQridbkZGuiXKj542eUmUZrkJV4VVQQJNYmaDuGCRL+7+alRycqiiceteSmB5dv1X6cBo3ged2cpNOlGF+Xn5fv+8SYotMlmz8mgOyfwN8R2USZ9X5u4O5/YuJ3mh+2Dz/7OZwof52CGAYjGOXNH2us/Bmtw/qBkj/I4dIwaR6AK+S7INwOby1qk/O6qLeHZsJgYF6mEeUt2LPxGrpucvIWdmvw1+/r1feLv0GQuVN5v2ADth/+0fZulvp+gZJmwuRRdbUN80HC61Fczbz86+H1bFIQZzhhEE5QMyYD1N3UefLQyb1D+iEcSZU/fPxxnEVmboRXCKEyOKruK5FIhFZmNjKXLfAEWpSP/dP/z7kDZ4nnClCiNzRVV3QODGTV9RZ5E6uNO857sLiDr68oL+zJ8zfU1HckLIzwYvrabfL9tTUVNiY3PyuHMDRzMbevIom0pwTUKkRIlnbsOpjlnhcItSesLO+MRPT6UO2i7oNWrv7gjIx7/jgk/8qcJN9e2DA1dsrxRKnJH+Fc1Nzxz3Znzk735v46Q/ei8RVTw6db6w1lpQcfXFq2LSNQv3nTuqMPyhSzd14ioFYl6IEbUSszyfiNBySL6Eerta1+iV7XtjA6ePBSb0kkUlC6baHfHxxyVR664pBj7N9P972w03ZpKEa9quh2JTxFOOJE7XJ0dHkgTkm0VETfSrSPwC75DWhoLK1IqkkZDC9btWFVT/+N/oaEt0F6vbM7t2BBRe0R69edONHpObcqoEsqlQjQPgTrUGdO7RKS36f0IRqgTKA5NllXd0FptcE/v7wg+5hj4JiGilvzstz5UltRg3wCzYK0mTJ4DZ4kIpFIkHJgVCww29GwI3OC0i8x3lkQ/64i4hOtAbJxhPJUKehpXrlYCJkNm8fsy8PB8slYy9EbJif9fzu4Z2Ftc5/wrs9XWiFJZRUpOkeZxCdH/B0xS3KT4G6Ksaw7V5eSVFkbXNzkdVdajellOe7ivDQeWgslj8fl9Sp9Dz9uR5sd1GYtY7Cp44bvE1XDQ5gyHZUD2Vxkvt3va2aukm8vqK8Rm+W3IdVnz+lr/oDGppEQci1zgfZ2McfLaRruMPN8ppPns8ZiTI0xk1Lu6Vthr1xNmJmvZgq0dRzlJGrPNTJxCHZhPMoVF6ycBXm1OnghnCqf1bmmKZ+ZUeFmLXkMLaGMRRS4fYxFz8P4baZIxHS6ef6y2x764AO0IHKZ1f7MDxpXIbtwlcaUohHmquk+FY15AuvArTznNL/w/8Q/+3uqvTKYk5GIRVbVn21TPBaMzOe8UiPsXVZQn8VL6DuhXfNdb8sHkOp1qD7UYkFrT5P5z2IRj9yMmPFwFIZRdtUHsUqSqUcDvrl3ct47ywPcB42Or9s0Nrbh2cMaFi4M/m3dsUes33T8kRVXxhbHFl+p9BQJnkMMM0lX+2tcJ9GoitJkQvvaSXlxQYA2mKeZM5bRbnLCsZY34JazuDv+OKR0AwluRDwjxUuwxHcDC+unSsU3g67hLasnGiLOqpbmaskXfBpEceHBqw4/tnz6PNi1yzHeFQ6HZ/1VT7WM95d+n6eSGotTTUaTta4S9k5JLYm9CRva7qPrnNhH1qCfPegfJ2inBGIp0s86Jp55OBneyaq+E8cYf4ErYF7g4p3efC6tpCavvROCrEd0lVqdIpeJDycWhbrhJDE/IwdfRY2GZIezKDurPNtSW8blORdkWFKtJkMyl+HKaGsNVio7FOoRY9opl7L5lVNbTlAdEdBeQAP2MNvFbN3KZrqKbHm5izpqWOw6W7c2/GmwTMyuKGsKrfqTwqmx214De4lDYy88dWYt0C6m+Fp0tdIs9DZi/9d1LuzJtV4Egvwh5szipk/l6nF3Ta1AtNOXqxDnNxzmkrN7N2h794buc7B2r9Y4TK9crXIY5gpcl62uw2VBOIDBlIJGYX53ePdiPSIlrokuUyCZhN7I5pXjoFPxJxH9tiydzgkh+Za0eUgyLBCWq8HLcvgjwSE/TTVNwo8/o0TKYAJiHIPR83MMJumsbZM9qtqGvuFtZy0Z1X6Mf/DO9pRENGD+9tc/3aHe7aD2Y55ej6jKKZnSsakXOF4K+KgVRrZkAWNgxn17+jcYEMiwsfccm7sy9HQ7nAoPy/elzjebTQ5olJf7IyG3xmi2wIMqo7FR4slKXNpXn8LAV99JEG7yyXe0qrtuGCTmZeX0kJJgfx3Ugq8aOCE3E+xGVs855+GN8sC1Ja+0NG91tKYMEm30VNWWCGU1I1Jh7CehIMGTUCD8tNQfeDE9NddqN+gMnDU3Nf3FgN9D5ayeOZVcz1yqcCLMk9Wtm1nnr39X/IkacKoGAUz5IvBLXlShjg34S+fhDT5QTzt4zggPFUoj+4uPrqZKXfGTz6OJ5lC0XRO9VFOMKHvsQ3AzLCYW5UQHlG1R28OF3F6vqa0wa5ldss/e7OVrqqor6Ydyan0G+QraaOwDc/vDq+miKEmi6Ls6Tery+brUd8xnmW/BOXs63cpc92wkorC6e8gt2il+gNc7y5ePwTP0lOvfjjE4di80M1fgmF4dDQKdMTayDC94FmdZ/8eZLDLY75m/KiflHK2bhLnT8px/esvs1g7R5b/H38Qfq+//hTZVMSnkr8xF2l8t+D0rlzcwKeeco3Gdm3Df4/dxnYq55pmDW47CdkYmf29omd/lKwUmdiN2nsyJDWuFjuYQLzfAMfIJFEfjD6nxOMqWFU+bEOj8SHGhr/SQQ1SU4ekbmcACKyJR5qTiMMcijmsfzpw6vyVimnoXtKR5zYLL+XAcK4s8rPAyTynvay2K52dwzJykO1GS+59KOtANc7LaUZbL5bxjP59E7oiTdoB35jzE3IfyCv65vAPd9VuBc747UFq8F+Ptg8F4FquZFB+Oto5em3++mOtUWGxLx2itO8tTU6WxWNfMF0w/vpdno84SoiFjdfB1QMtUT8MgarQ1oNFu1qXxV9bOa8wV7ot1hmszK5M7LQ053kBGuLbt8N5NnS2VI91t4XDFxNJ6KbxROqRQFD3wS/2oazyYtyY/tfwQMc/azHuCPd2Bocze6nBPSPZXHOVpl8rgGqljYdeCQtpVh8g8Zje8RntIfk6uiK1fL/qx1HT6CimH2S2fl7E0z3mk5/PPPUc685ZmwKpHdSZ+ScMLZS80LOFNOuWM7lNGx3gpAm/xBXCrEAMSrxddItKt7/abbYdV+8PJ55H9EWz0lKCC1rkgBpAjuvzfdcVD4LQDVVJ71Dzm96oV2KO8vMuDHub0Im6YOqH1QKmP7g+pvAF/A2/BN4RBL4AF3pKP+WaGMIpuOHKLOhIAixdO+AaITJQRUsd44X46kgg54KXP4X75GHXMimNnqXg4RsGscAJlb/AAZCidUa/+9VNS/gLaZ16CF/4VFP/hrPGZX8iTypmjEeWyEht3On+4bblNt+8sHu6Q27Wj9/8Hl/684wB42mNgZGBgKGfwZGBn8GNgAfMQgJmBEQAbWwEgeNpiQABDQEHwCBgIFAAA9Ns427Ztm+lsW+1s27btIc22ymzlqe09cAQEgSiQD+pgFzgCToUL4Ua4H96AL2EsAqgtmoT2oOMoHNXidng0no/X4kP4E5GkP1lLzpF3JJgkkQbahHagQ+liupbeof9pDsNsAtvEHrJPLI6V8S58Id/FT/Hb/CX/xSN4imBioFgqjogvIkH2lHPlFnlZvpO/ZLVyaohars6oF6pYCz1Az9Gn9FedoStMB9PXrDFHzE3z1Hw2gSbRFNkWtqudaXfY5zbLOTfYnXAvXagr8sh738H386P9PL+1EflVN+UAAQAAAAEBSLV1wrhfDzz1ABkD6AAAAADDz0icAAAAANYM2Xr/kP8MA/4DSQAAAAkAAgAAAAAAAHjaLZADbC5BFIXPnWfbtm3btm2jMes2dtKotm1FZVDbtq3t+bHJd60ddRCGL5SUAOKD1dKKXaoYWxGMXXIQJ8kkCWA8DydRhg3yEftRhf3yAAulhtoEyySC+GGOZDIfhq1SwrgL/TLOKKE/CzdkEU5yxjFi0P+xcIIH7qodmK6WUF/CfvUHd6WepNM3o/8bd6HhEXq0HrWS8WTcnTADl5Ul8w7c0WjUI8x1ck8uJqlPuKGmYtKExbxP4+0FWp+08L51eK6/eR1tR/3/QBKxVkZ5WyB7R3hrJvVTbJAC1jCOVpxHs9YpKbTbuXsuaxmXJtZR63suUdty3mPO7sdlicIcFUvbHdN1tthx1inWL8U36uncu0F24eSE47gMviuInDHA2HNZjuOcvUFNIT+wYcJEMps9e+j/xmZVh+fqKPbroH1ZzaY/m/ZHA3KVN23Hm3Fv515EAAAAeNpjYGRgYG75d4WBgUXt/4T/dcz/gCKooBwAoz8HCgB42mNgZlzPOIGBlYGBaQ9TFwMDQw+EZrzLYMTwCyjKDZQCUgwMDUBBBiSQU5qSyuDAwKCgxtzy7woDA3MLo44CA8NkkBzjUaZCIKXAwAwAyuoOVQB42gzJwwHFUAAAsHzbNqqtikXe6EWuQR8DHA30cDQUcLU1MMVKqlAK3+P39n19/9+0acDKV6ZUdXP9PttBZRj/f2Vg+P+AgfX//QfeDzweuD2weWAHMhtsOiZgZihjKAXaysrAxpADAJy/FrJ42mNgYGBikGNgZmBk4WRgZAACKJsJCBkY6gEGUADHAHjaY2BmAIP/WxmMGLAAACzCAeoAAAAAAf//AAN42kTIM5gcUBSG4e/6xrZt2zaqaWLbRhezjdOEfZV+UKZb22gWfTN71s97+KOAvixmO3r7zv0JBl49dfc6Y7EA2SwKem+hr5y7fZ2BnRNQHW3RIHNgvN5354DbKH5igf1qtJoYD6rp6rB6rj6G2SqjmnVCH9dn9X39Wn/U/3W+bjXejDdTzX6Taw6bu+ap+W5Scpdba6fa5Xan/Wz/2ka30K12j8NY99798xP9fJfx80PGFcvdX1oSsdHv9rf9c//V//YpX+rrgw1jw+xwuksmToyb40E0wzACnFAEIpq+DMcyinEMYpIYzhSmMoLpYhQzmcVo5rGAsSxiPRPYxFb5t7NL/r1iGfs5zHJOcIZtXBS7ucJV9nBP7EOxMlstczhttJc9TFtXFMevbR7gF7AhdQBD6pZmCKoURaHUgRRKSNK0aUkgJHykShV/RPlWt3TqrsyZmZk9VRVDs6BKlSovZHiqxOKhLF7c4S0Mr7973tXVk59QIG5z9ff9Oud///ecc43jqn51IqirgaCpBgNf5eiHwAjjPChiMwtuqEm1yHyZvVXgqr5gWmVANthRg1icVC53KWgGNE6oUfox0KXS8A9z3hy4D06olGYIatxuklNr+BbwddUp+hG4inDOgtXAYzW03jTWdawn5SSssdwOLVnPqzS+3AZtW2jbDLXhfVLfjPVT+nYoGKHPg1HWxsBp8CEosHdObu2qObgWmS+BZXCf+Q/YJFUazz6sEox8uR9zbpxBD1EwKxn2hsEs4xT6fVEyDPqxKaCzAUsNu2101rmRg8Y99O0TPxdtHto8yf4Len0ubKA7PJG1DMjKnVr6HBhcyWNL4l0Ue4/VFJXkmtOLgFXUU2XAZdzHKAOy6PpIPPe1jWT6BTY/wZQSvmmwKhrwRMOmibOPTlfNMw7tZsXuALs+1jNAcy+gbBnobKWlAjjZ7OY4uWnyWReLdYmlcANhBEk0NGUGg8qh4RUaXlsNReWIjmVOX2Xcg11B9QHjJ5mdB2QUfquPGb6sFPGcBuYOrKeICbUVuXNNasvUj+RI6oZ+GptZfQI3WQRLYBmsBm/UOr3OZQoWKgTMgwHL38e+1AOr5v3AnTV8Nfg8tQSoR/ha8JEfxoMwtAxDHYYdw+DDEEZFGNhbYH0RLIEwEwew+LA0iSwxYGXfKsqbCt2Cz4OvocYAtzV8mxFFOmd7cO3CVdd5Uy6WjjnFl0rbkTxkwCArvHrzjok8vNP064AK4tQbWgu9I9WOMqlw0Qv65LawyQ7VbbJaEL8l5mH+YbSZjlb5Op8pYTas5tVGz0jqGXwolz23LUPEViyW6VfZlXqNqXU4N2vPxVbskva0HhlJ3oDhlGxzA/vWd9n9I7Jbh4F9uZ1hYF9sGEcZnGiFy846ayn5/jHf7OzKtwD5yQDsqABXvq8+AFr5EPNhxiP0RfrwLXnMU4zScLg0qRaQBQPak36YW8v3LdpHidwYsO8Fv2mtijYHFlmT71vud5/5Q9QMGfYJyz6MB9+O9uV9rLVwyhyYZ30BlhtBK1Kbu+a17MM6Aasnr6YX5lnJqlQ0p8yxu6BjArAkStSp/dYktypnVRTxTKjTrCpRuKx+UV5iNLGRLCV+S5bYS+Pfq6NCfLNqAN9T5GqKky+iZoa+BMqgAqogz35OfcrJU/QXwQx3uszZV8BVcA18habrrN+kv8X8Nv0KuAvWmG+w94jxY/AEPAXPwHPwUuXQ1E8ExsEU6h7Ql/AogwqoggHVww37ie+46HFRvak+h/si1jNkcI1YbjB+gE0J2zKogCp4CbIhA4AB75rx3sF7E+89vHfxrsW9QT48G/4zaD4LzoMLQOKCnhn6y0TsCrgKroHr4Ca4BW6DFXAX3MMPnbFbdqt+fX9Q4qQyqIAqSKhLktcR9Ur9CF7Taup39Vb9k+hNfJn4Nfln4u+kSo7yG/JZ8ufkFr8f/0o2U0N4jlCxw3yOqjHq6hN+rZ3jd22ROv+CGpunvhaplVVe4ffqofwqQwexeQDaFSatQl03deLnh3WDbRlUQBU4xIpV6qYMKqAKUvg0sW8Rax+GcRg+0wz6xqAMKqAKHGx9VQJlUAFV0I8Pp7J7hW+Sq+AauAXu4LPG+oZw5VQZVEAVFDjLlTuNUyVTkqm9aKbCCibON4Fki34F3AVrWi+4d0hMDq9sV52QU8+As+A8uAB0ld+x74O6BZq529TmDnElTpx9ifk90M3qtqnYulTsdVbXGGfQzu3BBqCyYm/4EeuPwRPwFDwDz4GjPWLWXbFcukSrFYv3CmiPRLrdCu3xbKR4vwXRvwG6Yu9N19ak+pq9b8C34DtQYq0MKqAKXgInjJetQ+KFd7L3LawqPeF2yf9SVNBASYf/giYcbmc8osMJfP353iQFlOwG+3A16GnwtYDPt1cuaNI82h5oHMqRU3k+s8QqGxzoZhUyYjcrE+edd/kv/qHhnXE7+F91GA6JwzFPj3H4nXDwKsgHEXGEiWb9Gcn6UZTAYE50gPU5Xs1hDUtcx5FvVZD9DjJrOFrhMF6nR+RwaZ3WRw0V8HD7+N6OjY+S3gma0t7Iu9y1p+dAh0pQcfie3zZvmr4RzmhigaaDo3DEuOTT3rTOhysrLd2iCjnJs/OGhm5WkSM9DGJ1SEzF03Jg5UnbClr41YyOjuNxrNgfwBDNnxP9e0B/1CpHmbRWm8ocFbPNHZt8SrP227p2ZDdsHmOJqampAloOjcRxc42OA/P3pBnLrRvGIWw2/vG6zpt8NUFdN8tRV1mYG6zLDqNdw1YIT7fKbB+vsbj+YF+3jt6WvGNYc21/k5ij2lQsLXKXSD49sBnUTF4mlAKT+Bru99DD64i8ggR8PfrX778dz9EKmQEYx+GfDwAAHwBiqVECiSMZLAthiSPb1FI7dv/79/ZcwUObDl169BkwZMSYCVNmzFmwZMWaDVt27Dlw5MSZC1du3Hnw5Be/+cOLNx8cOgSlTlyatCRFW9J0JENXsvQkR1/yDMRlKC4jKTCWIhMpMZUyM6kwlyoLqbESD2tx2IiXrfjYiZ+9BDhIkKOEOEmYs0S4SJSrxLhJnLskeEiSpzS1etHgLV4+Usfhi92SdnPtVrBb0VYlvkrLPmX7lG3StEnFJlWb1GxSt0mDpXjtE+SbhGwVtpXfVgFbRfguUbvF+CFxG2ZsmLBb1m45u6X4KXkbpm3o2NBnQ9eGHv7yD78Nk/8BNx1bqgB42kWOg1KAURCFv4tsDLLdqEG2MW6QbfMhep5eLndmb/jxnfUuDsilj2v81MzSMoXnO/eX1BIBvr4IgJf37zv9GWTu7Zzf05q4f35yRHeisENPIuDwRoyOSC6PPPNKtEg2jlUC+aqesWwpldRzrVgBtVyajnCDl3cnjujPpJALlNF7ixdT7CrFuLeYM6+akf9dPJlmkE+5Mo20c6KqaeY4NV3kGC89FOc4EhfJTN0E0yUcpTggiOVkkUMudQwxzDizzOmd17vAIutss8Muezzg/m7IpFV0TH8Dk+Mm+gAAAA==') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* rest */

@font-face {
  font-family: 'medium-content-sans-serif-font';
  font-weight: 600;
  font-style: normal;
  src: url('marat-sans-600-normal.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}


/* latin */

@font-face {
  font-family: 'medium-content-sans-serif-font';
  font-weight: 600;
  font-style: normal;
  src: url('data:font/opentype;base64,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') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* latin */

@font-face {
  font-family: 'medium-marketing-display-font';
  font-weight: 500;
  font-style: normal;
  src: url('noe-display-500-normal.woff') format('woff');
  unicode-range: U+0-7F, U+A0, U+200A, U+2014, U+2018, U+2019, U+201C, U+201D, U+2022, U+2026;
}


/* rest */

@font-face {
  font-family: 'medium-marketing-display-font';
  font-weight: 500;
  font-style: normal;
  src: url('noe-display-500-normal.woff') format('woff');
  unicode-range: U+80-9F, U+A1-2009, U+200B-2013, U+2015-2017, U+201A-201B, U+201E-2021, U+2023-2025, U+2027-10FFFF;
}",
    after: ""
  )
end


def add_users
  # Install Devise
  generate "devise:install"
  # Create Devise User
  generate :devise, "User",
           "first_name",
           "last_name",
           "slug",
           "admin:boolean"
  generate "uploader image"
  generate "uploader avatar"
  generate "devise:views"
  generate "meta_tags:install"
  rake "sitemap:install"

  in_root do
    migration = Dir.glob("db/migrate/*").max_by{ |f| File.mtime(f) }
    gsub_file migration, /:admin/, ":admin, default: false"
  end

  # Configure Devise
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
              env: 'development'
  route "root to: 'home#index'"

  # Devise notices are installed via Bootstrap
  # generate "devise:views:bootstrapped"

  inject_into_file("app/models/user.rb", "omniauthable, :masqueradable, :",
  after: "devise :")

  insert_into_file(
    "app/models/user.rb",
    "\n\tinclude FriendlyId
  friendly_id :full_name, use: :slugged

  def full_name
    [first_name, last_name].join(' ')
  end\n",
    before: "end"
  )
  insert_into_file(
    "config/routes.rb",
    ",
      :path => '',
      :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile' },
      :controllers => {:omniauth_callbacks => 'omniauth_callbacks'
      #  confirmations: 'confirmations'
      }",
    after: "devise_for :users"
  )

end

def simple_form
  generate "simple_form:install"
end

def friendly_id
  generate "friendly_id"

  in_root do
    migration = Dir.glob("db/migrate/*").max_by{ |f| File.mtime(f) }
    gsub_file migration, /Migration/, "Migration[5.2]"
  end
end

def add_config_application
  insert_into_file(
    "config/application.rb",
    "
    config.generators do |g|
      g.test_framework  nil #to skip test framework
      g.assets  false
      g.helper false
      g.stylesheets false
      g.javascript_engine :js
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: true,
        fixtures: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile += %w( .svg .eot .woff .ttf)
    config.assets.initialize_on_precompile = false
    config.active_record.default_timezone = :local
    config.time_zone = 'Bangkok'
    #{%q(config.encoding = "utf-8")}
    config.gem 'sitemap_generator'",
    after: "config.load_defaults 5.2\n"
  )

  insert_into_file(
    ".gitignore",
    ".DS_Store\n.keep\n/public/uploads/*\n/public/assets/*",
    after: ".byebug_history\n"
  )
end


add_gems

after_bundle do
  create_file
  add_users
  add_assets
  add_config_application
  simple_form
  friendly_id

  # Migrate
  rails_command "db:create"

  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
