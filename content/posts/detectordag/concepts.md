---
title: "Concepts"
date: 2020-04-13T11:41:03+01:00
showDate: true
draft: true
tags: ["detectordag"]
---

I set to work designing a system for monitoring power remotely, and came up with a few iterations.

All of my concepts revolved around a few assumptions:

- A device would be a cheap Raspberry Pi Zero
- There would be a cloud that could receive staus updates from multiple devices
- The cloud would email users in the case of a power failure

# Iteration 1: I'm alive

My initial ideas revolved around connecting a Raspberry Pi to the house's WiFi network:

{{< svg "_gen/archie/im-alive-context-device.svg" >}}

- Devices are connected to home WiFi network
- Devices send 'I'm alive' messages to the server
- During a power cut, the devices die and no messages are sent
- The server informs users of a failure after a device hasn't been seen for a while

Thinking about this design caused me concerns:

- I didn't much like using internet connectivity as a proxy for power.
I could envisage false positives in cases where the internet failed, or the Pi's WiFi connection failed.
- I didn't relish the prospect of getting non-technical users to connect Pi Zero's to their home network.

# Iteration 2: I'm dead

I really preferred to have a convincing 'power lost' signal rather than relying on the _absence_ of an 'I'm alive' message.
However this required the Pi to remain powered during a powercut, at least long enough to send a 'power lost' message.

I found the [UPSLite](https://www.aliexpress.com/item/32954180664.html),
a reasonably-priced, uninterruptable power supply shield designed for the Pi Zero.
It includes a digital signal connected to a GPIO pin to indicate power status, as well as extra features such as battery capacity/voltage.

Ok, so now the Pi can send a 'power lost' message. But if there's been a power cut the router is probably down too!
Fine, lets throw in a [small UPS](https://www.amazon.co.uk/gp/product/B075QZQSS1) for the router too.

{{< svg "_gen/archie/im-dead-context.svg" >}}

{{< svg "_gen/archie/im-dead-context-device.svg" >}}

- Devices are connected to home WiFi network
- During a power cut the UPSs for the device and router keep both running
- The devices send a 'power lost' message to the server
- The server sends an email upon receiving a 'power lost' message

My concerns with _this_ design were:

- Initial research suggested the internet might stay up during a powercut
(internet providers would probably have their own generators).
However my use case was [_Alderney_](https://en.wikipedia.org/wiki/Alderney)
where normal assumptions about infrastructure may not hold true...
- The system still depends on WiFi between a couple of Pis and the router.
I just felt superstious about leaving these devices for long periods of time, unattended,
and relying that they'd be connected for these rare, important events.

# Iteration 3: I'm independent

This iteration isn't so clever. If you've read the [Introduction]({{< ref "introduction.md" >}})
you'll realise that I've just reinvented the products discussed there for a bit less money.

Well, those guys are running a business on this model, maybe they know what they're doing?

{{< svg "_gen/archie/independent-context-device.svg" >}}

- Devices are connected to the internet using a USB dongle loaded with a data SIM
- During a power cut the UPSs for the devices keep them running
- The devices send a 'power lost' message to the server
- The server sends an email upon receiving a 'power lost' message

I had reservations about this design too, of course:

- WiFi is 'free' (paid for already), whereas SIM cards introduce a new running cost

But what I liked about this was the removal of any configuration steps aside from activating a SIM card.
My end users should be able to plug-and-play.
