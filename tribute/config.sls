# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "tribute/map.jinja" import tribute with context %}

tribute-config:
  file.managed:
    - name: {{ tribute.config }}
    - makedirs: True
    - source: salt://tribute/files/config.yaml.jinja
    - template: jinja
    - mode: 600
    - user: root
    - group: root
