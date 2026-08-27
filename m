Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F504C61DC2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2026 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vHJggA9nixE7B1FyFS0v6M49d22TtLHsASQi5EVY0vw=;
  b=mSwbxbrN90ULJo9yFgRJoaM/zu61dUnMEIMb8cIx65LLRxwV5FztHJ6h
   o4QZf3JVzLChCL9tIygboVjZSHOHGu1fq+VplyyFOxe56rag+veOcPbCf
   Ac31RI2x1OtgIY3nDyDrI3MisYLDObEVK7JQNpAFDb+PSwfr2PAm2LM4M
   g=;
X-CSE-ConnectionGUID: AVBqkhHcQJastpthYP25dw==
X-CSE-MsgGUID: cRxgx+mTT2uslinMMZ2SIw==
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
   d="scan'208,217";a="291814248"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Aug 2026 14:35:01 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 24A028130E; Thu, 27 Aug 2026 14:35:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 31F6481E13
	for <cocci@sympa.inria.fr>; Thu, 27 Aug 2026 11:39:59 +0200 (CEST)
X-CSE-ConnectionGUID: ZFR3Ed4GS621/lde/9sAxw==
X-CSE-MsgGUID: 7bfUrs6fTqK+7jHNUAWeaA==
IronPort-SDR: 6a9005ee_FBszjeFk97UD2H2k3lNXEtFCp61p8AvtparqMrzCtKR1VL9
 s+l3E3Q15wgkMMNUOT+qdTwtWQ4YGYE4CFfr9dg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQAgAoBZBqfCvYVdFaglmCQYEKXzMEVIRYgSOHV4ZYg?=
 =?us-ascii?q?X8FHQOXRIZXgXwCDwEDAQwBNB0EAQEBAgSEOEYCjW8CHgcBBDEIDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBIx0BATcBBAsLCw0qAgIhEgEFA?=
 =?us-ascii?q?RwGEwiCe4IiAQYkJwMRtAqKd3qBMoEBggwBAQbcM4ENXAMGCQEKAQGBN4heA?=
 =?us-ascii?q?YFfAw6ICnonG4INgUqCRTE+gmEBAxiBJAEBTYMugkgigiZ6EhuCRotohHgmJ?=
 =?us-ascii?q?gMHBw4NHkYOASEDJjMsAVUTFwsHBV5FQwECAYEFIw88BS0dgSMhHQ8IFx5YG?=
 =?us-ascii?q?wYFEiAqQUMBIwM+gRlBAoF1PyMZNnyBCV6BKylgAQIQF0YuFYIHAoE9gR2BJ?=
 =?us-ascii?q?14CAUlDDgc5DkMLYgs9NxUZSo9cH4IJRAKBDSwgOIFykxCDNJBJikOVF4Qoh?=
 =?us-ascii?q?HOHL5VUM5dTkxmFPZNLjgqbDgIKBwcRJIFGATcugS4zGggoCGwGgjATPQMZD?=
 =?us-ascii?q?44tFohzxwhCNQIBCDICBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:U+sc1q/gaM66mUVzHzFuk+DoI+orL9Y04lQ7vn2ZKCY4TiX8ra
 uTdZsguiMc5Ax+ZJhYo6HnBEDYewKkyXcW2+ks1MaZPTUO0VHAROsO0WKI+UyCJ8SRzJ846Y
 5QN4R4Fd3sHRxboK/BkW6F+g8bsbu6GXaT9ILj80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AL2zdH2sR9Ks3xdsu4+p+e2IW6IsXXEeG4XuMDHT?=
 =?us-ascii?q?mUz8uTLGYDg6L0bN7xp8=3D?=
X-Talos-MUID: 9a23:eH2wkwgjl5vR6I0cacs2iMMpa81m3r61Vk4xiLZF5MukExFZBDqUpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208,217";a="155169881"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHSI1vBGVD9Y3h+0T73QhvL3mT4tjvGJg5Ltl?=
 =?us-ascii?q?2KucIuTU77JiHQvi/IYnACgi7ufr48PXjWHgCG+W7GVYYHThoTcp5+b6?=
 =?us-ascii?q?1gklsOMblAeBZoJ71FNaSOeZ4f1dKNOAiJMo3jgeqWRJ9GG2C91HaSIF?=
 =?us-ascii?q?WNrI9IxB6KRGCCPL7d6vSGKA=3D=3D?=
Received: from mail-pj1-f43.google.com ([209.85.216.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 11:39:58 +0200
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso818895a91.0
        for <cocci@inria.fr>; Thu, 27 Aug 2026 02:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823596; x=1788428396;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vHJggA9nixE7B1FyFS0v6M49d22TtLHsASQi5EVY0vw=;
        b=A6FZhJfVJZ1gPolydcfQCvdATy6c874gyUh/s12U80kbT1sIVoCRt9Hfo5GwIJK3fv
         zsrXAmzM/oNg45is27/JObLOKn7nnHPRLUlFQax4ZdePry6m1yrkvqycbtnoVnQ27a0W
         u/B9Q9bDdu+sEG0HScB7YsRHgh/USQOm/uZ1FuhYBrWyZH06IONkR01xVnDwxw1tkxVu
         3L2qImWqWT9g3u8dqazmo1HZBGV476BaAmon/ziZLL63fT8YHWse0BL3gmU0fXJK2qmN
         ZdHJCB5myiazTo1kfKJI8+SPz10FKqkWYMfg2EX0GPumIFbmUnhb0CKpdYC76miGhBsl
         zHiw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/qfW/1Hhlx8S5Lf7VGn3bpg5ewHn4zaaPplQYZUYWJ3212LLpRGY7xzi9C4Cn0vClryCGIA==@inria.fr
X-Gm-Message-State: AFuF++kYG29U3eu5h6MX6qVx+Wg2lxkywffpekRMuV+PYTcaF9vStBr2
	CVOGFgkeZAb4e4YuvGBhmE+paA6VF/pm0QOTTL/7UNGzp/6PgbphO3NMADc1vXn9QTo9UhNx7t2
	Wpv5cEw==
X-Gm-Gg: AR+sD12Zf8z/annOPGoxQnnPq+WHkCLIWeTqVnnhjMiIxUZUNrS8yWmZiRx4ydekwkT
	o8bIkipZYonfU4GnO8cXhDxTz2p2wiyRwdJmgA5Cdx+kl4ZlScxO53MXClG4th0N9COoQ8ZPKYu
	gisjmt0cDPpvzkf4wTHsvKwAZCyVjl1dq91ZADxwY48Pdo55CK1GaPQAWSi/mPWSVes35eLkqzH
	lA+k3FFh9jqCu4jw5xt8lMOBobIxa3cfhhl4kjnAMHjeY4APrJAdZSxRTDeXeHplFlJsaZ1BtbI
	nIpwETe/2lI5sXMB0cMkDBq7tHJt+0IFmsv64m8vEax3qTGTB8KKTITT9Ib99UGCxCf7SN+l5ox
	DJ770SNBcIm/irIMWKjCVNh+0+LsNzpo/3vYCPg+qPjQHROjUUMG597Hcz9jZ6dAryP9FBTH5av
	7iilZRIKjFRuiK+hLyedVzh5GPNtctD+O1hbYGR/swDdIz/GWicOXMIrRm7xd6YVm1uIOUxHgzp
	DdeOohjm673scatbiX01z+Klz7yWjc=
X-Received: by 2002:a17:90b:4c4a:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-3966d00a01amr26559766a91.0.1787823596177;
        Thu, 27 Aug 2026 02:39:56 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fa7a3fsm2041456a91.10.2026.08.27.02.39.55
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:39:55 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so1377733a12.2
        for <cocci@inria.fr>; Thu, 27 Aug 2026 02:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrVltgOuABSZzQON0OKNtTIIsFsJxqlSqh2gZ1HqOzPtT5tre/f9UXjbJBkrxeRsN3rtYwIVw==@inria.fr
X-Received: by 2002:a17:90a:c107:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-3966d412aa5mr29086581a91.7.1787823594433; Thu, 27 Aug 2026
 02:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
 <20260818120428.2546810-1-ribalda@chromium.org> <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
In-Reply-To: <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 27 Aug 2026 11:39:39 +0200
X-Gmail-Original-Message-ID: <CANiDSCu5PhZ8OhACB6ODvtyX6t7BNYJfeDSKH7XF7Jcte1iUxA@mail.gmail.com>
X-Gm-Features: AcwNN1XlEHFppRhMi9hIlf5XOpxjAOVBHVrZK2z8n6GaPHJc23nOYgykLSI00mk
Message-ID: <CANiDSCu5PhZ8OhACB6ODvtyX6t7BNYJfeDSKH7XF7Jcte1iUxA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: dmitry.torokhov@gmail.com, bentiss@kernel.org, cocci@inria.fr, 
	corbet@lwn.net, hadess@hadess.net, jikos@kernel.org, lains@riseup.net, 
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
	skhan@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000465849065a041ed1"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] HID: add documentation and Coccinelle script for FF
 registration race
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3717
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/NcOl6V5vwrvIOfbj5kctnA>

--000000000000465849065a041ed1
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a heads-up that this this patch has landed in Linus tree, not only in
-next:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/hid/ff_race.cocci?id=225c30812857f47cb42bfd945a15f448f58e82cc

We should fix it before -rc1 is tagged

Regards!

On Tue, 18 Aug 2026 at 14:08, Julia Lawall <julia.lawall@inria.fr> wrote:

>
>
> On Tue, 18 Aug 2026, Ricardo Ribalda wrote:
>
> > Hi Dimitry
> >
> > Looks like media-ci is not particularly happy about this patch:
> >
> >
> https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/108127901
> >
> > /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file
> /builds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci
> --patch /builds/linux-media/users/ribalda --dir . -I
> /builds/linux-media/users/ribalda/arch/x86/include -I
> /builds/linux-media/users/ribalda/arch/x86/include/generated -I
> /builds/linux-media/users/ribalda/include -I
> /builds/linux-media/users/ribalda/include -I
> /builds/linux-media/users/ribalda/arch/x86/include/uapi -I
> /builds/linux-media/users/ribalda/arch/x86/include/generated/uapi -I
> /builds/linux-media/users/ribalda/include/uapi -I
> /builds/linux-media/users/ribalda/include/generated/uapi --include
> /builds/linux-media/users/ribalda/include/linux/compiler-version.h
> --include /builds/linux-media/users/ribalda/include/linux/kconfig.h --jobs
> 16 --chunksize 1
> > Position variable r.p2 on line 20 must be attached to some other token
> using @.
> > coccicheck failed
> >
> >
> > The following change fixes the issue for me... but you probably want to
> double
> > check it, I am not proficient at cocci.
>
> I would also like to improve this, as suggested in a previous mail.
> Could it be detached from the documentation change?  Then I can take this
> part and fix it up.
>
> julia
>
> >
> > diff --git a/scripts/coccinelle/hid/ff_race.cocci
> b/scripts/coccinelle/hid/ff_race.cocci
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
>


-- 
Ricardo Ribalda

--000000000000465849065a041ed1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Just a heads-up that this this patch has landed=
 in Linus tree, not only in -next:<br><br><a href=3D"https://git.kernel.org=
/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/hid/=
ff_race.cocci?id=3D225c30812857f47cb42bfd945a15f448f58e82cc">https://git.ke=
rnel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccine=
lle/hid/ff_race.cocci?id=3D225c30812857f47cb42bfd945a15f448f58e82cc</a><br>=
<br>We should fix it before -rc1 is tagged<br><br>Regards!</div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, 18 Aug 2026 at 14:08, Julia Lawall &lt;<a href=3D"mailto:julia=
.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Tue, 18 Aug 2026, Ricardo Ribalda wrote:<br>
<br>
&gt; Hi Dimitry<br>
&gt;<br>
&gt; Looks like media-ci is not particularly happy about this patch:<br>
&gt;<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/linux-media/users/ribalda/-/=
jobs/108127901" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedes=
ktop.org/linux-media/users/ribalda/-/jobs/108127901</a><br>
&gt;<br>
&gt; /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /bu=
ilds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch=
 /builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/rib=
alda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include=
/generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-me=
dia/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/inc=
lude/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/u=
api -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-medi=
a/users/ribalda/include/generated/uapi --include /builds/linux-media/users/=
ribalda/include/linux/compiler-version.h --include /builds/linux-media/user=
s/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1<br>
&gt; Position variable r.p2 on line 20 must be attached to some other token=
 using @.<br>
&gt; coccicheck failed<br>
&gt;<br>
&gt;<br>
&gt; The following change fixes the issue for me... but you probably want t=
o double<br>
&gt; check it, I am not proficient at cocci.<br>
<br>
I would also like to improve this, as suggested in a previous mail.<br>
Could it be detached from the documentation change?=C2=A0 Then I can take t=
his<br>
part and fix it up.<br>
<br>
julia<br>
<br>
&gt;<br>
&gt; diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle=
/hid/ff_race.cocci<br>
&gt; index 479f5d1e3184..7cf84936db13 100644<br>
&gt; --- a/scripts/coccinelle/hid/ff_race.cocci<br>
&gt; +++ b/scripts/coccinelle/hid/ff_race.cocci<br>
&gt; @@ -9,7 +9,8 @@ virtual report<br>
&gt;<br>
&gt;=C2=A0 @r@<br>
&gt;=C2=A0 identifier probe_fn;<br>
&gt; -expression hdev, flags;<br>
&gt; +identifier hdev;<br>
&gt; +expression flags;<br>
&gt;=C2=A0 position p1, p2;<br>
&gt;=C2=A0 @@<br>
&gt;<br>
&gt; @@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {<br>
&gt;=C2=A0 =C2=A0 &lt;...<br>
&gt;=C2=A0 =C2=A0 hid_hw_start@p1(hdev, flags)<br>
&gt;=C2=A0 =C2=A0 ...<br>
&gt; -=C2=A0 \(input_ff_create\|input_ff_create_memless\)@p2(...)<br>
&gt; +=C2=A0 \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)<br>
&gt;=C2=A0 =C2=A0 ...&gt;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt; Regards!<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Ricardo Ribalda</div></div>

--000000000000465849065a041ed1--
