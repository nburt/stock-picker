require 'rails_helper'

describe UrlHelper do

  describe 'tweet_url' do

    it 'takes a tweets data and returns a url' do
      data = {
        'id_str' => '1237676834',
        'user' => {
          'screen_name' => 'yoshi'
        }
      }

      expect(tweet_url(data)).to eq('https://twitter.com/yoshi/status/1237676834')
    end

  end

end