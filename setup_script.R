# Use usethis package to create a bunch of things we might need.
# Not all of these things have to be used but I've found them helpful
# in packages I've created so going to be fairly liberal in adding them.
library(usethis)

# Creates package infrastructure
usethis::create_package(here::here())

# Creates a description file that we need to edit
usethis::use_description()
usethis::use_mit_license()

# creates a Rmarkdown readme file and a news.md file
usethis::use_readme_rmd()
usethis::use_news_md()

# Sets up pkgdown so we can create good documentation
usethis::use_pkgdown()

# Sets up testing infrastructure with 'testhat' and codecoverage
usethis::use_testthat()
usethis::use_coverage()

# Allows us to use the Pipe operator without needing to directly reference {magrittr}
usethis::use_package_doc()
usethis::use_pipe(export = FALSE)

# Sets up a code of conduct
usethis::use_code_of_conduct()

# Marks the lifecycle as experimental
usethis::use_lifecycle_badge("experimental")

# Setup a few github related things
usethis::use_github_links()

# Sets up some github actions to run automated testing
usethis::use_github_action_check_standard()
usethis::use_github_actions_badge()
usethis::use_github_action_pr_commands()
usethis::use_github_actions_badge(name = "R-CMD-check")
