RSpec.shared_examples 'authenticated' do
  context 'when not authenticated' do
    let(:user) { nil }
    it 'redirects to login' do
      make_request
      expect(response).to redirect_to '/users/sign_in'
    end
  end
end
RSpec.shared_examples 'valid status' do
  it 'responds with valid status' do
    make_request
    expect(response).to have_http_status 200
  end
end
RSpec.shared_examples 'forbidden' do
  it 'raises Pundit::NotAuthorized' do
    expect { make_request }.to raise_error Pundit::NotAuthorizedError
  end
end
