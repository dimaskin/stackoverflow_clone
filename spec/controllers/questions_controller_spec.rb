require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  let (:question) { create :question, author: user1}
  

  describe 'GET #index' do
    let(:questions) { create_list :question, 3, author: user1 }
    before { get :index }
    it 'populate an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:answers) { create_list :answer, 3, question: question, author: user }

    before do
      answers
      get :show, params: { id: question }
    end

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'populates an array of answers' do
      answers
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'prepares new @answer' do
      expect(assigns(:answer)).to be_a_new Answer
    end

    it { should render_template :show }
  end

  describe 'GET #new' do

    before { login(user) }
    before { get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do

    let(:send_request) { get :edit, params: { id: question } }

    context 'Author' do
      before do
        login(user1)
        send_request
      end

      it 'assigns requested question to @question' do
        expect(assigns(:question)).to eq(question)
      end

      it { should render_template :edit }
    end

    context 'Not author' do
      before do
        login(user2)
        send_request
      end

      it { should redirect_to question_path(question) }
    end
  end

  describe 'POST #create' do

    before { login(user) }
    let(:attributes) { attributes_for(:question) }
    let(:send_request) { post :create, params: { question: attributes } }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { send_request }.to change(Question, :count)
      end

      it 'redirects to show view' do
        send_request
        should redirect_to question_path(assigns :question)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { attributes_for(:invalid_question) }

      it 'doesnt save a new question in the database' do
        expect { send_request }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        send_request
        should render_template :new
      end
    end

  end

  describe 'PATCH #update' do
    let(:attributes) { attributes_for(:question) }
    let(:question_params) { { id: question, question: attributes } }
    let(:send_request) { patch :update, params: question_params }
    let(:question_instance) { assigns(:question) }

    context 'when right owner' do
      before { login(user) }

      it 'assings the requested question to @question' do
        send_request
        expect(question_instance).to eq question
      end

      context 'valid attributes' do
        before { send_request }

        it 'changes question attributes' do
          expect(question_instance.title).to eq attributes[:title]
          expect(question_instance.body).to eq attributes[:body]
        end

        it 'redirects to the updated question' do
          should redirect_to question
        end
      end

      context 'invalid attributes' do
        let(:attributes) { attributes_for(:invalid_question) }

        it 'not changes question attributes' do
          old_title, old_body = question.title, question.body
          send_request
          question.reload
          expect(question.title).to eq old_title
          expect(question.body).to eq old_body
        end

        # it 'redirects to the updated question' do
        #   byebug
        #   send_request
        #   should render_template :edit
        # end
      end
    end

    context 'when not author' do
      before do
        login(user2)
        send_request
      end

      it 'not changes question attributes' do
        old_title, old_body = question.title, question.body
        question.reload
        expect(question.title).to eq old_title
        expect(question.body).to eq old_body
      end

      # it { should redirect_to questions_url(question) }
    end
  end


  describe 'DELETE #destroy' do
    let(:question_params) { { id: question } }
    let(:send_request) { delete :destroy, params: question_params }

    context 'when author' do
      before { login(user1) }

      it 'deletes his question' do
        question
        expect { send_request }.to change(Question, :count).by(-1)
      end

      it 'redirects to index' do
        #byebug
        send_request
        should redirect_to questions_url
      end
    end

    context 'when not author' do
      before { login(user2) }

      it 'deletes his question' do
        question
        expect { send_request }.to_not change(Question, :count)
      end
    end
  end

end