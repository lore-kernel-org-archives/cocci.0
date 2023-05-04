Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DD1C77B7C
	for <cocci@archiver.kernel.org>; Thu,  4 May 2023 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:from:to:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CE4QJaFATi70AxduK7pmjDAK+4ChoZwZRPiddy5PEZU=;
  b=sVi/AmvxDxDyVs8uf8rFbav093zyiJ/GPu5K9joFrgngHjwnPPNLikHd
   44p/p05JIsuhJ4OPKO8ej4K8ftA/5/g7nF6UOIercD3+gUEPexSLAlHvN
   OweonHXLOc4YuMWVCeFaaQ7fI9Avw0/5GBRUiFLUxrUi/MGxsYSFP3lup
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.99,249,1677538800"; 
   d="scan'208";a="106162091"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 May 2023 07:38:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3B4AE0D45; Thu,  4 May 2023 07:38:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AB601E0D40
	for <cocci@sympa.inria.fr>; Thu,  4 May 2023 02:31:00 +0200 (CEST)
IronPort-SDR: 6452fcc4_a/KoNYJBMSwXrZ9px/mH8K0ad4t78jnKdXK0a3cho3LdG/e
 O0Y/iqsDydut77JZ3R8RLbo/49noR8U/ijBSzRQ==
X-IPAS-Result: =?us-ascii?q?A0HNAwC++1Jkf6vSVdFaHgEBCxIMQIFEC4IugUskCwRRj?=
 =?us-ascii?q?U6mGYF+DwEDAQwBRAQBAQMEikUCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQFAQIQAQEZCRkHDg4FJIVoDYI3In2BCAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEWAg2BEBUTBgEBOE5GAQUBV4U5A6EygQRCizGBATOBAYIIAQEGn?=
 =?us-ascii?q?U6BXgkJAQiBL5BbgSEbgUlEgRU2iESDQYI0l2tngTFygSeBL4EEAgkCEWuBE?=
 =?us-ascii?q?AhogXNAAg1kCwtvgUSDEgQCEUIMFV0CgQcIEgEYAwcHAgGBNBA+BwZCDjcDR?=
 =?us-ascii?q?B0GOgMLdT01FB+CTwSCAApQnxShLYIai02TDoE3hAiBWgyfITSXCpI6l3yne?=
 =?us-ascii?q?gIKBwYQI4FCATcugS4zGggoCIMiTwMZD44giQaLBSE0PQIHCwEBAwmLRQEB?=
IronPort-PHdr: A9a23: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
 dzC0qn0LWUam+8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9TqPQa5jxp9L2rTn0APXwBXXdLJyesId70hD6qlUc20vTiX4rb
 HXoB1/73XJYVkqKRQdcLy7Sc29qBDnhOdICOsqTNSftWDd0QPCTL2KhbGC/9SKIVyZygcy79
 YGT0G8MrHN5JpB4PrS0U2XFdAvxdXC1rupi+fYx3IoaQ1xcalv40NYJ2+gYy9LrcV9aqbR3a
 Dz2vZ6
X-Talos-CUID: 9a23:j4LQ3WwFtFrxtcumdnrjBgU/R8N8Q0/63UyMHF2TCntyQ4SWYFG5rfY=
X-Talos-MUID: 9a23:KrPCCgpDIW4MAA+AYn4ezxVnOutY3OeCMkYygcoXocjcDyFJJCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,248,1677538800"; 
   d="scan'208";a="106144712"
X-MGA-submission: =?us-ascii?q?MDEUh6e2c2RNVIwDcehpmxmVBnzOMTM1Rcdo+J?=
 =?us-ascii?q?KKf/nx2u+LCdgyPBwqp2S8nqPBZmSZm0a/JQXzVnQI5FcZqnsNvTVbvs?=
 =?us-ascii?q?O63NcJQMikzDarq0jYYXFOFeZSLpEAjUxiY4LFXZFjn5TRM5uoqECPpU?=
 =?us-ascii?q?PeYMf9FUyOiuJZrr90t2Z0Aw=3D=3D?=
Received: from mail-pf1-f171.google.com ([209.85.210.171])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 02:30:59 +0200
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64115eef620so8831624b3a.1
        for <cocci@inria.fr>; Wed, 03 May 2023 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683160258; x=1685752258;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE4QJaFATi70AxduK7pmjDAK+4ChoZwZRPiddy5PEZU=;
        b=MiH26FHDeEduKp5gkVdGqx1lL2aVJd6IDbDxeage5ugMbFrcg29WQhvadiHzMpK1xc
         My3qyAUmBirjowa8y68g7ox2cLO6YV0Nlpn1cmEZ1cX0FYTPG3JoLlC9nvWCOuPlGcvG
         hsABGSGfXafN/c1mp0n2xoNvsid+sIRLyyPxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683160258; x=1685752258;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE4QJaFATi70AxduK7pmjDAK+4ChoZwZRPiddy5PEZU=;
        b=Bqr51rnNLywtpvXzZ1WF59JOzteqqtKOy7ekd5pLAn1DPELqaYCrg1rRyu/P9mMUGR
         BWJlQQxaBHXXr9Ptxelk2K7F+bgTzrViCYC64xk2N1smB0KCmOcOft9cH19OdqkKUcw0
         MOkV2iKX5J/5ZnOVAqn/AeSxA9IdflCwmxwcY8gLq1OS6WNKcnjqJkZBYQIXRhN4BqLW
         BPYYfAgjNkBwCjwKe6ktjlqDneGz5qxsNElE5ILrh2nGEg7wXO0cDF8cr7qg/3UXR2Dx
         md0VwjVKv+2ortDBXKz2jJ29y+lwHrCSlHrHYq0fGEb7S8Il0NzRm8k8v/YinfwIFrxL
         L7mw==
X-Gm-Message-State: AC+VfDxFHb+mySF0r/IofURh7L2ARTCVM0ZeRNiSVUbb2DKe85zIQMK3
	8W+sJ39GLJ7Ug869dAzXK2sX0nVqLr2/dn+4Xlw=
X-Google-Smtp-Source: ACHHUZ5H/eCgI9DosQdByVZrGc3nXQaz4zG/Cy437jE0haI7YQm70CghQTU0d2ybvcKD4TGaBdPWqA==
X-Received: by 2002:a05:6a00:1150:b0:635:7fb2:2ab4 with SMTP id b16-20020a056a00115000b006357fb22ab4mr289747pfm.6.1683160257790;
        Wed, 03 May 2023 17:30:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p5-20020a056a000b4500b0062a56e51fd7sm24134584pfo.188.2023.05.03.17.30.57
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 17:30:57 -0700 (PDT)
Message-ID: <6452fcc1.050a0220.ab3f.2321@mx.google.com>
X-Google-Original-Message-ID: <202305031729.@keescook>
Date: Wed, 3 May 2023 17:30:56 -0700
From: Kees Cook <keescook@chromium.org>
To: cocci@inria.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] variable declarer?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1139
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/6452fcc1.050a0220.ab3f.2321%40mx.google.com>

Hi,

I can't figure out how to match a declarer in a struct definition. For
example:

    struct foo {
        int bar;
        DECLARE_FLEX_ARRAY(u8, array);
    };

using:

declarer name DECLARE_FLEX_ARRAY;

doesn't work, without it, I get errors at "u8" since, I assume, it's not
expecting parens. :)

The full script I'm trying to use is a variation on the prior one:


// Options: --include-headers

@allocated@
identifier STRUCT, ARRAY, COUNTER, CALC;
expression COUNT;
struct STRUCT *PTR;
identifier ALLOC =~ "(devm_)?[kv][cvzm]alloc";
@@

(
        CALC = struct_size(PTR, ARRAY, COUNT);
        ...
        PTR = ALLOC(..., CALC, ...);
|
        PTR = ALLOC(..., struct_size(PTR, ARRAY, COUNT), ...);
)
        ...
        PTR->COUNTER = COUNT;

@annotate@
type COUNTER_TYPE, ARRAY_TYPE;
identifier allocated.STRUCT;
identifier allocated.ARRAY;
identifier allocated.COUNTER;
attribute name __counted_by;
declarer name DECLARE_FLEX_ARRAY;
@@

 struct STRUCT {
        ...
        COUNTER_TYPE COUNTER;
        ...
        DECLARE_FLEX_ARRAY(ARRAY_TYPE, ARRAY)
+       __counted_by(COUNTER)
        ;
 };



Thanks!

-Kees

-- 
Kees Cook
