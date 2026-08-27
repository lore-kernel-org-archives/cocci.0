Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856CBC61DC2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2026 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZezuO2NgwuOKZZT46NB5n0n9jBETCPGkKkIHPY19i1k=;
  b=V98wXjqJc9mCiAXHrmtNI22nR/PAMXugdePg3lIdv3FhC/uTVBD1Oohm
   1+kyJb5eAe673SSrtSQk38KKGpvvj+I4Qs8/zakBFRWmKNd6WadnYeYUr
   Axhlr5vOh2pDBZv9pavtq+LJU5T+/g5aiFfmf4xFXrZfJVkj1/Q7b1AsO
   M=;
X-CSE-ConnectionGUID: ATf6VtQ9SLizXIqNnc01VA==
X-CSE-MsgGUID: 7qDXQT9STr+G6MI4HeNGBQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="291805066"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Aug 2026 14:00:06 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 05D1480512; Thu, 27 Aug 2026 14:00:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2441E80512
	for <cocci@sympa.inria.fr>; Thu, 27 Aug 2026 14:00:01 +0200 (CEST)
X-CSE-ConnectionGUID: kUUrCOlrQG+IFxsgUdOTDw==
X-CSE-MsgGUID: kt5pwAjhTl6ACnTAinlsVg==
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="155185037"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 14:00:01 +0200
Date: Thu, 27 Aug 2026 14:00:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Ricardo Ribalda <ribalda@chromium.org>, cocci@inria.fr, 
    linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <eaca9bae-fba2-4824-9219-faad0b9f766e@web.de>
Message-ID: <ec917c17-dcee-bbed-b59f-49e3cde23cc@inria.fr>
References: <20260827112949.2431233-1-Julia.Lawall@inria.fr> <eaca9bae-fba2-4824-9219-faad0b9f766e@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-444202327-1787832000=:3521"
Subject: Re: [cocci] [PATCH] HID: fix semantic patch and improve its
 performance
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3716
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/_08ARin5D1kJue5jy9133A>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-444202327-1787832000=:3521
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 27 Aug 2026, Markus Elfring wrote:

> > Replace "expression" with "identifier" in the declaration of hdev.
> > This is necessary because hdev is used as the name of a function
> > parameter.
> …
> > +++ b/scripts/coccinelle/hid/ff_race.cocci
> …
> > -@r@
> > +@r exists@
> >  identifier probe_fn;
> > -expression hdev, flags;
> > +identifier hdev;
>
> May the following SmPL code variant be applied?
>
>  identifier hdev, probe_fn;

Yes, but it doesn't matter.

>
>
> > +expression flags;
> >  position p1, p2;
> >  @@
> >
> >  probe_fn(struct hid_device *hdev, ...) {
> > -  <...
> > +  ... when any
> >    hid_hw_start@p1(hdev, flags)
> >    ...
> > -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> > -  ...>
> > +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
>
> How do you think about to use the following SmPL code variation?
>
> (input_ff_create@p2
> |input_ff_create_memless@p2
> )(...)

I find this completely unreadable.

julia

>
>
> > +  ... when any
> >  }
> >
> >  @script:python depends on report@
>
> Regards,
> Markus
>
--8323329-444202327-1787832000=:3521--
