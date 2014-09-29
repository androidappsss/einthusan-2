einthusan
=========

A simple script that scrapes einthusan.com and alerts you of movies that are uploaded. 

To get started:

1.) Set environment variables for email address.

    a.) ENV['EINTHUSAN_LIST'] a comma separated email address used for sending emails to
    b.) ENV['SARATH_ALERTS_EMAIL'] sender email
    c.) ENV['SARATH_ALERTS_PASSWORD']sender email password
    
2.) Set a cron job to the script and you're set!


Question: How to set up environment variables?
Answer: In you bash shell, append 

export SARATH_ALERTS_EMAIL=yourmeail@gmail.com

export SARATH_ALERTS_PASSWORD=yourpassord

export EINTHUSAN_LIST=subscriber1@gmail.com,subscriber2@gmail.com

save the above text and source your shell and that should be it!
