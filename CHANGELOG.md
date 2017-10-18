# Change Log

## [5.2.0](https://github.com/katello/puppet-pulp/tree/5.2.0)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/5.1.0...5.2.0)

**Closed issues:**

- pulp\_rpmbind resource creation 'succeeds' for repos that don't exist. [\#276](https://github.com/Katello/puppet-pulp/issues/276)

**Merged pull requests:**

- Allow extlib 2.0 [\#282](https://github.com/Katello/puppet-pulp/pull/282) ([ekohl](https://github.com/ekohl))
- Add SSLProtocol configuration for crane [\#281](https://github.com/Katello/puppet-pulp/pull/281) ([ehelms](https://github.com/ehelms))
- Fix bad pulp\_role example in readme.md [\#280](https://github.com/Katello/puppet-pulp/pull/280) ([ccnifo](https://github.com/ccnifo))
- Verify successful bind when creating pulp\_rpmbind [\#279](https://github.com/Katello/puppet-pulp/pull/279) ([alexjfisher](https://github.com/alexjfisher))

## [5.1.0](https://github.com/katello/puppet-pulp/tree/5.1.0) (2017-09-15)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/5.0.0...5.1.0)

**Closed issues:**

- Please make a new Release [\#257](https://github.com/Katello/puppet-pulp/issues/257)
- Manage pulp repositories \(pulp\_repo provider\) [\#179](https://github.com/Katello/puppet-pulp/issues/179)

**Merged pull requests:**

- Explicitly set ssl\_certs\_dir to an empty string [\#275](https://github.com/Katello/puppet-pulp/pull/275) ([ekohl](https://github.com/ekohl))
- crane requires mod wsgi [\#274](https://github.com/Katello/puppet-pulp/pull/274) ([sean797](https://github.com/sean797))
- Fixes \#20865 - correct profiling configuration [\#273](https://github.com/Katello/puppet-pulp/pull/273) ([iNecas](https://github.com/iNecas))
- Add basic provider for Pulp roles [\#234](https://github.com/Katello/puppet-pulp/pull/234) ([ccnifo](https://github.com/ccnifo))

## [5.0.0](https://github.com/katello/puppet-pulp/tree/5.0.0) (2017-08-30)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.3.3...5.0.0)

**Closed issues:**

- EPEL and Pulp repos not deployed [\#164](https://github.com/Katello/puppet-pulp/issues/164)
- Update documentation with all settings available [\#143](https://github.com/Katello/puppet-pulp/issues/143)
- pulp\_schedule broken [\#260](https://github.com/Katello/puppet-pulp/issues/260)
- How to use Pulp - need docs [\#241](https://github.com/Katello/puppet-pulp/issues/241)
- EPEL Dependency [\#247](https://github.com/Katello/puppet-pulp/issues/247)
- unable to add pulp\_rpmrepo \(undefined method `each' for nil:NilClass\) [\#245](https://github.com/Katello/puppet-pulp/issues/245)
- Facts broken with some ruby versions [\#243](https://github.com/Katello/puppet-pulp/issues/243)
- Add pulp\_rpmbind type [\#230](https://github.com/Katello/puppet-pulp/issues/230)
- Service refresh every run ?  [\#223](https://github.com/Katello/puppet-pulp/issues/223)
- katello/puppet-katello using yum\_max\_speed which is not in current puppet-pulp release [\#207](https://github.com/Katello/puppet-pulp/issues/207)
- Authentification issue [\#206](https://github.com/Katello/puppet-pulp/issues/206)
- Idempotent repo creation [\#205](https://github.com/Katello/puppet-pulp/issues/205)
- pulp-admin-client [\#201](https://github.com/Katello/puppet-pulp/issues/201)
- OAuth enabled by default [\#175](https://github.com/Katello/puppet-pulp/issues/175)
- pulp::ssl\_ca\_cert is not defined [\#142](https://github.com/Katello/puppet-pulp/issues/142)
- mongodb\_version not set on first run [\#141](https://github.com/Katello/puppet-pulp/issues/141)
- Wrong parameters in init [\#135](https://github.com/Katello/puppet-pulp/issues/135)
- pulp-nodes-parent is no longer installed by default [\#107](https://github.com/Katello/puppet-pulp/issues/107)
- Machines without the pulp class included still run queries for mongodb version [\#91](https://github.com/Katello/puppet-pulp/issues/91)
- adding nodes support [\#49](https://github.com/Katello/puppet-pulp/issues/49)

**Merged pull requests:**

- Contain pulp::crane if included [\#271](https://github.com/Katello/puppet-pulp/pull/271) ([ekohl](https://github.com/ekohl))
- Allow repository management [\#270](https://github.com/Katello/puppet-pulp/pull/270) ([ekohl](https://github.com/ekohl))
- Add a link to puppetmodule.info [\#269](https://github.com/Katello/puppet-pulp/pull/269) ([ekohl](https://github.com/ekohl))
- Adding Pulp 2.14 changes [\#268](https://github.com/Katello/puppet-pulp/pull/268) ([parthaa](https://github.com/parthaa))
- Allow puppetlabs-mongodb 1.0 [\#267](https://github.com/Katello/puppet-pulp/pull/267) ([ekohl](https://github.com/ekohl))
- Allow newer puppetlabs-concat [\#266](https://github.com/Katello/puppet-pulp/pull/266) ([ekohl](https://github.com/ekohl))
- Allow puppetlabs-apache 2.0 [\#265](https://github.com/Katello/puppet-pulp/pull/265) ([ekohl](https://github.com/ekohl))
- msync: Puppet 5, parallel tests, .erb templates, cleanups, facter fix [\#263](https://github.com/Katello/puppet-pulp/pull/263) ([ekohl](https://github.com/ekohl))
- Remove redundancy in repo\_type definitions [\#262](https://github.com/Katello/puppet-pulp/pull/262) ([ekohl](https://github.com/ekohl))
- Fix pulp\_schedule and add tests [\#261](https://github.com/Katello/puppet-pulp/pull/261) ([ekohl](https://github.com/ekohl))
- Update the README [\#242](https://github.com/Katello/puppet-pulp/pull/242) ([ekohl](https://github.com/ekohl))
- Expand the admin login functionality [\#259](https://github.com/Katello/puppet-pulp/pull/259) ([ekohl](https://github.com/ekohl))
- Allow katello/qpid 2.x [\#258](https://github.com/Katello/puppet-pulp/pull/258) ([ekohl](https://github.com/ekohl))
- Bump qpid dependency [\#256](https://github.com/Katello/puppet-pulp/pull/256) ([ehelms](https://github.com/ehelms))
- Fix tests [\#255](https://github.com/Katello/puppet-pulp/pull/255) ([ekohl](https://github.com/ekohl))
- allow configuration of wsgi\_processes and wsgi\_max\_requests [\#254](https://github.com/Katello/puppet-pulp/pull/254) ([SimonPe](https://github.com/SimonPe))
- Clean up types and providers [\#252](https://github.com/Katello/puppet-pulp/pull/252) ([ekohl](https://github.com/ekohl))
- Disable oauth by default [\#249](https://github.com/Katello/puppet-pulp/pull/249) ([ekohl](https://github.com/ekohl))
- Fixes GH-243 - Ruby 1.8 compatible syntax for facts [\#246](https://github.com/Katello/puppet-pulp/pull/246) ([ccnifo](https://github.com/ccnifo))
- Fix typo in apache manifest [\#244](https://github.com/Katello/puppet-pulp/pull/244) ([johnpmitsch](https://github.com/johnpmitsch))
- Refactor the class inclusions and chaining [\#239](https://github.com/Katello/puppet-pulp/pull/239) ([ekohl](https://github.com/ekohl))
- Use the $pulp::ca\_cert variable rather than hardcoding [\#237](https://github.com/Katello/puppet-pulp/pull/237) ([ekohl](https://github.com/ekohl))
- Add pulp\_consumer\_id fact [\#233](https://github.com/Katello/puppet-pulp/pull/233) ([alexjfisher](https://github.com/alexjfisher))
- Remove mongodb\_version fact [\#232](https://github.com/Katello/puppet-pulp/pull/232) ([alexjfisher](https://github.com/alexjfisher))
- Add pulp\_rpmbind type [\#231](https://github.com/Katello/puppet-pulp/pull/231) ([alexjfisher](https://github.com/alexjfisher))
- Add repo classes [\#229](https://github.com/Katello/puppet-pulp/pull/229) ([ekohl](https://github.com/ekohl))
- Refactor pulp::child and use puppetlabs-apache vhost options [\#227](https://github.com/Katello/puppet-pulp/pull/227) ([ekohl](https://github.com/ekohl))
- Remove EL6 compatiblity code [\#226](https://github.com/Katello/puppet-pulp/pull/226) ([ekohl](https://github.com/ekohl))
- Refactor to Puppet 4 types [\#225](https://github.com/Katello/puppet-pulp/pull/225) ([ekohl](https://github.com/ekohl))
- Use concat 2.2.1 in .fixtures [\#224](https://github.com/Katello/puppet-pulp/pull/224) ([alexjfisher](https://github.com/alexjfisher))
- LDAP authentication support [\#221](https://github.com/Katello/puppet-pulp/pull/221) ([alexjfisher](https://github.com/alexjfisher))
- Include mod\_proxy\_http apache module [\#220](https://github.com/Katello/puppet-pulp/pull/220) ([alexjfisher](https://github.com/alexjfisher))
- Fix repo\_auth parameter [\#219](https://github.com/Katello/puppet-pulp/pull/219) ([alexjfisher](https://github.com/alexjfisher))
- Make SSL checking optional [\#214](https://github.com/Katello/puppet-pulp/pull/214) ([cristifalcas](https://github.com/cristifalcas))

## [4.3.3](https://github.com/katello/puppet-pulp/tree/4.3.3) (2017-10-13)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.3.2...4.3.3)

**Merged pull requests:**

- Fixes \#20865 - correct profiling configuration [\#273](https://github.com/Katello/puppet-pulp/pull/273) ([iNecas](https://github.com/iNecas))
- fixes \#19740 - pulp\_docker.conf schema 2 [\#251](https://github.com/Katello/puppet-pulp/pull/251) ([thomasmckay](https://github.com/thomasmckay))

## [4.3.2](https://github.com/katello/puppet-pulp/tree/4.3.2) (2017-08-28)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.3.1...4.3.2)

**Merged pull requests:**

- Refactor the class inclusions and chaining [\#239](https://github.com/Katello/puppet-pulp/pull/239) ([ekohl](https://github.com/ekohl))

## [4.3.1](https://github.com/katello/puppet-pulp/tree/4.3.1) (2017-07-13)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.3.0...4.3.1)

**Merged pull requests:**

- Run pulp-gen-key-pair to create the rsa key [\#238](https://github.com/Katello/puppet-pulp/pull/238) ([ekohl](https://github.com/ekohl))

## [4.3.0](https://github.com/katello/puppet-pulp/tree/4.3.0) (2017-04-07)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.2.0...4.3.0)

**Merged pull requests:**

- Expand ignore with generated files/directories [\#222](https://github.com/Katello/puppet-pulp/pull/222) ([ekohl](https://github.com/ekohl))
- Modulesync update [\#218](https://github.com/Katello/puppet-pulp/pull/218) ([ekohl](https://github.com/ekohl))
- Remove EL6 from README [\#217](https://github.com/Katello/puppet-pulp/pull/217) ([alexjfisher](https://github.com/alexjfisher))
- Modulesync update [\#213](https://github.com/Katello/puppet-pulp/pull/213) ([ekohl](https://github.com/ekohl))
- fix readme [\#210](https://github.com/Katello/puppet-pulp/pull/210) ([timogoebel](https://github.com/timogoebel))
- broker service may not run on the same node [\#209](https://github.com/Katello/puppet-pulp/pull/209) ([timogoebel](https://github.com/timogoebel))
- Fixes \#17219 - bump squid3 to 1.0.2 [\#208](https://github.com/Katello/puppet-pulp/pull/208) ([Klaas-](https://github.com/Klaas-))
- Remove code to support EL6 [\#202](https://github.com/Katello/puppet-pulp/pull/202) ([ekohl](https://github.com/ekohl))

## [4.2.0](https://github.com/katello/puppet-pulp/tree/4.2.0) (2017-03-10)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.1.0...4.2.0)

**Merged pull requests:**

- Use the correct variable for ca\_cert [\#203](https://github.com/Katello/puppet-pulp/pull/203) ([ekohl](https://github.com/ekohl))
- Fix linting errors [\#198](https://github.com/Katello/puppet-pulp/pull/198) ([ehelms](https://github.com/ehelms))
- Messaging transport version [\#195](https://github.com/Katello/puppet-pulp/pull/195) ([khdevel](https://github.com/khdevel))
- Fixes \#18484 - Enables ostree-importer proxy settings [\#194](https://github.com/Katello/puppet-pulp/pull/194) ([parthaa](https://github.com/parthaa))
- Update modulesync config [\#192](https://github.com/Katello/puppet-pulp/pull/192) ([ekohl](https://github.com/ekohl))
- Fixes \#16253 - Add max speed var to Katello [\#189](https://github.com/Katello/puppet-pulp/pull/189) ([chris1984](https://github.com/chris1984))
- Refs \#17298 - Add max tasks per Pulp worker [\#173](https://github.com/Katello/puppet-pulp/pull/173) ([mbacovsky](https://github.com/mbacovsky))

## [4.1.0](https://github.com/katello/puppet-pulp/tree/4.1.0) (2017-01-24)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/4.0.0...4.1.0)

**Merged pull requests:**

- update documentation with examples of providers [\#188](https://github.com/Katello/puppet-pulp/pull/188) ([cristifalcas](https://github.com/cristifalcas))
- add an schedule provider [\#187](https://github.com/Katello/puppet-pulp/pull/187) ([cristifalcas](https://github.com/cristifalcas))
- add the posibility to install katello\_agent [\#186](https://github.com/Katello/puppet-pulp/pull/186) ([cristifalcas](https://github.com/cristifalcas))
- add an rpm provider [\#185](https://github.com/Katello/puppet-pulp/pull/185) ([cristifalcas](https://github.com/cristifalcas))
- add an puppet provider [\#184](https://github.com/Katello/puppet-pulp/pull/184) ([cristifalcas](https://github.com/cristifalcas))
- add an iso provider [\#183](https://github.com/Katello/puppet-pulp/pull/183) ([cristifalcas](https://github.com/cristifalcas))

## [4.0.0](https://github.com/katello/puppet-pulp/tree/4.0.0) (2016-12-20)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.5.0...4.0.0)

**Closed issues:**

- show\_diff on /etc/pulp/server.conf show passwords [\#171](https://github.com/Katello/puppet-pulp/issues/171)

**Merged pull requests:**

- Fixes \#16941 - Check perms on Pulp key [\#182](https://github.com/Katello/puppet-pulp/pull/182) ([chris1984](https://github.com/chris1984))
- Fixes \#16946 - add step to verify Pulp CA [\#181](https://github.com/Katello/puppet-pulp/pull/181) ([chris1984](https://github.com/chris1984))
- version compared as number [\#180](https://github.com/Katello/puppet-pulp/pull/180) ([PascalBourdier](https://github.com/PascalBourdier))
- Add Pulp profiling option [\#178](https://github.com/Katello/puppet-pulp/pull/178) ([ehelms](https://github.com/ehelms))
- fixes \#17590 - add repo\_url\_prefixes to repo\_auth.conf [\#177](https://github.com/Katello/puppet-pulp/pull/177) ([stbenjam](https://github.com/stbenjam))
- module sync update [\#176](https://github.com/Katello/puppet-pulp/pull/176) ([jlsherrill](https://github.com/jlsherrill))
- Remove potential for circular dependency when using Apache [\#174](https://github.com/Katello/puppet-pulp/pull/174) ([ehelms](https://github.com/ehelms))
- fixes GH-171 - add a show\_conf\_diff param, defaults to false [\#172](https://github.com/Katello/puppet-pulp/pull/172) ([ccnifo](https://github.com/ccnifo))
- Move crane to puppet-pulp [\#170](https://github.com/Katello/puppet-pulp/pull/170) ([stbenjam](https://github.com/stbenjam))
- Modulesync [\#169](https://github.com/Katello/puppet-pulp/pull/169) ([stbenjam](https://github.com/stbenjam))

## [3.5.0](https://github.com/katello/puppet-pulp/tree/3.5.0) (2016-10-17)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.4.0...3.5.0)

**Closed issues:**

- Pulp v2.8 does not work with SSL\_CLIENT\_S\_DN\_CN  [\#138](https://github.com/Katello/puppet-pulp/issues/138)
- ProviderConsumer: file /bin/pulp-consumer does not exist [\#55](https://github.com/Katello/puppet-pulp/issues/55)

**Merged pull requests:**

- Pin squid to 1.0.0 to prevent breakage on EL6 [\#168](https://github.com/Katello/puppet-pulp/pull/168) ([ehelms](https://github.com/ehelms))
- allow to increase the timeout for the exec that does the db migration [\#167](https://github.com/Katello/puppet-pulp/pull/167) ([cristifalcas](https://github.com/cristifalcas))
- Restrict SSLUsername to /pulp/api [\#166](https://github.com/Katello/puppet-pulp/pull/166) ([jlsherrill](https://github.com/jlsherrill))
- ssl\_protocol: customisable parameter and default avoids SSLv3 [\#165](https://github.com/Katello/puppet-pulp/pull/165) ([ccnifo](https://github.com/ccnifo))
- SSLUsername directive breaks FakeBasicAuth [\#163](https://github.com/Katello/puppet-pulp/pull/163) ([llabrat](https://github.com/llabrat))

## [3.4.0](https://github.com/katello/puppet-pulp/tree/3.4.0) (2016-09-12)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.3.1...3.4.0)

**Closed issues:**

- sh: repoquery: command not found [\#154](https://github.com/Katello/puppet-pulp/issues/154)
- Catalogue failure if manage\_db=false [\#150](https://github.com/Katello/puppet-pulp/issues/150)

**Merged pull requests:**

- Fix typo in variable name in params.pp [\#162](https://github.com/Katello/puppet-pulp/pull/162) ([stbenjam](https://github.com/stbenjam))
- Modulesync update [\#161](https://github.com/Katello/puppet-pulp/pull/161) ([ehelms](https://github.com/ehelms))
- Remove trailing spaces [\#160](https://github.com/Katello/puppet-pulp/pull/160) ([stbenjam](https://github.com/stbenjam))
- Fixes \#16343 - Redirect fix for Atomic Hosts [\#158](https://github.com/Katello/puppet-pulp/pull/158) ([parthaa](https://github.com/parthaa))
- Do not attempt to write `vhosts80` file too early [\#156](https://github.com/Katello/puppet-pulp/pull/156) ([beav](https://github.com/beav))
- allow configuration of puppet wsgi processes [\#155](https://github.com/Katello/puppet-pulp/pull/155) ([jlsherrill](https://github.com/jlsherrill))
- fixes GH-150 - Eliminate duplicate, broken requires on mongodb [\#153](https://github.com/Katello/puppet-pulp/pull/153) ([ccnifo](https://github.com/ccnifo))
- Pin extlib since they dropped 1.8.7 support [\#152](https://github.com/Katello/puppet-pulp/pull/152) ([stbenjam](https://github.com/stbenjam))
- refs \#15217 - puppet 4 support [\#151](https://github.com/Katello/puppet-pulp/pull/151) ([stbenjam](https://github.com/stbenjam))
- Mongodb fact refactor [\#115](https://github.com/Katello/puppet-pulp/pull/115) ([walkamongus](https://github.com/walkamongus))

## [3.3.1](https://github.com/katello/puppet-pulp/tree/3.3.1) (2016-06-10)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.3.0...3.3.1)

**Merged pull requests:**

- refs \#15326 - remove mongo authentication [\#149](https://github.com/Katello/puppet-pulp/pull/149) ([stbenjam](https://github.com/stbenjam))
- allow adding chainfile for https certificate [\#148](https://github.com/Katello/puppet-pulp/pull/148) ([jlambert121](https://github.com/jlambert121))
- fixes \#15014 - restore pulp db init flag [\#145](https://github.com/Katello/puppet-pulp/pull/145) ([stbenjam](https://github.com/stbenjam))

## [3.3.0](https://github.com/katello/puppet-pulp/tree/3.3.0) (2016-05-19)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.2.1...3.3.0)

**Merged pull requests:**

- refs \#15058 - mongo auth only on newer mongos [\#147](https://github.com/Katello/puppet-pulp/pull/147) ([stbenjam](https://github.com/stbenjam))
- refs \#15058 - support auth for mongo [\#146](https://github.com/Katello/puppet-pulp/pull/146) ([stbenjam](https://github.com/stbenjam))
- allow browsing root of repos [\#144](https://github.com/Katello/puppet-pulp/pull/144) ([jlambert121](https://github.com/jlambert121))
- Add paths for puppet-lint docs check [\#140](https://github.com/Katello/puppet-pulp/pull/140) ([stbenjam](https://github.com/stbenjam))
- Pulp streamer requires mod\_proxy module [\#139](https://github.com/Katello/puppet-pulp/pull/139) ([ehelms](https://github.com/ehelms))

## [3.2.1](https://github.com/katello/puppet-pulp/tree/3.2.1) (2016-03-28)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.2.0...3.2.1)

**Merged pull requests:**

- Fixes \#14361 - Setting a couple missing squid options [\#137](https://github.com/Katello/puppet-pulp/pull/137) ([daviddavis](https://github.com/daviddavis))
- update to add defaultsite to squid conf [\#136](https://github.com/Katello/puppet-pulp/pull/136) ([beav](https://github.com/beav))

## [3.2.0](https://github.com/katello/puppet-pulp/tree/3.2.0) (2016-03-16)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.1.0...3.2.0)

**Merged pull requests:**

- Modulesync [\#134](https://github.com/Katello/puppet-pulp/pull/134) ([stbenjam](https://github.com/stbenjam))
- Allow specifying custom fragment on httpd module [\#133](https://github.com/Katello/puppet-pulp/pull/133) ([ehelms](https://github.com/ehelms))
- update vhosts80/rpm.conf to support http lazy sync [\#132](https://github.com/Katello/puppet-pulp/pull/132) ([jlsherrill](https://github.com/jlsherrill))

## [3.1.0](https://github.com/katello/puppet-pulp/tree/3.1.0) (2016-02-23)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/3.0.0...3.1.0)

**Merged pull requests:**

- adds pulp streamer service [\#130](https://github.com/Katello/puppet-pulp/pull/130) ([cfouant](https://github.com/cfouant))
- Add KeepAlive support [\#128](https://github.com/Katello/puppet-pulp/pull/128) ([jlsherrill](https://github.com/jlsherrill))
- Refs \#13625 - Install ostree via puppet-pulp [\#127](https://github.com/Katello/puppet-pulp/pull/127) ([parthaa](https://github.com/parthaa))
- Fixes \#13451 - enables lazy sync [\#122](https://github.com/Katello/puppet-pulp/pull/122) ([cfouant](https://github.com/cfouant))

## [3.0.0](https://github.com/katello/puppet-pulp/tree/3.0.0) (2016-02-10)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/2.1.0...3.0.0)

**Merged pull requests:**

- do not specify ca cert in apache pulp.conf [\#126](https://github.com/Katello/puppet-pulp/pull/126) ([jlsherrill](https://github.com/jlsherrill))
- Ensure JSON is wrapped in quotations [\#125](https://github.com/Katello/puppet-pulp/pull/125) ([ehelms](https://github.com/ehelms))
- Fixes \#13607 - Adding pulp.conf [\#124](https://github.com/Katello/puppet-pulp/pull/124) ([parthaa](https://github.com/parthaa))
- Fix importer JSON to produce correct JSON [\#123](https://github.com/Katello/puppet-pulp/pull/123) ([ehelms](https://github.com/ehelms))
- Fix wsgi paths for 2.8 [\#121](https://github.com/Katello/puppet-pulp/pull/121) ([ehelms](https://github.com/ehelms))
- Include apache::mod::headers when using docker [\#120](https://github.com/Katello/puppet-pulp/pull/120) ([ehelms](https://github.com/ehelms))
- Removes ssl\_ca\_cert parameter that duplicates the ca\_cert parameter [\#119](https://github.com/Katello/puppet-pulp/pull/119) ([ehelms](https://github.com/ehelms))
- fix template :undef checks and yum proxy variables [\#117](https://github.com/Katello/puppet-pulp/pull/117) ([walkamongus](https://github.com/walkamongus))
- Fixes \#13431 - Apache changes for pulp 2.8 [\#116](https://github.com/Katello/puppet-pulp/pull/116) ([parthaa](https://github.com/parthaa))

## [2.1.0](https://github.com/katello/puppet-pulp/tree/2.1.0) (2016-02-01)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/2.0.0...2.1.0)

**Merged pull requests:**

- Remove inclusion of concat\_native [\#118](https://github.com/Katello/puppet-pulp/pull/118) ([ehelms](https://github.com/ehelms))
- Fixes \#13394 - Added xsendfile support for pulp 2.8 [\#113](https://github.com/Katello/puppet-pulp/pull/113) ([parthaa](https://github.com/parthaa))
- fixes \#13189 - allows authentication with username and certificate [\#112](https://github.com/Katello/puppet-pulp/pull/112) ([cfouant](https://github.com/cfouant))
- Config file updates, ostree support, and bugfix [\#85](https://github.com/Katello/puppet-pulp/pull/85) ([beav](https://github.com/beav))

## [2.0.0](https://github.com/katello/puppet-pulp/tree/2.0.0) (2015-11-20)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/1.0.2...2.0.0)

**Merged pull requests:**

- consolidate node parent params into one parameter [\#111](https://github.com/Katello/puppet-pulp/pull/111) ([jlsherrill](https://github.com/jlsherrill))

## [1.0.2](https://github.com/katello/puppet-pulp/tree/1.0.2) (2015-10-21)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/1.0.1...1.0.2)

**Merged pull requests:**

- Ensure broker service running before Pulp services and DB manage [\#109](https://github.com/Katello/puppet-pulp/pull/109) ([ehelms](https://github.com/ehelms))

## [1.0.1](https://github.com/katello/puppet-pulp/tree/1.0.1) (2015-10-15)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/1.0.0...1.0.1)

**Closed issues:**

- Severe lack of answers file documentation [\#105](https://github.com/Katello/puppet-pulp/issues/105)
- Unable to set pulp::num\_workers in an answers file [\#104](https://github.com/Katello/puppet-pulp/issues/104)
- service.pp forces to use qpidd service [\#100](https://github.com/Katello/puppet-pulp/issues/100)

**Merged pull requests:**

- fixes \#12094 Added parent param to ensure pulp-nodes-parent is installed [\#108](https://github.com/Katello/puppet-pulp/pull/108) ([johnpmitsch](https://github.com/johnpmitsch))
- Drop puppet-foreman in favor of extlib for cache\_data [\#106](https://github.com/Katello/puppet-pulp/pull/106) ([ehelms](https://github.com/ehelms))
- Remove direct references to Service\['qpidd'\] [\#103](https://github.com/Katello/puppet-pulp/pull/103) ([ehelms](https://github.com/ehelms))
- fixes \#12033: set topic\_exchange using the messaging\_topic\_exchange param [\#102](https://github.com/Katello/puppet-pulp/pull/102) ([bbuckingham](https://github.com/bbuckingham))
- Refs \#11998 - support plugin httpd files without manage\_httpd [\#101](https://github.com/Katello/puppet-pulp/pull/101) ([jlsherrill](https://github.com/jlsherrill))

## [1.0.0](https://github.com/katello/puppet-pulp/tree/1.0.0) (2015-09-08)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/0.1.3...1.0.0)

**Closed issues:**

- Module is missing some apache configuration? [\#43](https://github.com/Katello/puppet-pulp/issues/43)
- pulp requires an encrypted connection to qpid, but the nssdb configuration is not performed. [\#38](https://github.com/Katello/puppet-pulp/issues/38)
- mongodb can't start on el7 [\#37](https://github.com/Katello/puppet-pulp/issues/37)
- Do not install qpid and mongodb from pulp [\#36](https://github.com/Katello/puppet-pulp/issues/36)

**Merged pull requests:**

- Use qpid::tools class [\#97](https://github.com/Katello/puppet-pulp/pull/97) ([ehelms](https://github.com/ehelms))

## [0.1.3](https://github.com/katello/puppet-pulp/tree/0.1.3) (2015-08-11)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/0.1.2...0.1.3)

**Merged pull requests:**

- Ensure python-gofer-qpid is installed. [\#94](https://github.com/Katello/puppet-pulp/pull/94) ([ehelms](https://github.com/ehelms))
- Add forge and travis badges to README [\#90](https://github.com/Katello/puppet-pulp/pull/90) ([stbenjam](https://github.com/stbenjam))

## [0.1.2](https://github.com/katello/puppet-pulp/tree/0.1.2) (2015-07-20)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/0.1.1...0.1.2)

**Merged pull requests:**

- Update 0.1-stable for modulesync [\#89](https://github.com/Katello/puppet-pulp/pull/89) ([stbenjam](https://github.com/stbenjam))
- Prepare puppet-pulp for release [\#88](https://github.com/Katello/puppet-pulp/pull/88) ([stbenjam](https://github.com/stbenjam))
- fix config.pp [\#87](https://github.com/Katello/puppet-pulp/pull/87) ([cristifalcas](https://github.com/cristifalcas))
- fixes \#10716 - migrate pulp when new pulp plugins are installed [\#86](https://github.com/Katello/puppet-pulp/pull/86) ([stbenjam](https://github.com/stbenjam))
- Consumer [\#83](https://github.com/Katello/puppet-pulp/pull/83) ([cristifalcas](https://github.com/cristifalcas))
- Require qpidd to be started before migrating the database. [\#82](https://github.com/Katello/puppet-pulp/pull/82) ([ehelms](https://github.com/ehelms))
- make pulp configurable [\#80](https://github.com/Katello/puppet-pulp/pull/80) ([cristifalcas](https://github.com/cristifalcas))
- fix including apache configuration [\#79](https://github.com/Katello/puppet-pulp/pull/79) ([cristifalcas](https://github.com/cristifalcas))
- autorequire the goferd service for the provider [\#77](https://github.com/Katello/puppet-pulp/pull/77) ([cristifalcas](https://github.com/cristifalcas))
- Fixes \#10885 - Allow customizing mongodb path [\#73](https://github.com/Katello/puppet-pulp/pull/73) ([adamruzicka](https://github.com/adamruzicka))
- Fixes \#10885 - Allow customizing mongodb path [\#72](https://github.com/Katello/puppet-pulp/pull/72) ([adamruzicka](https://github.com/adamruzicka))
- Refs \#10385: Don't redirect standard err to standard out for mongodb … [\#68](https://github.com/Katello/puppet-pulp/pull/68) ([ehelms](https://github.com/ehelms))
- Refs \#10616 - add ssl virt host fragment type [\#67](https://github.com/Katello/puppet-pulp/pull/67) ([jlsherrill](https://github.com/jlsherrill))
- Refs \#10616 - add ssl virt host fragment type [\#66](https://github.com/Katello/puppet-pulp/pull/66) ([jlsherrill](https://github.com/jlsherrill))
- Remove qpid and mongodb declaration [\#65](https://github.com/Katello/puppet-pulp/pull/65) ([cristifalcas](https://github.com/cristifalcas))
- move httpd config to a separate class [\#64](https://github.com/Katello/puppet-pulp/pull/64) ([cristifalcas](https://github.com/cristifalcas))
- fix spaces [\#63](https://github.com/Katello/puppet-pulp/pull/63) ([cristifalcas](https://github.com/cristifalcas))
- updates for consumer class [\#62](https://github.com/Katello/puppet-pulp/pull/62) ([cristifalcas](https://github.com/cristifalcas))
- Refs \#10385: repoquery doesn't omit the errors, so we account for that. [\#58](https://github.com/Katello/puppet-pulp/pull/58) ([ehelms](https://github.com/ehelms))
- Fixing some documentation in admin.pp [\#57](https://github.com/Katello/puppet-pulp/pull/57) ([timhughes](https://github.com/timhughes))
- Updates from modulesync. [\#56](https://github.com/Katello/puppet-pulp/pull/56) ([ehelms](https://github.com/ehelms))

## [0.1.1](https://github.com/katello/puppet-pulp/tree/0.1.1) (2015-05-08)
[Full Changelog](https://github.com/katello/puppet-pulp/compare/0.1.0...0.1.1)

**Merged pull requests:**

- Update to 0.1.1 [\#54](https://github.com/Katello/puppet-pulp/pull/54) ([ehelms](https://github.com/ehelms))
- Fixes \#10385: Omit errors from yum info when acquiring version. [\#53](https://github.com/Katello/puppet-pulp/pull/53) ([ehelms](https://github.com/ehelms))
- Pin rspec version on 1.8.7 [\#47](https://github.com/Katello/puppet-pulp/pull/47) ([stbenjam](https://github.com/stbenjam))
- use preffix enable\_ for extra packages [\#45](https://github.com/Katello/puppet-pulp/pull/45) ([cristifalcas](https://github.com/cristifalcas))
- add consumer [\#41](https://github.com/Katello/puppet-pulp/pull/41) ([cristifalcas](https://github.com/cristifalcas))

## [0.1.0](https://github.com/katello/puppet-pulp/tree/0.1.0) (2015-03-11)
**Merged pull requests:**

- fix services on el7 [\#42](https://github.com/Katello/puppet-pulp/pull/42) ([cristifalcas](https://github.com/cristifalcas))
- fixes \#9479: fix usage with centos [\#39](https://github.com/Katello/puppet-pulp/pull/39) ([dustints](https://github.com/dustints))
- fixes \#9204 - fix failing tests due to qpid module's validations [\#34](https://github.com/Katello/puppet-pulp/pull/34) ([stbenjam](https://github.com/stbenjam))
- add initial admin support [\#33](https://github.com/Katello/puppet-pulp/pull/33) ([cristifalcas](https://github.com/cristifalcas))
- Fixes \#8478 - set the version of mongodb we are using [\#31](https://github.com/Katello/puppet-pulp/pull/31) ([iNecas](https://github.com/iNecas))
- Fixes \#8266: Allow setting the number of Pulp workers to be used. [\#30](https://github.com/Katello/puppet-pulp/pull/30) ([ehelms](https://github.com/ehelms))
- refs \#7779 - Updating to add support for pulp docker [\#29](https://github.com/Katello/puppet-pulp/pull/29) ([bbuckingham](https://github.com/bbuckingham))
- fixes \#7296, BZ1135127 - switching to relying on apache for cert validat... [\#28](https://github.com/Katello/puppet-pulp/pull/28) ([mccun934](https://github.com/mccun934))
- Refs \#6736: Updating to standard layout and basic tests. [\#27](https://github.com/Katello/puppet-pulp/pull/27) ([ehelms](https://github.com/ehelms))
- fixes \#7115 - specify cert options for nodes.conf [\#25](https://github.com/Katello/puppet-pulp/pull/25) ([jlsherrill](https://github.com/jlsherrill))
- Refs \#7077/BZ1127242: generate random password for pulp user. [\#24](https://github.com/Katello/puppet-pulp/pull/24) ([waldenraines](https://github.com/waldenraines))
- fixes \#7006 - require mongo and qpidd before pulp-manage-db [\#23](https://github.com/Katello/puppet-pulp/pull/23) ([jlsherrill](https://github.com/jlsherrill))
- Refs \#6530: Ensure null for proxy\_port if not defined. [\#22](https://github.com/Katello/puppet-pulp/pull/22) ([ehelms](https://github.com/ehelms))
- Fixes \#6530: Ensure proxy configs work if not all values specified. [\#21](https://github.com/Katello/puppet-pulp/pull/21) ([ehelms](https://github.com/ehelms))
- Refs \#6360 - enable pulp\_manage\_puppet selinux boolean [\#20](https://github.com/Katello/puppet-pulp/pull/20) ([lzap](https://github.com/lzap))
- Refs \#5639: Adds proxy options for Pulp plugins. [\#19](https://github.com/Katello/puppet-pulp/pull/19) ([ehelms](https://github.com/ehelms))
- Fixes 5992 and 5993 - update pulp-katello to install qpid-dependencies [\#18](https://github.com/Katello/puppet-pulp/pull/18) ([jmontleon](https://github.com/jmontleon))
- fixes \#5845 - using new pulp httpd config files for 2.4 [\#17](https://github.com/Katello/puppet-pulp/pull/17) ([jlsherrill](https://github.com/jlsherrill))
- Refs \#5377: Ensure Pulp 2.4 services are run after config. [\#16](https://github.com/Katello/puppet-pulp/pull/16) ([ehelms](https://github.com/ehelms))
- Refs \#5377: Updates for Pulp 2.4 support. [\#15](https://github.com/Katello/puppet-pulp/pull/15) ([ehelms](https://github.com/ehelms))
- Refs \#5423 - fixes pulp node setting on the capsule [\#14](https://github.com/Katello/puppet-pulp/pull/14) ([iNecas](https://github.com/iNecas))
- Fixing \#5299: variables not used properly. [\#13](https://github.com/Katello/puppet-pulp/pull/13) ([omaciel](https://github.com/omaciel))
- Fix mongodb error waiting for service. [\#12](https://github.com/Katello/puppet-pulp/pull/12) ([dgoodwin](https://github.com/dgoodwin))
- Cleaning up certs related files. [\#11](https://github.com/Katello/puppet-pulp/pull/11) ([ehelms](https://github.com/ehelms))
- Changing apache to an include and including extra RPMs to install with P... [\#10](https://github.com/Katello/puppet-pulp/pull/10) ([ehelms](https://github.com/ehelms))
- adding plugin confs to puppet module [\#9](https://github.com/Katello/puppet-pulp/pull/9) ([jlsherrill](https://github.com/jlsherrill))
- Updates to pass parameters to the Qpid module. [\#8](https://github.com/Katello/puppet-pulp/pull/8) ([ehelms](https://github.com/ehelms))
- having the pulp module use the puppetlabs apache module [\#7](https://github.com/Katello/puppet-pulp/pull/7) ([jlsherrill](https://github.com/jlsherrill))
- remove default\_login override [\#5](https://github.com/Katello/puppet-pulp/pull/5) ([jlsherrill](https://github.com/jlsherrill))
- Updates for parameterized params and certs updates. [\#4](https://github.com/Katello/puppet-pulp/pull/4) ([ehelms](https://github.com/ehelms))
- Move the certs part of the module to puppet-certs [\#3](https://github.com/Katello/puppet-pulp/pull/3) ([iNecas](https://github.com/iNecas))
- Fixes documentation error to prevent Kafo from complaining about [\#1](https://github.com/Katello/puppet-pulp/pull/1) ([ehelms](https://github.com/ehelms))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
