require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user)     { create :user }
  let(:question) { create :question, author: create(:user) }
  let(:answer)   { create :answer, question: question, author: user }


  describe 'POST #create' do
    
  let(:attributes) { attributes_for(:answer) }
    let(:send_request)      { post :create, params: { question_id: question.id, answer: attributes } }
    let(:send_ajax_request) { post :create, params: { question_id: question.id, answer: attributes, format: :js } }

    context 'when signed in' do
      before { login(user) }

      context 'builded answer' do
        before { send_ajax_request }

        it 'have right owner' do
          expect(assigns(:answer).author).to eq user
        end

        it 'have right question' do
          expect(assigns(:answer).question_id).to eq question.id
        end
      end

      context 'creating answer' do
        context 'with valid attrs' do
          it 'saves new answer' do
            expect { send_ajax_request }.to change(question.answers, :count).by 1
          end
        end

        context 'with invalid attrs' do
          let(:attributes) { attributes_for(:invalid_answer) }

          it 'does not save the answer' do
            expect { send_ajax_request }.to_not change(Answer, :count)
          end
        end
      end
    end

    context 'when user is not signed in' do
      context 'with ajax request' do
        it 'should redirect to sign in' do
          send_request
          should redirect_to new_user_session_url
        end
      end

      context 'with normal request' do
        it 'should respond_with 401' do
          send_ajax_request
          should respond_with 401
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:answer_params) { { id: answer.id } }
    let(:send_ajax_request) { delete :destroy, params: answer_params, format: :js }

    context 'when owner' do
      before { login(user) }

      it 'deletes his answer' do
        answer
        expect { send_ajax_request }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question' do
        send_ajax_request
        should_not redirect_to question_url(answer.question)
      end
    end

    context 'when not owner' do
      it 'deletes his question' do
        answer
        expect { send_ajax_request }.to_not change(Answer, :count)
      end
    end
  end

end