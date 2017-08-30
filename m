From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Wed, 30 Aug 2017 13:50:59 +0100
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <WM!d9b0a1156da6c99c9820ebef21a59a8a89d121069b7a3992c73cc9e3056bf05f3193ceae9e855747b5cba0f4c7a73e77!@mailstronghold-3.zmailcloud.com>
References: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708292315050.5428@hadrien>
 <WM!749c3f172b3974a95a60915dcb92be0a7c29793379a0cf5b8c9fa31b26724555bb6748424359219db0307c72c35963de!@mailstronghold-1.zmailcloud.com>
 <20170829221532.ukkaxuvcgr7d25cn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708300722580.2152@hadrien>
 <WM!d9b0a1156da6c99c9820ebef21a59a8a89d121069b7a3992c73cc9e3056bf05f3193ceae9e855747b5cba0f4c7a73e77!@mailstronghold-3.zmailcloud.com>
Message-ID: <20170830125059.eqlq4w54oz57azum@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Aug 30, 2017 at 07:25:00AM +0200, Julia Lawall wrote:
> On Tue, 29 Aug 2017, Ond?ej Kuzn?k wrote:
>> On Tue, Aug 29, 2017 at 11:17:53PM +0200, Julia Lawall wrote:
>>> Allowing format list to match strings in multiple pieces seems like a
>>> somewhat complex undertaking.
>>
>> Again, I have little understanding of
>> how the parser works, but maybe it might be able to keep around a second
>> internal representation of the string as it is concatenated and extract
>> this information from that, even if it did not allow all manipulations
>> on it?
> 
> This was my thought also, but looking at the code, it seems complex.

OK, I understand. I any case, the suggestion below has very few false
negatives and no false positives that I could find, thanks a lot!

The only false negatives are related to macro expansion, which probably
ties into the same limitation. It's strings like this:

"string" BACKSQL_IDFMT "rest of string"

Where BACKSQL_IDFMT is "%llu" or similar. Given how few of these there
are and that there have been no false positives from that that I could
see, I'm happy.

I will see how the sprintf merging will pan out shortly after I clean
out the false negatives and re-test the patch series up to this point.

Again, many thanks! Without coccinelle, this project would not have been
possible at all.

>>> Perhaps the following could be acceptable?
>>>
>>> @initialize:ocaml@
>>> @@
>>>
>>> let fmtn(fmt,n) =
>>>    List.length (Str.split_delim (Str.regexp_string "%") fmt) = 3
>>>
>>> @@
>>> char[] fmt : script:ocaml() { fmtn(fmt,2) };
>>> expression list[2] args;
>>> expression E;
>>> @@
>>>
>>> Debug( E, fmt, args
>>> -, 0
>>>  );
>>>
>>> You would have to duplicate the latter rule for each possible number of
>>> arugments.
>>
>> I'll test it out, the potential problem I see is when I look into the
>> second step, merging the sprintf(buf, fmt,...);Debug(...,fmt2,...,buf,...)
>> calls into a single Debug call. I think I needed similar information
>> there but had no idea how complex the format string was, but will check
>> that patch again as well.

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
