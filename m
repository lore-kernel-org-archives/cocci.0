From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 11:20:55 +0100
Subject: [Cocci] how to debug missing match?
In-Reply-To: <20141221095337.GA1081@katana>
References: <20141221095337.GA1081@katana>
Message-ID: <20141221102055.GB1081@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> does not result in anything although three drivers should match IMO with
> the same pattern as the pmu driver above. Both use
> platform_driver_register() and both have the .owner field set.
> 
> drivers/macintosh/windfarm_pm112.c
> drivers/macintosh/windfarm_pm72.c
> drivers/macintosh/windfarm_rm31.c
> 
> How can I debug why the match does not occur?

So, I found "--verbose-parsing" to be helpful which gives me:

parse error 
 = File "drivers/macintosh/windfarm_pm112.c", line 685, column 4, charpos = 17702
    around = 'nr_cores', whole content = 		++nr_cores;

which basically means that it can't handle for_each_node_by_type()?

bad: 	for_each_node_by_type(cpu, "cpu")
BAD:!!!!! 		++nr_cores;

But neither "--include include/linux/of.h" nor "--recursive-includes"
does help the case for me?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141221/6a5b7940/attachment.asc>
