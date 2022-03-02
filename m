Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA11AC433F5
	for <cocci@archiver.kernel.org>; Wed,  2 Mar 2022 02:56:07 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,146,1643670000"; 
   d="scan'208";a="23909121"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2022 03:56:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A868DE00D3; Wed,  2 Mar 2022 03:56:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 69A83E00BA
	for <cocci@sympa.inria.fr>; Wed,  2 Mar 2022 03:56:00 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: 0/7c4CULTI2xGI+se9RmyGqqPFPbSpJfKqV9/wmQiVUcKWc57+dRM1CK4elpHMc2fvJcLDsG6n
 QLJxAvlmnKFLWh03dEEVmuO9LGxtk3Cp9mktw15pFurlsMRTtAKcfMal/8bsCJ6T1neRTIbGry
 oc1F9Dk2ngvuIRoetRb5i+OfkGh3E0nxk70nOni7OP4bORajkK9cKEh85eMzHf9+IyHPHWVWzm
 0lEA7kTAY1uD1TcisGqHl2XoLd2wH1wFdxfWtmFmDJ3/xKUw+r0fA9oA/WXG7ZBBZn0raDGptT
 JbsIuSBVvwT1hg81EV74bZMu
X-IPAS-Result: =?us-ascii?q?A0A6BQBj2x5i/0Xcza1agQmEAgd3VgEBASkEC0SVawOeW?=
 =?us-ascii?q?QsBAwENNQwEAQGFBwKEFAIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgMEAYEILAFjAWcBgU4BgXkGBDANgjUpAYNjAQEBAQIBJxMPMAULCxguV?=
 =?us-ascii?q?wYugmkBgnUhD6xCeIEBMoEBg08BhiuBPIYSE0KHXSccQIFNgRUnglMwPoJMF?=
 =?us-ascii?q?wICh1sElWNaIhMscwhKOSEcAjqfd4ITiyeSaoNSiwqUTAYULoNzklA3kSuWV?=
 =?us-ascii?q?I0TlCuBVYNjgT85JYFZHxQaCCYKgyQJRQECAQIBDAECAgECAQIBAgEIAQECA?=
 =?us-ascii?q?Y4oFoNQhRSFayABAQExOAIGCwEBAwmRNy2CGQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:jB9E4aIlKtrDSWTRFE+R6ZMlxSXFcZb7ZxGr2PjKsXjdYENS0DQOz
 WUZUGrTP6yKY2CnLdoiYY/jo01Uv8DQzt9jGVAd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFvU4
 YiaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhuYxL+
 fJVqrqLUiQRYKjqoqdNUAF/OnQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9G1r15gfRK+PD
 yYfQStvTzmROEEfAXNJDZcgsrixtGfCYiIN/Tp5ooJsvzaInVMhuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrS3zTOa+3aorv3OmCnhUcQTEqe5/7hkmjWuKnc7DQ1QWES7rPS9h1T4Xd9DQ
 6AJxsYwhY5uzn2MVsbbZAabmCCBmCRfC9lINMRvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQW6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFb7zg8L1FDz0z
 irMqiUi71nysSLp//7llbwkq2jwznQscuLTzlyGNo5Cxl4RWWJdT9b0gWU3FN4ZRGtZJ3HY1
 JT+p+CQ7foVEbaGnzGXTeMGEdmBvqjZbmSB0AA1QMF6qVxBHkJPm6gLvVmSw28yba45lcLBO
 hKN0e+vzMA70ISWgV9fON7vUJV1ncAM5PzoSfDZY95DeJl3f0rfpUlTib24hAjQfYlFuf9XB
 Kp3hu73VSdKUfk8lWHuLwrfuJdyrh0DKarobciT53yaPXC2PRZ5kJ8JbwmDaP4X9qSBrFmH+
 tpTLZLamRFeS/HlJCTI8YMeKV0Qa342Gcmu+cBQc+eCJCtgGX0gUqWNmul5JtU5xqkFxP3V+
 nydW1NDzAStj3PwKTKVNiJpZoTpUMsttnk8JyEtYAilgiBxfYa14a4DXJIrZr17pvd7xPt5Q
 qBdKcWNC/hCUBrd/DEZYcWvpYBubk371waPJDa+JjUgf5NtQwHTvNnpYlK3piUJCyO2s+o4o
 qGhj1mHGsBbGl0+VcuPMaCh1VK8u3QZidleZUqQL4kBYljo/ahrNzf10K09LfYMHgqflDGU4
 ACbXEUDru7Xro5ortSQ3fKYr52kGvdVF1ZBGzWJ9q6/MCTX8zbxwYJEV+rULznRWHmtpfend
 aNY0PHxPfkKhhBMvpYlS+Rnyqc35t3Oob5Gz10+QC6RNwnyVuptciucwM1ClqxR3bsH6wG4b
 UK45YUIM7u+Ps64QkUaIxAob7nd2KhMyCXS9/k8PG7z+DRzoOicSUxXMhTQ2jZRKqB5bNEsz
 es74ZNE7hz5hwUqP9uCgzoS8WmQdyRSX6Iiv5AcIYnqlgtykA0ZO8SBU3Ov7cHdcchIP2krP
 iSQ2vjIiYNc8VWeIXA9In7AgLhGjpMUtREXklJbfwaVmsDIj+Mc1QFK9WhlVRxcyxhK3oqf4
 ISw25GZ8UlPw9tpuCSHd2W8XQxeBBCU/kHrjV0EiAU1iqVuunPldAUA1SSlpSj1MF6wuhBf/
 aqE0yDoTjbnccX8xG00VFINRzkPizBu3lWqpS1kdvhp27E+YCH5memjemoFph/qG4U3iVGvS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:5+F/wKPV4eXcZsBcTsWjsMiBIKoaSvp037BL7TEJdfQ2Gvb2qy
 nAppomPHPP6Qr5HUtQ/OxoW5PwJ080l6QFhbX5VI3KNGKK1FdAbrsSircKqAeQeREWmNQ86U
 6+ScJDIdf7ZGIK7vrH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,146,1643670000"; 
   d="scan'208";a="23909119"
X-MGA-submission: =?us-ascii?q?MDEaiRjHF4bcxdHTPEQ4zWPp/IHSehlQYry12e?=
 =?us-ascii?q?FDM5Q0Za99CfZvTtSh9bLordyQE0TjVlZFDkRxPApFVRo2CXp7o9OgUc?=
 =?us-ascii?q?GwN+Jv2yG0Sk59J9cWckIHtHvaqKNe8EoovGs6stNmyIDXRohAlgReab?=
 =?us-ascii?q?t7Dcjber2AMyGGRxUnKxkeXA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:55:59 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id E735881;
	Tue,  1 Mar 2022 18:55:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bs6Mo2wbD7cG; Tue,  1 Mar 2022 18:55:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 8D27B41;
	Tue,  1 Mar 2022 18:55:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 8D27B41
Date: Tue, 1 Mar 2022 18:55:47 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203010710230.3160@hadrien>
Message-ID: <5d406855-8b98-e621-b972-b7953a49f049@ewheeler.net>
References: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net> <alpine.DEB.2.22.394.2202280705080.3112@hadrien> <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net> <ff76e0b6-d7cd-de3a-ec2d-b1b1492e2e69@ewheeler.net>
 <alpine.DEB.2.22.394.2203010710230.3160@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can you match identifiers of a specific type?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 161
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/5d406855-8b98-e621-b972-b7953a49f049%40ewheeler.net>

On Tue, 1 Mar 2022, Julia Lawall wrote:
> On Mon, 28 Feb 2022, Eric Wheeler wrote:
> > On Mon, 28 Feb 2022, Eric Wheeler wrote:
> > > On Mon, 28 Feb 2022, Julia Lawall wrote:
> > > > On Sun, 27 Feb 2022, Eric Wheeler wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > Can I match only specific identifier types and names where the type is a
> > > > > typedef? I've been reading as much as I can about Coccinelle but I've not
> > > > > found a way to do it.
> > > > >
> > > > > I'm trying to move global calculation structures into its own typedef
> > > > > structure to create a thread-safe environment where multiple threads can
> > > > > work on different struct instances.  Right now the code works only on
> > > > > static global values so parallelism is not possible without fork()ing.
> > > > > (This is for the www.xnec2c.org project.)
> > > > >
> > > > > The code that looks pretty close to the following:
> > > > >
> > > > > 	// Globals
> > > > > 	typedef struct {
> > > > > 		int a;
> > > > > 	} data_t
> > > > >
> > > > > 	data_t data;
> > > > >
> > > > > 	void f(char *data)
> > > > > 	{
> > > > > 		data[0] = 0; // parameter
> > > > > 	}
> > > > >
> > > > > 	void g()
> > > > > 	{
> > > > > 		data.a = 0; // global
> > > > > 	}
> > > > >
> > > > > I want to put all of the global 'data' variables of type 'data_t' into a
> > > > > new structure as follows:
> > > > >
> > > > > 	typedef struct {
> > > > > 		data_t data;
> > > > > 		// and many others...
> > > > > 	} nec_t;
> > > > >
> > > > > 	nec_t *nec;
> > > > >
> > > > > and replace the functions above as:
> > > > >
> > > > > 	void f(char *data)
> > > > > 	{
> > > > > 		data[0] = 0; // Does NOT change
> > > > > 	}
> > > > >
> > > > > 	void g()
> > > > > 	{
> > > > > 		nec->data.a = 0; // This DOES change
> > > > > 	}
> > > > >
> > > > > With a rule something like this:
> > > > >
> > > > > 	@ rule1 @
> > > > > 	typedef data_t;
> > > > > 	type T = {data_t};
> > > > > 	identifier I = {data};
> > > >
> > > > This means that your variable I should always be called "data".  Is that
> > > > what you intended?
> > > >
> > > > You should be able to do
> > > >
> > > > idexpression data_t I = {data};
> > > >
> > > > Then you want to use the name in a structure field.  Te problem is that a
> > > > structure field is not an expression, it is an identifier.  So you have to
> > > > make the match in two ways:
> > > >
> > > > @@
> > > > idexpression data_t I = {data};
> > > > identifier j;
> > > > @@
> > > >
> > > > -I@j
> > > > +nec->j
> > >
> > > Thanks Julia, that seems to work (I added `typedef data_t;` to the .cocci
> > > file).
> > >
> >
> >
> > Ok so this worked in the simple example .c file:
> > 	@ rule1 @
> > 	typedef data_t;
> > 	global idexpression data_t I = {data};
> > 	identifier j;
> > 	@@
> > 	-I@j
> > 	+nec->j
> >
> > But when I try it on the actual code base I get this:
> > 	]# spatch --sp-file nec-refactor2.cocci src/xnec2c.c
> > 	init_defs_builtins: /usr/local/coccinelle-git/bin/lib/coccinelle/standard.h
> > 	(ONCE) Expected tokens data_t
> > 	Skipping: src/xnec2c.c
> >
> > I have tried:
> >   * adding `-I src/`
> >   * adding `--include src/common.h --include src/shared.h` where data_t is defined.
> >   * adding --include-headers-for-types
> >   * adding --recursive-includes
> >   * Removing the `global` specifier on the idexpression.
> >
> > None of these seem to work, they all skip with the "(ONCE) Expected tokens data_t" error.
> >
> > However, if I hack "data_t data;" into the top of xnec2c.c then it works.
> >
> > There seems to be a problem finding the `data_t data` definition through the headers.
> >
> > What should I do?  Here is the .c file if you want to take a look:
> 
> I think that the file selection is done independent of includes.  A
> solution is to just disable the file selection:
> 
> --disable-worth-trying-opt
>
> You will still need the headers so that the type of data can be determined
> and the matching can take place.  If the connection to the relevant file
> is complex and involves lots of includes, then it is probably best to use
> --include.

--disable-worth-trying-opt option didn't seem to help, maybe I missed 
an include...but read on:

> Another approach could be to just say global idexpression d = {data}.
> If there is only one global variable called data in the entire system,
> this should be fine.

That worked!  I didn't realize idexpression can exclude the type.  All the 
variables I'm replacing are global and this time it didn't replace local 
versions of variables named "data".

The EM simulation completed after variable replacement, so while I still 
need to validate that the output data is the same, I think this is 
working.

Thanks again for your help!

-Eric

> 
> julia
> 
> 
> > 	https://github.com/KJ7LNW/xnec2c/blob/master/src/xnec2c.c
> >
> > and the .h file with data_t:
> > 	https://github.com/KJ7LNW/xnec2c/blob/master/src/shared.h#L219
> >
> > Here is the version:
> >
> > ]# spatch --version
> > spatch version 1.1.1-00044-gb2a4b9b compiled with OCaml version 4.05.0
> > Flags passed to the configure script: --prefix=/usr/local/coccinelle-git
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expressions: PCRE
> >
> > > What does I@j mean?  Can you point me at documentation?
> >
> > -Eric
> >
> 
