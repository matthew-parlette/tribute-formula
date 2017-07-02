# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "tribute/development/map.jinja" import tribute with context %}

tribute-development-image:
  dockerng.image_present:
    - name: {{ tribute.image }}:{{ tribute.branch }}
    - force: True
