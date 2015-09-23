#! /usr/bin/env ruby

# Ruby script to assist with opening GitHub Pull Requests

# HOWTO:
# `alias gcr='~/path/to/git-code-review.rb'`
# `gcr h` to code review against the latest hotfix branch
# `gcr r` to code review against the latest release branch
# `gcr` to code review against master branch

def latest_branch(prefix)
  # Sample output:
  # |  origin/master
  # |  origin/release/20150921
  # |  origin/release/20150922
  `git branch -r`.split("\n")
                 .reverse
                 .find { |branch| branch =~ /#{ prefix }/ }[9..-1]
end

def target
  case ARGV.first
  when 'r' then latest_branch('release')
  else 'master'
  end
end

def source
  # Sample output:
  # |On branch master
  # |nothing to commit, working directory clean
  `git status`.split("\n").first[10..-1]
end

def url
  "https://github.com/apartmentlist/web/compare/#{ target }...#{ source }"
end

`open #{ url }`
