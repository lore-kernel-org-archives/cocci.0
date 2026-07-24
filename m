Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57917C53209
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=40R9Zxw027ms/Fu4Pi8SHJPW0gKWq8gjqx1E5LRYD3s=;
  b=a4F3ktkaRovmsauMocn/1gv95y+HJWOfS40k47qsDc3Tl3hLadfUnE+0
   lRasEFLTFKOZ4SyEn9OCNXva0yDXq3YVb1ifFraqpi3DVy+YMmLUL+oHd
   UsA3iqtzoPvXZUn2vBAnyhH7xyVqYtXdxG5ti1ORlQRmGslViUvlJszxr
   A=;
X-CSE-ConnectionGUID: QRWpwXjVSx2CRvvYxYEUrA==
X-CSE-MsgGUID: XhFvr6y/Rz6IT0AaqXwMVA==
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
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871549"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:36 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C96D7802B7; Sat, 25 Jul 2026 13:44:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9AAC581948
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 16:43:04 +0200 (CEST)
X-CSE-ConnectionGUID: b1eKatOTT1mLbhcPSQFlQA==
X-CSE-MsgGUID: uADUOdDsThWsI1kgBxHaQA==
IronPort-SDR: 6a6379f8_MJ5zni7DRbapuJvUZUIDdv0w1XMqNUtBH2BQWramcz+Eo7A
 CI7d8z7Ntw0Hflh5g7EIgBwI9FAmREHcTwUFHwA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HkAgBWeWNqgbSAVdFaglmCQVqBDjQEC0mEWI9SgiSJL?=
 =?us-ascii?q?oIZMAKHUwOEboQJgxQ9Ag8BAwENUQQBAQECBIR+Ao1gAh4HAQQzBg4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDYJiA?=
 =?us-ascii?q?YEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFA?=
 =?us-ascii?q?ixeAQEBAQIBEhEdARsdAQMBCwYFCw0CAiYCAiEBEQEFARwGEyKCYIIjAQYQA?=
 =?us-ascii?q?QMQJwO2VYECQopDeoEVBQIWgQGCDQbaaAoZKA0VYIFmAgcVAYEJLoR4Kl0Dg?=
 =?us-ascii?q?j4cAQVufYQHRIM+eieBGIEQgUqCdj6EQxWDRoJqBIEOgRSBDIxQhT8mAQcBB?=
 =?us-ascii?q?hcDBwcJBQQJEwYFAwICPwkGBQoSAwQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SB?=
 =?us-ascii?q?BMCCAkECwcFHwoCDBQKKCIEDisKAQIBVRAGGgEIBgICBAQCBAIKAgkCAgUDB?=
 =?us-ascii?q?AIEDQMEAQEIAgIDKgMBAxkICQgCCwURGAwLBzEDEAkDAh0DFBYFCBE0CAYWA?=
 =?us-ascii?q?RoHBQYLASAWFAEFDBEBAhsCIQQdARAIAwEHAw4EBAIBCwMBAwEVBAgJBAwCD?=
 =?us-ascii?q?wEKEhUDAwsDBw8CDQcUBRULAwIOAgkIDBcCAgIGAgMDAwoBAgEBAQEBAQECB?=
 =?us-ascii?q?wMDAwIDGQcGAwMBAQMBBAQDAwIDBQEDAwMFAgIKBgkBAQEBAwICCAMHAwoJA?=
 =?us-ascii?q?gUDGwMcBgECAgMCAQIDBgMHCAMIBQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDA?=
 =?us-ascii?q?gEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDAgEDAhwDCAMGA?=
 =?us-ascii?q?xIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBAgICAwUDAwMIC?=
 =?us-ascii?q?AQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHAgELCwgDA?=
 =?us-ascii?q?gQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIBQYDAgIRBQgKB?=
 =?us-ascii?q?QYCAgIdAyEBAgEPBgEJBQIBBQ4HBQICChIDBgEBAwQFBQEDAQoBCwEBAgMDA?=
 =?us-ascii?q?QQFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDBAUFBQMCBQIEA?=
 =?us-ascii?q?wUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGBQMDA?=
 =?us-ascii?q?wMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFAwMDA?=
 =?us-ascii?q?wYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgTPQELB?=
 =?us-ascii?q?y4EBAwqARQUBSkhXxCNbiOCP4Eagh4igS8BAQGSKJImoGoeCQEGAmCBZ4EKF?=
 =?us-ascii?q?QovinuWejOqbC6HZheQXaNqhUgRJBKBSCSBXDMaI4EBbYFJUAMZD5IjzjU4M?=
 =?us-ascii?q?j0BAQcCBw4DC4FohF6LVoFMAQE?=
IronPort-PHdr: A9a23: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
 QpvMzKWHtps
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0221janD04nstt3yUFlr2hgrvNvpDfLt3DAbv31ZSRFFG/FwyP
 rDoB1L73LJYWgqMk3IV+rwRZVoJkmsiqKdgLNhQYtKOTOIhILGFvAF0WKP+UyGJ8S6zJ846U
 4CSdkdNDSTNykDsS+S2mDReOrIguP3lZxA7t2utEuFIzsaEZ1I3kNWDkK1HkVqWBJLH/MCZe
 Ohz/sCiT7lV3p/VKSG77o+PtQrZeekqHsuW29kOyIa
X-Talos-CUID: =?us-ascii?q?9a23=3AQFBDC2ksPf8PF2ceY5VFi8gLpGLXOXeEwVTZP2i?=
 =?us-ascii?q?ENT9sbLeVQmerwY1gquM7zg=3D=3D?=
X-Talos-MUID: 9a23:nPf5EQkVqLjrH3Q66m9Cdnp/HetVxKiCE3wNro4n4sqLHzxQMg602WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="152882888"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGLvitbATZl+6WHwuLwys4WenDeU3o33efFa+?=
 =?us-ascii?q?H+laJStWNWh8tdMP6ytpucmgDaMl9O42blDyz/oxSyBZCzwZqJqNsYZB?=
 =?us-ascii?q?WA5z2cbQ6/cVmR/o1WYSezksw7Iv5bezDaDKnOhSXSydba4Akwc0AU/V?=
 =?us-ascii?q?8BezOtjILywfxV0EdjMYJ8wQ=3D=3D?=
Received: from mail-yw1-f180.google.com ([209.85.128.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 16:43:04 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e69a2db34so5385717b3.0
        for <cocci@inria.fr>; Fri, 24 Jul 2026 07:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904182; cv=none;
        d=google.com; s=arc-20260327;
        b=L8P/BwpWA2+t8o/7KKS2nfFcI+68pDwCxDLhIR9Z4AChoEidbeko+HqYrJrprJNhK3
         Gid9Ju/RVf5P9hWZDquwVzVdFbkHlPAWvzvA35TamQwvvtcd8W4B+flpSHdj/gkKRkPF
         SuCXi2L8LJlf3qGT4EXr9eVrYyIy5oQW7c2Siu8NYaYrXFBraxYz6B4yJni23Bc30YPi
         pgvLumSdteH3EoD8QjlMVbe5BiFhSYNHUGAYFJVJt1qE5ijsWtojESAOCTadzgFW1iiV
         m98R60MR56ROhKzKdRKG60wOAFTMebI/Yoz9Ks6W1r3HeyOTE8SBaggN5AF+93AeJWt9
         iBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40R9Zxw027ms/Fu4Pi8SHJPW0gKWq8gjqx1E5LRYD3s=;
        fh=98o/vL8tvD+D6Lk3tVkGiKTfGX1YouR5vr0DoujIoQE=;
        b=JX3lN/x8+ZqCmhZlAxqu76i5wAhYYJC1KAE2TZhNrUfHxACEC8ZRn0F0xhNhsPzJnP
         v/Q7mNCmsy74TcrZAnj++av//A/vgbm+Yxg2JOAgkVEvwHTwq7/rLu4xPqi2BObNJG3m
         95vyEuii8TgyVjr+n6V8TL/kKHGUulaptu5FHhisnSmskCAlXgUVryTsz6esx3kx18Mv
         4D7Rn0XtxYlqAZJnEwIljbtQxeUtXOfY91D7x3O0ozqLcCE+i149bo1obltZhNRqiD3p
         /ANx+QVAiXeHb/Wy0bSM/lSKLszy0svkEssin4p9N9Q2E1iNsBwbx/rhqAaxIHdCq0Z/
         2ABw==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904182; x=1785508982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40R9Zxw027ms/Fu4Pi8SHJPW0gKWq8gjqx1E5LRYD3s=;
        b=Az9hTgQIuS9bLglI0XUQDqowIDkWAfopTQr7pUPx1qBh0q1nTzBYr+MXBwWoyL2Rfh
         hNe0pr8Z6EyfPugECGd54HOANE09kHEgsRI1MnbxQ10JTE/6bhrCk9ZmzlQOyZtjRwua
         Kheyoyxz8j77GywndNbFK59FV8im40W1oo9UDp1gUeAtd8vtfv/54mK+ZtF541+NfMST
         W8DDqxq7ad8YVyh2isqCozoH9jqCgNZW+ZYPs0TYCE0qgQVgVk8v+tlFNjH4Q5Q6nGhh
         mA8EFao0Qe7PwYgMQKy9t875tnJyJnIHKzoB8OtncB16VtNmk4huYBTRmXlsHctOGBJz
         qwYA==
X-Gm-Message-State: AOJu0YyvDou7zCf8oECK36EoEQ/ibUw1S5GmDZvn5NCyW0nwQSNgVPo7
	QTiWLbUKT4mR8SAUSwoWxZ1x6CA5GZA4D1xaDQant/xotkDlRw6o88D4paAZp7tj/EBW4a2ozne
	kO0KXH0DE6SJDtqeedG5aVQuhyF4UJ/A=
X-Gm-Gg: AR+sD101GOx4hwasl8XPARFFFk4OO2SxV80eA4y2hldcquj+PlANqZmLFVRDtnLHtgI
	M1i3PCHr4LaxgxH+HRsDe2m5bE23J0FDNrF9k5nV5b4Wf8+UbV/Ouc2LohyO31983nBqcinvkNQ
	5103h0HklUq0Z7zEyAZ9MrnfBrcM2l1IyVqG+qa2MltV6e00rgE7K4zi0pXnNeO+2+DWK7VSB8x
	xgGVRdvKyUU2dp9Fh9x2ecK5JBR+krgSPI53uFc4hPLV+wRcF8xvJBHvVuvBZL14i9KKQ==
X-Received: by 2002:a05:690c:d0d:b0:81e:b3d9:4295 with SMTP id
 00721157ae682-81f4c390e02mr24981977b3.60.1784904182241; Fri, 24 Jul 2026
 07:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-2-ekffu200098@gmail.com> <b0577cf2-d8eb-473f-87af-82ecc653f29c@web.de>
In-Reply-To: <b0577cf2-d8eb-473f-87af-82ecc653f29c@web.de>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 24 Jul 2026 23:42:51 +0900
X-Gm-Features: AUfX_myl00xXBUA5qTiBhpgdFQbaoUWsGjc-tQWSqm4A-o4NHHL3a7Qmdr-m9MM
Message-ID: <CABFDxMFYvuAZSGcPmhAj4H43dwYBG01P2-UQPGa=-M=yRE8YKg@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 01/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3649
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/ZQ-LKGU3sFLr_F4d6QFyFw>

Hello,

On Fri, Jul 24, 2026 at 8:19=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> > @@ -0,0 +1,121 @@
> =E2=80=A6
> > +@depends on patch@
> > +local idexpression ret;
> > +expression E;
> > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > +constant C;
> > +@@
> > +-    ret =3D E;
> > +-    if (\(ret \| !ret \| ret cmp C\))
> > +-            return ret;
> > +-    return ret;
> > ++    return E;
> > +
> > +@depends on patch@
> > +idexpression ret;
> > +binary operator cmp =3D {<, <=3D, >, >=3D, =3D=3D, !=3D};
> > +constant C;
> > +@@
> > +-    if (\(ret \| !ret \| ret cmp C\))
> > +-            return ret;
> > +     return ret;
> =E2=80=A6
>
> How do you think about to combine such transformation rules
> by using an SmPL disjunction?

The two rules look similar, but the metavariable kinds are different
for a reason.

- If both rules used `local idexpression`, the second rule could miss
global or static variable cases, even though such patterns are not
common.
- If both rules used `idexpression`, the first rule could remove an
assignment to a global or static variable, which would be a false
positive.

Combining them with two separate metavariables would be okay, but I
don't see much benefit in that change. So I'd prefer to stay existing
form.

> Regards,
> Markus

Thanks for reviewing :)

Best Regards,
Sang-Heon Jeon
