From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 12:55:53 +0100
Subject: [Cocci] Finding missing return value checks for some function
 calls with SmPL
In-Reply-To: <alpine.DEB.2.10.1612021143050.3056@hadrien>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
 <e853f47b-78be-7450-a420-b301f4f504d1@users.sourceforge.net>
 <alpine.DEB.2.10.1612021143050.3056@hadrien>
Message-ID: <298f7485-a554-11ab-97f1-31e2ba2a6b0f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_too_late_checking2.cocci ../Probe/clk-mstp-excerpt1.c
>> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
>> HANDLING: ../Probe/clk-mstp-excerpt1.c
>> diff =
>> --- ../Probe/clk-mstp-excerpt1.c
>> +++ /tmp/cocci-output-20109-52f048-clk-mstp-excerpt1.c
>> @@ -5,7 +5,6 @@ static void __init cpg_mstp_clocks_init(
>>  	struct clk **clks;
>>  	unsigned int i;
>>
>> -	group = kzalloc(sizeof(*group), GFP_KERNEL);
>>  	clks = kmalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
>>  	if (group == NULL || clks == NULL) {
>>  		kfree(group);
>>
>>
>> I imagine that there are further software improvements to consider around
>> such use cases.
> 
> Not sure what you are asking about here.

A bit more explanation can be found in my update suggestion
?[PATCH 3/4] clk/Renesas-MSTP: Less function calls in cpg_mstp_clocks_init()
after error detection? from 2016-09-14.

https://patchwork.kernel.org/patch/9332367/
https://lkml.kernel.org/r/<b945de99-815a-b380-e13c-17b01e0febad@users.sourceforge.net>


> Note that it is unlikely that anyone would accept a patch on the above code.

I would agree because I used the asterisk functionality from the Coccinelle software
just to try another source code search pattern out a bit more for test purposes.

I guess that corresponding syntax elements can be clarified further.


> Group is tested before it is used.

But can it be that this assignment is checked a bit too late?

Regards,
Markus
