# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "tribute/map.jinja" import tribute with context %}

include:
  - tribute.install
  - tribute.config

tribute-container:
  dockerng.running:
    - name: {{ tribute.name }}
    - image: {{ tribute.image }}
    - binds: {{ tribute.config }}:/usr/src/app/config.yaml
    - require:
      - dockerng: tribute-image
    - watch:
      - file: tribute-config
