CelluloidBenchmark::Session.define do
  event_id = (770 + rand * 500).to_i

  benchmark :results_page, 1
  get "http://104.198.7.192/events/#{event_id}/results"

  benchmark :results_page_json, 1
  get "http://104.198.7.192/events/#{event_id}/results.json"
end
