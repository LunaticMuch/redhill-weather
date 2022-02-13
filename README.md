#  Redhill Weather app

## Introduction

This application allows to read the weather report as provided the (Redhill Airport)[https://www.redhillaerodrome.com] weather station. The report is normally available at the (weather station private website)[https://81.2.71.178:8080/].

The application can be used be taken in background, although it does not retrieve any ATIS info. When the last issue date on the ATIS becomes older than 30 minutes from the current clock time, a yellow triangle is displayed to inform that the ATIS is no more current. Pull to refresh will make the update.

## Policies and Terms 

(Privacy policy)[https://pages.flycricket.io/redhill-weather-0/privacy.html] is available on FlyCricket.

(Terms)[https://pages.flycricket.io/redhill-weather-0/terms.html] are available on FlyCricket.

## ToDo

[] - Refactor struct
[X] - Change view state after 30 mins since the last weather report
[] - Add weather info (on top of other observation provided)
[/] - Refactor other code

