yaml-cv
[![ ](https://api.travis-ci.com/gmantaos/yaml-cv.svg?branch=master) ](https://travis-ci.com/gmantaos/yaml-cv)
[![ ](https://img.shields.io/gem/v/yaml-cv.svg)](https://rubygems.org/gems/yaml-cv)
[![ ](https://img.shields.io/gem/dt/yaml-cv.svg)](https://rubygems.org/gems/yaml-cv)
[![ ](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
=====================

Static CV generator from a YAML file, in HTML or PDF format.

[Demo](https://gmantaos.github.io/yaml-cv/)

<h1 align="center">
  <img src="examples/demo.png">
</h1>

## Installation

```shell
$ gem install yaml-cv
```

**Disclaimer:** On versions `0.1` PDF generation will be a little rough, since I implemented the release system before getting around to that.

## Usage

The CV can be drawn-out in a yaml file, similar to the one shown below.

```yml
details:
  first_name: John
  last_name: Doe

  title: Placeholder Engineer

profile: Personal description.

contact:
- text: johndoe@example.com
  url: mailto:johndoe@example.com
  icon: email

technical:
  - category: Languages
    items: C, C++, C#, HTML
  - category: Frameworks
    items: Node.js, React.js, Bootstrap
```

For more, there is the [examples folder](examples).

By default, the output will be printed to stdout in HTML format.

```shell
$ yaml-cv my_cv.yml
<html>
<head>
    <title> Doe John - Public Figure </title>

    <style>
...
```

To save to a file, use one or both of the `--html` and `--pdf` arguments, while specifying the output file to write to.

```shell
$ yaml-cv my_cv.yml --html my_cv.html
```

```shell
$ yaml-cv my_cv.yml --pdf my_cv.pdf
```

The `--watch` option can also be used to watch the input file for changes and automatically regenerate the output.

```shell
$ yaml-cv my_cv.yml --html my_cv.html --watch
```
