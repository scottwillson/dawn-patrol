'use strict';

var express = require('express');
var fs = require('fs');
var morgan = require('morgan');

var app = express();

var accessLogStream = fs.createWriteStream('tmp/nginx.log', { flags: 'a' });
app.use(morgan('combined', { stream: accessLogStream }));

if (process.env.NODE_ENV !== 'test') {
  app.use(morgan('combined'));
}

function json() {
  return '\n  [\n    {\n      "id": 119686,\n      "category_id": null,\n      "person_id": 52,\n      "race_id": 6128,\n      "team_id": 29,\n      "age": null,\n      "city": null,\n      "date_of_birth": null,\n      "is_series": null,\n      "license": null,\n      "notes": null,\n      "number": "",\n      "place": "1",\n      "place_in_category": 0,\n      "points": 0,\n      "points_from_place": 0,\n      "points_bonus_penalty": 0,\n      "points_total": 0,\n      "state": null,\n      "status": null,\n      "time": 0,\n      "time_bonus_penalty": null,\n      "time_gap_to_leader": null,\n      "time_gap_to_previous": null,\n      "time_gap_to_winner": null,\n      "created_at": "2006-04-02T01:26:40.000-08:00",\n      "updated_at": "2010-09-29T03:08:20.000-07:00",\n      "time_total": null,\n      "laps": null,\n      "members_only_place": null,\n      "points_bonus": 0,\n      "points_penalty": 0,\n      "preliminary": null,\n      "bar": true,\n      "gender": null,\n      "category_class": null,\n      "age_group": null,\n      "custom_attributes": {},\n      "competition_result": false,\n      "team_competition_result": false,\n      "category_name": null,\n      "event_date_range_s": "4/1",\n      "date": "2006-04-01",\n      "event_end_date": "2006-04-01",\n      "event_id": 22,\n      "event_full_name": "Ice Breaker Criterium",\n      "first_name": "Nick",\n      "last_name": "Skenzick",\n      "name": "Nick Skenzick",\n      "race_name": "Senior Men",\n      "race_full_name": "Ice Breaker Criterium: Senior Men",\n      "team_name": "Hutch\'s-Eugene",\n      "year": 2006,\n      "non_member_result_id": null,\n      "single_event_license": false,\n      "team_member": true\n    },\n    {\n      "id": 119687,\n      "category_id": null,\n      "person_id": 43,\n      "race_id": 6128,\n      "team_id": 90,\n      "age": null,\n      "city": null,\n      "date_of_birth": null,\n      "is_series": null,\n      "license": null,\n      "notes": null,\n      "number": "",\n      "place": "2",\n      "place_in_category": 0,\n      "points": 0,\n      "points_from_place": 0,\n      "points_bonus_penalty": 0,\n      "points_total": 0,\n      "state": null,\n      "status": null,\n      "time": 0,\n      "time_bonus_penalty": null,\n      "time_gap_to_leader": null,\n      "time_gap_to_previous": null,\n      "time_gap_to_winner": null,\n      "created_at": "2006-04-02T01:26:40.000-08:00",\n      "updated_at": "2010-09-29T03:08:20.000-07:00",\n      "time_total": null,\n      "laps": null,\n      "members_only_place": null,\n      "points_bonus": 0,\n      "points_penalty": 0,\n      "preliminary": null,\n      "bar": true,\n      "gender": null,\n      "category_class": null,\n      "age_group": null,\n      "custom_attributes": {},\n      "competition_result": false,\n      "team_competition_result": false,\n      "category_name": null,\n      "event_date_range_s": "4/1",\n      "date": "2006-04-01",\n      "event_end_date": "2006-04-01",\n      "event_id": 22,\n      "event_full_name": "Ice Breaker Criterium",\n      "first_name": "Mikkel",\n      "last_name": "Bossen",\n      "name": "Mikkel Bossen",\n      "race_name": "Senior Men",\n      "race_full_name": "Ice Breaker Criterium: Senior Men",\n      "team_name": "CMG Racing/Alpine Mortgage",\n      "year": 2006,\n      "non_member_result_id": null,\n      "single_event_license": false,\n      "team_member": false\n    },\n    {\n      "id": 119688,\n      "category_id": null,\n      "person_id": 5993,\n      "race_id": 6128,\n      "team_id": 6977,\n      "age": null,\n      "city": null,\n      "date_of_birth": null,\n      "is_series": null,\n      "license": null,\n      "notes": null,\n      "number": "",\n      "place": "3",\n      "place_in_category": 0,\n      "points": 0,\n      "points_from_place": 0,\n      "points_bonus_penalty": 0,\n      "points_total": 0,\n      "state": null,\n      "status": null,\n      "time": 0,\n      "time_bonus_penalty": null,\n      "time_gap_to_leader": null,\n      "time_gap_to_previous": null,\n      "time_gap_to_winner": null,\n      "created_at": "2006-04-02T01:26:40.000-08:00",\n      "updated_at": "2014-11-24T18:08:28.000-08:00",\n      "time_total": null,\n      "laps": null,\n      "members_only_place": null,\n      "points_bonus": 0,\n      "points_penalty": 0,\n      "preliminary": null,\n      "bar": true,\n      "gender": null,\n      "category_class": null,\n      "age_group": null,\n      "custom_attributes": {},\n      "competition_result": false,\n      "team_competition_result": false,\n      "category_name": null,\n      "event_date_range_s": "4/1",\n      "date": "2006-04-01",\n      "event_end_date": "2006-04-01",\n      "event_id": 22,\n      "event_full_name": "Ice Breaker Criterium",\n      "first_name": "Aaron",\n      "last_name": "Tuckerman",\n      "name": "Aaron Tuckerman",\n      "race_name": "Senior Men",\n      "race_full_name": "Ice Breaker Criterium: Senior Men",\n      "team_name": "Rubicon-ORBEA Benefiting the Lance Armstrong Foundation",\n      "year": 2006,\n      "non_member_result_id": null,\n      "single_event_license": false,\n      "team_member": false\n    }  ]';
}

app.get('/events/0/results.json', function (req, res) {
  res.send(json());
});

module.exports.app = app;