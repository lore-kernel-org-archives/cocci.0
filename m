From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 20 Dec 2016 19:28:48 -0800
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
Message-ID: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

I noticed your patch series to change DEVICE_ATTR() to DEVICE_ATTR_{RW,RO,WO}().
In hwmon, we have a lot of candidates for this change, but unfortunately the
function names do not typically match the _show/_store name convention.

Is there a way to tell coccinelle to change the function names to match this
convention ?

Background is that I want to change SENSOR_DEVICE_ATTR() and SENSOR_DEVICE_ATTR_2()
as well (after introducing _{RO,RW,WO} variants), but there the function names are
even more non-standard. The ability to change function names would help a lot for
automating this change.

Thanks,
Guenter
