Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08459C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=JV/eiOsq30PaiiAk9ZD7yuxHM6tU/kZjwHFf8EKsftI=;
  b=t0WEKkbDQ9AyusDjwFFtbTMMCT6ioLXGZ0ENjLGO1Tw/nTgonOjTPAXa
   +2GCgun2P8HgCG/Zeu1LewGp9P+ftZvzLYW9FRU2zduPZ9qhvWeBrZ7vP
   XBHW6yIOqF+NUHap5Ux5S8+REmaVmsFXOyMFPD/6gdiJyt6Kvm+ZmUyTE
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29701368"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 23:19:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99BE2E033C; Sat,  2 Apr 2022 23:19:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 03B37E00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 23:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JV/eiOsq30PaiiAk9ZD7yuxHM6tU/kZjwHFf8EKsftI=;
  b=vyF59ZEpbyHDij+gKPxovKHq/xX8dnfYl1GtREq7lMJR6PIvsxDMpo+u
   3wCeaTHfpNMp+Xffmtsv7HOl6vh9dLMLPEYrnRrKOw6DGP88Ml/fr5wQt
   HKNhWezkITnsSfq6XDe52nr4Jkl7KBOC3vkvcKDp8jSOut1PUA0mYsMUY
   c=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10381865"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 23:19:21 +0200
Date: Sat, 2 Apr 2022 23:19:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2204022318100.3208@hadrien>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
 <alpine.DEB.2.22.394.2204012224060.3048@hadrien> <5f832bd0-37e2-3417-df60-4cdbc5cf5fb8@ewheeler.net> <alpine.DEB.2.22.394.2204021940530.3208@hadrien> <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 339
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204022318100.3208%40hadrien>



On Sat, 2 Apr 2022, Eric Wheeler wrote:

> > > Is there a reason that spatch should treat a list of files on the
> > > cmdline differently than a list of files coming out of a directory?
> >
> > So that you can have semantic patches that cross multiple files.  Ideally,
> > you would find the files that go together, eg for each device driver, and
> > then run spatch for each.  There is also a way to make a file with the
> > names of the files that go together, separated by blank lines.  But that
> > is a lot of work, and fragile over time.
> >
> > > Much faster as a directory:
> > >
> > > 	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci src/
> > > 	real	0m0.980s <<<
> > >
> > > Slower even with `parallel` on a list of .c files:
> > >
> > > 	]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> > > 	real    0m1.224s
> > >
> > > 	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> > > 	real    0m4.852s
> > >
> > > > It seems that you don't want to process resources.c.  Maybe the semantic
> > > > patch should be adjusted so that the code in resource.c is not matched?
> > > > With python or OCaml you can also cause Coccinelle to exit on a file you
> > > > don't want to process.
> > > When you say "exit", will it skip the file or exit and skip any later
> > > files?
> > Just stop processing of the current file.
> > > How do you skip a certain .c file in the patch?
> > @script:ocaml@
> > @@
> > if List.mem (List.hd(Coccilib.files())) ["badfile1";"badfile2"]
> > then Coccilib.exit()
> >
> > > Is there a way to list exclusively which .c files I would like to use? For
> > > example:
> > >
> > >    ]# spatch -j24 --sp-file cocci/printf-refactor.cocci `git grep -l printf`
> > >                                                         ^^^^^^^^^^^^^^^^^^
> >
> > Coccinelle already finds the words in your semantic patch that are
> > important for a change to occur, and only parses files that contain those
> > words.
>
> Ok, then maybe I'm trying to optimize something that doesn't need
> optimized.
>
> > > I tried --use-gitgrep but I'm not sure that it did anything, or at least
> > > the time didn't change substantially:
> >
> > You can see from the HANDLING and Skipping output what is being parsed and
> > what is being skipped.
> >
> > Perhpas your semantic patch is not written in a way that allows spatch to
> > find out what the important words are.  You can run spatch --parse-cocci
> > and it will show you the important words at the end.
>
> It is getting the important words for grepping:
> 	Grep query printf || stderr || fprintf
>
> > Note that putting the above script will cause there to be no more
> > important words and thus all files to be considered, because the script
> > code applies to all files.
>
> Interesting.  To confirm my understanding: Did you mean that including
> your @script:ocaml@ example would prevent important word processing?

I believe so.  You can always confirm with --parse-cocci.

>
> > You can use the --file-groups <file> argument with the files of interest
> > like this
>
> Should --file-groups work with spatch -jN such that each group is
> processed in parallel?  It seems that --file-groups is the same as putting
> it on the command line, at least in the trivial case of a single group:

Exactly.  But I suggested to put a line between each file, making one
group per file.

julia

> Directory is parallel:
> 	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
> 	real	0m1.063s
>
> File-groups are serial:
> 	]# git grep -l printf  > f
> 	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci --file-groups f &> /dev/null
> 	real	0m4.959s
>
> Same thing, serial, without the temp file "f" using <() since
> --file-groups doesn't appear to seek():
> 	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci --file-groups <(git grep -l printf) &> /dev/null
> 	real	0m4.981s
>
> -Eric
>
> > But in most cases this doesn't seem like a good idea.  The list of files
> > could change over time.
> >
> > julia
> >
> > > 	]# time spatch --use-gitgrep -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
> > > 	real	0m1.305s
> > >
> > > 	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
> > > 	real	0m1.300s
> > >
> > > These are small numbers and doesn't really need a speed increase for this
> > > patch, so this question is really about future patches that may take
> > > longer to process.
> > >
> > > -Eric
> > >
> > > >
> > > > julia
> > > >
> > > > >
> > > > > Not sure if this is an spatch bug or not, but its ~3x faster to use
> > > > > `parallel` as follows:
> > > > >
> > > > > ]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> > > > > real	0m1.224s
> > > > >
> > > > > ]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> > > > > real	0m4.852s
> > > > >
> > > > >
> > > > > Here is the SmPL:
> > > > > 	@ p4 @
> > > > > 	expression list EL;
> > > > > 	constant C =~ "BUG";
> > > > > 	@@
> > > > > 	-printf(C, EL);
> > > > > 	+BUG(C, EL);
> > > > >
> > > > > 	@ p3 @
> > > > > 	expression list EL;
> > > > > 	constant C =~ "warn";
> > > > > 	@@
> > > > > 	-printf(C, EL);
> > > > > 	+pr_warn(C, EL);
> > > > >
> > > > > 	@ p @
> > > > > 	expression list EL;
> > > > > 	constant C;
> > > > > 	@@
> > > > > 	-printf(C, EL);
> > > > > 	+pr_info(C, EL);
> > > > >
> > > > > 	@ p2 @
> > > > > 	expression list EL;
> > > > > 	constant C;
> > > > > 	@@
> > > > > 	-fprintf(stderr, C, EL);
> > > > > 	+pr_err(C, EL);
> > > > >
> > > > >
> > > > > The .c files are from here:
> > > > > 	https://github.com/KJ7LNW/xnec2c
> > > > >
> > > > > --
> > > > > Eric Wheeler
> > > > >
> > > > >
> > > > > >
> > > > > > julia
> > > > > >
> > > > >
> > > >
> > >
> >
>
