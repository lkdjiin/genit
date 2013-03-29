Genit
================

Genit builds a **static web site**, that is a web site without server side programing language
and database. A genit site consists only of xhtml code (+ css, medias and eventually javascript).

Genit is written in Ruby but there is no needs to know the Ruby language.

Description
-----------

It is a command line framework, essentially based on conventions.

Genit must above all be :

  + **simple**
  + **readable**
  + **minimalist**

Genit is based on the idea that *we don't have* to learn any new languages to manage templates
because **xml can do it well**.

For example, to generate the xhtml including the 4 latest news:

    <genit class="news" number="4" />

And more simply, to generate the footer:

    <genit class="footer" />


Install
-------------------------

First install ruby and rubygem (if there are not installed on your system) then:

    gem install genit

All other dependencies will be downloaded and installed automatically.

Usage
--------------------------

    genit create my-site
    cd my-site
    genit compile
    genit server

See the wiki for user documentation and a tutorial.


Dependencies
--------------------------

### Users dependencies

  * ruby >= 1.9.2
  * nokogiri (xml parser)
  * bluecloth (markdown parser)
  * clamp (command line utility)

### Contributors dependencies

  * rspec for tests
  * [tomdoc](http://tomdoc.org/) to document your code


License
--------------------------

Expat License (also known as MIT)

    Copyright (c) 2011 Xavier Nayrac

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Questions and/or Comments
--------------------------

Feel free to email [Xavier Nayrac](mailto:xavier.nayrac@gmail.com)
with any questions.
