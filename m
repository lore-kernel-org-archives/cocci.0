Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD83C02194
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=f7nvPGNe2lrc2kHfyR7ZhylPLa8kSJFN5rJnyjQDoao=;
  b=OrfZxWimWvFXnC8QguWgenDRCPDHYWToydZKN9RHqjqqf224hjfHhf4G
   nLxy/ZgkjoEjFFv+nw9v0U/YzNNsm0CbpTL+j9rDwX3uVRlLC5M+lCRbW
   fcpkjHjoOQSR+J3VkFfenNGqySpN27nbWEp/hTgh4wXXuQuWnPYQc3Tm5
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324736"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4558AE0D60; Tue, 28 Jan 2025 10:13:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 99EB1E00A5
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 13:43:18 +0100 (CET)
IronPort-SDR: 67938ae6_bF/1xWU7mli0j1HVErJADWt/wP0UrXDAEgAKgWeAQR6/LPC
 YKu+wbiHoRU2wkPQHjMIQRrV7qfSzoC5y3cEIOg==
X-IPAS-Result: =?us-ascii?q?A0EDAAAxipNnfKzQVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVY0BAtIhFaIHYcxgiSeGIElA1YPAQMBD?=
 =?us-ascii?q?UQEAQEDBIUAAop1Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBIhkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?0QBAQEDEhEdAQE3AQ8LCw0CAiYCAiESAQUBHAYTCBqCX4JlA6wzgQVCikR6g?=
 =?us-ascii?q?TKBAYIMAQEG3B+BZAkUgQYuAYV+gk8BgWyEQ4M5eicbgg2BFTWBBoFvPmmBe?=
 =?us-ascii?q?AKFO4JpgjOBdINAoBMmCR0DBwcODR5JDwUcA1ksAVUTFwsHBYEpSAECAW8iI?=
 =?us-ascii?q?4EmBTVBOoINaUk3Ag0CNYIefIIrgh+CO4IYgi1HhAyFW4IUgWUDAxYQAYFzg?=
 =?us-ascii?q?TR7H4EoHUADC2ILPTcUG0ydETyERzETgksexkqEJYRvg3WYfDOqU5h8o0qFU?=
 =?us-ascii?q?hEjgUQ6gVwzGggbFWwGgjBPAxkPjiGDesVnRTI8AgcLAQEDCZAjgUsBAQ?=
IronPort-PHdr: A9a23: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
 pEJT+0DPGE=
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:TCG2VKPxb6t9A8BcTh6jsMiBIKoaSvp037Dk7TELdfU1SL3jqy
 nKpp4mPHDP+VIssR0b6LW90ey7MBHhHP1OgbX5X43SOjUO0VHAROpfBMnZsl7d8kbFh5dgPM
 lbAtBDIey1I1w/osrz/RWiH8xI+qjhzImYwcnbi1liJDsEV0ii1WtE48Sgf3GeiDMpOXPxLv
 uh2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3ACsHyOGoX0mC3X+c8YlYDoWTmUcN4LHvN0VLBGk+?=
 =?us-ascii?q?xKm81daOsFW2Bu5oxxg=3D=3D?=
X-Talos-MUID: 9a23:sScN9Qm73g4lNpDIR9oOdnohbNsrpLTpGnokjIVYn8aNKAlzBQmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107275971"
X-MGA-submission: =?us-ascii?q?MDFFk5ijlQXJvfnI9W8jobkSWVke8kcPks7BT4?=
 =?us-ascii?q?BRoVvjoYPbH84fRP28PpHm4/5uEjB8Cwnn6EQt9L5QPL03jOA2Yvzn3i?=
 =?us-ascii?q?d4NA3p+QKn7XV6p4Q2RIop7Rq64mc8pEqu/NgHCVNKlfB1ciAHaYktPt?=
 =?us-ascii?q?CPnMRZJ+l6kDwF1PGO7u7VFw=3D=3D?=
Received: from mail-lj1-f172.google.com ([209.85.208.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:43:18 +0100
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30613037309so20512121fa.3
        for <cocci@inria.fr>; Fri, 24 Jan 2025 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737722597; x=1738327397; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f7nvPGNe2lrc2kHfyR7ZhylPLa8kSJFN5rJnyjQDoao=;
        b=JLpXan69WmATH9bkc4s3L7iw1V/+u5Pi9Ih29QkhmEsGbF0j3xRaSeXUW+hC3pDj4s
         qTryvFw1tGirZvtSYxXvwWh49j8dZCSuw+a2YF8fuAPSTnHnWiJRnzpr/GOLwqjdrSS3
         CdX6Tv2BsswLpMyLYlVAbXCOYx22zbZ6Msxo6dx2ueMcQxpmOmOAHLbuDPVAzuL/Lnkp
         SYD1nan9uZvUya3ijYzTxHtiFEe4YDmHXMFLd5AfS0V1XyQRzWbOrTmPYU4YA/LNxHXo
         QE1oE/yQR3+DILm0DAt7xuITxIJGTB76C4NlYTUxeN/CZWPOVKvLh6sBH9D2TFcamVep
         N5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737722597; x=1738327397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7nvPGNe2lrc2kHfyR7ZhylPLa8kSJFN5rJnyjQDoao=;
        b=fo2ING/Ug8oT0+Y0jMOBRPazZf0BgPW3bdE2bxLDKXDVPtHdDmM/GklHc0BqZU42WD
         YtzzOaBqgSTL+VUa6UwcGLgmPqDbLgMOgxsntZMG0R2Sqo+G3jcjkSd9r9wrSjHr47m9
         h31XRgx8r1WK0b4b779Apqc5/fdSoEHJ4hy4XLFP4m6CrSghQET6356pKx/d3SwAKKLw
         aopFEvAn88eoW+kQWFJ7Rk/j+jpGadqOPLBWJGF65RgxBuVrWRF9e9AfBKEqa7YbeuVQ
         rJkNhFKJTB6uuvDi8ehdFWxZAA4wyygUxBCo67jW7TfJP8PsXpn/fV1rd46QHIsJH3rO
         pIaA==
X-Gm-Message-State: AOJu0YxHwDBAc9NZzBvFA6IMcZvCM/hO2P6etGI4A4casS52dIbM0ygX
	k62FE8hsL8nyG6oFMdeIuq6fWzVjav4ZjoKpFGsx0dTFSlSo00P1yES6fSXWYqXB3VNo6/k9uN6
	Bq3FWqeF6kzUQp5lDmWCoqFZfqDHEvdx5gyiWW6pusdnKqEbrlRXn
X-Gm-Gg: ASbGncsD8jVXSQx0wFtxi1dECHqpE2Ld/OMh3vjs4Yl+IWUFMGWMZms34xIe8SrmJhf
	otwmtOcVFV43JVvMnLinVnlVkdM8TgDsTHLgRGAABllDifpC28SFEjIRx1WqGMCdfiyFNZ1VhhR
	7DD/k58XIM9kxD2kY=
X-Google-Smtp-Source: AGHT+IHt87HHIZy7kIr9Eg70119yvmrYbDrsJ2dsCle6KIRFfkLrPkI7aJrP8spwAOtseuANB2LTXLKtEV0LvrQMjTE=
X-Received: by 2002:a2e:be9d:0:b0:300:3a15:8f2a with SMTP id
 38308e7fff4ca-3072ca60c6amr114723161fa.2.1737722596505; Fri, 24 Jan 2025
 04:43:16 -0800 (PST)
MIME-Version: 1.0
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
In-Reply-To: <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
From: Ricardo Ribalda <ribalda@google.com>
Date: Fri, 24 Jan 2025 13:43:03 +0100
X-Gm-Features: AWEUYZkTCWhy77-fb7zW_f1yy3Jng0BDGUA_QKUzO27hO5LDkkTc471FUZ4DSI4
Message-ID: <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
To: Victor Gambier <victor.gambier@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Ricardo Ribalda <ribalda@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 2245
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA%40mail.gmail.com>

Hi Victor

I can easily repro with:

```
spatch -D report --no-show-diff --very-quiet --cocci-file
scripts/coccinelle/misc/secs_to_jiffies.cocci --dir .
```

tested with
spatch version 1.1.1 compiled with OCaml version 4.14.1
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
--libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
--enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: Str

and
patch version 1.3 compiled with OCaml version 5.2.0
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
--libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
--enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: Str

This patch "fixes" it for me:

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci
b/scripts/coccinelle/misc/secs_to_jiffies.cocci
index 8bbb2884ea5d..2d85dca16418 100644
--- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -10,6 +10,7 @@
 //

 virtual patch
+virtual report

 @depends on patch@ constant C; @@

@@ -20,3 +21,8 @@ virtual patch

 - msecs_to_jiffies(C * MSEC_PER_SEC)
 + secs_to_jiffies(C)
+
+// Dummy rule for report mode that would otherwise be empty and make spatch
+// fail ("No rules apply.")
+@script:python depends on report@
+@@

On Thu, 23 Jan 2025 at 15:41, Victor Gambier <victor.gambier@inria.fr> wrote:
>
> > Deleting scripts/coccinelle/misc/secs_to_jiffies.cocci "works"
>
> That script was added to the linux kernel in December. Which version of Coccinelle are you using?
>
> On my end, with Linux 21266b8d and Coccinelle d4309c2, the following command executes without error:
>
> .../linux $ make coccicheck M="drivers/media" MODE=report
>
> Victor



-- 
Ricardo Ribalda
