 * Look for and remove any DB work that occurs during calculate
 * promoter=should take just a Person, too
 * Show JS/React errors
 * import event editors as promoters
 * Improve host scheme for different environments
 * Event start time should be in association time zone
 * handle tandem results correctly
  * each person has a result
  * tandem team appears in the BAR (could just be people?)
 * DRY up `ActsAsTenant.current_tenant = DawnPatrol::Association.create!` in tests
 * factories?
 * find_or_create category helper
 * try to create test without DB access
 * define Calculation categories as names or Categories?
 * consider deferring Calculate and Calculation creation methods for in-memory tests

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
