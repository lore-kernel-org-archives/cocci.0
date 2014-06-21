From: romieu@fr.zoreil.com (Francois Romieu)
Date: Sat, 21 Jun 2014 12:52:05 +0200
Subject: [Cocci] SmPL for automatic request_firmware_nowait() conversion
In-Reply-To: <20140621015714.GX4841@wotan.suse.de>
References: <20140621015714.GX4841@wotan.suse.de>
Message-ID: <20140621105205.GA31611@electric-eye.fr.zoreil.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Luis R. Rodriguez <mcgrof@suse.com> :
> I was just porting over an ethernet driver [0] to use request_firmware_nowait()
> since firmware loading seems can take over a minute on one device, while
> at it I noticed no other ethernet drivers yet use this API so figure
> this may be a trend coming if devices are getting as complex as cxgb4.
> The cxgb4 driver happens to even use the firmware API 3 times!

There should be no problem for the firmware requests issued through
ethtool in cxgb4.

[...]
> netdev: how worthy is this effort?

Biased comment below :o)

I'm wondering the benefit of automatic API changes when it could be argued
that the symptoms call for driver dependant code rework.

The 60 seconds delay is kind of a pavlovian signal: one can bet that the
driver includes a request_firmware in its probe method. So does cxgb4.

I still believe in the old school "request firmware from net_device_ops.open".
I've been happy with it since f1e02ed109df5f99abf942b8ccc99960cb09dd38.
This kind of rework may not be trivial for cxgb4. Please get code tested on
real hardware (modular/monolithic build, with/without firmware, etc.) as I
won't argue against your crusade for cxgb4.

Asynchronous firmware loading provides a rather nice high level API but
it's imho not the essence of network devices firmware loading problems.

-- 
Ueimor
