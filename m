From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 29 Aug 2017 23:15:33 +0100
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <WM!749c3f172b3974a95a60915dcb92be0a7c29793379a0cf5b8c9fa31b26724555bb6748424359219db0307c72c35963de!@mailstronghold-1.zmailcloud.com>
References: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708292315050.5428@hadrien>
 <WM!749c3f172b3974a95a60915dcb92be0a7c29793379a0cf5b8c9fa31b26724555bb6748424359219db0307c72c35963de!@mailstronghold-1.zmailcloud.com>
Message-ID: <20170829221532.ukkaxuvcgr7d25cn@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Aug 29, 2017 at 11:17:53PM +0200, Julia Lawall wrote:
> On Tue, 29 Aug 2017, Ond?ej Kuzn?k wrote:
>> Hi again,
>> having achieved some consensus to go ahead with this in the project and
>> some time to spare again, I have started on refining the patch to get as large
>> part of the OpenLDAP source code converted as possible.
>>
>> There seem to be a few hundred occurrences that I can't seem to get
>> coccinelle to process, a few too many to process manually (by an order
>> of magnitude).
>>
> 
> Allowing format list to match strings in multiple pieces seems like a
> somewhat complex undertaking.

Hi Julia,
I thought matching multiple part strings had worked before, but maybe
not the format string part of it. Again, I have little understanding of
how the parser works, but maybe it might be able to keep around a second
internal representation of the string as it is concatenated and extract
this information from that, even if it did not allow all manipulations
on it?

Or maybe a solution that could be shared with the one for
stringification/concatenation (# and ##)? But at the moment, I think
coccinelle struggles with these as well, so maybe not.

> Perhaps the following could be acceptable?
> 
> @initialize:ocaml@
> @@
> 
> let fmtn(fmt,n) =
>    List.length (Str.split_delim (Str.regexp_string "%") fmt) = 3
> 
> @@
> char[] fmt : script:ocaml() { fmtn(fmt,2) };
> expression list[2] args;
> expression E;
> @@
> 
> Debug( E, fmt, args
> -, 0
>  );
> 
> You would have to duplicate the latter rule for each possible number of
> arugments.

I'll test it out, the potential problem I see is when I look into the
second step, merging the sprintf(buf, fmt,...);Debug(...,fmt2,...,buf,...)
calls into a single Debug call. I think I needed similar information
there but had no idea how complex the format string was, but will check
that patch again as well.

Thanks,

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
