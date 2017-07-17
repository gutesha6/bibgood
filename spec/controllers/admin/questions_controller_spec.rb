require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:lesson) { create :lesson }
  let(:question) { create :admin_question, lesson: lesson }
  let(:user) { create :user, :admin }
  let(:valid_attributes) { attributes_for :admin_question }
  let(:invalid_attributes) { attributes_for :admin_question, body: '' }

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
      it 'assigns all admin_questions as @admin_questions' do
        req
        expect(assigns(:admin_questions)).to eq([question])
      end
    end
  end

  describe 'GET #show' do
    let(:req) do
      get :show, params: { id: question.to_param,
                           lesson_id: question.lesson.to_param }
    end
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'assigns the requested admin_question as @admin_question' do
        req
        expect(assigns(:admin_question)).to eq(question)
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
      it 'assigns a new admin_question as @admin_question' do
        req
        expect(assigns(:admin_question)).to be_a_new(Admin::Question)
      end
    end
  end

  describe 'GET #edit' do
    let(:req) { get :edit, params: { id: question.to_param } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'assigns the requested admin_question as @admin_question' do
        req
        expect(assigns(:admin_question)).to eq(question)
      end
    end
  end

  describe 'POST #create' do
    let(:req) do
      post :create, params: {
        lesson_id: lesson.to_param, admin_question: valid_attributes
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
        it 'creates a new Admin::Question' do
          expect { req }.to change(Admin::Question, :count).by(1)
        end

        it 'assigns a newly created admin_question as @admin_question' do
          req
          expect(assigns(:admin_question)).to be_a(Admin::Question)
          expect(assigns(:admin_question)).to be_persisted
        end

        it 'redirects to the created admin_question' do
          req
          expect(response).to redirect_to(Admin::Question.last)
        end
      end

      context 'with invalid params' do
        let(:req) do
          post :create, params: {
            lesson_id: lesson.to_param, admin_question: invalid_attributes
          }
        end
        it 'assigns a newly created but unsaved admin_question as @admin_question' do
          req
          expect(assigns(:admin_question)).to be_a_new(Admin::Question)
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
        admin_question: valid_attributes, id: question.to_param
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
        it 'updates the requested admin_question' do
          req
          question.reload
          expect(question.body).to eq valid_attributes[:body]
        end

        it 'assigns the requested admin_question as @admin_question' do
          req
          expect(assigns(:admin_question)).to eq(question)
        end

        it 'redirects to the admin_question' do
          req
          expect(response).to redirect_to(question)
        end
      end

      context 'with invalid params' do
        let(:req) do
          put :update, params: {
            admin_question: invalid_attributes, id: question.to_param
          }
        end

        it 'assigns the admin_question as @admin_question' do
          req
          expect(assigns(:admin_question)).to eq(question)
        end

        it "re-renders the 'edit' template" do
          req
          expect(response).to render_template('edit')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:req) { delete :destroy, params: { id: question.to_param } }
    before(:each) { sign_in user }
    let!(:question) { create :question, lesson: lesson }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end
    context 'when admin' do
      it 'destroys the requested admin_question' do
        expect { req }.to change(Admin::Question, :count).by(-1)
      end

      it 'redirects to the admin_questions list' do
        req
        expect(response).to redirect_to(admin_lesson_questions_url(lesson))
      end
    end
  end
end
