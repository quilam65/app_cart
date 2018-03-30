RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  config.model 'Cart' do
    list do
      scopes [:finished]
      sort_by :finished
      field :name
      field :phone
      field :address
      field :finished
      field :total_amount_cents
      field :updated_at
    end
    edit do
      field :finished
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
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
