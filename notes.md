```
jamie@MacBook-Pro-4 organizer % stack new organizer
Downloading template new-template to create project organizer in directory organizer/...
Downloaded /Users/jamie/.stack/templates/new-template.hsfiles.               

Note: The following parameters were needed by the template but not provided: author-email, author-name, category, copyright and github-username.
      
      You can provide them in Stack's global YAML configuration file (/Users/jamie/.stack/config.yaml) like this:
      
      templates:
        params:
          author-email: value
          author-name: value
          category: value
          copyright: value
          github-username: value
      
      Or you can pass each one on the command line as parameters like this:
      
      stack new organizer new-template -p "author-email:value" -p "author-name:value" -p "category:value" -p "copyright:value" -p "github-username:value"
      
Looking for Cabal or package.yaml files to use to initialise Stack's project-level YAML configuration file.

Using the Cabal packages:
* organizer/

Selecting the best among 21 snapshots...

Could not find local global hints for ghc-9.6.5, forcing a redownload

Note: Matches https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/22/23.yaml
      
Selected the snapshot https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/22/23.yaml.
Initialising Stack's project-level YAML configuration file using snapshot
https://raw.githubusercontent.com/commercialhaskell/stackage-snapshots/master/lts/22/23.yaml.
Considered 1 user package.
Writing configuration to organizer/stack.yaml.
Stack's project-level YAML configuration file has been initialised.
```