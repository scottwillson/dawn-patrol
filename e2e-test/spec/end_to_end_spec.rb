require 'net/http'
require 'spec_helper'

RSpec.describe 'DawnPatrol', type: 'feature' do
  it 'shows a webpage' do
    visit 'http://web/'
    expect(page).to have_css 'h2', text: 'Dawn Patrol'
    expect(page).to have_css '.events', text: '0 events'

    3.times do
      begin
        Net::HTTP.post_form URI('http://api:8080/rails/copy'), {}
        break
      rescue
        sleep 1
        retry
      end
    end

    visit 'http://web/'
    expect(page).to have_css '.events', text: '2 events'
  end
end
