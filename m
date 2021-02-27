Return-Path: <SRS0=+EIx=H5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71603C433DB
	for <cocci@archiver.kernel.org>; Sat, 27 Feb 2021 14:47:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5934D64DD0
	for <cocci@archiver.kernel.org>; Sat, 27 Feb 2021 14:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5934D64DD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11REl4Q5018749;
	Sat, 27 Feb 2021 15:47:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8C435760C;
	Sat, 27 Feb 2021 15:47:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B63E43E64
 for <cocci@systeme.lip6.fr>; Sat, 27 Feb 2021 15:47:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11REl235010450
 for <cocci@systeme.lip6.fr>; Sat, 27 Feb 2021 15:47:02 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,211,1610406000"; d="scan'208";a="374274836"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 15:47:01 +0100
Date: Sat, 27 Feb 2021 15:47:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <yefremov.denis@gmail.com>
In-Reply-To: <f4369a0b-aed9-ae77-a44a-99e468d7cb4d@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2102271545550.2926@hadrien>
References: <alpine.DEB.2.22.394.2102270905410.2926@hadrien>
 <47b8a2cd-ff8a-ac8c-a9b1-015488bbc959@gmail.com>
 <alpine.DEB.2.22.394.2102271013190.2926@hadrien>
 <f4369a0b-aed9-ae77-a44a-99e468d7cb4d@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 27 Feb 2021 15:47:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 27 Feb 2021 15:47:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] release of version 1.1.0
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sat, 27 Feb 2021, Denis Efremov wrote:

>
>
> On 2/27/21 12:14 PM, Julia Lawall wrote:
> >
> >
> > On Sat, 27 Feb 2021, Denis Efremov wrote:
> >
> >> Hi,
> >>
> >> Great news!
> >>
> >> Could you please create release tag on GitHub?
> >> This will allow me to add this version to tests and add new opam package version.
> >> Currently, I use these versions for tests:
> >> https://github.com/evdenis/cvehound/blob/master/.github/workflows/test.yml#L25
> >
> > There is no tag at the moment.  I have asked why.
> >
> >>
> >> BTW, is there 1.0.9 version? I see that fedora provides 1.0.9 version,
> >> but there is not release tag for it and there is no opam package for it.
> >
> > No, there is no version 1.0.9.  We moved on to 1.1 due to the #spatch
> > feature.
> >
>
> Seems like there is a mess. There is a commit with 1.0.9 release planned:
> https://github.com/coccinelle/coccinelle/commit/842075f77505386a782030ebffb1acf7f4237737#diff-652d5876e7e73c420820682a12ecdec66ecdec029223e24808e129d64493a967
>
> Repology says that Fedora provides most recent coccinelle version:
> https://repology.org/project/coccinelle/versions
> Other distibutives use 1.0.8 version.
>
> On Fedora:
> $ sudo dnf info coccinelle
> Installed Packages
> Name         : coccinelle
> Version      : 1.0.9
> Release      : 0.14.gitd0fd4c7d.fc33.1 // <== d0fd4c7d commit reference
> Architecture : x86_64
> Size         : 26 M
> Source       : coccinelle-1.0.9-0.14.gitd0fd4c7d.fc33.1.src.rpm
>
> $ /usr/bin/spatch --version
> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
> Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
> Fedora 33, 1.0.9 version points to commit:
> $ fedpkg clone -a coccinelle
> $ cd coccinelle
> $ git checkout f33
> $ cat coccinelle.spec | grep commit
> %global commit d0fd4c7dfa70763870914eedee7022fa35f700e2
> %global shortcommit d0fd4c7d
>
> Fedora 34 also uses d0fd4c7d as base for 1.0.9 version.
> Fedora 32 points to 111d328fee1303f14a5b9def835301d849e41331.
>
> Maybe release 1.0.9 wasn't planned, but as my personal opinion adding 1.0.9 tag is not a bad idea
> just to reference some commit (for example, d0fd4c7d) and have 1.0.9 version to run
> backward compatibility tests on it.
> https://github.com/coccinelle/coccinelle/releases

I donm't think any 1.0.9 was planned. It was probably an experiement with
the release system gone wrong.  But if someone has picked up on it, we may
as well put a tag for it too.  Thanks for the feedback.

julia

>
> Thanks,
> Denis
>
> >>
> >> On 2/27/21 11:11 AM, Julia Lawall wrote:
> >>> A new version 1.1.0 has been released.  The most interesting change is the
> >>> ability to put spatch command line options in a .cocci file, for example:
> >>>
> >>> #spatch --very-quiet -j 8 --recursive-includes --include-headers-for-types
> >>>
> >>> Other specific improvements are an improved handling of attributes and a
> >>> more efficient treatment of header files (all thanks to Jaskaran Singh).
> >>>
> >>> Various other small issues have been addressed.
> >>>
> >>> All of these changes have already been available on github.
> >>>
> >>> julia
> >>> _______________________________________________
> >>> Cocci mailing list
> >>> Cocci@systeme.lip6.fr
> >>> https://systeme.lip6.fr/mailman/listinfo/cocci
> >>>
> >> _______________________________________________
> >> Cocci mailing list
> >> Cocci@systeme.lip6.fr
> >> https://systeme.lip6.fr/mailman/listinfo/cocci
> >>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
