 * format more like existing site (mobile first!)
 * add custom color overrides
 * deploy to staging
 * import data
 * performance test
 * only show non-empty column in results
 * show custom columns
 * add inverse for all associations?
 * ensure proper cascading deletes/prevention
 * events should set start time based on city, state time zone
 * consider replacing Actions with methods
 * make Action attributes declarative
 * result pagination?
 * versioning (of? events? results?)
 * handle tandem results correctly
  * each person has a result
  * tandem team appears in the BAR (could just be people?)
 * update README with running and testing steps. Test.
 * ensure React.js is configured for prod
 * replace react-rails so we can unit-test components
 * check react.js best practices
 * replace default_value_for with actions
 * use react defaults; don't make view init empty data
 * Actually exclude feature specs
 * imported competitions appear to be in wrong year
 * Add CreateCategory (Save?) action that ensures correct state (what is correct state? normalized name?)
 * does format.html belong in stale? block?


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
