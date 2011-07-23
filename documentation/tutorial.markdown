Genit Tutorial
==============

Create Your Project
-------------------

On the command line, type:

    genit create my-site
    cd my-site

### Edit The Home Page

All pages go to the pages/ folder. Open the index.html in your favorite editor
and modify its content as follow:

    <h1>Welcome to Genit !</h1>
    <p>This is my first Genit site.</p>
    <div id="footer">
        <p>copyrighted by me</p>
    </div>

### Add A New Page

Create a new file in the pages/ folder and name it 'about.html'.
Copy/paste the following code in that file:

    <h1>The About Page</h1>
    <p>This is a page about me.</p>
    <div id="footer">
      <p>copyrighted by me</p>
    </div>
    
### Edit The Menu Template

In the templates/ folder there is a 'menu.html' file. Open it in your editor.
Edit this file as follow:

    <ul id="menu">
      <li><a href="index.html">home</a></li>
      <li><a href="about.html">about</a></li>
    </ul>

Compile your project
--------------------

Now you have to 'compile' your site before seeing the result.

    genit compile

There is a shortcut for this command:

    genit cc

Then go to the www/ folder and open the index.html with your browser.
Congratulations ! You have made your first project using genit.


Refactor your project
----------------------

The two pages (index.html and about.html) have the same structure. Especially the footer
section are identical. Let's refactor that.

Create a file named 'footer.html' in the fragments/ folder and copy paste this code into it:

    <div id="footer">
      <p>copyrighted by me</p>
    </div>

Now edit the page index.html as follow:

    <h1>Welcome to Genit !</h1>
    <p>This is my first Genit site.</p>
    <genit class="fragment" file="footer.html"/>

Do the same thing with the page about.html:

    <h1>The About Page</h1>
    <p>This is a page about me.</p>
    <genit class="fragment" file="footer.html"/>

Now, recompile your site with:

    genit cc

and go to the www/ folder then open the index.html with your browser.


Using Markdown
--------------

If a part a page doesn't need to use html tag attributes (id an class), markdown syntax is
much cleaner than html syntax. Why not using markdown ?

Edit the index.html page as follow:

    `<genit class="fragment" file="index_content.markdown"/>`
    <genit class="fragment" file="footer.html"/>

Then add this `index_content.markdown` file in the fragments/ folder:

    Welcome to Genit !  
    ==================
    
    This is my first Genit site.
    
    I'm using HTML and markdown !

Now recompile your project with `genit cc` before being able to view the change.


Styling your site
-----------------

Edit the styles/screen.css file as follow:

    a#selected { color:red; }

Recompile your project with:

    genit compile
    
or its shortcut:

    genit cc

and reopen the index.html with your browser to see what's changed.
