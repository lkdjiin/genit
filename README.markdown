Genit
================

Genit génère un site web statique, c'est à dire sans langage de programmation ni BDD coté serveur.
Le site est uniquement composé de code xhtml (+ css et médias) et eventuellement de javascript.

Le projet est en phase d'analyse, il n'y a pas de code à voir pour l'instant.

Description
-----------

C'est un framework en ligne de commande, essentiellement basé sur des conventions.

Genit doit être avant tout :

  + simple
  + lisible
  + minimaliste

Genit produit des sites xhtml uniquement.

Il ne faut pas avoir à apprendre de nouveaux langages, ou de nouveaux tag pour les templates,
on doit réussir à s'en sortir avec un langage qu'on connait déja tous : le xml.
Par exemple, pour génerer le code html comprenant les 4 dernières news :

    <generate class="news" number="4" />

Et plus simplement, pour générer le footer :

    <generate class="footer" />

Objectifs de base
----------------

Au minimum, Genit doit permettre de :

  + inclure les sections typiques tel que :
    - header
    - footer
    - sitemap
    - menu (avec code css pour :hover)
  + générer le flux RSS (comprenant toutes les news, ou seulement un certains nombre)
  + générer une section de news (toutes ou un certain nombre)
  + inclure des fichiers css différents par fichier html
  + inclure des scripts différents par fichier html
  + générer des <meta> différents par fichier html (title, keywords, etc.)

Mise en oeuvre
--------------

### Créer le projet

On utilse la commande suivante :

    genit create mon-site
    cd mon-site

#### Structure du projet

    mon-site/
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
        index.html
      www/

#### Le dossier news

Pour inclure les X dernières news :

    <genit class"news" number="5" />

Sans l'attribut number, on inclut toutes les news.

Les news sont repérées par le nom du fichier, qui est la date. Je sais que cela
ne permet qu'une seule news par jour, mais pour un site web statique, je ne vois
pas le problème.

#### Le dossier pages

Toutes les pages du site sont dans ce dossier pages. Écrits en .html ou en .markdown.
Les pages peuvent contenir d'autres pages.

    <reflexion>
    Pour inclure une page dans une page, on pourrait avoir un dossier "subpages" et
    utiliser une ligne du genre : <genit class="subpage" file="foo.html" />
    </refexion>



#### Le dossier scripts

Tout le javascript va ici. Je pense inclure par défaut prototype et scriptaculous.

Pour inclure un script dans la balise <head></head> d'une page particulière on
écrit dans cette page (n'importe où mais c'est plus lisible au début) :

    <genit class="script" file="foo.js" />


#### Le dossier styles

Tout ce qui est en rapport avec le design du site va ici.

Pour inclure un css dans la balise <head></head> d'une page particulière on
écrit dans cette page (n'importe où mais c'est plus lisible au début) :

    <genit class="css" file="foo.css" />

#### Le dossier templates

Les templates généraux vont dans le dossier templates. Écrits seulement en .html.
Pour l'instant il n'y a qu'un seul template.

Pour préciser le point d'inclusion des pages dans le template :

    <genit class="pages" />

Certaines sections se retrouvent sur l'immense majorité des sites : header, footer,
menu principal (qui peut-être en haut, à droite, à gauche), reprise du menu en bas,
coté gauche, coté droit et sitemap. Pour inclure ces sections on utilisera :

    <genit class="header" />
    <genit class="footer" />
    etc.

#### Le dossier www

C'est ici que le projet "compilé" atterrira.

TODO il serait peut-être bien d'voir une option pour changer ce nom de dossier ?

### Compiler le projet

La commande suivante va générer le site web dans le dossier www :

    genit compile

La commande suivante est une abréviation :

    genit cc

L'option --minimze permet de diminuer la taille des fichiers :

    genit compile --minimize

License
-------

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
