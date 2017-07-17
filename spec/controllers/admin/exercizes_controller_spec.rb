require 'rails_helper'

RSpec.describe Admin::ExercizesController, type: :controller do
  let(:lesson) { create :lesson }
  let(:exercize) { create :admin_exercize, lesson: lesson }
  let(:user) { create :user, :admin }
  let(:valid_attributes) { attributes_for :admin_exercize }
  let(:invalid_attributes) { attributes_for :admin_exercize, body: '' }

  describe 'GET #index' do
    let(:req) { get :index, params: { lesson_id: lesson.id } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'assigns all admin_exercizes as @admin_exercizes' do
        req
        expect(assigns(:admin_exercizes)).to eq([exercize])
      end
    end
  end

  describe 'GET #show' do
    let(:req) { get :show, params: { id: exercize.to_param } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'assigns the requested admin_exercize as @admin_exercize' do
        req
        expect(assigns(:admin_exercize)).to eq(exercize)
      end
    end
  end

  describe 'GET #new' do
    let(:req) { get :new, params: { lesson_id: lesson.id } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'assigns a new admin_exercize as @admin_exercize' do
        req
        expect(assigns(:admin_exercize)).to be_a_new(Admin::Exercize)
      end
    end
  end

  describe 'GET #edit' do
    let(:req) { get :edit, params: { id: exercize.to_param } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'assigns the requested admin_exercize as @admin_exercize' do
        req
        expect(assigns(:admin_exercize)).to eq(exercize)
      end
    end
  end

  describe 'POST #create' do
    let(:req) do
      post :create, params: {
        lesson_id: lesson.to_param, admin_exercize: valid_attributes
      }
    end
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      context 'with valid params' do
        it 'creates a new Admin::exercize' do
          expect { req }.to change(Admin::Exercize, :count).by(1)
        end

        it 'assigns a newly created admin_exercize as @admin_exercize' do
          req
          expect(assigns(:admin_exercize)).to be_a(Admin::Exercize)
          expect(assigns(:admin_exercize)).to be_persisted
        end

        it 'redirects to the created admin_exercize' do
          req
          expect(response).to redirect_to(Admin::Exercize.last)
        end
      end

      context 'with invalid params' do
        let(:req) do
          post :create, params: {
            lesson_id: lesson.to_param, admin_exercize: invalid_attributes
          }
        end
        it 'assigns a newly created but unsaved admin_exercize as @admin_exercize' do
          req
          expect(assigns(:admin_exercize)).to be_a_new(Admin::Exercize)
        end

        it "re-renders the 'new' template" do
          req
          expect(response).to render_template('new')
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:req) do
      put :update, params: {
        admin_exercize: valid_attributes, id: exercize.to_param
      }
    end
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      context 'with valid params' do
        it 'updates the requested admin_exercize' do
          req
          exercize.reload
          expect(exercize.body).to eq valid_attributes[:body]
        end

        it 'assigns the requested admin_exercize as @admin_exercize' do
          req
          expect(assigns(:admin_exercize)).to eq(exercize)
        end

        it 'redirects to the admin_exercize' do
          req
          expect(response).to redirect_to(exercize)
        end
      end

      context 'with invalid params' do
        let(:req) do
          put :update, params: {
            admin_exercize: invalid_attributes, id: exercize.to_param
          }
        end

        it 'assigns the admin_exercize as @admin_exercize' do
          req
          expect(assigns(:admin_exercize)).to eq(exercize)
        end

        it "re-renders the 'edit' template" do
          req
          expect(response).to render_template('edit')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:req) { delete :destroy, params: { id: exercize.to_param } }
    before(:each) { sign_in user }
    let!(:exercize) { create :admin_exercize, lesson: lesson }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'destroys the requested admin_exercize' do
        expect { req }.to change(Admin::Exercize, :count).by(-1)
      end

      it 'redirects to the admin_exercizes list' do
        req
        expect(response).to redirect_to(admin_lesson_exercizes_url(lesson))
      end
    end
  end
end
