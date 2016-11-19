From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Sat, 19 Nov 2016 12:12:07 +0100
Subject: [Cocci] Fwd: Fwd: Re: min/max mtu field in struct net_device
In-Reply-To: <1fe56a70-5747-7ab6-ae81-bde587401906@broadcom.com>
References: <3a964780-2513-624f-6a2a-ae507398b0a8@broadcom.com>
 <2c575398-b566-6529-4f30-10e8e0c8fcba@broadcom.com>
 <alpine.DEB.2.20.1611172300070.2001@hadrien>
 <1fe56a70-5747-7ab6-ae81-bde587401906@broadcom.com>
Message-ID: <51cfe03d-bcb0-d403-a435-56a0bdba943f@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 18-11-16 10:01, Arend van Spriel wrote:
> On 17-11-16 23:48, Julia Lawall wrote:
>>
>>
>> On Thu, 17 Nov 2016, Arend Van Spriel wrote:
>>
>>> Not seen a response on the backports mailing list so subscribed to the
>>> cocci mailing list and reposting it.
>>
>> Sorry to have missed seeing it.
> 
> No problem.
> 
>>>
>>> Attached is a script I want to use to backport drivers. However, the
>>> second (unnamed) rule matches for each occurence of 'struct
>>> net_device_ops'. Is there a way to disable a rule after a desired amount
>>> of matches (in my case once)?
>>
>> Here is a somewhat clunky solution:
>>

[...]

>> struct net_device_ops OPS = {
>> +      .ndo_change_mtu = __change_mtu,
>>        ...
>> };
>>
>> -------------------------
> 
> Big thanks. Have not tried it yet, but do you want me to add your
> Signed-off-by given that you mostly solved the problem.

Hi Julia,

It works so let me know if you want me to add the Signed-off-by giving
you proper credit when I submit it as patch to the backports project.

Regards,
Arend
