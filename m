From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Dec 2016 08:30:17 +0100 (CET)
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612210824400.2083@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 20 Dec 2016, Guenter Roeck wrote:

> Hi Julia,
>
> I noticed your patch series to change DEVICE_ATTR() to
> DEVICE_ATTR_{RW,RO,WO}().
> In hwmon, we have a lot of candidates for this change, but unfortunately the
> function names do not typically match the _show/_store name convention.
>
> Is there a way to tell coccinelle to change the function names to match this
> convention ?
>
> Background is that I want to change SENSOR_DEVICE_ATTR() and
> SENSOR_DEVICE_ATTR_2()
> as well (after introducing _{RO,RW,WO} variants), but there the function names
> are
> even more non-standard. The ability to change function names would help a lot
> for
> automating this change.

Names can always be constructed with python or ocaml script code.  Looking
quickly at the code, I see some occurrences of eg set_ and get_, for
example.  This should be possible to handle.  I will look into it.

julia
