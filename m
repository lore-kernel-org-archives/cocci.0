Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE5C88E75
	for <cocci@archiver.kernel.org>; Tue, 15 Sep 2026 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zetP5fNnd4Ik74pn4yYhqWStmsT+30ISyz9oe8Z/6rA=;
  b=sXFouUbfI1wv9iF6jPxuABX1e4mxHpmz6fy7kg87B2G/xGh/FcIGijSe
   tGua4RKBr07ECFaiNKQ7L1HzMJ3UdaRm4EKaJYJ+GKCLiFpTEn8JDJEtF
   /rNPtOgGpPLlo9LOZu3TSs4zjzkkJRd/WY01jzQNqpUZoq3IkSRah6KWB
   o=;
X-CSE-ConnectionGUID: zAvQPDPZQmKE+ueiaxPbJQ==
X-CSE-MsgGUID: XT+pqqXPQKebtSLMv7+kyg==
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
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="294998387"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Sep 2026 10:45:50 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1DF98826FC; Tue, 15 Sep 2026 10:45:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 085F781315
	for <cocci@sympa.inria.fr>; Mon, 14 Sep 2026 21:02:52 +0200 (CEST)
X-CSE-ConnectionGUID: Mm4X9ONJTUSNeapY/2Qf6A==
X-CSE-MsgGUID: DEMl9uBWTpS96muwyvhlKQ==
IronPort-SDR: 6aa844db_cvyVlyNMw6bX76LM2Ofj4yX13S8GlR8xKYdNCcF/95p+UQv
 x5nhexQeimx/agLrBVCBt7gGx0I3Eb3kbh/QR4Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H5AQBaQ6hqgS/dVdFaglmCQVoxYDQEC0mEWI9SgiEDi?=
 =?us-ascii?q?3mMRIVeFIErPQIPAQMBDT0UBAEBAQIDATgPhDcCjgcCHgcBBDAJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NjBoBg?=
 =?us-ascii?q?SRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAiw/AR8BAQEDIx0BGx0BAwwGBQsNAgImAgIgAQERAQUBHAYTgwIBgiIBB?=
 =?us-ascii?q?hABAzcDEblvi3KBFQUCFoEBgg0G2msKGSgNcgOBaAIBBhQBAYEJLoR4Kk8Og?=
 =?us-ascii?q?j8BHwGBcIRMgz56J4IogRU1gnY+gh+BZ4QYgmoEgiKBDJQBJgEHAQYXAwcHC?=
 =?us-ascii?q?QUECRMGBQMCAj8JBgUKEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggJB?=
 =?us-ascii?q?AsHBR8KAgwUCigiBA4rCgECAVUwAQgGAgIEBAIEAgoCCQICBQMEAgQNAwQBA?=
 =?us-ascii?q?QgCAgMqAwEDGQgJCAILBREYDAsHMQMQCQMCHQMUEQUIETQIBhYBGgYFBgsBI?=
 =?us-ascii?q?BYUAQUMEQECGwIfBB0BEAgDAQcDEQQCAQcCAwQWBAIUCiEDAwIDBQEDAwMFA?=
 =?us-ascii?q?gIKBgcBAQEDAgIIAwYDCgkCBQMbGAQBAgIDAgECCAMHCAMIBQMEAgMDAwQBA?=
 =?us-ascii?q?gIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMFAwMFBQICBQUDBQICCgIDA?=
 =?us-ascii?q?wMCAQMCGggDBgMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDBQECAgQDAwgIB?=
 =?us-ascii?q?AMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCBAgHBwUCCwQCC?=
 =?us-ascii?q?AQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFBgICAhwDHQECAQ8GAQkFA?=
 =?us-ascii?q?gEFDgcFAgIYAwYBAQMGBQEDAQoLAQECAQIKAQIEAgUDAwEDAgMCBgMDAgUFB?=
 =?us-ascii?q?QMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEAwQDCgMCCAMDCAMMAhoCB?=
 =?us-ascii?q?QMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUfAwMBBQMDAgEDAgUDA?=
 =?us-ascii?q?xgCAgQFAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECBwwDD?=
 =?us-ascii?q?AYDBwMDBAQDAgUKAgQBBwMDBwcJBwMCAwgBAQsEAQMDCgMDBQIBAQcFAwYDB?=
 =?us-ascii?q?wIDAwMFBAUDAgsDBwICAwMDAikBAQEDAwMDAwQDAQMBAwMHAwUDAg4CBwEBC?=
 =?us-ascii?q?gMCBgMHBgMFAwMCAQIDAwURAwYEBQYZAgYROgEIAgMDARQEBAUFAgUVAggBA?=
 =?us-ascii?q?wMFAwMDAwIFAwEFAQEDAwUDAwMDAwMEAQMEAgMHBggBAQECCAMDAgUDAwMEA?=
 =?us-ascii?q?wMCAQIMCQgTPQELBy4EBAwqARUUBSkhX481H4JfgQ4sL1F+FQyBLwGSHAuyS?=
 =?us-ascii?q?jQzCgYBgkmBCk6BZoo8g12FBIZdhhYzqm0uh2aQdI4KhAmXHxEkEoEyOoFcM?=
 =?us-ascii?q?xojgQFtgUlQAxkPjmCDRIE+yl1FMgI7AgcCBw4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 ZGppnNEnQlkaYxtTZE=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:YfN6NKMZLUEeOsBcTvWjsMiBIKoaSvp037BL7SBMoHluGaalfq
 +V8cjzuSWZtN9pYgBHpTnYAtj4fZq+z/9ICOsqUotKNTOO0FdBRulZnPPfKlbbdREWmNQttp
 uJf8BFeb/N5VUTt7ec3OGze+xQpeVu/8iT9IPj80s=
X-Talos-CUID: 9a23:rCzoTmzQqS5meI3PGaw1BgUxH5wVI1r77kvtGGm1AH5YD+esRwG5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3ACRjT3Q5QawrsWrYl+P7hDv6FxoxEzoGqWV0nrqk?=
 =?us-ascii?q?egJjaMDFvKimdiBeOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="156893451"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHYA24CZIQMWkQUk75JxWU0lbK01Lo7VrGAaI?=
 =?us-ascii?q?tJcDFEE3X4+knsDg/jh5B5BU8Ll/eLR6xPmcqvkkEMLHd6htlVMLSfeM?=
 =?us-ascii?q?Mulzh/A4h0QiVQ8/aWs4X4Cck2TeY1a/RdNZDLCcqksdESehbWW04/Nd?=
 =?us-ascii?q?o55/Pz0DqsLubj4U0dCdHJUA=3D=3D?=
Received: from mail-wr1-f47.google.com ([209.85.221.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 21:02:51 +0200
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486fa798933so1700638f8f.0
        for <cocci@inria.fr>; Mon, 14 Sep 2026 12:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789412571; cv=none;
        d=google.com; s=arc-20260327;
        b=UAsUHpJsSivp7V8eZtLpxWC7ADAYTDcUFlublu2PiNQgJXkwCTZLN5zxHR7QNaTF+Q
         qtRPjzuyiqDZXQAHmfWvzAKiyoOKyfcZU9FW5sCWHfp3ComXtnq8qcvRzuPeOHe2ESMM
         df+/ULsyptSHAloyjfheHfFnI8/5VkhOBNpAjUwVK1jo+qf0I6Iqkr5pFh5m1CAJHJ/M
         g1ryJbzJ648lhqxvgWcPED9diMMxtE+59B269HmyI2XV70meKWMM7SXui/wS3m9ww8Rv
         rgQ1pRD8w/xN9QTuVvAWAIlAvyiKj+jV8LuAEBtyekpRjO/Qdl31g02jUJTdlSoI+6Lu
         yXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zetP5fNnd4Ik74pn4yYhqWStmsT+30ISyz9oe8Z/6rA=;
        fh=MdxyNCmxHDJwjm5BeQSVlR+jLXqt4E/OWn+A6GTM3+Y=;
        b=Kh2lY3maZE7WUBMRt5pq1auGY7alUI7tTLWASU05LOUrGuyXg3IvSROEwDDatMPmXk
         KzUH9nHSL0mLdaJmniLw/W+MxIVMZJWvIOr5BSOTMyXLDDOz97oQwHvMIqZiToQoB8ml
         0pY29hTT/8RCwtHIAEkLv+OzA2XZaDsT7xJl/ebMIYbrUlxxGdUCJBXCrQ7D0VdjjZvO
         MnNNo2wwa1GrQRXd2zUMGiRV7UtypQo5HFk9v+pCYSM43juGMPA7X3GB9RKBi//XIAKb
         tcIuDjRmC9/iHzdXBEt7faUfrUnbX3YrLZ+WQtrI4FxufhOPrz4EG/mYKRSidLeGwMe4
         6eWQ==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412571; x=1790017371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zetP5fNnd4Ik74pn4yYhqWStmsT+30ISyz9oe8Z/6rA=;
        b=r8ZFBrL4jHaIVC5NO3X5VwW0HVwA+yOnoo58FUt0PqjXCsaiu8n1gkR2usiWPr+bJg
         AhTn732Jd8L3PXFMhPMXWV7Ojun5a9MlCewvMQFa9FtTrVIj0vsYeaOU40axfO2OvI31
         yngIRTGweINo6Sx/wXQSVAA/DCxMS/mg6Q9G+EjFgTBmTn45Y2kyyQ4+CR+XjrfPi72T
         fdOKRfb/EWxuHzx1jKA52jj9Z6xqnDt1nW+kw6b6h96lQ9ZFeE1Kn1ER1b3TgXJbCOMV
         +GvdbdNWpnViTv706ATcs85U1jpke5e9qNN/+uwpIHkCOsdEsEDRHbwV+B4Zpzc5rjId
         xVag==
X-Forwarded-Encrypted: i=1; AKwUvBzSyDukTyxC0BeBwX8Z3pxcFBa7PDBAHWiZCFcdMlA0Yak7rr2KVd8bis0UxZRYcI8dT3okuQ==@inria.fr
X-Gm-Message-State: AFuF++lKFJ1V51cjHfVpS2HTuNzVdND0fr9AnYlHkTjgf2p4/2s/DYjX
	pM/O8iO+T1sH7/8xYYyjBMZRLVfJGgJClHj/GsgzYEe2ZoLF6we/vdvyTyv4vmfGlyYSeW7EXIY
	lROXeNWGrA4YjMlK+gt1gVNOmvQjWcHo=
X-Gm-Gg: AYBFou3oeIWZvIbQlIAFofSPRnf90sTetglxezhSdYdPUIrpzeJVRGgDawzsHW89Pyl
	vXSChHUwl0425pi0BU1QAgVmSavawxSk3lYsuZttdSW9ANP5xV0e+Gvfe3DZ0/ANZ6qglRFhJcv
	ACdyDBZr3PO67XT76IEewSes1QgHrhUbVUYUwXhzf6BF0QMuGIdO5FLIPGHdZ8nkzcDQEO5utwq
	CskLBA2qKzLbPeOJwxpV5ws/GH/ZjQC2r0RV3kzxqYnvGdj1lEbxFUXfM5FdtajVwKj8kxDrdKf
	52RArgjWMpysfDBEcjF0qS9zAxdvYLeYXwt5hwanJGjMDUCFh0OK0JsgbuBMtQKoSfn4rvGmL17
	DEDwED4mk/WFG8/wJLBlsrHwAHKpzPy6ScgXr7UtT3koI+OcHTd0Q7j3kH/BRfVHK4KteFXjXYj
	wADcsWRFl+FFsb86HNl0VCD8XazX0jiuJvCXt+SxWKYdreIHYtBwjQgNKySZUEh8BiYFMQ/NsFX
	CBra9abrQv6wtWGaH6+A/t251TBowuKtdC+LA87bIsKD/4mb42VgAVFEg==
X-Received: by 2002:a05:6000:985:b0:487:1fa:17f1 with SMTP id
 ffacd0b85a97d-48702ac0dfdmr4594588f8f.16.1789412570476; Mon, 14 Sep 2026
 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260914151145.1328-1-joshua.crofts1@gmail.com> <c737384a-aad6-8ebd-a633-4ab354991c28@inria.fr>
In-Reply-To: <c737384a-aad6-8ebd-a633-4ab354991c28@inria.fr>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 14 Sep 2026 21:02:37 +0200
X-Gm-Features: AcwNN1W8r7b_khgD2SdSD1YPse46l-NBkfyyMg2BuWraYp_tGjRdaVQ10OIEkCU
Message-ID: <CALoEA-zGPk5sHhzhKRVE3uvFotyMTPRtkf-rCAgU2cosfe3w=Q@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3732
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/dTRKCW8MsGqPs4OLMxihOg>

On Mon, 14 Sept 2026 at 17:17, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 14 Sep 2026, Joshua Crofts wrote:
>
> > Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
> > called in a file if pm_runtime_use_autosuspend() is called and its
> > devm_* counterpart isn't present.
> >
> > Without _dont_use_autosuspend(), removing devices causes resource leaks.
> >
> > Assisted-by: LLM
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  scripts/coccinelle/api/pm_autosuspend.cocci | 62 +++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/pm_autosuspend.cocci
> >
> > diff --git a/scripts/coccinelle/api/pm_autosuspend.cocci b/scripts/coccinelle/api/pm_autosuspend.cocci
> > new file mode 100644
> > index 000000000000..2354396d9344
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/pm_autosuspend.cocci
> > @@ -0,0 +1,62 @@
> > +//SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Confidence: High
> > +// Copyright: (C) 2026 Joshua Crofts
> > +// URL: https://coccinelle.gitlabpages.inria.fr/website
> > +// Options: --no-includes
> > +
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > +//----------------------------------------------------------
> > +// Detection
> > +//----------------------------------------------------------
> > +
> > +@has_use@
> > +expression dev;
> > +position p;
> > +@@
> > +
> > +pm_runtime_use_autosuspend@p(dev);
> > +
> > +@has_dont@
> > +expression dev;
> > +@@
> > +
> > +pm_runtime_dont_use_autosuspend(dev)
> > +
> > +@has_devm@
> > +expression dev;
> > +@@
> > +
> > +devm_pm_runtime_enable(dev)
> > +
> > +//----------------------------------------------------------
> > +// Context mode
> > +//----------------------------------------------------------
> > +
> > +@depends on context && has_use && !has_dont && !has_devm@
> > +expression dev;
> > +position has_use.p;
> > +@@
> > +
> > +* pm_runtime_use_autosuspend@p(dev)
>
> I don't think you need the position variable here.
>
>
> > +
> > +//----------------------------------------------------------
> > +// Org and report mode
> > +//----------------------------------------------------------
> > +
> > +@script:python depends on org && has_use && !has_dont && !has_devm@
>
> In this rule and the next one, you don't need to depend on has_use.  That
> happens already due to the inheritance of the metavariable.
>

Thanks for the review. This is my first time writing a semantic patch,
so it's a bit
rough. Additionally, I just noticed I sent the wrong version...

--
Kind regards,
Joshua Crofts
