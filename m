Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AB3C433EF
	for <cocci@archiver.kernel.org>; Thu, 10 Mar 2022 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Gvn8kOGqN9bKo1r/0vLcEbDNzGImw51BY5AbPiFyBIo=;
  b=Rojn34gXwpBU2dKgJdd7z/H3bdjfiBJQm7bnuSn6wYHcE8+BRUt4ULIq
   XVbmJUFHOx3OZfia+ZG/bwd4dECmRxy8VbP+Nng6ams2CDNyx7RIlYbsk
   A6F/ke/yuFardv5Gu23qrVy5oGIYh0leHr/8U+iz6LnRnTAjk6BYeACd/
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.90,169,1643670000"; 
   d="scan'208";a="25341852"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2022 03:25:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9E99E2FB9; Thu, 10 Mar 2022 03:25:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2EA52E2FB8
	for <cocci@sympa.inria.fr>; Thu, 10 Mar 2022 03:25:38 +0100 (CET)
IronPort-SDR: zxpUmpCRm/rry8Zrtkcep153zICHKN02etVc9EqOLFPkjbXGDUD3HWfoXRomfYGrU1K2oPOtq8
 w8R9ycQUrAadT1KR2y2nbsUhbj/chVZZHQVi3l70r+7U4JXHHuFcaLM6V8DASNe2Cgcw09B/y3
 SKlzKNaODJxaDZXULP+QdDK0Mi2kNPSovSJUlt1Va2wsSKtuY/mD0z86eqYoogNBP5eM5aaN2e
 Au7o42z6BC8OmCeEcT7hcl1WtF7c64uKr+xSJudWs3MERhHY3ET+rRL5N3Mvpt0dgpl+6RwQ9A
 AI74mwq/1W2FsUeqicb+DKd5
X-IPAS-Result: =?us-ascii?q?A0BgBQDYYCli/0Xcza1agQmEAgeBTQEBASkEC5QLgiUDn?=
 =?us-ascii?q?lsLAQMBDUEEAQGFBwKEIgIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgMEAYEILAFjAWcBgU4BgXkGBD2CNSkBg2MBAQEBAgE6PwULCxguVwaDF?=
 =?us-ascii?q?4J2Ia1MeIEzgQGJe4E8jkgnHECBTYE8DIJ3PopEBJZmgRWBJwoTCBQReJI4k?=
 =?us-ascii?q?BGBL5xjg1OfVgYULpZFkW2WVaZ5gT85JYFZHxQaCCYKO4JqTQECAQIBDAECA?=
 =?us-ascii?q?gECAQIBAgEIAQECAYd8lREgAQEBaQIGCwEBAwmREl0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:zi0dcK+Zrfm31cI8TafADrUDsniTJUtcMsCJ2f8bNWPcYEJGY0x3m
 GQeUGuDb6vbZmH8f9FxaNmx8UhUusfSz9RiSFZorixEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 ouj+5G31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z5
 8oRs4yhVygVJbT9vrkZSTVpDBFgMvgTkFPHCSDXXc27yl2AfmTszvhqAVtwO4AEkgp1KTgRr
 rpCcG1LNErbwbznqF64YrEEasALJ87gN4I3vnB70SqfAOkmTJ3HTr+M49JEtNs1rpAXRaePN
 5FxhTxHNhfBZERAJHcrC4MAmMitulLEQgwJgQfAzUYwyzOPklcgj+iF3MDuUteNTs5Utl2Jo
 3rPuWX/GBATctKFoRKB+22lguvnjyL+UpgbUry+7P9jxlOJrlH/EzUTRR22vvm0h0qzQZRZJ
 lB8FjcSQbYa21P3SMnsQTKEu2e1mEMYQfZhDN0k51TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mO0c8PV6S9H6+LKFCrMnluAhXbjZnhPdD5qiTosFFNdu7HeTJcPYgUjp+uP/Yawnpv4BjH9z
 jSHtm44iql7YS83O0eTpg+vb9GE/MShousJCuL/Bz7N0++BTNT5D7FEEHCChRuARa7AJrV7g
 FAKmtKF8McFBoyXmSqGTY0lRe/1uabYaWSF2AM/QfHNEghBHVb5Iui8Bxkley9U3jssI2K3C
 KMtkVw5CGBv0IuCNvMpONPuW6zGPIDtCtToW/TZdNtIad0pLWe6ENJGPiatMqGEuBZErJzTz
 r/AKJfyVylGUfo7pNd0Ls9EuYIWKukF7Tu7bfjGI96PiNJyvVaZFuUINkWgdOc84P/WqQnZ6
 Y8PZc+L0AlEFuDhYiTa9YMJa1YHMSFjV5zxrsVWcM+FIxZnQTt9UKWJnOp9IoE1zb5Ikuro/
 22mXhEKwlTIhUrYdVeAZEdlZe69Rp14t386YHIhZA76x3g5bI+zx64DbJ9rL6I//eluwKcsH
 fkIcsmNGNpVTTHD92hPZJXxttUyJhCqnh6VeSe6YDUye5N6AQrE5oa8LAfo8SAPCAuxtNc/+
 uf8jVmDHMNfHgk7VZTYcvOiyV+1rEMxouMqUhuaOMRXdWXt7JNudX77gMg3FN5Qex/N8T2Xi
 lSNChACqOiQ/YJsqIvVhbqJppuCGvdlGhYIBHHS6Lu7OHWI/menxoMcAu+EcSqECTHx6OOve
 uVYwvXxKrsBkUoT69hwFLNizKQf4drzpuYAkl8+RCiSMw2mWuF6P32L/chTrakTlLVXjguBR
 R7d8NdtP7jUatjuF0QcJVd7Y73bh+0UgDTb8d88PF7+uH1s5LOCXEgObQOAjjdRcOl8PI8/m
 Lpzvd5Q5hO/hxcuP8zAiC1IrjzeInsFWqQhl5cbHI6y0FZwkAkfOMCFB3+k+oyLZvVNLlIuf
 G2eip3CsKsAlEDMRHw+SCrW1u1HiJVT5h0TlA0eJ06Ek8buj+Ms2EED6iw+SwlYw32rCQ6o1
 rSH46G0GUmPw9usrM1TGW2zGwxMABCDvEr81zPlUYEfo1aADgTwwK8VYI5hP3z1N0pYfyNH5
 /eV12boXDLnZof30zdatYuJbRD8ZYQZy+AB8fxL2+yBHoImenzona+jaG4FsV3hDN9ZaIgrY
 wV11L4YVJAX/hL8b0H250d2GFjQpN25yLR+fMxc
IronPort-HdrOrdr: A9a23:gwTXequq6KUgUNYWG3aE8p1g7skDctV00zEX/kB9WHVpm62j5r
 mTdJZy73DJYVkqNk3I9ergBEDEewK4yXcX2/h2AV7BZniDhILAFugLhuaP/9SjIVyYygc379
 YDT0ERMr3N5IdB5/rS6gPQKadC/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,169,1643670000"; 
   d="scan'208";a="8109983"
X-MGA-submission: =?us-ascii?q?MDHuMl+JlyKge1Z9dgQOjJwiBYuxcq+Ir0KZTu?=
 =?us-ascii?q?Iaj6KgmA4XHiuChy9V7/3s4ASjac5ysFvL2FWdAQh8BjadbxVPKlb9MX?=
 =?us-ascii?q?sh8T0w2Ovpah7xoPxolw71dIqLkzki4IYkEJB4lFH0Yczk9ctCHEnyMn?=
 =?us-ascii?q?ttYEdmFQ8VddCo07wLeO+BbA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 03:25:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id D3F5681;
	Wed,  9 Mar 2022 18:25:33 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KZWSRhtd5blo; Wed,  9 Mar 2022 18:25:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id B1A9540;
	Wed,  9 Mar 2022 18:25:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net B1A9540
Date: Wed, 9 Mar 2022 18:25:30 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
Message-ID: <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <alpine.DEB.2.22.394.2203090654100.4094@hadrien> <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net> <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 199
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ce6ae8a0-9976-4177-bce7-446d54bdc4f1%40ewheeler.net>

On Wed, 9 Mar 2022, Julia Lawall wrote:
> On Wed, 9 Mar 2022, Eric Wheeler wrote:
> > > Regex groups are not supported.  You can use python to do whatever you
> > > want with the matched terms.  See demos/pythontococci.cocci
> >
> > Thanks Julia.  It seems the Coccinelle =~ matches do not support escaping.
> > I was getting errors trying to match like so:
> >
> > expression E =~ "\.gplot";
> >
> > It works without the \ but errors with the .
> > 	File "cocci/untitled-fix.cocci", line 5, column 35, charpos = 144
> > 	  around = '\.',
> > 	  whole content = expression EXT, arg, E =~ "untitled\.(.*)";
> >
> > It failed scaping \" as well but now I'm unable to reproduce the problem.
> > Sounds like python is the way to go, built-in regex's are useful and might
> > need a bit of cleanup.
> 
> I would imagine that you need to put "\\.gplot"
> I would imagine that escaping is trivial to addres.  

Running this against a few examples:

	@ r @
	constant C =~ "(a)\\.([a-z])";
	@@
	-C
	+"foo"

No match:
	main()
	{   
	    char *a = "a.b";
	} 

No match:
	main()
	{   
	    char *a = "aXb";
	} 

No match:
	main()
	{   
	    char *a = "a\\.b";
	}   

Does match:
	main()
	{   
	    char *a = "a\\b";
	}
... so I'm not sure what escapes are doing with the "." in the regex, it 
seems to have disappeared!

It occurs to me that to match an actual "." I could have used "[.]" in the 
regex instead of trying to escape with "\."

However, for quotes, this spatch:
	@ r @
	constant C =~ "\\\"ab\\\"";
	@@
	-C
	+"foo"

Does indeed match this:
	main()
	{   
	    char *a = "\"ab\"";
	}  
and it makes sense that \ needs escaped and the " needs escaped, thus \\\" 
matches the C string of "\"".  It might be more intuative to the SmPL 
author if the regex matched without all those extra escapes.
 
> I have no idea what one would even want from grouping.

See my example below for a real-world case, but first, a simpler contrived 
example...

> That is, what notation do you expect to use to refer to the groups.  
> And which group, if there are multiple metavariables that use regular 
> expressions?

I would think that the group would be bound to the metavariable since 
the metavariable is tied 1:1 to the regex.

I'm not sure what syntax fits best with the Coccinelle paradigm, so 
whatever works best for you in terms of group reference.  In the examples 
below I use @n where n is the group number.

Here is a possible example to replace the string "az" with "z" and "run 
quick" with "quick run" where @n could be the group number:

	@ r @
	constant C =~ "(a)([a-z])";
	constant D =~ "(run|walk) (quick)";
	@@
	-C
	+C@2
	...
	-D
	+D@2 D@1 /* "quick run", or possibly, "quick walk" */


In my example from the original thread post (below), I was trying to 
replace all constant strings "untitled(\..*$)" with f(group1) because the 
refactor changes things like "untitled.png" to only pass the extension 
".png" (get_nec_filename_stem() will use lookup the original filename so 
"untitled" needs to be dropped and the extension placed in the function 
call.).

There were lots of "untitled.png", "untitled.nec", "untitled.s1p", etc., 
so a quick regex could pull out the filename extension in this case and 
put it in the function call in the right position:

	@ replace_untitled @
	identifier F;
	parameter list PL;
	expression list EL1, EL2;
	constant C =~ "untitled(\..*)";
	@@

	F(PL)
	{   
	+   char newfn[PATH_MAX];
	    ...
	    file_chooser = Open_Filechooser(EL1,
	-       C,
	+       get_nec_filename_stem(newfn, C@1, PATH_MAX),
		EL2);
	    ...
	}

I'm not sure how common of a use-case this was, but if OCaml already 
supports regex groups then perhaps it is trivial to create a "group" 
notation in SmPL for metavariables using regex's.  (Or perhaps not, I 
really haven't used OCaml so I can't comment on how easy that would be!)

Anyway, my needs for this are already met with a combination of SmPL 
cleverness and a bit of manual intervention, so no need to rush about 
trying to implement this on my behalf unless it would benefit others.

-Eric
