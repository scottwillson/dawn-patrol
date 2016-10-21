 * consider deferring Calculate and Calculation creation methods for in-memory tests
 * Calculation source events: add attribute like source_events_strategy?
   * all (default)
   * children of single parent event
   * specific set of parents
 * Add CreateEvent and UpdateEvent action that ensure correct state
 * Use namespaces for React components
 * move *_attributes methods to RacingOnRails models
 * use react-rails camelcase option
 * Use import not application.js require?
 * add category slugs and use them for anchor links
 * consistently use module names for things like Events::Event
 * Add reactjs component tests
 * ditch Actions and just use methods?
 * events should set start time based on city, state time zone
 * handle tandem results correctly
  * each person has a result
  * tandem team appears in the BAR (could just be people?)
 * show rejections on calculation results pages
 * consider replacing Actions with methods
 * make Action attributes declarative
 * Test React code

 Calculations
 ============
 * Steps common methods
  * log
  * benchmark
  * size change
  * record exclusions
 * filter results
 * report exceptions
 * handle excluded events
 * re-use existing events
 * re-use categories
 * parameterize year
 * include year in calculation event name?
 * check performance (DB queries) with real data
 * assert result name and team
 * reject_upgrade_only (should just be source results all from self?)
 * results_per_event, use_source_result_points
 * results_per_race, use_source_result_points
