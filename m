Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7A8C02194
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cWNHiaFKjqPhX4vlYexEmSZOorF24k6iBeG1ljdP8fE=;
  b=szIY4wUa+B6flUCrPL33J+M79iRTN6/QdKNK94kfT9ldXQgxXtL+TNwY
   a6Sh29CFdoznaAn/kh7wAoCVRUm2BcT+Ko8p9tQn+AeEDTPOsMLoX9ptm
   ypJjaun5lDlLw2ErB1Qn1yso4pXj4tr+9+JEWCvrt3UZ//8YCT4kKUDmc
   Q=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206515413"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 13:46:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 52FBCE0D1F; Tue,  4 Feb 2025 13:46:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6CB5EE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 13:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cWNHiaFKjqPhX4vlYexEmSZOorF24k6iBeG1ljdP8fE=;
  b=Ssc/+hQTCw66en+1WZz6JEyv1JdCmtafSURg8umlj3b80MXT2mydyxTd
   +wqjy5X/d6FLT+gil/OA6+A25FBLmeWTZaQnWp7zNwdFCh0J67ot6/Pjd
   oVwFjgBe6OFAszf2jQQE+ooc4Ft4ezCg3oxUwSWi1fHZkn5o4VBeSgt/n
   s=;
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="108163292"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:46:30 +0100
Date: Tue, 4 Feb 2025 13:46:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
Message-ID: <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com> <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com> <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com> <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr> <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2137440300-1738673190=:3519"
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2337
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1c92f6ab-9992-1f5-d911-f8cd52991c66%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2137440300-1738673190=:3519
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 4 Feb 2025, Ricardo Ribalda wrote:

> Hi Julia
>
> Just FYI, In media-ci tried again with Debian's 1.3.0 and it is better
> than  1.2 but still much slower than 1.1.1.

Thanks for the update.  Do you have a number?

julia

>
> Regards!
>
> On Mon, 5 Aug 2024 at 14:12, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Mon, 5 Aug 2024, Ricardo Ribalda wrote:
> >
> > > On Mon, 5 Aug 2024 at 13:27, Markus Elfring <Markus.Elfring@web.de> wrote:
> > > >
> > > > > It seems to be related to the cocci version, and not the kernel version.
> > > > >
> > > > > Debian updated it recently from 1.1.1 to 1.2.
> > > >
> > > > Thanks for such background information.
> > > >
> > > >
> > > > > These are my results for the same kernel code:
> > > > >
> > > > >
> > > > > root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
> > > > > MODE=report V=1  > 1.1.1.txt
> > > > >
> > > > > real    1m59.021s
> > > > > user    53m53.038s
> > > > > sys     2m17.171s
> > > > …
> > > > > root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
> > > > > MODE=report V=1  > 1.2.txt
> > > > >
> > > > > real    15m0.552s
> > > > > user    371m28.976s
> > > > > sys     3m32.884s
> > > >
> > > > Are there any possibilities to increase the measurement granularity for
> > > > affected SmPL scripts?
> > > > Would you like to compare software run time characteristics in more detail
> > > > (in parallel) also according to each SmPL script?
> > >
> > > Let me know if this is enough:
> > >  time make coccicheck M=drivers/media/ MODE=report V=1 | ts -i > 1.2.ts.txt
> >
> > Yes, that's helpful, thanks!
> >
> > julia
>
>
>
> --
> Ricardo Ribalda
>
--8323329-2137440300-1738673190=:3519--
