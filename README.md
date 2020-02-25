# JumpSpark

[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Gnu-bash-logo.svg/120px-Gnu-bash-logo.svg.png)]
[![N|Solid](https://cyberboy.in/Innovo%20-%20Innovative%20Parallax%20Coming%20Soon%20Template_files/logo.png)](https://cyberboy.in)

JumpSpark is a shell script which automates first time deployment of Django project on a Linux server via a git repo.


# New Features!

  - Import a Django project from git repo.
  - Installation of all dependency is taken care by JumpSpark


### Tech

JumpSpark uses a number of tools to work properly:

* [BASH] - Yes, we are a bash script
* [Git] - We need this to pull project from repo
* [Apache2] - We use apache2 webserver how server http request
* [Python] - yes, python3 is our favourite

And of course JumpSpark itself is open source with a public repository on GitHub.

### Usage

Download JumpSpark script and get started.

```sh
$ wget https://raw.githubusercontent.com/theflyingmachine/JumpSpark/master/JumpSpark.sh
$ chmod 755 JumpSpark.sh
$ ./JumpSpark.sh
```

Answer few questions...

```sh
Git Repo: <repo url>
Project Name: <project name>
Site Name: <site name>
Requirements.txt File Name: <Requirement file>
Installation App Directory: <location to install>
```

And we're done...

```sh
=====================================================
   Your Django Application is sucessfully Deployed   
                 Made with <3 by Eric                	
=====================================================
```

### Development

Want to contribute? Great! Feel free to contriburte to JumpSpark for the greater good.

### Todos

 - Generate SSL conf
 - Support httpd and nginx webservers

License
----

MIT


**Free Software, Hell Yeah!**
