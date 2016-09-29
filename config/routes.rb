load './config/initializers/model_loader.rb'

Kribi::Application.routes.draw do
  # Web
  root({
    to: 'static_pages#home',
    as: :home
  })

  post 'register_web', {
    to: 'static_pages#register_web',
    as: :register_web
  }
  post 'login_web', {
    to: 'static_pages#login_web',
    as: :login_web
  }
  get 'logout_web', {
    to: 'static_pages#logout_web',
    as: :logout_web
  }

  get 'export', {
    to: 'static_pages#export',
    as: :export
  }

  get '/all_dumps.zip', to: 'static_pages#all_dumps'

  AbstractIntervalModel.descendants.each do |model|
    scope '/batches' do
      resources model.table_name, controller: "#{model.table_name}_batch", only: [] do
        collection do
          # collection create
          get     '',             action: :collection_read,    as: :collection_read
          post    '' ,            action: :collection_update,  as: :collection_update
          post    'elevate',      action: :collection_elevate, as: :collection_elevate
        end
      end
    end
  end

  post '/events/engine_trip'
  {
    context: {
      action: 'create'
    },
    content: {
      member_key: 'value',
      member_key: 'value',
      member_key: 'value'
    }
  }

  {
    context: {
      action: 'update'
    },
    content: {
      id: 1,
      attr1: 'value',
      attr2: 'value',
      attr3: 'value'
    }
  }


  ### COLLECTION

  ## CREATE

  # REQUEST
  {
    context: {
      action: 'create'
    },
    content: [
      {
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
    ]
  }

  # RESPONSE
  {
    context: {
      action: 'create',
      result: 'success'
    },
    content: [
      {
        id: 1,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        id: 2,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
    ]
  }


  ## UPDATE

  # REQUEST
  {
    context: {
      resource: 'engine_energy_readings',
      action: 'create'
    },
    content: [
      {
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      }
    ]
  }

  {
    context: {
      resource: 'engine_energy_readings',
      action: 'create',
      result: 'success',
      messages: {
        'success' => [
          {
            description: {
              internal: 'everything_ok',
              external: 'Everything OK!'
            }
          }
        ],
        'failure' => [],
        'error' => []
      }
    },
    content: [
      {
        id: 1,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        id: 2,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      }
    ]
  }
  # RESPONSE
  # success
  # failure
  #   error
  {
    context: {
      resource: 'engine_energy_readings',
      action: 'update',
      result: 'success'
      messages: {
        'success' => [
          {
            description: {
              internal: 'everything_ok',
              external: 'Everything OK!'
            }
          }
        ],
        'failure' => [],
        'failure' => []
      }
    },
    content: [
      {
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      }
    ]
  }





          {
            type: :collection_member,
            internal: 'collection_member_failure',
              external: 'member 1 must have a date 1 day after last record'
            },
            extra: {
              member: 1,
              suffix: 'must have a date 1 day after last record'
            }
          },
            member_id: 
          },
          {
            type: :collection_member_attribute
          },
        ]















        'failure' => [
          {
            id: 123,
            description: {
              internal: 'collection_failure',
              external: 'collection members with id 1,2,3 are in mismatch with members with id 4,5,6'
            },
            extra: {
              suffix: 'members with id 1,2,3 are in mismatch with members with id 4,5,6'
            }
          },
          {
            id: 123,
            description: {
              internal: 'collection_member_failure',
              external: 'member 1 must have a date 1 day after last record'
            },
            extra: {
              member: 1,
              suffix: 'must have a date 1 day after last record'
            }
          },
          {
            id: 123,
            description: {
              internal: 'collection_member_attribute_failure',
              exernal: 'attribute name of member 1 is too long'
            },
            extra: {
              member: 1,
              attribute: 'attribute_name',
              suffix: 'is too long'
            }
          }
        ],
        'error' => [
          {
            id: 321,
            description: 'request took too long'
          },
          {
            id: 321,
            description: 'internal server error'
          },
        ]
      }
    },
    content: [
      {
        id: 1,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        id: 2,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
    ]
  }
  # ERROR
  {
    context: {
      action: 'update',
      result: 'success'
    },
    content: [
      {
        id: 1,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
      {
        id: 2,
        attr1: 'value',
        attr2: 'value',
        attr3: 'value'
      },
    ]
  }

















  # kppc.com/events/engine_trip/member/
  # kppc.com/events/engine_trip/collection/
  AbstractEventModel.descendants.each do |model|
    scope '/events' do
      resources , path:  '/collection/#', controller: "#{model.table_name}_member"


        scope '/member' do
          resource model.table_name, controller: "#{model.table_name}_member", only: [:create, :read, :update, :delete]
        end
        scope '/collection' do
          %w{create read update delete elevate}.each do |verb|
            post verb, actionkkkkkkkkkk
          end
        end
      end

      resources model.table_name, only: [] do
        collection do
          # post    '',             action: :collection_create,  as: :collection_create
          get     '',             action: :collection_read,    as: :collection_read
          post    '' ,            action: :collection_update,  as: :collection_update
          post    'elevate',      action: :collection_elevate, as: :collection_elevate

          post    '',             action: :member_create,      as: :member_create
          get     ':id',          action: :member_read,        as: :member_read
          post    ':id',          action: :member_update,      as: :member_update
          delete  ':id',          action: :member_destroy,     as: :member_destroy
          post    ':id/elevate',  action: :member_elevate,     as: :member_elevate
        end
      end
    end
  end
end
