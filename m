From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 17 Aug 2017 21:26:06 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708172043460.2068@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <be855581-e22e-2b58-8565-68412ae590b3@users.sourceforge.net>
 <c5f3c8db-e5ec-47c1-3d84-8392a7101645@users.sourceforge.net>
 <alpine.DEB.2.20.1708172043460.2068@hadrien>
Message-ID: <b4451f01-e10a-c0f3-91ff-f49e185b3644@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> elfring at Sonne:~/Projekte/Linux/next-patched> git checkout next-20170803 && spatch.opt ~/Projekte/Coccinelle/janitor/show_same_statements3.cocci fs/ubifs/lpt.c
>> ?
>> @@ -1974,10 +1974,6 @@ again:
>>  		int ret, lnum = lprops->lnum;
>>
>>  		ret = scan_cb(c, lprops, path[h].in_tree, data);
>> -		if (ret < 0) {
>> -			err = ret;
>> -			goto out;
>> -		}
>>  		if (ret & LPT_SCAN_ADD) {
>>  			/* Add all the nodes in path to the tree in memory */
>>  			for (h = 1; h < c->lpt_hght; h++) {
>>
>>
>> Now I wonder how this test result should fit to my source code search pattern.
> 
> I guess there is a loop around this code, so it is reachable from itself.

* How can we achieve progress with such a bit of information?

* Should such false positives be avoided anyhow?

* Will answers to other questions become more helpful again?

* Are there further development challenges to consider for the safe identification
  of unique statements by metavariables?

Regards,
Markus
