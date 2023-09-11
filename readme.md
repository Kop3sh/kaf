# Task

## High Level Requirements

- [] allows a user to upload an excel having 3 columns [Name , Salary, percentage] and X rows.
- [] User should be able to choose one of the names.
- [] Leading to a visual element (your choice) that consists of the salary and (salary*percentage). feel free to get creative in your visual element display.

This task is preferably done using Django & flutter.


## Backend
- [x] setup postgres
- [x] db schema, models and migrations (NB. decimal values)
- [x] routes
    - [x] post - upload excel file and handling conversion/ serializtion from excel into db
    - [x] get - search for name and get its corresponding salary and percent.
- [x] upload file validation
- [] upload file extension validation
- [x] setup admin panel
- [] env variables
### lower priority
- [] tests
    - [] excel file upload
    - [] reading data

## Frontend
- [] flutter setup
- [] model schema and serialization
- [] UI/UX
    - [] listview for customer data
    - [] single name view, showing salary and percentage data
    - [] basic name search functionality
    - [] upload excel data button
- [] API integration
### Extra
- [] live search functionality
- [] filters/ sorting based on name, salary, percentage data
- [] update/ delete feature