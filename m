Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD3AC433F5
	for <cocci@archiver.kernel.org>; Sun,  6 Feb 2022 19:48:15 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19953599"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2022 20:48:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 459BAE0381; Sun,  6 Feb 2022 20:48:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4ED12E037F
	for <cocci@sympa.inria.fr>; Sun,  6 Feb 2022 20:48:07 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="5156456"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 20:48:08 +0100
Date: Sun, 6 Feb 2022 20:48:06 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
cc: cocci@inria.fr
In-Reply-To: <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com>
Message-ID: <alpine.DEB.2.22.394.2202062047220.3126@hadrien>
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com> <alpine.DEB.2.22.394.2202061941500.3126@hadrien> <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 127
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/alpine.DEB.2.22.394.2202062047220.3126%40hadrien>



On Sun, 6 Feb 2022, Denis Efremov wrote:

>
>
> On 2/6/22 21:43, Julia Lawall wrote:
> >
> >
> > On Sun, 6 Feb 2022, Denis Efremov wrote:
> >
> >> Hi,
> >>
> >> I'm observing a weird crash with spatch 1.1.1
> >>
> >> $ spatch --version
> >> spatch version 1.1.1 compiled with OCaml version 4.11.2
> >> Flags passed to the configure script: --enable-opt --enable-ocaml --enable-python --enable-pcre-syntax --enable-pcre --prefix /home/work/.opam/4.11.2 --libdir /home/work/.opam/4.11.2/lib
> >> OCaml scripting support: yes
> >> Python scripting support: yes
> >> Syntax of regular expressions: PCRE
> >>
> >> $ cat segfault.cocci
> >> @err@
> >> position p;
> >> @@
> >>
> >> amd_energy_is_visible(...)
> >> {
> >> *       return 0444;@p
> >> }
> >>
> >> @script:python@
> >> p << err.p;
> >> @@
> >>
> >> coccilib.report.print_report(p[0], "found")
> >>
> >> $ mkdir empty_dir # creating empty directory
> >> $ spatch segfault.cocci empty_dir
> >> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
> >> 0 files match
> >> [1]    152475 segmentation fault (core dumped)  spatch segfault.cocci test
> >
> > I tried 1.1.1 with the options --enable-opt --enable-ocaml --enable-python
> > --enable-pcre-syntax --enable-pcre, but it seems to work find for me.
> > Does the problem go away if there is a file in the directory?  If you
> > remove the python code?
>
> It doesn't crash if I run it on the linux kernel sources on commits prior to
> 9049572fb145 hwmon: Remove amd_energy driver
>
>
> $ git checkout 9049572fb145~
> # there is amd_energy_is_visible in drivers/hwmon/amd_energy.c
> # spatch doesn't crash on this commit
>
> $ git checkout 9049572fb145
> # no amd_energy_is_visible in kernel source
> # spatch crashes
>
> If I remove python code then spatch doesn't crash.

Maybe try with --debug.  Or try without the p[0] in the python code.

julia
