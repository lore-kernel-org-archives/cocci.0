Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F34C61DC6
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2026 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vM0/L21f9tot3vpFXvyjlc2gt/uZgvIf/L0mZwOnhSg=;
  b=pKTDfnJYFgAENGZ2K28yx9HSiHrRI4NIvW3yVpl0Yy28NxnyzuBIWKa2
   /E7gDYmTRQwGTg0V4MUuYBpqk3CI7+A47N7+h7YKvwtSV4wNsMVLPHAFp
   booumfGRfSJTKwxRssS/1xx2mnqitMWP8XE/nGC06NqY5W3nFAztz562x
   Y=;
X-CSE-ConnectionGUID: aVz+AFWkQfiosUoiDoMmaw==
X-CSE-MsgGUID: kD3oIwWeTU2OnW2K8eHuQg==
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
   d="scan'208";a="291814265"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Aug 2026 14:35:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3559D812DA; Thu, 27 Aug 2026 14:35:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4C75681E29
	for <cocci@sympa.inria.fr>; Thu, 27 Aug 2026 11:45:20 +0200 (CEST)
X-CSE-ConnectionGUID: ogNU0DiBTw6Zt1F9ddHopg==
X-CSE-MsgGUID: /8TAUlDeTS2bq6j6Hk0PMg==
IronPort-SDR: 6a90072f_tDKpReQ9XFjDN+SzI/NW+iCTRFC8wTwjqRwCfCiuJAaRnrT
 UBBmrrm3mqC6c5Y/sZvOusFbwEMSWLDDJDKhdPQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EPAgCYBpBqgbTWVdFaglmCQVowXzMEVIRYiHqGWIIhA?=
 =?us-ascii?q?54bFIFoAg8BAwEMATQdBAEBAQIEhDhGAo1vAh4HAQQxCA4BAgQDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAg1+AQEBAyMdAQE3AQ8LCw0CAiYCAiESAQUBHAYTCIJ7g?=
 =?us-ascii?q?iIBBksDEbQKi3GBMoEBggwBAQbcM4FpAwYJAQoBAYEJLoheAYFwiAp6JxuCD?=
 =?us-ascii?q?YFKgkUxPoJhAQMYgREBEQIBIBWDRoJIIoImgQyOSYR4JgkdAwcHDg0eRg8FH?=
 =?us-ascii?q?ANZLAFVExcLBwVeRUMBAgGBBSMPPAUtHYEjIR0PCBceWBsGBRIgKkFDASMDP?=
 =?us-ascii?q?oEZQQKBdT8jGTZ8gQlegSspYAECEBdGLhWCBwKBPYEdgSdeAgFJQw4HOQ5DC?=
 =?us-ascii?q?2ILPTcVGUqPXB+CCUQCgQ0qAiA4gXKTEIM0kEmKQ5UXhCiEc4cvlVQzl1OTG?=
 =?us-ascii?q?YU9k0uOCpsOAgoHBxEkgUUBOC4+cDMaCCgIbAaCMBM9AxkPji0WiHPHCEI1A?=
 =?us-ascii?q?gEIMgIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KEznL6mcyiCKPg8ZQMl8JNFHQijpDfOEimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7Sc+9qADnhOdICOgqTP6ftWzd1FdAQ7sSibcKrweAJ8SczJ8U6U
 4DSdkYNDSYNzET4qjHCWKDYrUdKay8gcWVbJDlvhVQpG9RC51I3kNcMEK2A0d2TA5JCd4SD5
 yH/PdKoDKmZDA+ctm7LmNtZZmIm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYZ93
 TfmQCR3NTvjxj78G6R64bg1eUZpDLT8KoDOCVKsLlUFtzYsHfmWG2mYczAgNl6mpDs1L9gqq
 i1n/5pBbUJ15qWRBD/nfKl4Xib7B8+r3Dl0lOWmn3lvIjwQy87EdNIgcZDfgLe8FdIhqAI7E
 tn5RPri3NsN2KzoA3to9zTEx16nEu9pnQv1eYVknxESIMbLLtct5YW8k9ZGIoJWHuS0vFRLM
 B+SMXHoPpGe1KTaH7U+mFp3dy3R3w2WhOLWFILtMCZ2yVf2CgR9Tpv+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKaZwHv0IT8e7AnHEBRjMLGWRK1L6E7xvAQO4l7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P1njDMWftac7giwkDA6GLErQIwFllulEU5HHNcXW2He4OS0TeuOb0okiPvE=
X-Talos-CUID: =?us-ascii?q?9a23=3AJWrn8mrybGZtDVistjK3eFzmUccqVECF4Hb6H1D?=
 =?us-ascii?q?mO3owZuyZRX+X4Kwxxg=3D=3D?=
X-Talos-MUID: 9a23:uBpzwAbMHy6S+OBT8G/QrQxmGMpU2P6kER4Pz7UF4/GhOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="291776745"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEAo7xaEhPF15M3o44fFMnuWDzG+DjdSPwzXC?=
 =?us-ascii?q?cNXsgbzallwMf6oZPbS8h4D7w4XpFMGtoaif+6sISCGKa15GfEwnakBn?=
 =?us-ascii?q?TyEd/NmuOgtc2ERN8sbydE9PvmCrU+kZeCGWHnJK3PavF+ZzSt1XG6QT?=
 =?us-ascii?q?pTQAjOoMbiUv/xri25+lx/nw=3D=3D?=
Received: from mail-pl1-f180.google.com ([209.85.214.180])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 11:45:19 +0200
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf452def93so6114925ad.1
        for <cocci@inria.fr>; Thu, 27 Aug 2026 02:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823918; x=1788428718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vM0/L21f9tot3vpFXvyjlc2gt/uZgvIf/L0mZwOnhSg=;
        b=Wg9Mvp9X+efuE5dPUuU7f58pTqTy9eHHIoKYOSJ9/E91SspfVHOYRlhROcBETltrke
         OuS4yPxRoQOK6AewfuDUJrEeTKkE6+xU87pOm3NweCZGGRcm3aeoSxwQGCYNI+X3FFS7
         8sU0vepaW73NrLHRQZRIeQqiptJAGyL/bAeA14SPWl0/3Y0fCjWge2WGhwIYfMv69Ptm
         wqVMNngU+YJSYmvlmid0lIDoPMtkG1QY4vpjb7YKLHiqq5ARAW89/s4MNy8iMBUR0WNW
         caB3tarQ1Sz3CstPjTdoZ8Ik4f6kC5um9kzLfnO7QN7THroh/5j+DyJmP/jgnt/D28FX
         2HZA==
X-Forwarded-Encrypted: i=1; AHgh+RqCuWTMMo1//5Op7aqqaB/cCcOGNC/XG4BdrEK/EveJ+jPOeTSI5PCha0mPkbXj9VmsdMOPmg==@inria.fr
X-Gm-Message-State: AFuF++n2SlUoffzMsieMnt+R9rLsbQB9A9NcCgYV9Q7UjxEqv/zWwWV1
	yDNqIBFUHZDSSPXGSD/UlnIfijbL0vD97XDLMCZkLBl4b/rB5TkJ1syK744k5unBmEhZVXrd5vZ
	6PjEa1A==
X-Gm-Gg: AR+sD10oCc9khZgCbyFaQw8d+N1Ro7iVwDe+/nZZrVpNBQBMqXLeZYveFaaEZGcfzpw
	3htT0bpKuQHoKY51sr087+6s+4oe9x4KmSfZeYiYyJkgjBU2zDF40rzDdKUoRBzTZWvxg7Hn0ht
	VgLpceWJJHVb/gPzk1YHzkpnLauaX+54WTKrdNozuruy0x4VVSZOm50p6DdqHKKxr7ZU2hpcxlT
	xgbULe2ARzMAmWoheS7EAi517VmOfgOKseg25EP/fZDdglwmolQO76wsjOsBpiDGp2I+6wX0klh
	Gu+kn7Yn29v6HjoP9P1X8B1bNE0o0O/t4HjpnuUHDDQWs2J71yMwpIbpDZV9XUHDegoKRFjIluB
	Um3FfuXsoerVv5bYsaE9pPOovAPjGX1a9+xrTxrMPNGow3OOEksVcluDruEcgODvpYvdDiryGmU
	GBpl+m2+VbpR5lZjE86odDcrc478qAFjfr8p+NmUuZbwhpFwvAgevRjOol2/0YfMHwOYIPvwBDU
	v7JwqLy92lZ25aohJCYVA7qj68a9w==
X-Received: by 2002:a17:902:ce87:b0:2d6:dcf3:b754 with SMTP id d9443c01a7336-2d7265b53a1mr59383585ad.7.1787823918052;
        Thu, 27 Aug 2026 02:45:18 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70498d74asm15068705ad.29.2026.08.27.02.45.17
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:45:17 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so638766a12.0
        for <cocci@inria.fr>; Thu, 27 Aug 2026 02:45:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrwdZIYkUT8RgdZ03CVcpEhuyjrlwlmnpvTVSS5EepC15flPBAW+/TCe5uYALgY63kUAY7h1Q==@inria.fr
X-Received: by 2002:a17:90b:5281:b0:396:4ce0:6400 with SMTP id
 98e67ed59e1d1-3969ba3a303mr7718113a91.2.1787823916368; Thu, 27 Aug 2026
 02:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
 <20260818120428.2546810-1-ribalda@chromium.org> <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
In-Reply-To: <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 27 Aug 2026 11:45:00 +0200
X-Gmail-Original-Message-ID: <CANiDSCubAtxPLft=YF4Cq2aAO9c7ZEe_gYmvSQ5yT8UxGzzSEA@mail.gmail.com>
X-Gm-Features: AcwNN1Wg35VaoCPidKcyTWNXMAGNl7vbS8U51ZtBOmn-f-e6hSKjRXwP7gyXSqM
Message-ID: <CANiDSCubAtxPLft=YF4Cq2aAO9c7ZEe_gYmvSQ5yT8UxGzzSEA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: dmitry.torokhov@gmail.com, bentiss@kernel.org, cocci@inria.fr, 
	corbet@lwn.net, hadess@hadess.net, jikos@kernel.org, lains@riseup.net, 
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] HID: add documentation and Coccinelle script for FF
 registration race
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3718
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/a8gR_Wa1PmyIkwZsiiUBRw>

[In plaintext this time, sorry for the previous HTML email[

Hi,

Just a heads-up that this this patch has landed in Linus tree, not
only in -next:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/s=
cripts/coccinelle/hid/ff_race.cocci?id=3D225c30812857f47cb42bfd945a15f448f5=
8e82cc

We should fix it before -rc1 is tagged

Regards!

On Tue, 18 Aug 2026 at 14:08, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 18 Aug 2026, Ricardo Ribalda wrote:
>
> > Hi Dimitry
> >
> > Looks like media-ci is not particularly happy about this patch:
> >
> > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/1081279=
01
> >
> > /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /bui=
lds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch =
/builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/riba=
lda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include/=
generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-med=
ia/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/incl=
ude/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/ua=
pi -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-media=
/users/ribalda/include/generated/uapi --include /builds/linux-media/users/r=
ibalda/include/linux/compiler-version.h --include /builds/linux-media/users=
/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1
> > Position variable r.p2 on line 20 must be attached to some other token =
using @.
> > coccicheck failed
> >
> >
> > The following change fixes the issue for me... but you probably want to=
 double
> > check it, I am not proficient at cocci.
>
> I would also like to improve this, as suggested in a previous mail.
> Could it be detached from the documentation change?  Then I can take this
> part and fix it up.
>
> julia
>
> >
> > diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/=
hid/ff_race.cocci
> > index 479f5d1e3184..7cf84936db13 100644
> > --- a/scripts/coccinelle/hid/ff_race.cocci
> > +++ b/scripts/coccinelle/hid/ff_race.cocci
> > @@ -9,7 +9,8 @@ virtual report
> >
> >  @r@
> >  identifier probe_fn;
> > -expression hdev, flags;
> > +identifier hdev;
> > +expression flags;
> >  position p1, p2;
> >  @@
> >
> > @@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {
> >    <...
> >    hid_hw_start@p1(hdev, flags)
> >    ...
> > -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> > +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
> >    ...>
> >  }
> >
> >
> > Regards!
> >



--=20
Ricardo Ribalda
