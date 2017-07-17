require 'rails_helper'

RSpec.describe Admin::LessonsController, type: :controller do
  let(:valid_params) { attributes_for :lesson }
  let(:invalid_params) { attributes_for :lesson, title: '' }
  let(:lesson) { create :admin_lesson }
  describe 'GET #index' do
    let(:req) { get :index }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      it 'assign @lessons' do
        req
        expect(assigns(:lessons)).to eq [lesson]
      end
    end
  end

  describe 'GET #show' do
    let(:req) { get :show, params: { id: lesson.id } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      let!(:lesson) { create :lesson }
      it 'assign @lesson' do
        req
        expect(assigns(:lesson)).to be_truthy
      end
    end
  end

  describe 'GET #new' do
    let(:req) { get :new }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      it 'assign @lesson as new Lesson' do
        req
        expect(assigns(:lesson)).to be_a Admin::Lesson
      end
    end
  end

  describe 'POST #create' do
    let(:req) { post :create, params: { admin_lesson: valid_params } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      context 'when valid attributes' do
        it 'assign @lesson as new Lesson' do
          req
          expect(assigns(:lesson)).to be_a Admin::Lesson
        end
      end
      context 'when invalid attributes' do
        let(:req) { post :create, params: { admin_lesson: invalid_params } }
        it 'renders new template' do
          req
          expect(response).to render_template 'new'
        end

        it 'sets unprocessable entity status' do
          req
          expect(response).to have_http_status 422
        end
      end
    end
  end

  describe 'GET #edit' do
    let(:req) { get :edit, params: { id: lesson.id } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      it 'assign @lesson as new Lesson' do
        req
        expect(assigns(:lesson)).to be_a Admin::Lesson
      end
    end
  end

  describe 'PATCH #update' do
    let(:req) { patch :update, params: { id: lesson.id, admin_lesson: new_params } }
    let(:new_params) { attributes_for :lesson }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      context 'with valid params' do
        it 'updates lesson' do
          req
          lesson.reload
          expect(lesson.attributes).to include new_params.stringify_keys
        end

        context 'with video' do
          let(:new_params) { attributes_for :lesson, :with_video }
          it 'updates video for lesson' do
            req
            lesson.reload
            expect(lesson.video_id).to include new_params[:video_id]
          end
        end

        it 'changes friendly_id' do
          expect do
            req
            lesson.reload
          end.to change lesson, :slug
        end

        it 'new friendly_id exists' do
          req
          lesson.reload
          expect(lesson.friendly_id).to be_present
        end
      end

      context 'with invalid params' do
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:lesson) { create :lesson }
    let(:req) { delete :destroy, params: { id: lesson.id } }
    before(:each) { sign_in user }
    context 'when not admin' do
      let(:user) { create :user }
      it 'raise unauthorized exception' do
        expect { req }.to raise_error Pundit::NotAuthorizedError
      end
    end

    context 'when admin' do
      let(:user) { create :user, :admin }
      it 'removes records' do
        expect { req }.to change(Lesson, :count).by(-1)
      end

      it 'redirects to lessons index' do
        req
        expect(response).to redirect_to admin_lessons_path
      end

      it 'sets notice' do
        req
        expect(flash[:notice]).to be_present
      end
    end
  end
end
