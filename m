From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 18 Sep 2018 23:52:16 +0200
Subject: [Cocci] 0079-netdev-destructor.cocci very slow
In-Reply-To: <1537262543.2957.19.camel@sipsolutions.net>
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
 <1537262543.2957.19.camel@sipsolutions.net>
Message-ID: <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/18/2018 11:22 AM, Johannes Berg wrote:
> On Mon, 2018-09-17 at 23:55 +0200, Hauke Mehrtens wrote:
>> The 0079-netdev-destructor.cocci spatch in backports is very slow for
>> me. For bigger files I get a warning that it takes over to 15 seconds to
>> apply it to just one file, for the complete backports tree it takes over
>> an hour to apply.
>>
>> This is the patch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0079-netdev-destructor.cocci
>>
>> When I remove the <-- --> in the first rule, it is applied in some
>> seconds on the complete tree, so an speed improvement of about 100
>> times, but it is not working correctly any more. ;-)
>>
>> Is this normal or how can I improve the spatch to be faster? I am using
>> coccinelle 1.0.7 build with default configure arguments against the
>> libraries from Debian stable.
> 
> We've had this discussion before :-)
> I think we determined that it was normal.
> 
>> If this is normal I should probably try to reduce the number of files it
>> tries to apply this against in gentree.py before spatch gets started.
> 
> spatch should already try that internally, but perhaps with some extra
> knowledge we can do a better job ...
> 
> johannes
> 
Hi Johannes,

Yes we talked about this topic some months ago in IRC.
If there is really no better solution, then I will grep in all files for
needs_free_netdev and priv_destructor and only apply this to the files
which are matching. This list should be pretty short.

It looks like coccinelle already does such a grep when I remove the <--
--> from the patch, because this is about 100 times faster.

Hauke

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180918/07796208/attachment.asc>
