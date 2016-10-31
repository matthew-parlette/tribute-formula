# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "tribute/map.jinja" import tribute with context %}

tribute-image:
  dockerng.image_present:
    - name: {{ tribute.image }}
    - force: True
