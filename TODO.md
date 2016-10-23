 * consistently use module names for things like Events::Event
 * Add reactjs component tests
 * events should set start time based on city, state time zone
 * handle tandem results correctly
  * each person has a result
  * tandem team appears in the BAR (could just be people?)
 * show rejections on calculation results pages
 * consider replacing Actions with methods
 * make Action attributes declarative
 * result pagination?
 * ensure proper cascading deletes/prevention
 * versioning
 * Add CreateCategory (Save?) action that ensures correct state

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
 * re-use existing results
 * re-use categories
 * parameterize year
 * include year in calculation event name?
 * check performance (DB queries) with real data
 * assert result name and team
 * reject_upgrade_only (should just be source results all from self?)
 * results_per_event, use_source_result_points
 * results_per_race, use_source_result_points
 * set dates to something consistent
 * validate that :map Steps maintain collection size (and groups/reduce may change size)
 * only calculated events can have rejections
 * batch result, category, event_category updates for speed
 * source events: add attribute like source_events_strategy?
   * all (default)
   * children of single parent event
   * specific set of parents
