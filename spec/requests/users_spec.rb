require 'swagger_helper'

RSpec.describe 'Users API', swagger_doc: 'v1/swagger.yaml' do
  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'
      
      response '200', 'users found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       type: { type: :string },
                       attributes: {
                         type: :object,
                         properties: {
                           name: { type: :string },
                           email: { type: :string }
                         }
                       }
                     }
                   }
                 }
               }
        
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: :id, in: :path, type: :string, required: true

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      
      response '200', 'user found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     type: { type: :string },
                     attributes: {
                       type: :object,
                       properties: {
                         name: { type: :string },
                         email: { type: :string }
                       }
                     }
                   }
                 }
               }
        
        run_test!
      end

      response '404', 'user not found' do
        run_test!
      end
    end
  end
end
