#Instructions on how to install and use Sass for Bundles

###Installing Sass
Before we can compose Sass we need to install it. Sass is built upon Ruby. If you are working on a Mac, chances are, you already have Ruby installed. If you need to install Ruby in Windows, use this [Ruby Installer](http://rubyinstaller.org/).

After the installation is complete, you can go to Terminal (on a Mac) or in Command Prompt (on Windows) then type the following command line in it:

On Mac;

```
sudo gem install sass
```
On Windows;
```
gem install sass
```
###Bundle Sass file
If the installation succeeds, we need to select master.scss for Sass to compile using the following command;

```
sass  --sourcemap=none master.scss:../master.css
```
This bundle's master.scss contains many components that style the bundle. These contain style blocks that are imported into the master.scss file. You may comment these components out if you are not using them in the master.scss file.

####Sourcemapping
Sass 3.4 by default creates a sourcemap file. This allow you to see the original source (the Sass) in a modern browser instead of the compiled CSS while debugging.

To enable the source.map, use this command line argument:

```
sass master.scss:../master.css
```
###More information on Sass
To select which directory for Sass to watch using the following command;

```
sass --watch path/sass-directory
```

The command line above will watch every .scss/.sass files in path/directory and whenever one of the files in that directory is changed, Sass will update the corresponding files or create one if none exists.

If we need Sass to generate the files in a specific directory, we can do it this way;

```
sass --watch path/sass-directory:path/css-directory
```
We can also watch a specific file rather than the directory, with this command line;

```
sass --watch path/sass-directory/styles.css
```
If the watch command succeeds, your Terminal/Command Prompt with display success.

### Online tools
 * [CSS 2 SASS/SCSS CONVERTER](http://css2sass.herokuapp.com) Paste your css code and convert
 * [Sassmeister](http://www.sassmeister.com) Sass playground

###Links
 * [Sass](http://www.sass-lang.com/) CSS with superpowers
 * [Sache](http://www.sache.in/) Discover Sass Extensions