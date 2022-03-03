Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756BBC433F5
	for <cocci@archiver.kernel.org>; Thu,  3 Mar 2022 03:26:41 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,150,1643670000"; 
   d="scan'208";a="24116303"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2022 04:26:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78A94E00CB; Thu,  3 Mar 2022 04:26:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 85728E00BA
	for <cocci@sympa.inria.fr>; Thu,  3 Mar 2022 04:26:37 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: A+0GisuS9SHGdmD5KozrhMuGnCBdIS70hkP29FYbIryklGzckDFpEee+8g4WNiJXyEwwLnCl6S
 DMdd8OoInX0p7RiP73DGY6WnpzuoPf72U824aLRSx8hbXuFCGYW7AflBueTD6/Wg3qr8iXQjwG
 4Lk7E/VhmGrEpgpCALO1wUCVF3r8I3nnNtmIT+75MV0wOHhYQgjTXzBo2MyrWkWEGtPxY3MLTZ
 DxFlcbTYih3+wVxt3x5gY7rcSNo6SgPrdqu9gkbEwQbPfzSsKeMYny+GyYApo72DXc2ljjkmhM
 ZkrmqdjaEDc2WZrV+7dPolAL
X-IPAS-Result: =?us-ascii?q?A0ChBQA8NCBi/0Xcza1agQmEAgeBTQEBASkEC5QLgiUDn?=
 =?us-ascii?q?lkLAQMBDUEEAQGFBwKEGQIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgMEAYEILAFjAWcBgU4BgXkGBAMHM4I1KQGDYwEBAQECATo/EAsYLlcGg?=
 =?us-ascii?q?xeCdiGsBHiBM4EBiXuBPIYTE0KHXiccQIFNgRUnglMwPopDBJV5ehOBJxGBE?=
 =?us-ascii?q?x6iRosnkmqDUp9WGi6Dc5JQkWKWVIJJnnaFOIE/OSWBWR8UGggmCjuCak0BA?=
 =?us-ascii?q?gECAQwBAgIBAgECAQIBCAEBAgGLIYMHFo5PIAEBAWkCBgsBAQMJkmsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:fjndM6v4elvRL7exlj58MIojJ+fnVG5YMUV32f8akzHdYApBsoF/q
 tZmKWmCaPeLa2T3Kt8kaoW+8ElU656Em4NlSwBs+C4wFXgTgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCY0idfCc8IMsboUsLd9UR38g52bBVPyvX4
 Ymo+5aHYgf5s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnYXoQB8MOp3qobkAfj57ODt+MLBDxZaSdBBTseTLp6HHW378hfhxDEw7OYACvOB6HQmi9
 9RBd2tLNEjewbjsmPTlG4GAhex7RCXvFIgYsXph5TXYFuo9B53cQ6jH4dJCmjE9mqiiGN6EO
 5NAN2E3NHwsZTVFOnIYOJAhmdvzgz7ScmZxrnvIh5sotj27IAtZi+Sza4uKKrRmX/59lUGTr
 WPu5HX8GhhcNdqFyDPD/GjEruvGgir/XKoAFbiy7PcsgVuJx2VVBgd+aLegifypzEOhW99SL
 0EOvCwjscDe6XBHUPHkBxSghXq0mCdBRvd3MMYg6AyQz5f9tlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOQGDoIF5WlrGqejJ9WLa1Tw9aD5dNXVdHGPp9vG6+Nlr5i8jWOqPB0JcszEYMTTgh
 T2VrCUzg7gJy8gGy81XHGwrYRr3+PAlrSZvum07u15JCCsjPuZJgKT1gWU3Fd4acO6koqCp5
 RDpW6G2tYji962lmi2XW/kqF7q0/fuDOzC0qQcxQ8d7q2r3pSH/JNs4DNRCyKFBaZ9sldjBO
 xC7hO+szMUOYhNGk4coC25ONyja5fO8S4+0CaC8gitmb4dxeQKD8TtvY0XVhzmFraTfufpXB
 HpaGO7yZUsn5VNPl2LnF79AiuZwnkjTBwr7HPjG8vhu6pLGDFb9dFvPGALmgjkR4PzWrQPL3
 cxYMsfWmRxTXPenMnvT8JUPNhYHMng2CJT7sYpRe/LaelhqH2QoCvnwx7I9etU/w/8PzrqRo
 iiwCh1C1V7ypXzbMgHUOHptX7PYQsotp3wMOyFxb02j3GIuYNvx4f5HJYc3Z7Qu6Mdq0eVwE
 6seY8yFD/kWEmbH9j0RYIPTtotncBj31wuCMzD8MGo7foV8XErE5d/pcw/i7m8IAzbu7Zkyp
 Lip1wX6R5sfRl04UJ2MMK/2kwq85CFPlvhzUk3EJshoVH/tqIU6eTbsivIXIt0XLUuRzDWt1
 zGJXUUSq97LrtJn69LOn62F8tmkSrMsAkpAEmDHxr+qLi2GrHG7yIpNXevULzDQUGT4pPera
 elPlqyuNe1BkUlKvod4Hqwty68ivoO9q7hfxwViPXPKc1XyUO87eCHbhJUWu/0f3KJdtCu3R
 lmLpItQN4KJD9y5QlQfEwwoM7aY3vYOlziPs/lseBfm5DV69aasWFlJO0XekzRUKbZ4bNE/z
 eE6tJJE4gCzkEN3YNOWyC1L92mBKnEaFaMqqshCUoPsjwMqzHBEYIDdU3Wqu8vXNowQa0R6c
 CWJgKfihqhHwhSQeXQEFU/SgbhXi6MItU0Y11QFPVmIx4TI36dlwB1L/D0rZQ1J1REbgflrM
 21mOkAdyX9iJNu0aByvnlxAGj2twDWc6gr81FsEmWnUVQ+uW3ClwKjR/wqS1Bhxzo6eVmEzE
 HKkJKLNVTfxYNq30zQyVENhpualS9FtnuEHdAZLAOzdd6TXolPZbmuGYWsTtwChDNwxiUDDq
 PMs+utsAUE+2ej8vIVjY7SnOX8spNxo6YCMrTyNPE/EII0ERAyP5A==
IronPort-HdrOrdr: A9a23:Onuc1KzvBRwqtkcjX5l/KrPwKL1zdoMgy1knxilNoH1uA7Wlf6
 LHppsmPHDP5gr5NEtApTnEAtjkfZq+z+8S3WByB8bHYOCOggLBR+wP0WKh+UyGJ8SUzJ8+6U
 4PSchD4QLLZ2RSh8yS2njaL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,150,1643670000"; 
   d="scan'208";a="24116300"
X-MGA-submission: =?us-ascii?q?MDHECWh126wG01O4RWePpBXYNw6Xvo/imvxFlR?=
 =?us-ascii?q?HhPBgtCeADVS1/LUSjbozTIllsoWwiBeMRtBrZ7NcpI1kXdZO24Ptq/L?=
 =?us-ascii?q?Sx0K759DaVN+QF6aotto48namXjfWpKZ5YW3WRDIxrLHqaLCZBhpnBXb?=
 =?us-ascii?q?DNiPeAuIBCFF1g8Bw8FeRwjw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:26:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 0CBE449;
	Wed,  2 Mar 2022 19:26:34 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c2S5CADcX3FX; Wed,  2 Mar 2022 19:26:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 3401E48;
	Wed,  2 Mar 2022 19:26:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 3401E48
Date: Wed, 2 Mar 2022 19:26:30 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203020820050.3162@hadrien>
Message-ID: <1ac1a9c-d25e-746f-4a31-2cef61a12aca@ewheeler.net>
References: <9225d1eb-8211-53d7-9cec-bdbda52f743b@ewheeler.net> <alpine.DEB.2.22.394.2203020820050.3162@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How can I find all static variable declarations?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 165
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/1ac1a9c-d25e-746f-4a31-2cef61a12aca%40ewheeler.net>

On Wed, 2 Mar 2022, Julia Lawall wrote:
> On Tue, 1 Mar 2022, Eric Wheeler wrote:
> > Hello,
> >
> > I'm trying to find all static variable declarations (either global or
> > within a function:
> >
> > 	static int global_x, y, z;
> >
> > 	void foo()
> > 	{
> > 		static int a, b, c;
> > 	}
> >
> > with a patch like this:
> >
> > 	@ rule1 @
> > 	identifier I;
> > 	type T;
> > 	@@
> > 	static T I;
> > 	+ // static ^^
> >
> > It gets single variable declarations:
> > 	   static gint iv[4];
> > 	+  // static ^^
> >
> > but not multiple variable declarations like the foo() example above
> > because 'I' only matches a single variable in the rule.
> >
> > It also matches functions, but I really only want variables (if possible):
> > 	 static void subph( int nx, int ny );
> > 	+// static ^^
> >
> > I tried an identfier list:
> > 	@ rule1 @
> > 	identifier list IL;
> > 	type T;
> > 	@@
> > 	static T IL;
> > 	+ // static ^^
> >
> > but gives the error:
> >
> > 	init_defs_builtins: /usr/lib64/coccinelle/standard.h
> > 	minus: parse error:
> > 	  File "nec-static.cocci", line 5, column 9, charpos = 50
> > 	  around = 'IL',
> > 	  whole content = static T IL;
> >
> > What is the right way to do this?
> 
> What you tried should have worked.  And it should not have matched
> function definitions.  I will check on it.

Thanks for checking!

FYI:

]# spatch --version
spatch version 1.1.1-00044-gb2a4b9b compiled with OCaml version 4.05.0
Flags passed to the configure script: --prefix=/usr/local/coccinelle-git
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

Let me know if there if you have a patch or git update and I'll try it out.

> 
> >
> > I'm just printing the diffs so I can inspect the code, sort of using
> > `spatch` like a semantic grep.  Is there an official way to do "semantic
> > greps"?
> 
> Use * instead of - or + for the things you are interested in.  You will
> still get a diff, but the - lines are the ones that match what you wanted
> to see.

Neat!  I'll give it a try.

--
Eric Wheeler



> 
> julia
> 
