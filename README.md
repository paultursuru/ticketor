# Work in progress

## Ticketor : ticket app manager
This app lets you handle tickets when teaching

* students can sign up/sign in
* students can create and cancel their own tickets
* students can send homeworks at the end of class
* teachers can resolve tickets
* teachers can see details about the teaching day
* teachers can grade students homeworks and export all grades into a csv


### To Do :
* the app was made with only one teacher for many students => tickets should be a attributed to a specific teacher (when there is more)
* main teacher should be able to turn users to `.assistant!`
* teacher should be able to post documentation for students


## Stack
* Rails 7 | turbo
* tailwindCSS
* importmaps

## Want to use ?
* `git clone`
* `bundle install`
* `npm install`
* `rails db:create && db:migrate`
* serve from your machine with `ngrok` or deploy wherever you prefer
