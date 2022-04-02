Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6342FC433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QOs4Q3oafNbIv7MQwUs1B5XaRicdiJp5R+SzySa5Yn4=;
  b=m96ycndgiZluA6mgFJIhbCIlB8kJBS+r6PhID9zYMb88IhsOCkHg+kXJ
   XI8pTl11NwMCVNdCgd9iS/xS+A5g63IMZvGgV0jzSXIazcNrk1QmMo/n2
   LAUv+YnmpL0FMOaLOb50ag3n+0EdRwBKRI9ljZOuNwKBlnXaZtbbbHb5C
   8=;
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
   d="scan'208";a="29705770"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 01:03:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 55FE1E033B; Sun,  3 Apr 2022 01:03:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 38DA5E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 01:03:55 +0200 (CEST)
IronPort-SDR: iElxVJ4sZ1YBN4zSHuORAS01JEV8ddbK4B7eEKgRAtPpNoZyaI2sXhA+lIegvq7FY82G5HpPuH
 V931/AOmRt1lynRKu0r02YMz/RHbxAzs8oFOVQLFzwruU5vhkvDD1Neeb8n8uTfIJCYSGk8Lyf
 Z9yGOrFyy3sKJK74D8xKzcDXCPIomj26PRjbCY0WCiUpiTWHhr/ZiaD2cMgaxfKNPtIIvr1ijS
 lr6355/IHpDfZEwMTALHZdwuddGlrfbesCkE5k9dJs9wYl6uTldFFbqCkJAbT8QwS6UvC6LFvS
 0Ubb/6jqCAwSqDhGHurrOHIL
X-IPAS-Result: =?us-ascii?q?A0AVBQCR1Uhi/0Xcza1agQmEAgeBTQEBASkEC5YwA55jC?=
 =?us-ascii?q?wEDAQ1DBAEBhQcChFoCHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAFWMiwBYwFnAYFOAYF5BgQDCDKCNSkBg2QBBTo/EAsYLlcGgxeDF68tg?=
 =?us-ascii?q?TOBAYl8gTyOTiccQIFNgTwMgnc+iiIiBJlHBj5RAYEmSAqBKqIfiy2Sc4NTn?=
 =?us-ascii?q?2gaLpZRkX6WXqFXgVGDZIE/OSWBWR8UGggmCjuCak0BAgECAQwBAgIBAgECA?=
 =?us-ascii?q?QIBCAEBAgGFM4h1FhWOOSEBAQFpAgYLAQEDCZAGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:tAitTKA2GTRWXhVW/+Plw5YqxClBgxIJ4kV8jS/XYbTApDklhDAGm
 mQbUWjSbvyJYGb2KYsiOdi3/UoHvMKGn9IyOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YThWVvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYozuIrshU0
 fsQjMaTDiAqEbXNpdskeCANRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcBhGxg2pgRQZ4yY
 eITbj9+bAzMWiFQBQ43Vp4zt9WPizrWJmgwRFW9/vZpuDmMnGSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkDThAJVVa2pfSjzEizR7qzN
 nD45AIgrJkq0VWFE+CnfFqfo1GcvyMjYvFpRrhSBB629oLY5AOQB24hRzFHacA7uMJeeQHGx
 mNljPuyWmMy6Oz9pWa1s+bL/WnraED5OEdbPXdcJTbp9eUPt23as/4iZtNzVqOqjtD4HTzqh
 TaHsEDSZon/b+ZXj81XHnid31pAQ6QlqCZvuG07uUr/tGtEiHaNPdDA1LQixa8owUbwZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuarVYWeA3gY2QsB/n9hIx5JFVdsJiN2ZDBwyWvvohBezP
 RG7Vf15uve/w0dGnYcsP9zqWpt6pUQRPdn6Vv3ZatdUY556MVfelByClmbLt10BZHMEyPllU
 ap3h+7zVS5CYUmmpRLoL9ogPUgDnXthlTuKFcmkl3xKE9O2PRaodFvMC3PWBshR0U9OiFy9H
 w93O5TYxhNBfvf5ZyWLo4cfIUpTfSo/BIvqsIpaae6OLw5rAicnBuOImeEtfIlsnqJ0kObU/
 yjnBhQCkAem2STKeVeQd3RuSLLzRpIh/3g1CiwbIgr60XYUZ4vyvrwUcIE6fOR5+bU7n+J0V
 fQMZ+6JHu9LFmbc4z0YYJSk9N5ieR2niBigJS2gZDRjLZdsSxaQqo3gfxDz728DESq6uM8zu
 fum2x+CGcgPQAFrDcD3bvOzzgrr4SNHwL8rAxLFe4ABdl/t/Y5mLz3KosU2e8xcew/ewja61
 hqNBUlKr+f6o7gqrIvDi5eCotr7COB5BEdbQjfWtO7kKSnA82O/6oZcS+LULyvFXWb59aj+N
 +VYy/bwbK8OkFpQ6tcuFqYtwL0+6tbrqqUcyAl4RS2ZY1OuA7JmA3+HwcgW7PEWnOcE4FfvV
 xLd4MReNJWIJNjhTgwbKj0lWfvfh/sarT/fsKYuK0Lg6S4qorfeCRdOPwOBgTB2JaduNN932
 v8ovcMbt16lhhwxPorUhyxY7T3RfHkQFag4tpwXBILxzAwm1ggaM5DbDyb35rCJaslNaxN2e
 WXM2fOe3rkMlFDfd3cTFGTW2bQPj5o5uCdVkA0IKWOPl4eXnfQwxhBQrGo6F1wH0hVd3utvE
 WF3LEkpd76W9jJlicUrs7pAwO2d6Ml1O3AdymflUEXcXw+lSWzAIWkwI6CL8VxxH6ewuNRE1
 Onw9YoneW+CkALNMu8aXU9+t+elQMNx+wDGldrhGcmZd3X/jfwJnYf2DVflaHLb7QcZgEzcu
 fIs8flwZKD/ODRWpaAnY2VfOXL8VzjcTFF/rTpdEG/l0I0SlPxeGdRDFqxpRv5wGg==
IronPort-HdrOrdr: A9a23:tMDLoKnDK8KAAHnLMORG/ceGGFrpDfIo3DAbv31ZSRFFG/Fw9v
 re5cjyt3fP5wr5N0tPpTntAsi9qDbnhPtICOoqTNGftWvdyQ+VxehZhOOIrlHd8m/Fh4lgPM
 xbAspD4bPLbWSSUvyR3CCzGb8bsbq6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10384074"
X-MGA-submission: =?us-ascii?q?MDE8rojQrHAb+hnmlhUfhhdIB/5fEc8/sBvTPG?=
 =?us-ascii?q?UFlodrRKkOTc1ezsj5SzMVfvcSeBAWdevZalWMUDBggPOSqCT6QiaZ09?=
 =?us-ascii?q?rwej6PlblP3KpaXhn/44WlO75C+hCYhOa4aFpzIh0MfvUNCQ5JtXQOQm?=
 =?us-ascii?q?/JNTIOFOrZdvHiLD8vO4ehkw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 01:03:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id A11684A;
	Sat,  2 Apr 2022 16:03:51 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1MgBDiUZjHTO; Sat,  2 Apr 2022 16:03:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 726CF39;
	Sat,  2 Apr 2022 16:03:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 726CF39
Date: Sat, 2 Apr 2022 16:03:48 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2204022318100.3208@hadrien>
Message-ID: <ff9e39af-d654-2824-ecfd-b7cce56d4ef@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
 <alpine.DEB.2.22.394.2204012224060.3048@hadrien> <5f832bd0-37e2-3417-df60-4cdbc5cf5fb8@ewheeler.net> <alpine.DEB.2.22.394.2204021940530.3208@hadrien> <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net> <alpine.DEB.2.22.394.2204022318100.3208@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 342
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/ff9e39af-d654-2824-ecfd-b7cce56d4ef%40ewheeler.net>

On Sat, 2 Apr 2022, Julia Lawall wrote:
> On Sat, 2 Apr 2022, Eric Wheeler wrote:
> > > > Is there a reason that spatch should treat a list of files on the
> > > > cmdline differently than a list of files coming out of a directory?
> > >
> > > So that you can have semantic patches that cross multiple files.  Ideally,
> > > you would find the files that go together, eg for each device driver, and
> > > then run spatch for each.  There is also a way to make a file with the
> > > names of the files that go together, separated by blank lines.  But that
> > > is a lot of work, and fragile over time.
> > >
> > > > Much faster as a directory:
> > > >
> > > > 	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci src/
> > > > 	real	0m0.980s <<<
> > > >
> > > > Slower even with `parallel` on a list of .c files:
> > > >
> > > > 	]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> > > > 	real    0m1.224s
> > > >
> > > > 	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> > > > 	real    0m4.852s
> > > >
> > > > > It seems that you don't want to process resources.c.  Maybe the semantic
> > > > > patch should be adjusted so that the code in resource.c is not matched?
> > > > > With python or OCaml you can also cause Coccinelle to exit on a file you
> > > > > don't want to process.
> > > > When you say "exit", will it skip the file or exit and skip any later
> > > > files?
> > > Just stop processing of the current file.
> > > > How do you skip a certain .c file in the patch?
> > > @script:ocaml@
> > > @@
> > > if List.mem (List.hd(Coccilib.files())) ["badfile1";"badfile2"]
> > > then Coccilib.exit()
> > >
> > > > Is there a way to list exclusively which .c files I would like to use? For
> > > > example:
> > > >
> > > >    ]# spatch -j24 --sp-file cocci/printf-refactor.cocci `git grep -l printf`
> > > >                                                         ^^^^^^^^^^^^^^^^^^
> > >
> > > Coccinelle already finds the words in your semantic patch that are
> > > important for a change to occur, and only parses files that contain those
> > > words.
> >
> > Ok, then maybe I'm trying to optimize something that doesn't need
> > optimized.
> >
> > > > I tried --use-gitgrep but I'm not sure that it did anything, or at least
> > > > the time didn't change substantially:
> > >
> > > You can see from the HANDLING and Skipping output what is being parsed and
> > > what is being skipped.
> > >
> > > Perhpas your semantic patch is not written in a way that allows spatch to
> > > find out what the important words are.  You can run spatch --parse-cocci
> > > and it will show you the important words at the end.
> >
> > It is getting the important words for grepping:
> > 	Grep query printf || stderr || fprintf
> >
> > > Note that putting the above script will cause there to be no more
> > > important words and thus all files to be considered, because the script
> > > code applies to all files.
> >
> > Interesting.  To confirm my understanding: Did you mean that including
> > your @script:ocaml@ example would prevent important word processing?
> 
> I believe so.  You can always confirm with --parse-cocci.
> 
> >
> > > You can use the --file-groups <file> argument with the files of interest
> > > like this
> >
> > Should --file-groups work with spatch -jN such that each group is
> > processed in parallel?  It seems that --file-groups is the same as putting
> > it on the command line, at least in the trivial case of a single group:
> 
> Exactly.  But I suggested to put a line between each file, making one
> group per file.

Got it.  Now my understanding is consistent with the output,
and `spatch -jN` is faster than using `parallel`:

	]$ time spatch  -j4 --sp-file cocci/printf-refactor.cocci src/ &>/dev/null
	real	0m6.826s

	]$ time spatch  -j4 --sp-file cocci/printf-refactor.cocci --file-groups <(git grep -l printf | sed 's/$/\n/') &>/dev/null
	real	0m6.767s

	]$ time parallel -j4 spatch --sp-file cocci/printf-refactor.cocci ::: src/*.c &> /dev/null
	real	0m8.295s

Thanks for your help!

--
Eric Wheeler

