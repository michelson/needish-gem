= needish

* FIX (url)

== DESCRIPTION:

This Gems provides basic methods to access the Nedish.com api

== FEATURES/PROBLEMS:

lists the user profile, user friends , needs and helps from a need
sends needs, helps

-todo
search methods
make friends etc..

== SYNOPSIS:

*examples

login to needish
pass to login user and pass AND apikey!! (since 0.0.2)

<pre>login =  Needish::Base.new('miguelmichelson(at)gmail.com','********' ,'apikey2234455566')</pre>

obtain the user logged data

<pre>miguel = login.me</pre>

obtain the user id

<pre>miguel.id</pre>

obtain the user friends

<pre>login.user_friends(miguel.id)</pre>

obtain the needs

<pre>login.user_needs(me.id)</pre>

obtain the needs helps

<pre>login.helps(user_needs(me.id)[0].id)</pre>

Other methods

add need, pass subject and text

<pre>login.add_need('subject','text')</pre>

add help, pass need id and text

<pre>login.add_help(need.id,'text')</pre>

new methods

helped needs
 <pre>	login.helped </pre>

search by tag
<pre>	login.tag("tag") </pre>
 
simple search
<pre>	login.search("term") </pre>


== REQUIREMENTS:

this gem requires hricot, 

sudo gem install hpricot


== INSTALL:

to install this gem simply do :

git clone git://github.com/michelson/needish-gem.git  

cd needish-gem

sudo gem install pkg/needish-0.0.1.gem

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIXME full name

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.