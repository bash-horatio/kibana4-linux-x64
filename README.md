# Kibana4: kibana4-linux-x64

Kibana 4.2.2 redistributed by Bash Horatio
2017-07-31: Bash Horatio <bash.horatio@gmail.com>
============

Build Status

Kibana is an open source (Apache Licensed), browser based analytics and search dashboard for Elasticsearch. Kibana is a snap to setup and start using. Kibana strives to be easy to get started with, while also being flexible and powerful, just like Elasticsearch.


Features
============

Main Differences between this and Kibana 4.2.2 from Elastic are:
* Support [AMap](http://ditu.amap.com/) in Tile Map
* Change the Color theme in **Visualize** to Material Design from Google
* Deploy Kibana4 as a system service on Redhat/CentOS or Debian
* Work with [Transwarp Search](https://docs.transwarp.cn/5.0/goto?iframe=true&file=EsManual_es-introduction.html#es-introduction) out of box
* Features above are only tested in Linux x64 platform


Requirements
============
    Elasticsearch version 2.0.0 or later
    Kibana binary package


Installation
============
    Download: https://github.com/bash-horatio/kibana4-linux-x64/releases
    Extract Kibana4 to /srv: tar -zxvf kibana4-linux-x64.tar.gz -C /srv
    Initialize Kibana4: /srv/kibana4/tools/kibana4-init.sh
    Visit http://localhost:5601


Quick Start
===========

You're up and running! Fantastic! Kibana is now running on port 5601, so point your browser at http://YOURDOMAIN.com:5601.

The first screen you arrive at will ask you to configure an index pattern. An index pattern describes to Kibana how to access your data. We make the guess that you're working with log data, and we hope (because it's awesome) that you're working with Logstash. By default, we fill in logstash-* as your index pattern, thus the only thing you need to do is select which field contains the timestamp you'd like to use. Kibana reads your Elasticsearch mapping to find your time fields - select one from the list and hit Create.

Tip: there's an optimization in the way of the Use event times to create index names option. Since Logstash creates an index every day, Kibana uses that fact to only search indices that could possibly contain data in your selected time range.

Congratulations, you have an index pattern! You should now be looking at a paginated list of the fields in your index or indices, as well as some informative data about them. Kibana has automatically set this new index pattern as your default index pattern. If you'd like to know more about index patterns, pop into to the Settings section of the documentation.

Did you know: Both indices and indexes are acceptable plural forms of the word index. Knowledge is power.

Now that you've configured an index pattern, you're ready to hop over to the Discover screen and try out a few searches. Click on Discover in the navigation bar at the top of the screen.


Documentation
=============

Visit Elastic.co for the full Kibana documentation.


Build Manually
===============

Requirements:
* Node 0.12.9+
* NPM 2.14.3+

```
git clone https://github.com/bash-horatio/kibana4-linux-x64.git
cd kibana4-linux-x64
npm install
bin/kibana
```
