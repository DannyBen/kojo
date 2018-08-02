<div align='center'>

![kojo](images/kojo.png)

Kojo - Configuration Ninja
==================================================

[![Gem Version](https://badge.fury.io/rb/kojo.svg)](https://badge.fury.io/rb/kojo)
[![Build Status](https://travis-ci.com/DannyBen/kojo.svg?branch=master)](https://travis-ci.com/DannyBen/kojo)
[![Maintainability](https://api.codeclimate.com/v1/badges/f24566ad04b5054a2251/maintainability)](https://codeclimate.com/github/DannyBen/kojo/maintainability)


Kojo helps you generate configuration files from templates, using variables 
and definition files.  
It is a command line utility, and it works on any text file format.

</div>

---

Installation
--------------------------------------------------

    $ gem install kojo


Examples
--------------------------------------------------

See the [examples](examples) folder.


Usage
--------------------------------------------------

### Variables

![kojo](images/features-vars.svg)

Include variables in your configuration templates using this syntax:

```ruby
%{varname}
```

Variables can be provided through the command line, or when using `@import`.


### Import

![kojo](images/features-import.svg)

Use the `@import filename` directive anywhere to include another file in the
resulting configuration file.

- The `@import` directive should be the only thing in the line.
- The indentation will be respected when importing.
- The `filename` parameter does not have to include an extension - Kojo will
  use the same extension as the parent file.
- Arguments can be passed down to the included template by using this syntax:

```ruby
@import filename (arg: "value", arg2: "value")
```

The space after `filename` is optional.


### One to Many Generation

![kojo](images/features-config.svg)

In order to generate several configuration files that are based on the same 
template, you should:

1. Create the configuration template, using `%{variables}` and `@imports` 
   where appropriate.
2. Create a configuration YAML file using this syntax:

```yaml
input: base-template.yml

output:
  outfile1.yml:
    argument1: value
    argument2: value

  outfile2.yml:
    argument1: value
    argument2: value
```