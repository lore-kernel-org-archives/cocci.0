From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Aug 2018 11:36:08 +0200
Subject: [Cocci] Adjustment for const qualification
In-Reply-To: <alpine.DEB.2.20.1808151127520.2309@hadrien>
References: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
 <b417bf64-7970-8482-0246-ab00129b4657@users.sourceforge.net>
 <alpine.DEB.2.20.1808151127520.2309@hadrien>
Message-ID: <94cb119a-e880-2442-35e7-c1286ea8b032@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How do you think about to try the following SmPL script variant out?
>>
>> @replacement@
>> @@
>> -const
>> +__genl_const
>>  struct
>> (
>>  genl_multicast_group
>> |genl_ops
>> )
> 
> This is rejected by the semantic patch parser.

Can my update suggestion make sense if the parsing software
will be adjusted anyhow?

Does this variant need a small adjustment to get it working
with the current tool version?

Regards,
Markus
