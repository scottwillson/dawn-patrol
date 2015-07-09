'use strict';

var express = require('express');
var morgan = require('morgan');

var app = express();

if (process.env.NODE_ENV !== 'test') {
  app.use(morgan('combined'));
}

function json() {
  return `
  [
    {
      "id": 119686,
      "category_id": null,
      "person_id": 52,
      "race_id": 6128,
      "team_id": 29,
      "age": null,
      "city": null,
      "date_of_birth": null,
      "is_series": null,
      "license": null,
      "notes": null,
      "number": "",
      "place": "1",
      "place_in_category": 0,
      "points": 0,
      "points_from_place": 0,
      "points_bonus_penalty": 0,
      "points_total": 0,
      "state": null,
      "status": null,
      "time": 0,
      "time_bonus_penalty": null,
      "time_gap_to_leader": null,
      "time_gap_to_previous": null,
      "time_gap_to_winner": null,
      "created_at": "2006-04-02T01:26:40.000-08:00",
      "updated_at": "2010-09-29T03:08:20.000-07:00",
      "time_total": null,
      "laps": null,
      "members_only_place": null,
      "points_bonus": 0,
      "points_penalty": 0,
      "preliminary": null,
      "bar": true,
      "gender": null,
      "category_class": null,
      "age_group": null,
      "custom_attributes": {},
      "competition_result": false,
      "team_competition_result": false,
      "category_name": null,
      "event_date_range_s": "4/1",
      "date": "2006-04-01",
      "event_end_date": "2006-04-01",
      "event_id": 22,
      "event_full_name": "Ice Breaker Criterium",
      "first_name": "Nick",
      "last_name": "Skenzick",
      "name": "Nick Skenzick",
      "race_name": "Senior Men",
      "race_full_name": "Ice Breaker Criterium: Senior Men",
      "team_name": "Hutch's-Eugene",
      "year": 2006,
      "non_member_result_id": null,
      "single_event_license": false,
      "team_member": true
    },
    {
      "id": 119687,
      "category_id": null,
      "person_id": 43,
      "race_id": 6128,
      "team_id": 90,
      "age": null,
      "city": null,
      "date_of_birth": null,
      "is_series": null,
      "license": null,
      "notes": null,
      "number": "",
      "place": "2",
      "place_in_category": 0,
      "points": 0,
      "points_from_place": 0,
      "points_bonus_penalty": 0,
      "points_total": 0,
      "state": null,
      "status": null,
      "time": 0,
      "time_bonus_penalty": null,
      "time_gap_to_leader": null,
      "time_gap_to_previous": null,
      "time_gap_to_winner": null,
      "created_at": "2006-04-02T01:26:40.000-08:00",
      "updated_at": "2010-09-29T03:08:20.000-07:00",
      "time_total": null,
      "laps": null,
      "members_only_place": null,
      "points_bonus": 0,
      "points_penalty": 0,
      "preliminary": null,
      "bar": true,
      "gender": null,
      "category_class": null,
      "age_group": null,
      "custom_attributes": {},
      "competition_result": false,
      "team_competition_result": false,
      "category_name": null,
      "event_date_range_s": "4/1",
      "date": "2006-04-01",
      "event_end_date": "2006-04-01",
      "event_id": 22,
      "event_full_name": "Ice Breaker Criterium",
      "first_name": "Mikkel",
      "last_name": "Bossen",
      "name": "Mikkel Bossen",
      "race_name": "Senior Men",
      "race_full_name": "Ice Breaker Criterium: Senior Men",
      "team_name": "CMG Racing/Alpine Mortgage",
      "year": 2006,
      "non_member_result_id": null,
      "single_event_license": false,
      "team_member": false
    },
    {
      "id": 119688,
      "category_id": null,
      "person_id": 5993,
      "race_id": 6128,
      "team_id": 6977,
      "age": null,
      "city": null,
      "date_of_birth": null,
      "is_series": null,
      "license": null,
      "notes": null,
      "number": "",
      "place": "3",
      "place_in_category": 0,
      "points": 0,
      "points_from_place": 0,
      "points_bonus_penalty": 0,
      "points_total": 0,
      "state": null,
      "status": null,
      "time": 0,
      "time_bonus_penalty": null,
      "time_gap_to_leader": null,
      "time_gap_to_previous": null,
      "time_gap_to_winner": null,
      "created_at": "2006-04-02T01:26:40.000-08:00",
      "updated_at": "2014-11-24T18:08:28.000-08:00",
      "time_total": null,
      "laps": null,
      "members_only_place": null,
      "points_bonus": 0,
      "points_penalty": 0,
      "preliminary": null,
      "bar": true,
      "gender": null,
      "category_class": null,
      "age_group": null,
      "custom_attributes": {},
      "competition_result": false,
      "team_competition_result": false,
      "category_name": null,
      "event_date_range_s": "4/1",
      "date": "2006-04-01",
      "event_end_date": "2006-04-01",
      "event_id": 22,
      "event_full_name": "Ice Breaker Criterium",
      "first_name": "Aaron",
      "last_name": "Tuckerman",
      "name": "Aaron Tuckerman",
      "race_name": "Senior Men",
      "race_full_name": "Ice Breaker Criterium: Senior Men",
      "team_name": "Rubicon-ORBEA Benefiting the Lance Armstrong Foundation",
      "year": 2006,
      "non_member_result_id": null,
      "single_event_license": false,
      "team_member": false
    }  ]`;
}

app.get('/events/:id/results.json', function (req, res) {
  res.send(json());
});

module.exports.app = app;
