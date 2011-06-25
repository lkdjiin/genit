Project guidelines
==================

Basic objectives
----------------

At a minimum, Genit should allow to do this :

  + include typical sections:
    - header
    - footer
    - sitemap
    - menu
  + generate the RSS feed (with all news, or only a certain number)
  + generate news section (with all news, or only a certain number)
  + include different css files per page
  + include different script files per page
  + generate different <meta> per page (title, keywords, etc.)

Implementation
--------------

### Create a project

We use the following command line :

    genit create mmy-site
    cd my-site

#### Project structure

    my-site/
      news/
        2011-06-19.markdown
      pages/
        index.markdown
      scripts/
      styles/
        css/
          alsa/
            all.css
          yui/
            reset.css
        handheld.css
        print.css
        screen.css
        images/
      templates/
        main.html
      www/

#### News folder

To include the X latest news:

    <genit class"news" number="5" />

Without number attribute, we include all news.

The news are marked with the file name, which is the date. 
I know it allows only one daily news, but for a static web site, I see
no problem.

#### Pages folder

All site pages are in this folder. Written in .html or .markdown.
Pages could include subpages.

    <reflexion>
    Pour inclure une page dans une page, on pourrait avoir un dossier "subpages" et
    utiliser une ligne du genre : <genit class="subpage" file="foo.html" />
    </refexion>



#### Scripts folder

I think to include prototype and scriptaculous by default.

To include a script in the `<head></head>` tag of a particular page,
we can write (anywhere in the page but it's more readable at the beginning):

    <genit class="script" file="foo.js" />


#### Styles folder

Everything that is related to the design of the site goes here.

To include a particular css file in the `<head></head>` tag of a particular page,
we can write (anywhere in the page but it's more readable at the beginning):

    <genit class="css" file="foo.css" />

#### Templates folder

Only written in .html.
For now, there is only one template.

To include a page in the template:

    <genit class="pages" />

Some sections are found on the vast majority of web sites : header, footer,
main menu, bottom menu, left side, right side and sitemap. To include those
sections we'll write

    <genit class="header" />
    <genit class="footer" />
    etc.

#### www folder

The "compiled" project will go here.

TODO il serait peut-être bien d'avoir une option pour changer ce nom de dossier ?

### Compiling the project

The following command will generate the web site in the www folder:

    genit compile

A shortcut:

    genit cc

The --minimize option minimize the size of the file, good for production phase:

    genit compile --minimize
