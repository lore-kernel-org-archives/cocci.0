Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7170C4332F
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XPzvHUJFcmrmwBdLqv88phqCPGJz+AlJYWNEiHZ+N9k=;
  b=ikBx8uxkcvmX5clnf7KSnxueJFQ2j6sFCGtfhzdr8p3/wLW33eVLyJrL
   8ehMQeVJcmakkdDs4dCYohDU1JtQA9O1UWwTumbAzTgZiwMdIm+2yiMo4
   3qAIGl/84UJsx1nIAFXWqUFH5mt49iVQWFoC43ljO/SuH34jWMFCkdv6m
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="scan'208";a="29007500"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 08:39:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63C5AE7D92; Wed, 30 Mar 2022 08:39:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B895E7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 01:23:24 +0200 (CEST)
IronPort-SDR: ZbuI9rkj5+NOVg021RfaMJInTk+c1jeoOrKpkZKJ8afg5R1fi4nM1oCSTUeRFmnZHLsjsN9MtS
 jg6Rv8i1piyXPBKzEw/fky/860RkbczfwOqHEJ0dnMx/r8buHJiRV/uh0G07UaoT6RZ7UMTAvh
 4xCdMmDjjFwBdTF/UeExcKl7ucQx8N3V+m8oEsSKPoAIXi8wNzZKuXmfWNH+4ZCIAOMW4GcESX
 WvpbB0xo5VwuoNYrqR8/+jPO0KW+NyepSy9UkR++lmFwK8R9DNlSCopD9XJPR7sk3/i5zR5G98
 814RiNtYIZWkBCZFtK+Lm6Ci
X-IPAS-Result: =?us-ascii?q?A0CWAAAJlENif7CnVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UcGAQELAYFRVn5XKwRPiy+KPYsqkT6BfAsBAwELAQE7CAQBATwBhEoChFMCH?=
 =?us-ascii?q?QcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LCQcIC?=
 =?us-ascii?q?gIFDg4FYAFhAwFEgU+BdAsDMQ2CNSKDbAIBAxIoBgEbHQEDDAYQOyECEQEFA?=
 =?us-ascii?q?RwHCwcigmOCZAEDLgEOol6BBD2LMIEXBReBAYIJBoFAAYMIChkoDWcDgVkCA?=
 =?us-ascii?q?QYJAQiBKgGGEAGEJ4MXeieCKYFIgQmCLIIhQgSHOyIEmHEBgQ0sgV9pLwNTA?=
 =?us-ascii?q?ZEhFq05MDEKBgGCIXM4gUGJT45qhXszlkSSA4R0kWkgjHiDVJEbhFcCCgcGE?=
 =?us-ascii?q?CMSgS0BgQCBEzMaI4EBbYFLEzsBAgEBAQ0BAgEBAwECAQIJAQECjh03gzuFF?=
 =?us-ascii?q?IVkJzQCNgIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:M6UZ9aj19SevAn9UnUadqr94WXBQXvcji2hC6mlwRA09TyVXrb
 HLoB0+726PtN9xYgBapTnkAsO9qBznhP1ICOUqTNWftUzdyRaVxeJZnPPfKl/bakvDH4dmvM
 8KE5SWSueAdGSS5fya3ODSKadG/DDoytHMuQ4c9RtQpMNRBp2IIz0XNu9TKCNLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="9990395"
X-MGA-submission: =?us-ascii?q?MDEgDVwkYWctoW7+JLQFr/DNew2NU+gzOblXuN?=
 =?us-ascii?q?MbcyXG2gRwwG6g2cwiWGF4XgFpujjdVzJAXc+RkEKiyv6ZrXSqWrKknd?=
 =?us-ascii?q?QnZYROVGvIFizot4tSIl1ORmcqRAsVlFFkcSQP50vCN2PtKXQ5siBGTT?=
 =?us-ascii?q?9rTkdyyf8oZjDJbqzBHAR+Xw=3D=3D?=
Received: from mail-oi1-f176.google.com ([209.85.167.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:23:22 +0200
Received: by mail-oi1-f176.google.com with SMTP id e189so20533460oia.8;
        Tue, 29 Mar 2022 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XPzvHUJFcmrmwBdLqv88phqCPGJz+AlJYWNEiHZ+N9k=;
        b=kv0gkWrKiGBy8kYA4uYrQ1vrivtKVfzqOyTvCj+p//11dTmhxCKTaLhU4ihHXdOGJ+
         EPBxOP94TQqKyAzQw16ZSCf0Q+KrvjahcXqouAlSnK0trik/L+5SiYi51LU8kzDiAk3U
         DMdYEIeZzyQUqIcYWxYqMDJd9ef96WJ/yvJrLNby/7RHZ8sjjA1Z4RrblYwyR86n21GE
         U2gyVHQVvANKcmiQGb/1APnAQQnnyRpCwMgyr8pi9ZY0x0Oi66zuS/15RlNdVL4ZdNE3
         Rf0IHJShFGcgrB9qbdW89h9J6ehCrxlMNzySC96KMwlna3arfnkwzEEdANfL4KTtAjAt
         0dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XPzvHUJFcmrmwBdLqv88phqCPGJz+AlJYWNEiHZ+N9k=;
        b=WQYf88zbMYiLoyawcTXfBYozEtNqP8azwz8gplZvqfGicJh1btmW99fPMMNbxYdadH
         reHJMj+R97aATatPq5EM/Se46Md7fWGE9oeOq/7a6x5d436IcB01oEY9BF/7H3eNUDYF
         lb6A1Z2Fw9wHOcLn/tg/iNyd7FAHqOITMCLNXXki4BsyDTuhQ6tBz2BEq9zm8cAAoDdl
         ULv0djss/jALy1Df4Cnf+iwUsPk5Sd9pfDayb14iAXfqnAqlnWlA0leosOYb884ka18P
         LaFwsys7X/pybeHOGiyqwUzaDg+l74q6nwiZyi8FmGdsMH+EMF2DvRFkFe+DA8CZ2scj
         k1yA==
X-Gm-Message-State: AOAM5303LmAcrD4Pida4wT+D5UOK8QYTYnFDZuLRyez+/Lk6zC6iPjyF
	bz/9hCMw8+HLwEnxds/5MMM=
X-Google-Smtp-Source: ABdhPJzLQP2ylpqyfwQ0/iHWuE5kgaqVA+koSF2KnxNt0QjXk6vd3PbeNN2JVnO26ZeoR+Z9yWlUig==
X-Received: by 2002:aca:4b50:0:b0:2ef:b47:294a with SMTP id y77-20020aca4b50000000b002ef0b47294amr701959oia.69.1648596201324;
        Tue, 29 Mar 2022 16:23:21 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id s6-20020a4ae546000000b0032480834193sm8863192oot.46.2022.03.29.16.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:23:21 -0700 (PDT)
Date: Tue, 29 Mar 2022 20:23:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@oracle.com,
	julia.lawall@inria.fr
Message-ID: <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 309
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1%40gmail.com>

Enhance the static analysis tools section with a discussion on when to
use each of them.

This was mainly taken from Dan Carpenter and Julia Lawall's comments on
the previous documentation patch for static analysis tools.

Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index b5e02dd3fd94..91e479045d3a 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
 
 Beware, though, that static analysis tools suffer from **false positives**.
 Errors and warns need to be evaluated carefully before attempting to fix them.
+
+When to use Sparse and Smatch
+-----------------------------
+
+Sparse is useful for type checking, detecting places that use ``__user``
+pointers improperly, or finding endianness bugs. Sparse runs much faster than
+Smatch.
+
+Smatch does flow analysis and, if allowed to build the function database, it
+also does cross function analysis. Smatch tries to answer questions like where
+is this buffer allocated? How big is it? Can this index be controlled by the
+user? Is this variable larger than that variable?
+
+It's generally easier to write checks in Smatch than it is to write checks in
+Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
+because there is no reason for re-implementing Sparse's check in Smatch.
+
+Strong points of Smatch and Coccinelle
+--------------------------------------
+
+Coccinelle is probably the easiest for writing checks. It works before the
+pre-compiler so it's easier to check for bugs in macros using Coccinelle.
+Coccinelle also writes patches fixes for you which no other tool does.
+
+With Coccinelle you can do a mass conversion from
+``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
+that's really useful. If you just created a Smatch warning and try to push the
+work of converting on to the maintainers they would be annoyed. You'd have to
+argue about each warning if can really overflow or not.
+
+Coccinelle does no analysis of variable values, which is the strong point of
+Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
+way.
-- 
2.35.1

