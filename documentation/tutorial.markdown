Genit Tutorial
==============

Create Your Project
-------------------

    genit create my-site
    cd my-site

### Edit The Index

All pages go to the pages/ folder. Open the index.html in your favorite editor
and modify its content as follow:

    <h1>Welcome to Genit !</h1>
    <p>Go to the <a href="hello.html">hello page</a>.</p>

### Add A New Page

You can use markdown to write your page content. Create a new file in
the pages/ folder and name it 'hello.markdown'. Copy/paste the following
markdown in that file:

    I Say Hello
    ===========
    
    Return to [home](index.html)

Compile your project
--------------------

    genit compile

Then go to the www/ folder and open the index.html with your browser.
