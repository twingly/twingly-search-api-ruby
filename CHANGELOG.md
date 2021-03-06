# Changelog

## [v5.3.1](https://github.com/twingly/twingly-search-api-ruby/tree/v5.3.1) (2021-02-03)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.3.0...v5.3.1)

**Implemented enhancements:**

- Make Travis test gem installation [\#63](https://github.com/twingly/twingly-search-api-ruby/issues/63)

**Merged pull requests:**

- Allow newer versions of Faraday [\#93](https://github.com/twingly/twingly-search-api-ruby/pull/93) ([Pontus4](https://github.com/Pontus4))
- Run tests on GitHub Actions [\#92](https://github.com/twingly/twingly-search-api-ruby/pull/92) ([walro](https://github.com/walro))
- Test with latest Ruby/JRuby versions and drop support for Ruby 2.4 [\#91](https://github.com/twingly/twingly-search-api-ruby/pull/91) ([roback](https://github.com/roback))
- Bump rake version [\#90](https://github.com/twingly/twingly-search-api-ruby/pull/90) ([walro](https://github.com/walro))
- Newer Ruby on Travis [\#89](https://github.com/twingly/twingly-search-api-ruby/pull/89) ([roback](https://github.com/roback))
- Test gem installation on TravisCI [\#88](https://github.com/twingly/twingly-search-api-ruby/pull/88) ([roback](https://github.com/roback))

## [v5.3.0](https://github.com/twingly/twingly-search-api-ruby/tree/v5.3.0) (2019-04-03)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.2.0...v5.3.0)

**Implemented enhancements:**

- Differentiate between 401 and 402 status codes [\#80](https://github.com/twingly/twingly-search-api-ruby/issues/80)
- Low hanging fruit that would reduce memory consumption [\#75](https://github.com/twingly/twingly-search-api-ruby/issues/75)
- Add fixture for "Invalid language code\(s\)" [\#56](https://github.com/twingly/twingly-search-api-ruby/issues/56)

**Fixed bugs:**

- Inconsistent formating in Result\#inspect [\#79](https://github.com/twingly/twingly-search-api-ruby/issues/79)
- Uninitialized variable warnings [\#76](https://github.com/twingly/twingly-search-api-ruby/issues/76)

**Merged pull requests:**

- Drop support for older Rubies [\#87](https://github.com/twingly/twingly-search-api-ruby/pull/87) ([walro](https://github.com/walro))
- AuthError -\> AuthenticationError/AuthorizationError [\#86](https://github.com/twingly/twingly-search-api-ruby/pull/86) ([jage](https://github.com/jage))
- Travis for modern Rubies [\#85](https://github.com/twingly/twingly-search-api-ruby/pull/85) ([jage](https://github.com/jage))
- Profile for object allocation and pick some fruit [\#84](https://github.com/twingly/twingly-search-api-ruby/pull/84) ([jage](https://github.com/jage))
- Improve Result\#inspect output [\#83](https://github.com/twingly/twingly-search-api-ruby/pull/83) ([jage](https://github.com/jage))
- Initialize variables to avoid warnings [\#82](https://github.com/twingly/twingly-search-api-ruby/pull/82) ([jage](https://github.com/jage))
- Remove deprecated Query\#language usage in example [\#81](https://github.com/twingly/twingly-search-api-ruby/pull/81) ([jage](https://github.com/jage))

## [v5.2.0](https://github.com/twingly/twingly-search-api-ruby/tree/v5.2.0) (2018-05-17)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.1.4...v5.2.0)

**Merged pull requests:**

- Add Post\#to\_h for both LiveFeed and Search [\#77](https://github.com/twingly/twingly-search-api-ruby/pull/77) ([dentarg](https://github.com/dentarg))

## [v5.1.4](https://github.com/twingly/twingly-search-api-ruby/tree/v5.1.4) (2018-02-23)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.1.3...v5.1.4)

**Implemented enhancements:**

- Looser requirement on Faraday [\#70](https://github.com/twingly/twingly-search-api-ruby/issues/70)

**Fixed bugs:**

- Update yard gem dependency [\#72](https://github.com/twingly/twingly-search-api-ruby/issues/72)

**Merged pull requests:**

- Looser requirements on Faraday [\#74](https://github.com/twingly/twingly-search-api-ruby/pull/74) ([jage](https://github.com/jage))
- Test with latest Ruby versions [\#73](https://github.com/twingly/twingly-search-api-ruby/pull/73) ([dentarg](https://github.com/dentarg))
- Test with latest rubies, support Ruby 2.4 and JRuby 9.1 [\#71](https://github.com/twingly/twingly-search-api-ruby/pull/71) ([walro](https://github.com/walro))

## [v5.1.3](https://github.com/twingly/twingly-search-api-ruby/tree/v5.1.3) (2017-10-16)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.1.2...v5.1.3)

**Merged pull requests:**

- Revert "Include timezone info for timestamps in search query" [\#69](https://github.com/twingly/twingly-search-api-ruby/pull/69) ([walro](https://github.com/walro))

## [v5.1.2](https://github.com/twingly/twingly-search-api-ruby/tree/v5.1.2) (2017-05-29)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.1.1...v5.1.2)

## [v5.1.1](https://github.com/twingly/twingly-search-api-ruby/tree/v5.1.1) (2017-05-17)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.1.0...v5.1.1)

**Merged pull requests:**

- Include timezone info for timestamps in search query [\#67](https://github.com/twingly/twingly-search-api-ruby/pull/67) ([roback](https://github.com/roback))

## [v5.1.0](https://github.com/twingly/twingly-search-api-ruby/tree/v5.1.0) (2017-05-09)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.0.1...v5.1.0)

**Fixed bugs:**

- Ruby 1.9.3 and Ruby 2.0.0 can't use nokogiri \>= 1.7.0 \(build failures\) [\#61](https://github.com/twingly/twingly-search-api-ruby/issues/61)
- rack-2.0.1 requires ruby version \>= 2.2.2, which is incompatible with the current version [\#58](https://github.com/twingly/twingly-search-api-ruby/issues/58)

**Merged pull requests:**

- Update Search client to Search API v3 [\#65](https://github.com/twingly/twingly-search-api-ruby/pull/65) ([roback](https://github.com/roback))
- Add LiveFeed v5 client [\#64](https://github.com/twingly/twingly-search-api-ruby/pull/64) ([roback](https://github.com/roback))
- Drop support for old Ruby versions \(1.9.3 and 2.0.0\) [\#62](https://github.com/twingly/twingly-search-api-ruby/pull/62) ([dentarg](https://github.com/dentarg))
- Add support for post outlinks [\#60](https://github.com/twingly/twingly-search-api-ruby/pull/60) ([dentarg](https://github.com/dentarg))
- Use any rake 11 version [\#59](https://github.com/twingly/twingly-search-api-ruby/pull/59) ([dentarg](https://github.com/dentarg))

## [v5.0.1](https://github.com/twingly/twingly-search-api-ruby/tree/v5.0.1) (2016-03-03)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v5.0.0...v5.0.1)

**Fixed bugs:**

- Not possible to remove start\_time from query [\#53](https://github.com/twingly/twingly-search-api-ruby/issues/53)

**Closed issues:**

- New release [\#48](https://github.com/twingly/twingly-search-api-ruby/issues/48)

**Merged pull requests:**

- Be able to remove start/end time from Query [\#54](https://github.com/twingly/twingly-search-api-ruby/pull/54) ([dentarg](https://github.com/dentarg))
- Actually test what we intend to test [\#52](https://github.com/twingly/twingly-search-api-ruby/pull/52) ([dentarg](https://github.com/dentarg))

## [v5.0.0](https://github.com/twingly/twingly-search-api-ruby/tree/v5.0.0) (2016-02-17)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v4.0.1...v5.0.0)

**Implemented enhancements:**

- Use Time all the time [\#50](https://github.com/twingly/twingly-search-api-ruby/issues/50)

**Fixed bugs:**

- Missing require "time" [\#44](https://github.com/twingly/twingly-search-api-ruby/issues/44)
- Query\#start\_time and \#end\_time should be converted to UTC [\#43](https://github.com/twingly/twingly-search-api-ruby/issues/43)

**Merged pull requests:**

- Improve time handling [\#51](https://github.com/twingly/twingly-search-api-ruby/pull/51) ([dentarg](https://github.com/dentarg))
- Improve parser specs [\#49](https://github.com/twingly/twingly-search-api-ruby/pull/49) ([dentarg](https://github.com/dentarg))
- Sync documentation with PHP changes [\#47](https://github.com/twingly/twingly-search-api-ruby/pull/47) ([walro](https://github.com/walro))
- Automatically convert Query\#start\_time and \#end\_time to UTC [\#46](https://github.com/twingly/twingly-search-api-ruby/pull/46) ([roback](https://github.com/roback))
- Use require\_relative [\#45](https://github.com/twingly/twingly-search-api-ruby/pull/45) ([dentarg](https://github.com/dentarg))
- Test Ruby 2.3 on Travis CI [\#42](https://github.com/twingly/twingly-search-api-ruby/pull/42) ([walro](https://github.com/walro))

## [v4.0.1](https://github.com/twingly/twingly-search-api-ruby/tree/v4.0.1) (2016-01-28)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v4.0.0...v4.0.1)

**Merged pull requests:**

- Improve tests [\#38](https://github.com/twingly/twingly-search-api-ruby/pull/38) ([roback](https://github.com/roback))
- Take contenttype into account [\#37](https://github.com/twingly/twingly-search-api-ruby/pull/37) ([walro](https://github.com/walro))

## [v4.0.0](https://github.com/twingly/twingly-search-api-ruby/tree/v4.0.0) (2015-12-02)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/v3.0.0...v4.0.0)

**Implemented enhancements:**

- Add JRuby 9000 to supported Ruby versions [\#27](https://github.com/twingly/twingly-search-api-ruby/issues/27)
- Rename analytics to search [\#21](https://github.com/twingly/twingly-search-api-ruby/issues/21)

**Fixed bugs:**

- Handle non-XML responses from server [\#31](https://github.com/twingly/twingly-search-api-ruby/issues/31)
- Changelog is not generated correctly [\#25](https://github.com/twingly/twingly-search-api-ruby/issues/25)

**Merged pull requests:**

- Example script: Retry on server error [\#35](https://github.com/twingly/twingly-search-api-ruby/pull/35) ([jage](https://github.com/jage))
- Yield self [\#34](https://github.com/twingly/twingly-search-api-ruby/pull/34) ([roback](https://github.com/roback))
- Handle non-XML responses from server [\#33](https://github.com/twingly/twingly-search-api-ruby/pull/33) ([roback](https://github.com/roback))
- Add YARD documentation comments [\#32](https://github.com/twingly/twingly-search-api-ruby/pull/32) ([roback](https://github.com/roback))
- Test with JRuby 9000 on travis [\#30](https://github.com/twingly/twingly-search-api-ruby/pull/30) ([roback](https://github.com/roback))
- Handle exceptions [\#29](https://github.com/twingly/twingly-search-api-ruby/pull/29) ([roback](https://github.com/roback))
- Let client handle api call [\#28](https://github.com/twingly/twingly-search-api-ruby/pull/28) ([roback](https://github.com/roback))
- Cleanup [\#26](https://github.com/twingly/twingly-search-api-ruby/pull/26) ([roback](https://github.com/roback))
- Show deprecation warnings for twingly-analytics [\#23](https://github.com/twingly/twingly-search-api-ruby/pull/23) ([roback](https://github.com/roback))
- Rename analytics to search in readme [\#20](https://github.com/twingly/twingly-search-api-ruby/pull/20) ([roback](https://github.com/roback))

## [v3.0.0](https://github.com/twingly/twingly-search-api-ruby/tree/v3.0.0) (2015-11-20)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/2.0.1...v3.0.0)

**Implemented enhancements:**

- Improve "Development and release" section in README [\#19](https://github.com/twingly/twingly-search-api-ruby/issues/19)

**Merged pull requests:**

- Rename analytics to search [\#24](https://github.com/twingly/twingly-search-api-ruby/pull/24) ([roback](https://github.com/roback))
- Improve "Development and release" section in README [\#22](https://github.com/twingly/twingly-search-api-ruby/pull/22) ([roback](https://github.com/roback))

## [2.0.1](https://github.com/twingly/twingly-search-api-ruby/tree/2.0.1) (2015-09-24)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/2.0.0...2.0.1)

**Fixed bugs:**

- Crash when pattern is empty string [\#17](https://github.com/twingly/twingly-search-api-ruby/issues/17)

**Merged pull requests:**

- Do not allow empty search pattern [\#18](https://github.com/twingly/twingly-search-api-ruby/pull/18) ([twingly-mob](https://github.com/twingly-mob))
- Generate Changelog \(with instructions to update it\) [\#16](https://github.com/twingly/twingly-search-api-ruby/pull/16) ([jage](https://github.com/jage))

## [2.0.0](https://github.com/twingly/twingly-search-api-ruby/tree/2.0.0) (2015-09-14)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/1.0.1...2.0.0)

**Implemented enhancements:**

- Release gem to rubygems.org [\#10](https://github.com/twingly/twingly-search-api-ruby/issues/10)

**Merged pull requests:**

- Improve time pagination \(breaking compatibility for Query\#start\_time and Query\#end\_time\) [\#15](https://github.com/twingly/twingly-search-api-ruby/pull/15) ([jage](https://github.com/jage))

## [1.0.1](https://github.com/twingly/twingly-search-api-ruby/tree/1.0.1) (2015-04-29)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/1.0.0...1.0.1)

**Fixed bugs:**

- Support Ruby 2.2 [\#12](https://github.com/twingly/twingly-search-api-ruby/issues/12)
- HTTPS broke compatibility with Ruby 1.9.3 [\#8](https://github.com/twingly/twingly-search-api-ruby/issues/8)

**Closed issues:**

- Use the rspec-its gem [\#11](https://github.com/twingly/twingly-search-api-ruby/issues/11)

**Merged pull requests:**

- Fix deprecations [\#14](https://github.com/twingly/twingly-search-api-ruby/pull/14) ([walro](https://github.com/walro))
- Support Ruby 2.2 [\#13](https://github.com/twingly/twingly-search-api-ruby/pull/13) ([dentarg](https://github.com/dentarg))
- Use Faraday instead of Net::HTTP directly [\#9](https://github.com/twingly/twingly-search-api-ruby/pull/9) ([jage](https://github.com/jage))

## [1.0.0](https://github.com/twingly/twingly-search-api-ruby/tree/1.0.0) (2014-10-30)

[Full Changelog](https://github.com/twingly/twingly-search-api-ruby/compare/d26d3011f16ce3fea7d8a78079804163dae81d6a...1.0.0)

**Implemented enhancements:**

- Use HTTPS for API access [\#7](https://github.com/twingly/twingly-search-api-ruby/issues/7)
- Remove swedish comment [\#5](https://github.com/twingly/twingly-search-api-ruby/issues/5)
- Rewrite history to remove huge vcr-cassettes [\#4](https://github.com/twingly/twingly-search-api-ruby/issues/4)
- Remove humongous vcr cassettes [\#1](https://github.com/twingly/twingly-search-api-ruby/issues/1)

**Closed issues:**

- Add a LICENSE [\#6](https://github.com/twingly/twingly-search-api-ruby/issues/6)
- Wrap lines at 72 characters [\#2](https://github.com/twingly/twingly-search-api-ruby/issues/2)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
