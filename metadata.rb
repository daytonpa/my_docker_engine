name 'my_docker_engine'
maintainer 'Patrick Dayton'
maintainer_email 'daytonpa@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures my_docker_engine'
long_description 'Installs/Configures my_docker_engine'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/my_docker_engine/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/my_docker_engine'

depends 'apt'
depends 'yum'
depends 'docker'
