Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE27EC433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=isp7+ZtkhvTqlHTSjTNIgpJRGYY9oLIKa/koGu8rPsk=;
  b=DZ03fszF/izERJLd14c8EsbTujcOh/pQ9142+Cg14wA6OAsF2C7o/GvO
   Ew90Q5wU8XXGb1sbiPVd3km1p60CtV7H9GuO/eZQaEvNF2iLmKQrDO4z7
   N33CgNCTn4pWFGYM2olfGDMMnwjNMI89KxOA9dcDH0ofReuX5++RWF0DA
   I=;
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
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="29693146"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 19:39:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29B9AE033A; Sat,  2 Apr 2022 19:39:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6776EE00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 19:39:29 +0200 (CEST)
IronPort-SDR: rAQo1dP20ovYQ+XqpCiPTKLeL5wnet3/OOauwDWICZEqt4eZmHxCE64anXBNRnny2dFoDMOBUp
 Ow4daCDT8P4yyZ2U1OAR/KkR3oUhAqqKnNqdqCudt6b60/2XySJrSDKGaHUh+7c2N1GMvg7+i+
 imSQKOvFtM7G9lOL78UwNkccWy85ZlAFRJbit6L+F8qgHgsDWMoJeUKhJnLt4Q7C0hBxUAFiJE
 /Z010l73WscsgxuhxfIzuXzmpSC03zSWjS5/7JX1qQBAJ70RDv/93agHYJY8sQ3iC/81hv/G4N
 ZyL7pvbP5UiZ0XbZvSuyaAg/
X-IPAS-Result: =?us-ascii?q?A0DvBAD9iEhi/0Xcza1agQmBWoIoB3dWAQEBKQQLlAuCJ?=
 =?us-ascii?q?QOeYwsBAwENMxAEAQGFBwKEWgIdBgYzBg4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBAGBCCwBYwFnAYFOAYF5BgQwDYI1KQGDYwEBAQECATo/BQsLG?=
 =?us-ascii?q?C5XBoMXAYJ1Ia45eIEzgQGDTwGGJgaBPI5OJxxAgU2BPAyCdz6CYwKHPSIEm?=
 =?us-ascii?q?UcGfBMBKwloFBstEUFYoAqCFZxxgS+DU4sVlFMGFC6DdJJdN4pRhnaWXopMg?=
 =?us-ascii?q?kyZdIE/OCaBWR8UGggmCjuCak0BAgECAQwBAgIBAgECAQIBCAEBAgGOKBYVg?=
 =?us-ascii?q?zuKfiEBAQFpAgYLAQEDCY8pXQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:kV8jXKpuRc4gu/DT9TAt2jxf/ypeBmIlYxIvgKrLsJaIsI4StFCzt
 garIBnXMqnbZWrweopybouz808PsJCBzIAySwZs/n9nHngV9+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWDYAX9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSuUSYYY7T3ldgPTgcGLH5yO7NI2OHYdC3XXcy7lyUqclPp07NjE0E7MIkV4KBxDH0mG
 f4wcW9WKErb2qTsmur9FLgEascLdKEHOKsUvXprzBndDO06WtbOXKXH6NtVxnE2i9wm8fP2P
 pJCNmUwNESojxtnFHwdFb5vmcSR2yOubxl8iQnStI0S/D2GpOB2+OOxboGEJYziqd9utk2fr
 WnH13/oBwkTct2Z0zuMtHy27sfLlDzyXIY6Bry9/ORjxlyV3G0aThMMPWZXutG8mgizRNJSJ
 kgZ4GwooLRaGFGXosfVQQWZkSOdhRMgScdOTdJl5AeTxIqK/FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQBSXK2ppWG1rejL8GvjUcQBBSpTOn9eFFptD8zL+dlr1nryosBf/LlZZ+AZ9Bn10
 3aHsygzirEel4gN2rnTEbH7b9CE/cmhou0dvFm/soeZAuRRPtTNWmBQwQKHhcus1a7AJrRB1
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOA0Q4zQcB7rGn9oxZPmLy8BhkkdS+F1e5fIlfUj
 LL7414PjHOtFCXCgVBLj3KZUJh0lvm/RbwJp9jZcdpDb5x8bg6B92Q2PCatM5PFyyARfGBWE
 cnzTPtA+l5BUvs3lGPmHrhFuVLprwhnrV7uqVnA50zP+dKjiLS9EN/p6XOCMbI06r2qugLQ/
 4oNPseG0UwPAun/eTXMt4MMLV0HKXUhQ5b7t5UPJOKEJwNnHkAnCuPQmOl9INY9wv0Jz+qYr
 GugXkJ4yUbkgSOVIwu9akd8NOHlU6F5oC9pJicrJ1uphiYuON798KcFepIrVrA77+g/n+VsR
 vwIdpzYUPRCQzjK4RoHapz5oNAwfRinn1vebS6keyQkOZN/RwHE/tL+OA3i6HBWXCawsMI/p
 Zym1x/aGMBfHF46UZ+KMf/2lgG/p3kQnu52TnDkGNgLdRW+6pVuJgzwkuQzfZMGJyLD8STGh
 QyYNhEV+LvWqIgv/diU263d99W1E/FzF1ZxFnXA6erkLjHT+2euzNMSUOuMejyBBmr49L/7O
 LdQ37fxL/0KkVJHqcx6HqoylfAy4N7mprl7yAV4HSyRMw/xUu45fiCLjZtVq6lA5r5Fog/oC
 EiBzdltJunbMs3SFlNMdhEuaf6O1KxKl2CKv+g1Okjz+AR+4KGDDRdJJxCJhSEBfqF5Npgpn
 bUotMIMslHtjwpsP8mGgy1Q+n7KKHEcCv11upYfCY7tqwwq1lAbO8CHUHeruc3WZoUeKFQuL
 x+VmLHG2eZWyH3CRGVvR3LD6uxQ2MYVsxdQwV5feVnQwojZhuU61QF6+CgsSlgH1Q1O1u9+N
 wCH7aGuyXliK9upuCRCY4xoMwRRQhCG+kH8z1YT0mvUUyFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmcyX35SnDnY8H80y8/QwhjpuCLoRmdMOHdsJjPIilGdqXWpRLhg7SyfiwFtBvqDMc8ngvBq
 PUCECOcr0HkHXZ4npDXwLV2GVjdpN5o6YCCrTxcEHs1IFzh
IronPort-HdrOrdr: A9a23:bqpWJKBic274nT7lHemo55DYdb4zR+YMi2TDtnoBMCC8EKSj+P
 xG88506faZslcssTQb6LW90cq7MBXhHPxOkO0s1N6ZNWGM1QeVxcNZnOzfKlbbak/DH4BmtZ
 uIrJIVNPT7BzFB/KXH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="10377708"
X-MGA-submission: =?us-ascii?q?MDGyvhGnRSrE7um7g/Npk7VlLPDCJZIB6mEgoq?=
 =?us-ascii?q?XJMt6oDLBnDE2feFx4zIzSqTuYD+yXn0YySTyy73h6aBgyqpONlvEeBR?=
 =?us-ascii?q?ty1m8dYohqzfA1C/Uu/nzDg58HttT0OlzF0d/e9f0268sW4xknLhqTM2?=
 =?us-ascii?q?3Ur6j5sj2uI1MHIjJWFiQzww=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 19:39:28 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 366374A;
	Sat,  2 Apr 2022 10:39:25 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wvJDsQiq1ZQf; Sat,  2 Apr 2022 10:39:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id DE69740;
	Sat,  2 Apr 2022 10:39:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net DE69740
Date: Sat, 2 Apr 2022 10:39:17 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2204012224060.3048@hadrien>
Message-ID: <5f832bd0-37e2-3417-df60-4cdbc5cf5fb8@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
 <alpine.DEB.2.22.394.2204012224060.3048@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 335
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/5f832bd0-37e2-3417-df60-4cdbc5cf5fb8%40ewheeler.net>

On Fri, 1 Apr 2022, Julia Lawall wrote:
> On Fri, 1 Apr 2022, Eric Wheeler wrote:
> > On Sun, 20 Mar 2022, Julia Lawall wrote:
> > > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > > > On Sat, 19 Mar 2022, Julia Lawall wrote:
> > > > > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > > > > > Just a quick tip for others (like me) who are new to Coccinelle:
> > > > > >
> > > > > > You might already use this, but if not, here's a hint for doing lots of
> > > > > > replacements in parallel:
> > > > > >
> > > > > > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> > > > > >
> > > > > > If the SmPL depends on interactions between files then `parallel` won't
> > > > > > work, but if the changes work per-file then it runs much faster with lots
> > > > > > of big .c files.
> > > > > >
> > > > > > In cases where you do need to run over lots of files and they _do_
> > > > > > interact, you might get a Stack Overflow error.  In this case set
> > > > > > something like this for 1GB of stack space:
> > > > > > 	ulimit -s $((1024*1024))
> > > > > >
> > > > > > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > > > > > minutes and finished thousands of replacements!
> > > > > >
> > > > > > Julia, you might add this to documentation if you think it would be
> > > > > > useful.
> > > > >
> > > > > I'm not sure what you are trying to do.  You can give spatch the name of a
> > > > > directory and the argument -j N for a number for cores N, ad it will run
> > > > > in parallel on the files in the directroy.
> > > >
> > >   --jobs          the number of processes to be used
> > >   -j              the number of processes to be used
> >
> > Running `top` shows spatch at 100% cpu: it is not parallelizing, though
> > the rules and files are completely independent of eachother (no
> > inter-SmPL-rule dependencies).
> 
> I don't understand what you mean by spatch at 100%.  I think you should
> have 24 spatches?

I meant 100% of a single CPU core, it wasn't running in parallel, but read on:

> On the other hand, you should not put a bunch of files on the command
> line.  The intended behavior is for that not to be parallel.  Coccinelle
> makes no effort to figure out whether parallelism is useful.
> 
> Normally, one runs spatch on a directory, and then it takes care of
> working on the different files in parallel.

Oh, in that case, it is faster to use spatch's -j option and pass a 
directory (see below).  I didn't realize it operated on a directory, I've 
always passed each .c file to the cmdline, usually specifying only the 
files that I know to be affected, and sometimes *.c .

If that could be combined then -j would work in both cases.

Is there a reason that spatch should treat a list of files on the 
cmdline differently than a list of files coming out of a directory?  

Much faster as a directory:

	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci src/
	real	0m0.980s <<<

Slower even with `parallel` on a list of .c files:

	]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
	real    0m1.224s

	]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
	real    0m4.852s


> It seems that you don't want to process resources.c.  Maybe the semantic
> patch should be adjusted so that the code in resource.c is not matched?

Ya, its 100k of byte stuffing from the gtk resources being written to a 
big .c file array.  No need to process it, its just slow and big.  It is 
generated at build time so I deleted it to use src/.

> With python or OCaml you can also cause Coccinelle to exit on a file you
> don't want to process.

When you say "exit", will it skip the file or exit and skip any later 
files?

How do you skip a certain .c file in the patch?

Is there a way to list exclusively which .c files I would like to use? For 
example:

   ]# spatch -j24 --sp-file cocci/printf-refactor.cocci `git grep -l printf`
                                                        ^^^^^^^^^^^^^^^^^^
I tried --use-gitgrep but I'm not sure that it did anything, or at least 
the time didn't change substantially:

	]# time spatch --use-gitgrep -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
	real	0m1.305s

	]# time spatch -j4 --sp-file cocci/printf-refactor.cocci src/ &> /dev/null
	real	0m1.300s

These are small numbers and doesn't really need a speed increase for this 
patch, so this question is really about future patches that may take 
longer to process.

-Eric

> 
> julia
> 
> >
> > Not sure if this is an spatch bug or not, but its ~3x faster to use
> > `parallel` as follows:
> >
> > ]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> > real	0m1.224s
> >
> > ]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> > real	0m4.852s
> >
> >
> > Here is the SmPL:
> > 	@ p4 @
> > 	expression list EL;
> > 	constant C =~ "BUG";
> > 	@@
> > 	-printf(C, EL);
> > 	+BUG(C, EL);
> >
> > 	@ p3 @
> > 	expression list EL;
> > 	constant C =~ "warn";
> > 	@@
> > 	-printf(C, EL);
> > 	+pr_warn(C, EL);
> >
> > 	@ p @
> > 	expression list EL;
> > 	constant C;
> > 	@@
> > 	-printf(C, EL);
> > 	+pr_info(C, EL);
> >
> > 	@ p2 @
> > 	expression list EL;
> > 	constant C;
> > 	@@
> > 	-fprintf(stderr, C, EL);
> > 	+pr_err(C, EL);
> >
> >
> > The .c files are from here:
> > 	https://github.com/KJ7LNW/xnec2c
> >
> > --
> > Eric Wheeler
> >
> >
> > >
> > > julia
> > >
> >
> 
