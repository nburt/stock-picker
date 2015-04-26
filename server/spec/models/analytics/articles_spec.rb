require 'rails_helper'

describe Analytics::Articles do

  describe 'added' do

    it 'returns the number of articles added between two date ranges' do
      start_date = 7.days.ago
      end_date = DateTime.now

      create_article(created_at: 1.days.ago, link: 'link.com/1', title: 'title 1')
      create_article(created_at: 8.days.ago, link: 'link.com/2', title: 'title 2')
      create_article(created_at: 6.days.ago, link: 'link.com/3', title: 'title 3')

      expect(Analytics::Articles.added(start_date, end_date)).to eq(2)
    end

  end

end