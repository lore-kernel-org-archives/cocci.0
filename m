Return-Path: <SRS0=OVN8=IO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CCC433DB
	for <cocci@archiver.kernel.org>; Tue, 16 Mar 2021 07:21:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CB161585
	for <cocci@archiver.kernel.org>; Tue, 16 Mar 2021 07:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CB161585
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12G7Kh1o001366;
	Tue, 16 Mar 2021 08:20:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BA5A977CD;
	Tue, 16 Mar 2021 08:20:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E19877610
 for <cocci@systeme.lip6.fr>; Tue, 16 Mar 2021 08:20:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12G7KfGN009147
 for <cocci@systeme.lip6.fr>; Tue, 16 Mar 2021 08:20:41 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyBAYoKpN7Ic5fUWszvr9mVYaV5rKeYIsi2QD?=
 =?us-ascii?q?101hICF9WMqeisyogbAnxQb54QxhPE0ItNicNMC7Kk/02oVy5eAqV4uKfA6jg2?=
 =?us-ascii?q?ewKZEn0I2K+VzdMgnf0sIY6qt6aah5D7TLfD1HpOL3+hOxHdpl4PTvysCVrNzT?=
 =?us-ascii?q?xXtsUg1mApsIhztRMQqVHlZ7QwNLH/MCZfmhz/BarDmtc2l/VKqGL0QCNtKum/?=
 =?us-ascii?q?T2jp78JTYJCxk7gTP+7w+A2frKVyKV2RoTSFp0rIsK+2KtqWPE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.81,251,1610406000"; d="scan'208";a="375847820"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 08:20:41 +0100
Date: Tue, 16 Mar 2021 08:20:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
In-Reply-To: <CALogXGW1-EbJo4_8HhtWbv02aYWgKpMwJeXuDasrsZ2HPDVJhg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103160820280.2872@hadrien>
References: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
 <20210314061001.GA993@kunai> <alpine.DEB.2.22.394.2103141016010.2986@hadrien>
 <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
 <CALogXGW1-EbJo4_8HhtWbv02aYWgKpMwJeXuDasrsZ2HPDVJhg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-770716469-1615879241=:2872"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Mar 2021 08:20:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Mar 2021 08:20:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a struct member with a function call
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-770716469-1615879241=:2872
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 15 Mar 2021, Mansour Moufid wrote:

> On Sun, Mar 14, 2021, 20:43 Thomas Adam <thomas@xteddy.org> wrote:
>       Hello,
>
>       I can see I was as clear as mud with my explanation -- apologies
>       for
>       that, so let me try again.
>
>       In my original example:
>
>       struct monitor {
>           struct {
>               int width;
>               int height
>           } virtual;
>       };
>
>       ... the members width and height aren't required any more, as
>       they're
>       actually computable generically, and don't belong in that
>       struct.
>       Instead, I have separate functions which can provide those
>       values.
>
>       So where I have in code, statements such as:
>
>       struct monitor *m = this_monitor();
>       int foo = m->virutal.width;
>
>       I want to be able to substitute "m->virtual.width" with a
>       function
>       call "get_width()" -- which does not involve "struct monitor" at
>       all.
>       Indeed, the semantic patch I'm trying to apply now looks like
>       this:
>
>       @@
>       struct monitor *m;
>       @@
>
>       - m->virtual.width;
>       + get_width();
>
>       ... and although spatch doesn't tell me of any errors, when I
>       run it
>       over my codebase, no modifications are made.  So clearly I'm
>       still
>       doing something wrong.
>
>
> Remove the semi-colons. ;)

Good catch :)

julia
--8323329-770716469-1615879241=:2872
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-770716469-1615879241=:2872--
