require 'net/http'
require 'spec_helper'

RSpec.describe 'DawnPatrol', type: 'feature' do
  it 'shows a webpage' do
    3.times do
      begin
        Net::HTTP.get URI('http://api:8080/status')
        break
      rescue
        sleep 1
        retry
      end
    end

    visit 'http://atra.web/'
    expect(page).to have_css 'h2', text: 'Dawn Patrol'
    expect(page).to have_css '.events', text: '0 events'

    visit 'http://wsba.web/'
    expect(page).to have_css 'h2', text: 'Dawn Patrol'
    expect(page).to have_css '.events', text: '0 events'

    Net::HTTP.post_form URI('http://api:8080/rails/copy'), { association: 'atra' }

    visit 'http://atra.web/'
    expect(page).to have_css '.events', text: '1 events'

    visit 'http://wsba.web/'
    expect(page).to have_css '.events', text: '0 events'

    Net::HTTP.post_form URI('http://api:8080/rails/copy'), { association: 'wsba' }

    visit 'http://atra.web/'
    expect(page).to have_css '.events', text: '1 events'

    visit 'http://wsba.web/'
    expect(page).to have_css '.events', text: '2 events'
  end
end
