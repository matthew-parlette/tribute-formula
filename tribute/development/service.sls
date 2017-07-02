# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "tribute/development/map.jinja" import tribute with context %}

include:
  - tribute.development.install

tribute-development-database:
  file.touch:
    - name: {{ tribute.database }}
    - makedirs: True

tribute-development-public:
  file.directory:
    - name: {{ tribute.public }}
    - makedirs: True

tribute-development-container:
  dockerng.running:
    - name: {{ tribute.name }}
    - image: {{ tribute.image }}:{{ tribute.branch }}
    {%- if tribute.has_key('database') %}
    - binds:
      - {{ tribute.database }}:/usr/src/app/db/development.sqlite3:rw
      - {{ tribute.public }}:/usr/src/app/public:rw
    {%- endif %}
    - port_bindings:
      - {{ tribute.port }}:3000
    {%- if tribute.environment %}
    - environment:
      {%- for env, value in tribute.environment.items() %}
      - {{ env }}: {{ value|yaml_squote }}
      {%- endfor %}
    {%- endif %}
    - require:
      - dockerng: tribute-development-image
      - file: tribute-development-database
      - file: tribute-development-public
