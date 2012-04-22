# CodeCampo

It's the source of http://codecampo.com , a light weight bbs for developer.

## Dependency

* ruby 1.9.3
* rails 3.1
* mongodb 1.8+

## Set Dev and Test Environments

vim ~/.bashrc

    export cc_admin_emails=hoooopo@gmail.com,hooopo@gmail.com
    export cc_secret_token=55eae02566fdd7adb439b51e241b9229d5d9dd11a415b2590825b9ba243ea2ca391b1723f386834793cf60967a9262b9216bbb4881cae86dbf9ce5823e3b5d11
    export cc_google_custom_search_id=xxx
    export cc_test_uri=mongodb://localhost/code_campo_test
    export cc_development_uri=mongodb://localhost/code_campo
    export cc_site_name=Rubylution

## Set Production Environments

    heroku config:add cc_admin_emails=hoooopo@gmail.com,hooopo@gmail.com
    heroku config:add cc_secret_token=55eae02566fdd7adb439b51e241b9229d5d9dd11a415b2590825b9ba243ea2ca391b1723f386834793cf60967a9262b9216bbb4881cae86dbf9ce5823e3b5d11
    heroku config:add cc_google_custom_search_id=xxx
    heroku config:add MONGOHQ_URL=mongodb://<user>:<password>@flame.mongohq.com:<port>/<database>
    heroku config:add cc_site_name=Rubylution

## Setup

    git clone git://github.com/hooopo/code_campo.git
    cd code_campo
    bundle install
    rake db:seed
    rails s thin

deploy to Heroku

    heroku create app_name --stack cedar
    set heroku env
    git push heroku master
