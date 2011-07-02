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
    <p>My first Genit site.</p>

### Add A New Html Page

Create a new file in the pages/ folder and name it 'help.html'.
Copy/paste the following code in that file:

    <h1>Help Page</h1>


### Add A New Markdown Page

You can use markdown too to write your page content. Create a new file in
the pages/ folder and name it 'hello.markdown'. Copy/paste the following
markdown in that file:

    I Say Hello
    ===========
    
### Edit The Menu Template

In the templates/ folder there is a 'menu.html' file. Open it in your editor.
Edit this file as follow to add a list element to the menu:

    <ul id="menu">
          <li><a href="index.html">home</a></li>
          <li><a href="hello.html">hello</a></li>
          <li><a href="help.html">help</a></li>
    </ul>

Compile your project
--------------------

    genit compile

Then go to the www/ folder and open the index.html with your browser.

Styling your site
-----------------

Edit the styles/screen.css file as follow:

    a#selected { color:red; }

Recompile your project with:

    genit compile
    
or its shortcut:

    genit cc

and reopen the index.html with your browser to see what's changed.
