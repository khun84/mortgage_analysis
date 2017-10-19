require 'rails_helper'

RSpec.describe Authentication, type: :model do
    describe '#create_from_omniauth' do
        context 'with returned auth_hash from facebook' do
            it 'should return a new authentication instance' do
                uid = SecureRandom.hex(10)
                token = SecureRandom.hex(15)
                auth_hash={}
                auth_hash["provider"] = 'facebook'
                auth_hash["uid"] = uid
                auth_hash["credentials"]={"token"=> token}

                auth = Authentication.create_with_omniauth(auth_hash)
                expect(auth).to be_an_instance_of(Authentication)
            end
        end

        context 'without returned auth_hash from facebook' do
            it 'should return a new authentication instance' do
                auth_hash = nil
                expect{Authentication.create_with_omniauth(auth_hash)}.to raise_error NoMethodError
            end
        end
    end
end

