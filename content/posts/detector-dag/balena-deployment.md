---
title: "Balena Deployment"
date: 2020-04-26T11:41:50+01:00
showDate: true
draft: true
series: ["detector-dag"]
series_weight: 4
tags: ["balena","raspberry-pi"]
---

- Controlling environment with docker vs. forgetting what you've installed into system python
- Building images on local machine vs. on the Pi is more convenient and quicker
- Deployment is as 'simple' as a 'push': although much, much slower it has to be said
- you get remote SSH for free
- you get env vars on a fleet and per-device basis

## BalenaCloud

In a [previous home project](https://github.com/briggySmalls/flipdot) I'd been frustrated that I couldn't
debug issues on a Pi I had deployed in my grandpa's house. Given _this_ project's primary purpose was
to be deployed to devices in an empty house I really wanted to have a solution for fleet management:
provisioning, deploying updates, remote debugging, etc.

I was curious to try [BalenaCloud](https://www.balena.io/cloud/), a service I'd encountered
on the aforementioned project only because I'd been looking for ARM-friendly docker containers.
Some nice features are:

- SSH terminal access
- Whole-fleet and per-device environment variables
- Docker-push-like deployment
- Support for multi-container applications[^1]

## Mocking

Irritation sets in quickly when you're using a Raspberry Pi as your 'test machine'. Using a service
like BalenaCloud for fleet management solves some problems, like dependency tracking, but creates others
like _really_ slow deployments.

It doesn't take long, as you watch your docker container slowly build for the 10th time, before nagging
thoughts in your head remind you:

> If you tear yourself away from the 'fun' of implementing features and fixing bugs for 5 minutes, you
could probably find a development process that saves you hours.
