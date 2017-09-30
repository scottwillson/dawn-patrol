require 'net/http'
require 'spec_helper'

RSpec.describe 'DawnPatrol', type: 'feature' do
  it 'shows a webpage' do
    3.times do
      begin
        Net::HTTP.post_form URI('http://api:8080/status'), {}
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

    # TODO should be 0
    visit 'http://wsba.web/'
    expect(page).to have_css '.events', text: '1 events'

    Net::HTTP.post_form URI('http://api:8080/rails/copy?association=wsba'), { association: 'wsba' }

    # TODO should be 1
    visit 'http://atra.web/'
    expect(page).to have_css '.events', text: '3 events'

    # TODO should be 2
    visit 'http://wsba.web/'
    expect(page).to have_css '.events', text: '3 events'
  end
end
