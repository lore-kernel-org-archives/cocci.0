Return-Path: <SRS0=hYZ6=QD=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12FEC433F5
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 17:04:48 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1635161AA9
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 17:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1635161AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3955210"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2021 18:04:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 28C53E00D0; Tue, 16 Nov 2021 18:04:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D795DE0092
	for <cocci@sympa.inria.fr>; Tue, 16 Nov 2021 18:04:43 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3AcAGTq6wkET4Vp8GOaMB6t+cMxCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDMn0z0Dx2McCjiCOv+KYWKme94ja4u2pEgB657Qy9AwHQtv/xmBbVoa8?=
 =?us-ascii?q?JufXYzxwmTYZn7JcJWbFCqL1yivAzX5BJhcokT0+1H9bdANkVEmjfvRH+OlVra?=
 =?us-ascii?q?eUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAfNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?Nnqq+dkQVS7rWexCHkHtNHamkmBlL4CIouko5HKNGOQEG0HPXwJYvlb2htrTpI?=
 =?us-ascii?q?estFq/RnOUUFR1RDCh6OYVH/qXGKD6xq6R/ymWdIiaxmqQ2ZK0xFchCkgptOkl?=
 =?us-ascii?q?H6/UCITolYRWKhubwy7W+IsFngc8oLeHwLYYHszdhyyvYBLAoW/j+rw/ijTND9?=
 =?us-ascii?q?Dssw8RHAv/aY4wBYCBud1LBZQdOMxEZEvoDcC6TriGXW1VlRJi9/MLbO1Tu8TE?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Avznf26nD5weF9Rssnk5qoqYAfv/pDfIr3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzuiWetN98YhsdcJW7WZVoIkmskKKdg7NwAV7KZmCPhI?=
 =?us-ascii?q?LrFvAA0WKI+VPd8kPFmtK1mZ0QEZRWOZnASWJ3isv3+2CDfuoIytPvys+Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3955190"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 18:04:43 +0100
Date: Tue, 16 Nov 2021 18:04:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <211116.86h7ccox6b.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111161803180.2333@hadrien>
References: <211116.86lf1op65q.gmgdl@evledraar.gmail.com> <alpine.DEB.2.22.394.2111161717040.2333@hadrien> <211116.86h7ccox6b.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-197359130-1637082283=:2333"
Subject: Re: [cocci] Is there a --no-includes --but-includet-this foo.h
 --but-in[...] mode?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 105
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111161803180.2333%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-197359130-1637082283=:2333
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 16 Nov 2021, Ævar Arnfjörð Bjarmason wrote:

>
> On Tue, Nov 16 2021, Julia Lawall wrote:
>
> > On Tue, 16 Nov 2021, Ævar Arnfjörð Bjarmason wrote:
> >
> >> [First time poster, long time spatch user, thanks a lot for providing
> >> it!]
> >>
> >> I'm trying to optimize the runtime of spatch in git.git by leveraging
> >> information that's already in the Makefile. Both GCC and Clang know how
> >> to spew out information about what headers a given file depends on in
> >> "Makefile" format, e.g. for a "hook.c" in git.git:
> >>
> >>     $ cat .depend/hook.o.d
> >>     hook.o: hook.c cache.h git-compat-util.h compat/bswap.h wildmatch.h \
> >>      banned.h strbuf.h hashmap.h hash.h repository.h path.h sha1dc_git.h \
> >>      sha1collisiondetection/lib/sha1.h sha256/block/sha256.h list.h advice.h \
> >>      gettext.h convert.h string-list.h trace.h trace2.h pack-revindex.h \
> >>      oid-array.h mem-pool.h hook.h run-command.h thread-utils.h strvec.h
> >>     [...]
> >>
> >> I wanted to feed that into spatch somehow, but with e.g. --include it
> >> will not include anything:
> >
> > How did you identify that nothing was included with --include?  --include
> > is supposed to allow you to specify files that should be included
> > regardless of the #includes found in the file.
>
> From strace-ing it it looks like it is including those files I asked for
> with just --include, but it doesn't print out an "including" message
> like in the other modes, so I assumed it was simply ignoring them.
>
> But it looks like it's working!

I think that the message is part of the inference process.

>
> > On the other hand, there is nothing to make a list of includes be
> > considered to be the only includes that are allowed as you suggest.
>
> For what it's worth I had in mind (presumably simpler)
> --check-include-exhaustiveness or whatever, i.e. it wouldn't try to
> generate a full list of includes, but just error out if it ever ran
> across an "#include" that I hadn't specifiec.
>
> But perhaps for that to be truly useful it would need to at least go far
> enough to check if that not-listed include was a local or a non-local
> one.
>
> In any case, I could just do that myself by running it twice in some
> assertion mode & parsing its output, thanks!

I'm not really sure that this is Coccinelle's problem.  You have the list
of inferred includes with the --verbose-includes option.

julia

> >>
> >>     ~/g/coccinelle/spatch.opt --sp-file contrib/coccinelle/strbuf.cocci --verbose-includes --no-includes --include cache.h --include path.h hook.c
> >>     init_defs_builtins: /home/avar/g/coccinelle/standard.h
> >>     HANDLING: hook.c
> >>
> >> It seems that there's --recursive-includes, --all-includes,
> >> --no-includes etc, but those all tweak different aspects of
> >> auto-discover, or "seed" the auto-discovery via --include.
> >>
> >> But I'd like a way to say "here, exhaustively, are my includes", does it
> >> have such a mode? If not consider this a feature request.
> >>
> >> Even better on top would be to further optionally tell it due die if it
> >> ever encounters an include file that's not explicitly provided on the
> >> command-line.
> >>
> >> That would serve as a nice sanity check on the *.d files we get from
> >> gcc/clang, and make sure that this way of optimizing its runtime works
> >> as intended. I was planning to do that by parsing its output, but having
> >> it as a native option would be easier.
> >>
> >> Note: I probably don't *really* need this, since I can look at the *.d
> >> file myself and have "make" determine if spatch needs to run at all, and
> >> I trust the gcc/clang information well enough.
> >>
> >> But being able to have spatch use that information exclusively would
> >> also be nice, especially for the above mentioned sanity check.
> >>
> >> Thanks!
> >>
>
>
--8323329-197359130-1637082283=:2333--
