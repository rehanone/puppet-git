# rehan-git

[![Puppet Forge](http://img.shields.io/puppetforge/v/rehan/git.svg)](https://forge.puppetlabs.com/rehan/git) [![Build Status](https://travis-ci.com/rehanone/puppet-git.svg?branch=master)](https://travis-ci.com/rehanone/puppet-git)

#### Table of Contents
1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
    * [Classes](#classes)
    * [Referances](#referances)
5. [Dependencies](#dependencies)
6. [Development](#development)

## Overview
The `rehan-git` module manages the Git, the distributed revision control system.

## Module Description
A puppet module for managing the installation and configuration of git so that it is available to be used by
`puppetlabs-vcsrepo` module. This module installs and configures the git package and allows configuration of user 
specific git settings.

Where possible, this module can be used to ensure the git installation is up to date with latest upstream release of git.
Currently, this feature is supported for the following OSes:

  - Ubuntu (using [ppa:git-core/ppa](https://launchpad.net/~git-core/+archive/ubuntu/ppa "ppa:git-core/ppa") )

#### Implemented Features:
* Installs git from packages
* Optionally installs package from upstream git sources (only on Ubuntu using ppa).
* Initialising user accounts with git configurations.

#### Features not yet updated
* Configure system wide git configurations

## Setup
In order to install `rehan-git`, run the following command:
```bash
$ puppet module install rehan-git
```
The module does expect all the data to be provided through 'Hiera'. See [Usage](#usage) for examples on how to configure it.

#### Requirements
This module is designed to be as clean and complient with latest puppet code guidelines.

## Usage

### Classes

#### `git`

A basic install with the defaults would be:
```puppet
include git
```

Otherwise using the parameters:  
```puppet
  class{ 'git':
    sources_manage  => true,
    sources_repo    => 'ppa:git-core/ppa',
    sources_ensure  => present,
    package_ensure  => latest,
    package_name    => 'git',
  }
```

##### Parameters

* **sources_manage**: Controls the upstream source management feature. The default is `false`.
* **sources_repo**: Defines the upstream source repository. The default value is OS dependent.
* **sources_ensure**: Sets the ensure parameter passed to the upstream source repo repository. The default is `present`.
* **package_ensure**: Sets the ensure parameter passed to the package. The default is `latest`.
* **package_ensure**: Provides the package name to be installed. The default is `git`.
* **users**: A hash of git user profiles, see `git:user` for more details.


All of this data can be provided through `Hiera`. 

**YAML**
```yaml
git::sources_manage: true
git::sources_repo: 'ppa:git-core/ppa'
git::sources_ensure: present
git::package_ensure: latest
git::package_name: 'git'
git::users:
  alice:
    user_email: 'alice@xyz.com'
    user_name: 'Alice Alic'
  bob:
    user_email: 'bob@test.com'
    user_name: 'Bob Builder'
    gitconfig:
      color:
         ui: true
      push:
         default: simple
      pull:
         ff: only
      fetch:
         prune: true
```

### Resources

#### `git::user`

This defined type is used to set the per user .gitconfig file. It includes the users' name and email.
The username should be a valid user account that has been managed by Puppet.
The gitconfig sections is a hash of values that go in the users' .gitconfig file. See [git-scm](https://git-scm.com/docs/git-config) for details.

Usage:
```puppet
git::user{'alice':
 user_name  => 'Alice Alic',
 user_email => 'alice@xyz.com',
 gitconfig => {
    'color' => {
       'ui' => true,
    },
    'push' => {
       'default' => 'simple',
    },
    'pull' => {
       'ff' => 'only',
    },
    'fetch' => {
       'prune' => true,
    },
  }
}
```

##### Parameters

* *ensure* could be set to `present` or `absent`, the default is `present`.
* *user_name* sets the user's name to the specified string.
* *user_email* sets the user's email address to the specified string.
* *gitconfig* A hash of values that go in .gitconfig file of the user., the default is as shown in the example above.

## Dependencies

* [stdlib][1]
* [apt][2]

[1]:https://forge.puppet.com/puppetlabs/stdlib
[2]:https://forge.puppet.com/puppetlabs/apt

## Development

You can submit pull requests and create issues through the official page of this module on [GitHub](https://github.com/rehan/puppet-git).
Please do report any bug and suggest new features/improvements.
