Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDF9C5B572
	for <cocci@archiver.kernel.org>; Sun, 16 Aug 2026 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rogr93xEBCwuiAzKlLpwDJRo4Ap18TiIfPxr3bQ3Gb0=;
  b=Fku1DFfztt+WZNfRt3PtIBq06qb+z/+S13HQfPPZwWyfw8j42zWfxUs5
   L3VAvI/sg7cbQGUr6v/PHYp0mrlaChRTKW2wc4FEI68r4hfHSOFvMHrNd
   XdQfceHV8gJIF6nu6Ez/EO6wl5iu1FYXdoTAW2NJsrt+7zGiyq3RCEoP5
   U=;
X-CSE-ConnectionGUID: 6HMaR0WjTMC/vdDKdm/cFg==
X-CSE-MsgGUID: mHZEUKOKTBOs3w+/jvywRg==
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
X-IronPort-AV: E=Sophos;i="6.25,227,1779141600"; 
   d="scan'208";a="290305533"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2026 20:52:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B630D80EA9; Sun, 16 Aug 2026 20:52:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A67CF8059B
	for <cocci@sympa.inria.fr>; Sun, 16 Aug 2026 20:52:51 +0200 (CEST)
X-CSE-ConnectionGUID: wVRgbFu8RtCSiN88Q/8iAQ==
X-CSE-MsgGUID: TmkET2/mQGqULuPbm3w4TQ==
X-IronPort-AV: E=Sophos;i="6.25,227,1779141600"; 
   d="scan'208";a="290305522"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 20:52:51 +0200
Date: Sun, 16 Aug 2026 20:52:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cocci@inria.fr
In-Reply-To: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
Message-ID: <5e96c91-164f-9ec5-43e4-474189e2a337@inria.fr>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com> <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 02/21] HID: add documentation and Coccinelle
 script for FF registration race
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3678
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/7Yzgf6Bg0IZaU7JBvWbrJg>

> diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
> new file mode 100644
> index 000000000000..479f5d1e3184
> --- /dev/null
> +++ b/scripts/coccinelle/hid/ff_race.cocci
> @@ -0,0 +1,34 @@
> +/// Detect HID drivers that initialize force-feedback after hid_hw_start()
> +/// when HID_CONNECT_HIDINPUT is used. This is a lifecycle violation as
> +/// the input device is already registered.
> +//
> +// Confidence: High
> +// Copyright: (C) 2026 Gemini. GPLv2.
> +
> +virtual report
> +
> +@r@
> +identifier probe_fn;
> +expression hdev, flags;
> +position p1, p2;
> +@@
> +
> +probe_fn(struct hid_device *hdev, ...) {
> +  <...
> +  hid_hw_start@p1(hdev, flags)
> +  ...
> +  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> +  ...>
> +}


This seems unnecessarily costly.  The pattern can be just:

hid_hw_start@p1(hdev, flags)
...
\(input_ff_create\|input_ff_create_memless\)@p2(...)

Or does it matter that struct hid_device *hdev is the first parameter
of the enclosing function?

julia

> +
> +@script:python depends on report@
> +p1 << r.p1;
> +p2 << r.p2;
> +flags << r.flags;
> +@@
> +
> +# Check if flags include HID_CONNECT_HIDINPUT (0x01) or HID_CONNECT_DEFAULT (0x0f)
> +# Note: HID_CONNECT_DEFAULT is 0x0f, HID_CONNECT_HIDINPUT is 0x01
> +if "HID_CONNECT_HIDINPUT" in flags or "HID_CONNECT_DEFAULT" in flags:
> +    msg = "WARNING: force-feedback initialized after hid_hw_start() with HID_CONNECT_HIDINPUT. Input device is already registered at this point. Use .input_configured() instead."
> +    coccilib.report.print_report(p2[0], msg)
>
> --
> 2.55.0.629.g250fe7f194-goog
>
>
