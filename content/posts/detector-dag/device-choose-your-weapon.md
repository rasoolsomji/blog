---
title: "Device - Choose your weapon(s)"
date: 2020-04-13T18:48:44+01:00
showDate: true
series: ["detector-dag"]
---

With a high-level plan sketched out, it was time to do some 'part selection'.

As someone who's trying to reposition themselves as a 'backend developer', I knew I wanted to
become familiar with AWS's cloud offerings. It might not be the answer to every solution, but it certainly
felt like something that should be in my toolkit.

Also, coming from an embedded background, I wasn't fussed about making a bells-and-whistles device.
I was in this for the cloud architecture lessons. So I wanted to get this end of the project done quickly
and simply.

## AWS IoT

[AWS IoT](https://aws.amazon.com/iot/) is a PaaS offering for getting connected 'things' talking to
the cloud (specifically, _Amazon's_ cloud) using the ubiquitous [MQTT](https://mqtt.org/) protocol.
I had initally thought might try out RabbitMQ and the more secure, and feature-rich [AMQP](https://www.amqp.org/),
protocol, but this seemed too handy to turn down. Leave some lessons for the future, eh?

As we will see later, AWS IoT plugs some of the deficiencies of MQTT, such as authentication and encryption,
which was perfect for me to quickly dabble in a complete networking project.

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

## ...Python 🤦‍♀️

Now, don't get me wrong. Python has its uses. But I've tried playing with Pi's, Docker, and Python
before, and the whole ARMv7 architecture thing was a real nightmare. Life isn't as simple as `pip install`
when you watch your tiny Pi trying to compile numpy from source[^2].

Sadly the AWS IoT Device SDK only came in Embedded C, Java, Javascript, and Python flavours. For me
and my homebrew hack project, Python was the only answer.

[^1]: Not that my simplistic use case had any call for this
[^2]: I am aware of [PiWheels]("https://www.piwheels.org/simple"), but some docker builds, alpine for
example, can't use them.
