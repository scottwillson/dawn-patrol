 * consistently use module names for things like Event
 * fix Reactjs warnings
 * Add reactjs component tests
 * format more like existing site
 * add custom color overrides
 * deploy to staging
 * import data
 * performance test
 * only show non-empty column in results
 * show custom columns
 * Add CreateCategory (Save?) action that ensures correct state
 * add inverse for all associations?
 * ensure proper cascading deletes/prevention
 * events should set start time based on city, state time zone
 * consider replacing Actions with methods
 * make Action attributes declarative
 * result pagination?
 * versioning
 * add event slug that is just name and defaults to current year's event
 * handle tandem results correctly
  * each person has a result
  * tandem team appears in the BAR (could just be people?)

 Calculations
 ============
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
 * assign place properly for ties
 * break ties correctly
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
 * show rejections on calculation results pages
