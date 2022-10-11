# Virtual File System API

## Summary

Virtual File System is a web application to help user manage file system.
This application have 2 parts

- GUI for having a better view on file structure, such as user can see which folders or files exist in the current folder
- CLI to help user create, move, remove, list all folders or files just like terminal app (with basic UNIX commands)

## Code Structure

I separate this application into 2 repositories

- [virtual-file-system-api](https://github.com/yorkittran/virtual-file-system-api): running as an API application, handle the request from web application (using Ruby and Ruby on Rails)
- [virtual-file-system](https://github.com/yorkittran/virtual-file-system): running as a web application, to interact with user directly (using VueJS)
- Using GraphQL to provide data from my API application to my web application
- Using Ancestry to organize file system at the database level

## Decision making

Unfortunately, I didn’t have time to spend on this project, so I would like to skip some bonus points (like bonus command, concurrency management, modify file system directly on explorer, ..)

- Realize that this application has to have a CLI, I tried to find some package that help me to implement this as fast as I can, but no any of that is useful, so I have to create a new CLI for my application
- Thinking about having user for this application (user has their own file system), I had to create a basic authentication (basic JWT)
