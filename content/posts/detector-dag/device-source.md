---
title: "Device Source"
date: 2020-04-16T22:08:03+01:00
showDate: true
draft: true
tags: ["blog","story"]
series: ["detector-dag"]
series_weight: 3
---

With a high-level plan sketched out and a couple of Raspberry Pi Zeros at my disposal it was time to
stay up late and start tapping!

As someone who's trying to reposition themselves as a 'backend developer', I knew I wanted to
become familiar with Amazon Web Services (AWS). It might not be the answer to every solution, but it certainly
felt like something that should be in my toolkit.

Also, coming from an embedded background, I wasn't fussed about making a bells-and-whistles device.
I was in this for the cloud architecture lessons, so I wanted to get this end of the project done quickly
and simply.

## AWS IoT

[AWS IoT](https://aws.amazon.com/iot/) is a PaaS offering for getting connected 'things' talking to
the cloud (specifically, _Amazon's_ cloud) using the ubiquitous [MQTT](https://mqtt.org/) protocol.
I had initally thought might try out RabbitMQ and the more secure, and feature-rich [AMQP](https://www.amqp.org/),
protocol, but this seemed too handy to turn down. Leave some lessons for the future, eh?

As we will see, AWS IoT plugs some of the deficiencies of MQTT, such as authentication and encryption,
which was perfect for me to quickly dabble in a complete networking project.

## ...Python 🤦‍♀️

Now, don't get me wrong. Python has its uses. But I've tried playing with Pi's, Docker, and Python
before, and the whole ARMv7 architecture thing was a real nightmare. Life isn't as simple as `pip install`
when you watch your tiny Pi trying to compile numpy from source[^2].

Sadly the AWS IoT Device SDK only came in Embedded C, Java, Javascript, and Python flavours. For me
and my homebrew hack project, Python was the only answer.

[^1]: Not that my simplistic use case had any call for this
[^2]: I am aware of [PiWheels](https://www.piwheels.org/), but the docker images I found can't use them.

## Source

I kicked off the source as always do, using my [cookiecutter template](https://github.com/briggySmalls/cookiecutter-pypackage)
to generate a python package with linting, testing, and dependency management ready-to-go.

Next I found a [tutorial][balena-pi-iot] on getting a Rasperry Pi, running BalenaOS sending messages
to AWS IoT. Which by-and-large went to plan. I smugly handled the parsing of the certificates from environment
variables using my [config class]({{< ref "../python-config.md" >}}).

This got me with the equivalent of a 'hello-world' IoT device, I could send MQTT messages to AWS IoT
and see them arrive. Now to actually move to _my_ solution.

[balena-pi-iot]: https://www.balena.io/blog/use-a-raspberry-pi-to-communicate-with-amazon-aws-iot/

## Device shadow

It's sometimes not worth telling a story chronologically. What I'll tell you is I spent a fair bit of
time reinventing the wheel on this project.

I knew I wanted to:

- __Associate__ one or more device with a single user account
- Post power status updates to the cloud
- Send the account owner an __email__ when the power status had changed
- Have some method of 'checking' the __most recent status__

The emphasised parts stood out to me as application 'state'. And when I hear 'state' and I think database.

