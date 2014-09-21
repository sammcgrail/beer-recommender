Beer Recommendation Engine

Current Todos:

- figure out efficiency issue with seed uploader
- figure out why only 20k / 100k records are getting uploaded
- add ! to create methods in seeders so if it  fails if create/save doesn't work: "you should try using #create! instead of #create so that you receive an error if the create fails. It's also probably good to use #find_or_create! so that you can run the script multiple times without creating duplicates."

- write user stories

- UI for ratings & reviews
  - user stories & wireframes
  - user finds beer and reviews it
  - after x amount of beers, the recommendation engine is unlocked

- capybara and unit tests

- research algorithms
  - cs problems with optimal algorithms (consider what kinds of filters you would use)
  - apply different algorithms to the same problem and see what kinds of algorithms give you the best results (adapter pattern)

- think about ways to present findings

- refactor parser

Sep 20, 2004
- get db schema down
  - write ActiveRecord models
    - update for validations
  - import data into postgres db

Sep 16, 2004
- parser complete
- er diagram complete

ER Diagram:

![alt tag](er_diagram.png)
