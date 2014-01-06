# new
Opinionated Project Creation

##### Usage
```shell
gem install new
new init
new [TEMPLATE] [NAME]
```

##### Templates
* `js`

##### Custom Templates
Copy or create folders in your `~/.new/templates` folder.

_These templates will take precendence over the default templates included with the gem._

###### Interpolation
Use ERB template syntax in your files to interpolate template data.  Make sure to add `.erb` to the end of the filename.

You can also access any custom values set in your `~/.new` config file.

_`foo.txt.erb`_
```erb
<%= license %>
<%= github.username %>
<%= developer.name %>
<%= developer.email %>
<%= type %>
<%= project_name %>
<%= custom %>
```


You can also interpolate directory and filenames using the syntax `foo_[DEVELOPER.NAME].txt`

_Notice that you can access nested values using the dot notation._

##### TODO
* common rake tasks (eg push to github)
* rake tasks per template type (eg gem: publish to rubygems)

##### Contributing
1. Fork it ( http://github.com/brewster1134/new/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
