# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "tribute/map.jinja" import tribute with context %}

include:
  - tribute.install

tribute-database:
  file.touch:
    - name: {{ tribute.database }}

tribute-public:
  file.directory:
    - name: {{ tribute.public }}

tribute-container:
  dockerng.running:
    - name: {{ tribute.name }}
    - image: {{ tribute.image }}:{{ tribute.branch }}
    - binds:
      - {{ tribute.database }}:/usr/src/app/db/production.sqlite3:rw
      - {{ tribute.public }}:/usr/src/app/public:rw
    - port_bindings:
      - {{ tribute.port }}:3000
    {%- if tribute.environment %}
    - environment:
      {%- for env, value in tribute.environment.items() %}
      - {{ env }}: {{ value|yaml_squote }}
      {%- endfor %}
    {%- endif %}
    - require:
      - dockerng: tribute-image
