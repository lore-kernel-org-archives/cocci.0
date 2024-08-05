Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9223C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 12:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lsAEE4Nph23JFtBPCbGFodKh+r66N7xoT2QfXDMsvVU=;
  b=jGt/1lfND+q64wUTliH8l5WjCmcR79EsDwHToKfUSMJiuxWzCM4cJHLZ
   4+fI8Ce6bKV0KNkNrOL5z+eodEut4bRTXRW71J6f1lckX6MVNk+xwhSHG
   teY50YQy6P0R7c4bTvuLeDydOT+fnQwRb4UFS1beA6ZvAS7ATToJWp1iA
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178141233"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 14:12:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12D46E0141; Mon,  5 Aug 2024 14:12:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DFF3E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 14:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lsAEE4Nph23JFtBPCbGFodKh+r66N7xoT2QfXDMsvVU=;
  b=cy4XBoKlSDzz8TXhahKRvuBhzdIRtPspPDp0WtL4MHvGk6drezWOAExe
   5EoHocavGPkp4XzUIvTWvu6yjXIsG6LUzd1xuQzruw09BgC9OZgSWMGWE
   gXMHeUwlxBkXlVXIR1BBNn+O5Kj7Zeks+wxpy2nz+YdwqHodJ0gMLlPBY
   M=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="93594539"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:12:52 +0200
Date: Mon, 5 Aug 2024 14:12:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
Message-ID: <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com> <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com> <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-6867523-1722859971=:3440"
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1837
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/66215b0-f6e-2cef-4022-4dd148fa2790%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-6867523-1722859971=:3440
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 5 Aug 2024, Ricardo Ribalda wrote:

> On Mon, 5 Aug 2024 at 13:27, Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > It seems to be related to the cocci version, and not the kernel version.
> > >
> > > Debian updated it recently from 1.1.1 to 1.2.
> >
> > Thanks for such background information.
> >
> >
> > > These are my results for the same kernel code:
> > >
> > >
> > > root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
> > > MODE=report V=1  > 1.1.1.txt
> > >
> > > real    1m59.021s
> > > user    53m53.038s
> > > sys     2m17.171s
> > …
> > > root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
> > > MODE=report V=1  > 1.2.txt
> > >
> > > real    15m0.552s
> > > user    371m28.976s
> > > sys     3m32.884s
> >
> > Are there any possibilities to increase the measurement granularity for
> > affected SmPL scripts?
> > Would you like to compare software run time characteristics in more detail
> > (in parallel) also according to each SmPL script?
>
> Let me know if this is enough:
>  time make coccicheck M=drivers/media/ MODE=report V=1 | ts -i > 1.2.ts.txt

Yes, that's helpful, thanks!

julia
--8323329-6867523-1722859971=:3440--
