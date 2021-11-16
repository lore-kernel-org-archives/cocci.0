Return-Path: <SRS0=hYZ6=QD=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C19C433F5
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 16:18:40 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B460261B64
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 16:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B460261B64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3945038"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2021 17:18:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6194E0284; Tue, 16 Nov 2021 17:18:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 02EE6E0092
	for <cocci@sympa.inria.fr>; Tue, 16 Nov 2021 17:18:33 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3AptweeqArcwO3ZhVW/xLhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBAPq0zxwhjZUnGcWUT+HPvuPZzT9c49+aNzloR5XsZaAx9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljPjWHuCU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8hFpa?=
 =?us-ascii?q?hm6nydklMWrfIPBPIi3xMWqHkjAIqSi4ai/xrcqtHLxkIzWvU9zxy4IwlWZiYS?=
 =?us-ascii?q?xotP6SKnO0CWh1cOyB4J6xPvrHdSZS6mZfCkxCeKSeEL/JGSRte0Zcj0u9pCHt?=
 =?us-ascii?q?H/9QXLTkMalaIgOfe6Lm8QeJtrt8yKdHieoIZoHBpiz/DZcvK67irr77i6cMd2?=
 =?us-ascii?q?D4vj8RKW+7XfcsCLztpdhXJJRNVUmr7wakWxI+A7kQTuRUEwL5NmZcK3g=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A42UAMa3OwWadBh/K+KdITQqjBL8kLtp133Aq?=
 =?us-ascii?q?2lEZdPUnSK2lfqeV7ZMmPH7P+VIssR4b9OxoVJPwI080sKQFhLX5Xo3PYOCFgg?=
 =?us-ascii?q?GVxehZhOOI/9SjIVycygc378ldmsZFaOEYQWIUsfrH?=
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3945024"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 17:18:33 +0100
Date: Tue, 16 Nov 2021 17:18:32 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <211116.86lf1op65q.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111161717040.2333@hadrien>
References: <211116.86lf1op65q.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-104864302-1637079512=:2333"
Subject: Re: [cocci] Is there a --no-includes --but-includet-this foo.h
 --but-in[...] mode?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 103
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111161717040.2333%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-104864302-1637079512=:2333
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Tue, 16 Nov 2021, Ævar Arnfjörð Bjarmason wrote:

> [First time poster, long time spatch user, thanks a lot for providing
> it!]
>
> I'm trying to optimize the runtime of spatch in git.git by leveraging
> information that's already in the Makefile. Both GCC and Clang know how
> to spew out information about what headers a given file depends on in
> "Makefile" format, e.g. for a "hook.c" in git.git:
>
>     $ cat .depend/hook.o.d
>     hook.o: hook.c cache.h git-compat-util.h compat/bswap.h wildmatch.h \
>      banned.h strbuf.h hashmap.h hash.h repository.h path.h sha1dc_git.h \
>      sha1collisiondetection/lib/sha1.h sha256/block/sha256.h list.h advice.h \
>      gettext.h convert.h string-list.h trace.h trace2.h pack-revindex.h \
>      oid-array.h mem-pool.h hook.h run-command.h thread-utils.h strvec.h
>     [...]
>
> I wanted to feed that into spatch somehow, but with e.g. --include it
> will not include anything:

How did you identify that nothing was included with --include?  --include
is supposed to allow you to specify files that should be included
regardless of the #includes found in the file.  On the other hand, there
is nothing to make a list of includes be considered to be the only
includes that are allowed as you suggest.

julia

>
>     ~/g/coccinelle/spatch.opt --sp-file contrib/coccinelle/strbuf.cocci --verbose-includes --no-includes --include cache.h --include path.h hook.c
>     init_defs_builtins: /home/avar/g/coccinelle/standard.h
>     HANDLING: hook.c
>
> It seems that there's --recursive-includes, --all-includes,
> --no-includes etc, but those all tweak different aspects of
> auto-discover, or "seed" the auto-discovery via --include.
>
> But I'd like a way to say "here, exhaustively, are my includes", does it
> have such a mode? If not consider this a feature request.
>
> Even better on top would be to further optionally tell it due die if it
> ever encounters an include file that's not explicitly provided on the
> command-line.
>
> That would serve as a nice sanity check on the *.d files we get from
> gcc/clang, and make sure that this way of optimizing its runtime works
> as intended. I was planning to do that by parsing its output, but having
> it as a native option would be easier.
>
> Note: I probably don't *really* need this, since I can look at the *.d
> file myself and have "make" determine if spatch needs to run at all, and
> I trust the gcc/clang information well enough.
>
> But being able to have spatch use that information exclusively would
> also be nice, especially for the above mentioned sanity check.
>
> Thanks!
>
--8323329-104864302-1637079512=:2333--
