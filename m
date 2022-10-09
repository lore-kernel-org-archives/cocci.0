Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1FC433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LSHrW6ery4gMp/3fPmWoB6oBXpcGujeahIMBt6GliBM=;
  b=USBXczuAEqtLDoTjVLJQZhXUj4mvFHNMUJnTo1j7rshTegdG1dpxAhdl
   vaYWHLONpE1IbQvQVQMaJ7ZaIboppix4ZhJOzBz80ZxMpDsSaBybQBsNE
   txtG23cShEFxkPCCHIZi6VDTRhd9ARMmlq2ekC6hOF5AkoQvsmCOdNz8b
   Y=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56687871"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 19:53:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B469E0290; Sun,  9 Oct 2022 19:53:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8070E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 19:37:05 +0200 (CEST)
IronPort-SDR: 634306c1_rTGG10zJH3p1+/vMwlu5/4uNTvVIFMrjqyDdoIcfpoy6mVK
 g07vOLzOroulXAfKlz74XHYwP+ftxje6D1ZvL+A==
X-IPAS-Result: =?us-ascii?q?A0B7AwC5BUNjf6vXVdFaHgEBCxIMQIFEC4IkgQFWLgRQj?=
 =?us-ascii?q?UyIGpFqiyuBfAsBAwEMATcLBAEBgVODMgKEdAIdBwEEMQgOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBGAkZBw4OBSSFaA2CNSkBg2QBAQEDE?=
 =?us-ascii?q?igGAQE3AQ8LGC40AQUBHAY1glyDIAMQnwuBBEKLMIE0gQGCCAEBBoFAAYRNg?=
 =?us-ascii?q?VwDBgkBCIEri1GDZXonHIFJRIQ/PoJiAoVvgi6aNDgDRB1AAwtCNhgDFAMFI?=
 =?us-ascii?q?QcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPBQIHLwUEL?=
 =?us-ascii?q?wIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMzGQEFWQ4JIRwOGg0FBhMDIG8FQ?=
 =?us-ascii?q?g8oL2krHRsHgQwqKBUDBAQDAgYTAyACDSkxFAQpEg8tBylxCQIDImUFAwMEK?=
 =?us-ascii?q?CwDCSEfBygkPAdYOgEEAwIQIj0GAwkDAiRZgSgmBQMNGSYIBTcaBAg8AgUGU?=
 =?us-ascii?q?xMCChIDEg8GJ0kPSj49mgaCFA1TAleCA6NxnmiDaIFJDIlplTARlleSHpcQj?=
 =?us-ascii?q?UCVBIUCAgoHBhAjgT8BOIFbMxoIKAiDIk4DGQ+OIINyhRSFaiE0OwIGCwEBA?=
 =?us-ascii?q?wmLFQEB?=
IronPort-PHdr: A9a23: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
 3M1
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TtMVraPqJLEIRMBcTuyjsMiBIKoaSvp037Dk7TEUdfVwSL3jqy
 nOpoVh6faQslwssR4b6LO90cW7MBHhHNtOkPQs1NSZLXHbUQmTXedfBOLZqlWKexEWtNQtrJ
 uIG5IeNDSaNykcsS+V2njcLz/i+rW6GWKT6Ns2A00DceiiUc9d0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="25893998"
X-MGA-submission: =?us-ascii?q?MDGse6DGGECJzZO6e1Q63gdj+TrgqHAsKr71L4?=
 =?us-ascii?q?3QglEIfIBkGlISPJ41pAkeaWIXCUqRTS8xeiu3TtSww2OHv1JGLVi5HO?=
 =?us-ascii?q?S/STNYmm8dwdZFZziKqgL+oxdPeE02dSBGULFmaLaSFinwpVDgvdvfxT?=
 =?us-ascii?q?haXPSL4C+vaCXPV1NNtn1onQ=3D=3D?=
Received: from mail-pg1-f171.google.com ([209.85.215.171])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 19:37:05 +0200
Received: by mail-pg1-f171.google.com with SMTP id q1so294530pgl.11
        for <cocci@inria.fr>; Sun, 09 Oct 2022 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSHrW6ery4gMp/3fPmWoB6oBXpcGujeahIMBt6GliBM=;
        b=ljNr4p6aRHAvBXKA6FfCiyqFXUnht/aiwfYmLfOe8W0UhpFyQzFHS0MHCan/Jl1xK1
         hGWbUjfrEHt5japhoUDlkKtyZJQIlwQsXyvoMESk/gl/JBPOpJYHdPnGUvXYuVMuXT8T
         0kCWTHGAcoxqGguPPEI0ocsrvwB8iJ7TUhxJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSHrW6ery4gMp/3fPmWoB6oBXpcGujeahIMBt6GliBM=;
        b=GIV8iFu52p7JEZ+7z1NC3lS2T08Qs19lc3rbua+nmQaqG35vFjA5DnIvOXSFSMe0m0
         /dkcvaRvaYqw11DEDUCN4bx51ncoU8E3pT2l8px9BecAjp2rB+GAe0Apzbd5MlquUkr+
         Hdov68//eDYtzGZNWAPhtewHn9t6YpAsY8e2Nzptiu8GUzOj6gjtGiepLJTA28XKh/Hx
         HcCge8QZR728GeKkWUAzX2IqCpfyYkhiTD6iSG7AAcr/zgRog0PftAaC6HBExXX/hk0a
         E1eHT5h/SnyTdmKo3tO/fdnLQnLcKz4yLXLSvNjX/coTmSjtlSg/OVS1zek38eIlK/wK
         rbXQ==
X-Gm-Message-State: ACrzQf1Hh4g9C2FNACzJjguTJnEmqVpjGIIH6AMPqfGmC2TVe9B1HOWO
	rDJQZZ8NL7X1p5fHM9SRbmbgxFxcu1UMEg==
X-Google-Smtp-Source: AMsMyM4rx2X1Ki7B1REkVtyatF5PSIxMblm1rQ9D191N0uP0YlijhRDXdHVP5mQ0soHNPGrPxD8nZw==
X-Received: by 2002:a65:5b8d:0:b0:434:e318:80f with SMTP id i13-20020a655b8d000000b00434e318080fmr13825723pgr.97.1665337022562;
        Sun, 09 Oct 2022 10:37:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79ad4000000b00562a5f29ac1sm5252922pfp.100.2022.10.09.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 10:37:01 -0700 (PDT)
Date: Sun, 9 Oct 2022 10:37:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <202210091035.7D63B5FB@keescook>
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
 <202210090808.AFE4016@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210090808.AFE4016@keescook>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 635
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210091035.7D63B5FB%40keescook>

On Sun, Oct 09, 2022 at 08:10:16AM -0700, Kees Cook wrote:
> On Sat, Oct 08, 2022 at 09:43:52AM +0200, Julia Lawall wrote:
> > - x = e;
> >   ... when != x
> > ? x = e';
> > 
> > The ? will stop the match if the thing is found, but won't require the
> > presence of that thing for the match to be successful.
> 
> Thank you! This worked perfectly. :)
> 
> I'm starting to realize I should document my set of "with cocci, how do
> I ...?" answers somewhere.

Okay, initial dump is here:

https://github.com/kees/kernel-tools/tree/trunk/coccinelle

And I've sent a PR for some missing docs in Coccinelle itself:

https://github.com/coccinelle/coccinelle/pull/290

(BTW, it looks like there are some other github PRs that can be closed?)

-- 
Kees Cook
