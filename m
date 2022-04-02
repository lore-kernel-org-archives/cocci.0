Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986E1C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cH4Nh4msIQdrOxsmcwMS/UaMakTcE23T1P1fEVztoo8=;
  b=k5Wzu3g9TpSyjdJLwFFXnu4Z63yq05/jv/OGFJVwl0yJ+XEcweAxdHTo
   BoT6wmOMgYTSicnTYR0PH7BDZ72in7sV3TY1UbSddEkaawdtxowpzU7en
   mPuEEBEnCvvMMVdlY4dfoOiozsx3IiUMKuPjGJL6CL8r4PmiQVa5U0u1n
   U=;
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29700728"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 22:59:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24887E033B; Sat,  2 Apr 2022 22:59:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 64EDFE00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 22:59:45 +0200 (CEST)
IronPort-SDR: k8Y1j0HVZRypAJdkIHsU3fPIueI4XBSnQKDhwxOcxPkYChQSz3b10u7ONUd9QHIRhOlv2qKWsE
 jHW5whnhgxV3I4OZShECyfiTUivaJUSIgJa6ccJlRDXPWWwcvuQRed5PfOMfMcO22+k14KiMqQ
 lJC9jaOu4OXbV9+T9OzK8IIuL4prIETRuC5D03cbp+m/HP/Ltm+ZrevZZ4oBAF7tNawWAupDMw
 ZEzXLx/Bda1MIpkSlPGmFURw2jVGXQMXc6hyM7quoazyXzQNgORyYDRAXBLblACtdC+2IxJjUX
 GNYh2cgBKBi4Vghq/B2032Lr
X-IPAS-Result: =?us-ascii?q?A0B4BQBTuEhi/0Xcza1agQmEAgd3VgEBASkEC5QLgiUDn?=
 =?us-ascii?q?mMLAQMBDTMQBAEBhQcChFoCHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAGBCCwBYwFnAYFOAYF5BgQwDYI1KQGDZAEEATo/BQsLRlcGgxcBg?=
 =?us-ascii?q?nUhrzKBM4EBg08BhiYGgTyOTiccQIFNgTyDAz6CYwKHPSIEmUcGPlEBGxAJc?=
 =?us-ascii?q?kgKEYEZoh+eIINTixWUUxoullGRfpZeikyCTJQ/hTWBPzklgVkfFBoIJgo7g?=
 =?us-ascii?q?mpNAQIBAgEMAQICAQIBAgECAQgBAQIBjigWFYM7in4hAQEBaQIGCwEBAwmQB?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ofhqaaLzmOI7RmXwFE+R7JMlxSXFcZb7ZxGr2PjKsXjdYENShWMCm
 2sWXTvXPPaIYGH1L9t1PYXipk4FvseBy9VkTlQd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhX1vX4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhkIlQw
 pJR5a2KVQYbP6LMo+gfbDV/DHQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9G5o3ZAXQaePD
 yYfQTd2dlfZZDxNAEtUGcxm27ynuHvgUTIN/Tp5ooJsvzaInVMhuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrS3zTOa+3aorv3OmCnhUcQTEqe5/7hkmjWuKnc7DQ1QWES7rPS9h1T4Xd9DQ
 6AJxsYwhadr1UbsUonMZQG5kn+LviUQWeV8NPJvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQW6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFb7zg8L1FDz0z
 irMqiUi71nysSLp//7qlbwkq2jwznQscuLSzl+NNl9JFisjOOaYi3WAsDA2LZ9ode51tGWps
 nkegNS55+sTF5yLnyHlaLxTQOH5u6jcamaB0QYH83wdG9KFoS/LkWd4u2oWGauUGpxZJ1cFn
 meN0e+u2HOjFCD2M/QmPNLZ5zUCwLfgGNnhW+rVaNELOsEZSeN01HoGWKNRtkiz+HURfVYXY
 szEIZ71XS9FUcyKDlOeHo8g7FPi/QhmrUu7eHwx507PPWO2aCHHRLEbHkGJa+xlvqqIrB+Mo
 4RbNtCW0FNST+3zby3a68gVIExTdSo3ApX/qsp2cO+fI1M8RDp7U6KIneosK95/gqBYtubU5
 XXjCEVW/1rImiGVIwu9bH0+OqjkWoxyrC9lMHV0b0qowXUqfa2m8LwbK8ksZbAi+eE6lax0Q
 vAJdt+uGPNKTjibqT0RYYOk/N5mdQ+3nkSDICqobTwyZdhmShCQoo3oeQ7m9S8vCCurtJJk/
 +b6jl6CHcMOHl0wAtzXZfSjy0KKkUIcwO8iDVHVJtRzeVn39NY4ISLGjsgof5MGJyLFy2bIz
 A2RGxoZ+LfA+tdn7NnTiKmYhI61CO8iTFFCFmzW4LvqZynX+m2vnd1JXOqSJG2PUXOy9bqia
 OhRwuu6NvAbxQ4Yv415Grdt7KQ/+9q2/eMBlFw5RSmSYgT5EK5kL1mHwdJL6P9HyIhZjhTqC
 EiBzd9XZOeSM8T/HV9Megd8Nraf1esZkyX55OguJBmo/zd++beKDRdIMx+XhHAPJbd5Ktp4k
 +Ix/sMJ6wGyjhcwdNCLknkMpWiLK3UBVYQht40bWdW30VBzlwgeOJGMWDXr5JyvaslXNhd4K
 DGjhJ3d2+ZWyH3EfidhDnPKx+dc2MoD4UgY0F8YKl2VsdPZnftrjgZJ+DE6Qwk9Is+rCA6v1
 ryH9nGZJJliOx9tlI5OQGChFgVMHluf91CZJ57lUoHGZxHAa4APBDRV1SWxEIQx92NHYiMd8
 a6YxWvhXCyseszttsf3tYiJtNS7JeGcNWT+dASPG8WeA4J8bCXlj6KqaHBOrRb7aS/0aIsru
 sEylNtNhWbH2eL8bkH150R2FVjddfxcGFF/fA==
IronPort-HdrOrdr: A9a23:UhA2PK9i0MwGyL2q7VJuk+DcI+orL9Y04lQ7vn2ZKCYlC/Bx9a
 iV88jzuiWbtN98YhAdcJW7Scy9qBDnhPhICOsqTNOftWDd0QPCQe1fBMnZslrd8kbFh4xgPM
 lbE5SW1+ebMXFxh6/BkWqFL+o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10381499"
X-MGA-submission: =?us-ascii?q?MDHN/bGwrFj2OP+tJzluS2d4FXy/t+pB6nb+Qh?=
 =?us-ascii?q?mRgTwEqBRFOc+bD7hbNngNQ41XnOyGT1REGQurIkG9rCIQ+jwp309xVs?=
 =?us-ascii?q?eoR/FWg1YVSj6fZu1FJgbf0N0c3vhONI3ZL+UsrcA19z+mBqsMgvs5lt?=
 =?us-ascii?q?tnfYo3Dgfx+8tDPtzF9almDA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 22:59:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 1080747;
	Sat,  2 Apr 2022 13:59:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ca6Jg16IVKro; Sat,  2 Apr 2022 13:59:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 860D539;
	Sat,  2 Apr 2022 13:59:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 860D539
Date: Sat, 2 Apr 2022 13:59:33 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2204021940530.3208@hadrien>
Message-ID: <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
 <alpine.DEB.2.22.394.2204012224060.3048@hadrien> <5f832bd0-37e2-3417-df60-4cdbc5cf5fb8@ewheeler.net> <alpine.DEB.2.22.394.2204021940530.3208@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 337
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/859aa8f6-9b42-b114-bbbc-2964dd47248%40ewheeler.net>

> > Is there a reason that spatch should treat a list of files on the
> > cmdline differently than a list of files coming out of a directory?
> 
> So that you can have semantic patches that cross multiple files.  Ideally,
> you would find the files that go together, eg for each device driver, and
> then run spatch for each.  There is also a way to make a file with the
> names of the files that go together, separated by blank lines.  But that
> is a lot of work, and fragile over time.
> 
> > Much faster as a directory:
> >
> > 	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci src/
> > 	real	0m0.980s <<<
> >
> > Slower even with `parallel` on a list of .c files:
> >
> > 	]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> > 	real    0m1.224s
> >
> > 	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> > 	real    0m4.852s
> >
> > > It seems that you don't want to process resources.c.  Maybe the semantic
> > > patch should be adjusted so that the code in resource.c is not matched?
> > > With python or OCaml you can also cause Coccinelle to exit on a file you
> > > don't want to process.
> > When you say "exit", will it skip the file or exit and skip any later
> > files?
> Just stop processing of the current file.
> > How do you skip a certain .c file in the patch?
> @script:ocaml@
> @@
> if List.mem (List.hd(Coccilib.files())) ["badfile1";"badfile2"]
> then Coccilib.exit()
> 
> > Is there a way to list exclusively which .c files I would like to use? For
> > example:
> >
> >    ]# spatch -j24 --sp-file cocci/printf-refactor.cocci `git grep -l printf`
> >                                                         ^^^^^^^^^^^^^^^^^^
> 
> Coccinelle already finds the words in your semantic patch that are
> important for a change to occur, and only parses files that contain those
> words.

Ok, then maybe I'm trying to optimize something that doesn't need 
optimized.

> > I tried --use-gitgrep but I'm not sure that it did anything, or at least
> > the time didn't change substantially:
> 
> You can see from the HANDLING and Skipping output what is being parsed and
> what is being skipped.
> 
> Perhpas your semantic patch is not written in a way that allows spatch to
> find out what the important words are.  You can run spatch --parse-cocci
> and it will show you the important words at the end.

It is getting the important words for grepping:
	Grep query printf || stderr || fprintf

> Note that putting the above script will cause there to be no more
> important words and thus all files to be considered, because the script
> code applies to all files.

Interesting.  To confirm my understanding: Did you mean that including 
your @script:ocaml@ example would prevent important word processing?  

> You can use the --file-groups <file> argument with the files of interest
> like this

Should --file-groups work with spatch -jN such that each group is 
processed in parallel?  It seems that --file-groups is the same as putting 
it on the command line, at least in the trivial case of a single group:

Directory is parallel:
	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
	real	0m1.063s

File-groups are serial:
	]# git grep -l printf  > f
	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci --file-groups f &> /dev/null
	real	0m4.959s

Same thing, serial, without the temp file "f" using <() since 
--file-groups doesn't appear to seek():
	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci --file-groups <(git grep -l printf) &> /dev/null
	real	0m4.981s

-Eric

> But in most cases this doesn't seem like a good idea.  The list of files
> could change over time.
> 
> julia
> 
> > 	]# time spatch --use-gitgrep -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
> > 	real	0m1.305s
> >
> > 	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
> > 	real	0m1.300s
> >
> > These are small numbers and doesn't really need a speed increase for this
> > patch, so this question is really about future patches that may take
> > longer to process.
> >
> > -Eric
> >
> > >
> > > julia
> > >
> > > >
> > > > Not sure if this is an spatch bug or not, but its ~3x faster to use
> > > > `parallel` as follows:
> > > >
> > > > ]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> > > > real	0m1.224s
> > > >
> > > > ]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> > > > real	0m4.852s
> > > >
> > > >
> > > > Here is the SmPL:
> > > > 	@ p4 @
> > > > 	expression list EL;
> > > > 	constant C =~ "BUG";
> > > > 	@@
> > > > 	-printf(C, EL);
> > > > 	+BUG(C, EL);
> > > >
> > > > 	@ p3 @
> > > > 	expression list EL;
> > > > 	constant C =~ "warn";
> > > > 	@@
> > > > 	-printf(C, EL);
> > > > 	+pr_warn(C, EL);
> > > >
> > > > 	@ p @
> > > > 	expression list EL;
> > > > 	constant C;
> > > > 	@@
> > > > 	-printf(C, EL);
> > > > 	+pr_info(C, EL);
> > > >
> > > > 	@ p2 @
> > > > 	expression list EL;
> > > > 	constant C;
> > > > 	@@
> > > > 	-fprintf(stderr, C, EL);
> > > > 	+pr_err(C, EL);
> > > >
> > > >
> > > > The .c files are from here:
> > > > 	https://github.com/KJ7LNW/xnec2c
> > > >
> > > > --
> > > > Eric Wheeler
> > > >
> > > >
> > > > >
> > > > > julia
> > > > >
> > > >
> > >
> >
> 
