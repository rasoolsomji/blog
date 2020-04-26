---
title: "Introduction"
date: 2020-04-13T10:33:44+01:00
showDate: true
series: ["detector-dag"]
series_weight: 1
---

My latest project was inspired when my best friend's mum came to me with a problem:

> A while back there was a powercut in Alderney[^1], the circuit breaker tripped, and all the food
in our freezer spoiled.
Can we find something that will warn us if that has happened, so we can send a neighbour round?

[^1]: [Alderney](https://en.wikipedia.org/wiki/Alderney) is a tiny island that I happen to love, where
they have a second home.

I felt confident that something would already exist, and sure enough a cursory search turned up a couple
of products[^2].
They worked by plugging into a mains socket, acting as a passthrough for electricity,
but loaded with a SIM card to text predefined numbers if the power failed.
However I was pretty surprised at how pricey they were (£125 and £150), given they looked a bit dated.

[^2]: [isocket](https://www.isocket.eu/) and [powertxt](https://www.tekview-solutions.com/powertxt.php).

The problem was further defined:

> We have two circuit rings in our house, and during the previous powercut one circuit stayed up and
the other tripped.
I don't really want to spend ~£300 because we need two of them.

At this point I could feel myself itching to solve this with a signature overengineered solution.
With images of raspberry pi's, cloud databases, email notifications, flying through my head, I tried
to find a _quick_ solution:

- Maybe Alderney electricity board have an API for announcing power failures[^3]? ❌
- Maybe UPSs already exist that could power a freezer and have in-built notifications[^4]? ❌

Who was I kidding, by this point my weakness for overcomplicating life had set in. I wanted to try my
hand at this IoT project.

> In a desperate and percipient attempt to stop the inevitable, Dad quickly took me to Spurs to see
Jimmy Greaves score four against Sunderland in a 5-1 win, but the damage had been done, and the six
goals and all the great players left me cold: I’d already fallen for the team that beat Stoke 1-0 from
a penalty rebound.
>
> ---
>
> Fever Pitch - Nick Hornby

[^3]: Honestly, their power failure advice page (which now reports 404 error) really revealed how funny
this question is.
[^4]: [inductive loads not suitable for UPSs.](https://community.spiceworks.com/topic/610697-can-someone-help-me-find-a-ups-battery-backup-that-will-power-this-fridge)
