From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 22 Dec 2016 07:33:39 -0800
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <alpine.DEB.2.20.1612221326060.14381@hadrien>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
 <alpine.DEB.2.20.1612212039090.2005@hadrien>
 <20161221214425.GA2315@roeck-us.net>
 <alpine.DEB.2.20.1612221326060.14381@hadrien>
Message-ID: <83039af2-7b45-8b1f-d842-85a70b71ba11@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/22/2016 04:29 AM, Julia Lawall wrote:
>
>
> On Wed, 21 Dec 2016, Guenter Roeck wrote:
>
>> Hi Julia,
>>
>> On Wed, Dec 21, 2016 at 08:39:38PM +0100, Julia Lawall wrote:
>>>
>>>
>>> On Wed, 21 Dec 2016, Guenter Roeck wrote:
>>>
>>>> Hi Julia,
>>>>
>>>> On Wed, Dec 21, 2016 at 03:05:37PM +0100, Julia Lawall wrote:
>>>>> A solution is below: the semantic patch, an explanation of the semantic
>>>>> patch, and the results.  I have only tried to compile the results (make
>>>>> drivers/hwmon/).  Two affected files were not considered for compilation:
>>>>>
>>>>> drivers/hwmon/vexpress-hwmon.o
>>>>> drivers/hwmon/jz4740-hwmon.o
>>
>> I compile tested those two patches. If possible please drop vexpress-hwmon.c
>> from the patch series; the changes in that file don't add any value.
>>
>> I compile tested all files, and reviewed the patch. It all looks good.
>> Please submit the series.
>>
>> Again, thanks a lot for your help!
>
> I have sent the patches.  I adjusted the semantic patch so that the
> indentation of function parameters/arguments would only change if the
> length of the function name changes.
>
> Do you think this could be of more general interest in the Linux kernel?
> Since the semantic patch works pretty well, I could add it to the
> scripts/coccinelle directory?  Previously, however, I got some negative
> feedback about this change, because people felt that the new names hid the
> actual behavior, so I didn't pursue it.
>

I do think it would add a lot of value, if for nothing else as an excellent example
of what can be done with coccinelle.

I actually liked the name changes. I think it is a good idea if the function name
reflects the sysfs attribute it serves (isn't that exactly what it does, ie its
behavior ?). But, as you have experienced, some people inadvertently did not like
it. Given that, I am not sure if it is worth adding it to the kernel source tree.
Maybe you could submit it as RFC so it is at least on record.

Anyway, for SENSOR_DEVICE_ATTR(), I'll have to be a bit more flexible since
the function _will_ be reused. I'll need something like
	SENSOR_DEVICE_ATTR_{RO,RW,WO}(attr, func, param)

Maybe Greg would be open to something like DEVICE_ATTR_FUNC_{RO,RW,WO}(attr,func)
to accommodate the "I want my own function name" crowd ? That would also solve
the case where the function is reused for multiple attributes.

Thanks,
Guenter
