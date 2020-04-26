---
title: "Concepts"
date: 2020-04-13T11:41:03+01:00
showDate: true
series: ["detector-dag"]
series_weight: 2
---

I set to work designing a system for monitoring power remotely, and came up with a few iterations.

All of my concepts revolved around a few assumptions:

- A device would be a cheap [Raspberry Pi Zero](https://www.raspberrypi.org/products/raspberry-pi-zero/)
- There would be a server that could receive staus updates from multiple devices
- The server would email users in the case of a power failure

## Iteration 1: I'm alive

My initial ideas revolved around connecting the Raspberry Pi to the house's WiFi network:

{{< figure alt=iteration-1 src=/_gen/im-alive-context-device.png >}}

- Devices are connected to home WiFi network
- Devices send "I'm alive" messages to the server
- During a power cut, the devices die and no messages are sent
- The server informs users of a failure after a device hasn't been seen for a while

Thinking about this design caused me concerns:

- I didn't much like using internet connectivity as a proxy for power.
I could envisage false positives in cases where the internet failed, or the Pi's WiFi connection failed.
- I didn't relish the prospect of getting non-technical users to connect Pi Zero's to their home network.
It would likely require a setup step where the Pi presents itself as an [access point](https://iot.stackexchange.com/a/658).
Then would it need a reset button? Urgh.

## Iteration 2: I'm dead

I really preferred to have a convincing "power lost" message rather than relying on the _absence_ of
receiving "I'm alive". However this required the Pi to remain powered during a powercut - at least long
enough to send the message.

I found the [UPSLite](https://www.aliexpress.com/item/32954180664.html),
a reasonably-priced, uninterruptable power supply shield designed for the Pi Zero.
It includes a digital signal connected to a GPIO pin that indicates power status, as well as extra
features such as allowing the Pi to interrogate battery capacity/voltage.

{{< figure alt=iteration-2-device src=/_gen/im-dead-context-device.png >}}

Ok, so now the Pi can send a "power lost" message. But if there's been a power cut the router is probably
down too! Fine, lets throw in a [small UPS](https://www.amazon.co.uk/GM312-Uninterrupted-11-13Vdc-Wireless-Peripherals/dp/B06XSZVJ6Q) for the
router too.

{{< figure alt=iteration-1 src=/_gen/im-dead-context.png >}}

- Devices are connected to home WiFi network
- During a power cut the UPSs for the device and router keep both running
- The devices send a "power lost" message to the server
- The server sends an email upon receiving a "power lost" message

My concerns with _this_ design were:

- Just because the router is powered, will the local area's internet still be up during a powercut?
Initial research suggested it _would_
(internet providers would probably have their own generators).
However my use case was [Alderney](https://en.wikipedia.org/wiki/Alderney)
where normal assumptions about infrastructure may not hold true...
- The system still depends on a WiFi connection between the Pis and the router.
I just felt superstious about leaving these devices for long periods of time, unattended,
and relying that they'd be connected for these rare, important events.

## Iteration 3: I'm independent

This iteration isn't so clever. If you've read the [Introduction]({{< relref "introduction.md" >}})
you'll realise that I've just reinvented the products discussed there for a bit less money.

Well, those guys are running a business on this model, maybe they know what they're doing?

{{< figure alt=iteration-3 src=/_gen/independent-context-device.png >}}

- Devices are connected to the internet using a USB dongle loaded with a data SIM
- During a power cut the UPSs for the devices keep them running
- The devices send a "power lost" message to the server
- The server sends an email upon receiving a "power lost" message

I had reservations about this design too, of course:

- WiFi is 'free' (paid for already), whereas SIM cards introduce a new running cost

But what I liked about this was the removal of any configuration steps aside from activating a SIM card.
My end users should be able to plug-and-play.

Love it.

## Onwards

Ok, so this post has attempted to justify the design decisions. But let's remember I like things complicated.
So take everything here with a few grains of salt, life tastes better that way...
