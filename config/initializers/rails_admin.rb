RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  
  config.current_user_method(&:current_user)

  config.authorize_with do
    return redirect_to main_app.new_account_session_path, alert: 'Please login to continue...' if current_user.nil?
    redirect_to main_app.root_path, alert: 'You not permission admin' if !current_user.role?
  end



  config.model 'Cart' do
    list do
      # scopes [:finished]
      sort_by :finished
      field :name
      field :phone
      field :address
      field :orders do
        searchable ["orders"]
      end
      field :finished
      field :total_amount_cents
      field :updated_at
    end

    edit do
      field :finished
    end

    show do
      field :name
      field :phone
      field :address
      field :orders do
        searchable ["orders"]
      end
      field :products do
        searchable ["products.title"]
      end
      field :finished
      field :total_amount_cents
      field :updated_at
    end
  end
  config.model 'User' do
    list do
      field :email
      field :role
      field :created_at
    end
    edit do
      field :email
      field :role
      field :created_at
    end
  end

  config.model 'Order' do
    list do
      field :cart do
        searchable ["cart.name"]
      end
      field :product do
        searchable ["product.title"]
      end
      field :quanlity
    end
  end



  config.model 'Category' do
    list do
      field :title
      field :created_at
    end
    edit do
      field :title
    end
  end

  config.model 'Product' do
    list do
      field :category do
        searchable ["category.title"]
      end
      field :image do
        pretty_value do
          bindings[:view].tag(:img, {:height=> '50px', :src => bindings[:object].image })
        end
      end
      field :title
      field :description
      field :price
    end

    edit do
      field :category do
        searchable ["category.title"]
      end
      field :title
      field :description
      field :price
    end

    show do
      field :category do
        searchable ["category.title"]
      end
      field :image do
        pretty_value do
          bindings[:view].tag(:img, {:height=> '50px', :src => bindings[:object].image })
        end
      end
      field :title
      field :description
      field :price
    end
  end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app do
      except ['Order']
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
