# crawler
#A platform auto save as images from other website using ruby on rails

#How to use it ?

Copy `data.rake` file to `lib/task` inside your Rails project.

Open terminal and run :

`cd your-project`

At my `data.rake` file . I have `xkcn` method crawler data from `http://xkcn.info/` website. So, I will run:

`bundle exec rake data:xkcn`

You can write your function using with `get_doc` method.

All data wil export with `images.txt` file at root folder of your project.

