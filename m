Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C1C02198
	for <cocci@archiver.kernel.org>; Sun, 16 Feb 2025 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9zRce5KDupQlAyQvjcHzz5EymYWKIHafArKmI09bdGo=;
  b=O4ok8Xc7ZpFIEbPP3+UK4wJ5HJbIEBg730OHsHl9Hc9s5u8doxxHizj5
   lyUpqR7MwOZfU2PpTiwzDJ1wHCn0EcR6XjkYA65cp9lnvjTIjxyxMuAwY
   aqRmVq5gbfkj0htjiRz1vVOJHkXlLOviypWFhBCWWfFiFRP9aBlC1qjug
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="208482202"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2025 09:48:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5D643E0D1D; Sun, 16 Feb 2025 09:48:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 582D4E0260
	for <cocci@sympa.inria.fr>; Sun, 16 Feb 2025 09:48:53 +0100 (CET)
IronPort-SDR: 67b1a674_XgCvKyF2hMcGkATNE5LLINPCtjiPjNLOr7z+nf31668yUzI
 Q2pFwrHPZyB2DDOlXIcj6Yeou/AW4YW5jM/GYZQ==
X-IPAS-Result: =?us-ascii?q?A0GUAgCtpbFnfKzQVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOBclKBVzMEU4RWj0+BdDCEO4c7k14+DwEDAQsBAUICBAEBAwQ4hEgCiwsCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw4SK?=
 =?us-ascii?q?YV7DYJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAQEBAxIRBBEIARsdAQMMBgULDQICJgICIhEBBQEcBhUBAR6CY?=
 =?us-ascii?q?IIwAQMxAwGhfYEFQos+fxYFAhaBAYINBtpdChkoDWwDgWICBwkBCoEGLoR1K?=
 =?us-ascii?q?U4OgjgdAYYvgzl6Jw+BVUSBPIJSMT6EWINGgmkEgi9KgSSDQIlniGqSfwgHH?=
 =?us-ascii?q?xIJCRMGCgJLCwoSAwQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SBBMKDQsHBR8KC?=
 =?us-ascii?q?AwRCigDIgQOKw8DWzQBCAYCAgQEAgQCCgIJAgIIBwIUAwIEBAIBBRIDCwEFB?=
 =?us-ascii?q?gUBAQQJDgICAwMCAgEIAgIBAQITAQQDAQcCBQMFAwoBAQECAQQUBgMFAwMHA?=
 =?us-ascii?q?wQCAwIGAgQFBQICAwMCAwEDAwIBAgMJEA8WAgIDBAIGAgIBBCYCARUFAgMEA?=
 =?us-ascii?q?gIHAgIDAQIBAgICBAIEAgIGAwkIAQICBwECAgIDFQIFAQQJAwMFEgwgAwICA?=
 =?us-ascii?q?gIDBwoDBQIBAQIEAwMDAwwNBwIDAQIBAwUDAQIBAgkDBgICAwMEEhkFAwIPA?=
 =?us-ascii?q?wIBBQQCCBALBwEBDxQFBAkFFQMGAgMDFgsEBQMDAwEMDw4CAgsDFwUBAQcBA?=
 =?us-ascii?q?w0IAwQEAgMDCQIBEAEDBAIJAgQBAgoCAgICAgQBAQUEAgQDAgUCAgEIBAMDA?=
 =?us-ascii?q?w0EAwgIAwUDDBICAgIJAgMBAgMDAwQNCB0FCRELAgkDBA0CBAICAQYDBgoGB?=
 =?us-ascii?q?QQFBgECGAICBgwEAwMIAwIDAgIBAgICARECAgkIDQUJBQYCAhUDAgMIAQkDD?=
 =?us-ascii?q?wMCFAEGAggDBwEBBAICChMKAQECAgEGJQIBAQITEwcDCAICAgIGFgwBBQcDB?=
 =?us-ascii?q?w8FBQQCAhYDAxIEBBACAgMDAgEBFAYVAQUCAwYLAQYBAgUEAgMEAhICERMDA?=
 =?us-ascii?q?wQGAwECChACBAIJCgEFBAMHBQIfAwMCAgULAggCAgUCBQcDCQ4BAgUDBAkCF?=
 =?us-ascii?q?AIQAgICAggWAgICBRwDJgIEAwMDAwsBAgIOCQMENgYRBAIDAwIOAQICCwECA?=
 =?us-ascii?q?gQCAwEEBwkDAwkKBwEKDQcCAgoICRABAgIPBwMCAgICBgcOAwITDwUGBgIKB?=
 =?us-ascii?q?w0LAgECAhUCAwkGAwUNAwcECg0CFQIWBQMgAggJCwIHEQIFEgMOBQMCAhEEA?=
 =?us-ascii?q?gMDBQMBBwEXAwcIAgIMAgICAgUCBQIFFxEBDQQDAwMCCAEEFQYDCQgqGxIBA?=
 =?us-ascii?q?QEFAQkCAwIDBAgDAwMCAwQMCwIBBwgDAwYLCAkGAwIHCBkDBQQDBwULIQIGA?=
 =?us-ascii?q?wIEBQQBBQITDQIDGQIGAwYRCQwCBggHCQMHAQEBAgICCAEGBRICAwQCBQQEA?=
 =?us-ascii?q?QEIAwMEBgIBAwICBAkBAQECCgIICgEJEwQDCAMDAwMDBQECAggEEQUFAgEFC?=
 =?us-ascii?q?hMMAQoGAwYDBAICAgsHAgMDAwIHAQsaCQIBAwICBQICAQUDAgIGBAMCAQEJA?=
 =?us-ascii?q?gMCCAECAgEBAgICBAEHAQQHBgEBAgQCAjQCAQMJAgUBAQEOAgIEAgIBAgICB?=
 =?us-ascii?q?AIEAQIGCwQFDQEBAgECAgEBAQQBCAMBAQECAgMDBQMFCA8NAQEXCx0FBAUCA?=
 =?us-ascii?q?gEBAQEBAhMCAgELAQIBAQMaAgEDAwQBCwIBAQQfBBYCAgICAgIEAwICAwICA?=
 =?us-ascii?q?gQHEyUBAwEDAgEGAxMCAgICAgQCAQICBQUFAQMEERMJAQMCBQQCAgYCBAYKA?=
 =?us-ascii?q?gcEAhoEAgICAQMEBgMBAggCAgcEAgMKAgIDAQICBxkdAgkDIw8CAQsJCBM9D?=
 =?us-ascii?q?AcyBDYBCQsUBwYlGGifRoQlCIEhgQkKgSSTR5E3oTs0B4QegV0GDJ9dBg8EL?=
 =?us-ascii?q?5dDkw+IQ5A6qQQCCgcGESMSgUkjgVwzGiOBAYI2TwMZD44hg3rGTEI1PAIHC?=
 =?us-ascii?q?wEBAwmFaYpXgUsBAQ?=
IronPort-PHdr: A9a23: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
 EVlMHLAResUgeI/LyZkjwjTvZYJEvlZH/UsXQ==
IronPort-Data: A9a23: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
 iaEuxADOahOFKydNHB6B+nEF1Kdn0/g1w30sTM=
IronPort-HdrOrdr: A9a23:TMa6nqDm/2aPY6vlHel655DYdb4zR+YMi2TDGXoBMSC9Afbo7f
 xG+85rqyMc6QxhJ03I/OrrBEDuewK4yXcY2/htAV7mZnibhILKFvAH0WKB+UyDJ8SWzIc0vt
 YCT0E9MqyKMbETt6bHCWKDYrAdKbe8gdmVbKvlvhBQZDAvRaUlwQkRMGmm+45NKDWux6BVKH
 NR3KR6TvObGEgqUg==
X-Talos-CUID: 9a23:M3iDH20R9FdFH4odzCkQJbxfNNtiaXvQxm7sAVajIltJRbilZkef9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ANEaU8w8SBfLHMoATKpXWqJqQf8l0/f/pFx8wrZA?=
 =?us-ascii?q?DofeLFyJNJinDnDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="109231246"
X-MGA-submission: =?us-ascii?q?MDFR7eJILr63Zf+lkA7VVcStWmT7cZIXhzx3BM?=
 =?us-ascii?q?n7pgBfh55czBVA0/wS7pLiJAxUTskKWNN7lfz0ib6Oas7mwMR+1OqN/P?=
 =?us-ascii?q?gGC1DVRTUNu8PlYdkOl4PM1yS+TAQ6V2JnBPJ5QcQbaOi9gxNolck7A1?=
 =?us-ascii?q?L7hc8jIv8GxHJPUD4UyzV4ww=3D=3D?=
Received: from mail-lj1-f172.google.com ([209.85.208.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 09:48:52 +0100
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30918c29da2so25220661fa.0;
        Sun, 16 Feb 2025 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739695731; x=1740300531; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zRce5KDupQlAyQvjcHzz5EymYWKIHafArKmI09bdGo=;
        b=f4BVJzZj9s6aaz+YhmkzQ9n92Kk7MVWy07EuvBjKjIHmxPuMpFblj53TFFoWPVdXr2
         GgxNCaRn/xmIz7RcA7ANfIHpEuQ+hMvoTFUnyiupgiZzGdd7SZReab3jxN+jSk/OAIki
         JZRon3P3Ouxsz5hjcf2Har875iIkxWG4A1DpwHNKf8v+Y4G/McS/QY9JRNvRSFkczRK6
         /f7b86C0kBr5QjO+Fnfvrp8ZbU644F1miH/ZGTYb3Fw5d+UOVedUR3onV/AFuhO83hCc
         4QXaKkEAb6Xo8N+A8g+Yg8ahNXBMVxIKh8LsC0YPCnGd4TyNc89/PxQKriWNRQYO/iZ5
         iygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739695731; x=1740300531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zRce5KDupQlAyQvjcHzz5EymYWKIHafArKmI09bdGo=;
        b=sgqFOvTzEc5X3433rqgPLy/f+GOCVXRwxQBDYeomC8ijjajKrUghXUILec/cj+g1Rz
         DAv0mAOekFS5G+1vY+CXIbM4Q0TUPJmoOJ5FV3XKjqWZubcbDa8AZIBs+nz0b0k7Xqpz
         dX5MlMWF2iYfWHWgbiSP/dqakLqa7C1sfdPX0kaFQnpk61VS4gsMlh6+0brs0fJOYWIm
         aKtFCpguzdSnKCh+d5eJXv/SbnCZG+vFpVF+qoe7mXmpfxR2jWvlgDwqbYbLLU1BW/f2
         HF/v5t1oSLJfRu1XMKPgWiEy0cxPWuiuUD9voRQDpUKpzS4wINXa0m4ydCpXY/bUfCTS
         UKcw==
X-Gm-Message-State: AOJu0Yz0F8t378AG2c8qWSlN2IXq8prabJfIetnEy9KHrzyxL3otzWCs
	lpip46ghgNp3Vag8LNvejZP2+QIvwAfqL14Obp+GWZxAQAedSVKbBcw+6w==
X-Gm-Gg: ASbGnctBSmwv0G1F6O3AU9fp+aPfl3/KbxOUQBQcgf7HevPmpOmoJaCjGS0CnUuy0Yi
	jykTzekjgCB957bXeysdJp3hbOn5oNV9Bhft7hSwGgu32fAWx8fjc6jK6Ai+q4Q8nW9mfByi/MN
	nukzBFCsIb0wJzB+Vwrsava88byjD4iA0+T6RYncaUfeOR3xcHAX/kp+zoj2fKsW/Sp58dDEYEj
	7McEZusrZL8F+queI523czYwexbshd5fFFbMUwX55BvNFX2yOS1oWJRMlZmreRq/l19n+OG1P3F
	GrD7Pu0k2Za8Y5YZXFlp1pXw73lTYIwj0VQzEJhFmkb8NUd9tR6L8PVLYoQ=
X-Google-Smtp-Source: AGHT+IHSZv/YmMv3TROin7HeTPDU/LlbVttxax/L8sqGSVTWIcSP54YFODBjrNZF/HHXS6jLJ5oEsQ==
X-Received: by 2002:a2e:7010:0:b0:309:25ce:8b8b with SMTP id 38308e7fff4ca-30927a42c1cmr17055051fa.4.1739695730990;
        Sun, 16 Feb 2025 00:48:50 -0800 (PST)
Received: from ?IPV6:2a02:aa1:104a:f928:1f22:9cb:642:bb6? ([2a02:aa1:104a:f928:1f22:9cb:642:bb6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30931b895e5sm3779361fa.113.2025.02.16.00.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 00:48:50 -0800 (PST)
Message-ID: <289696b5-d47e-4acd-90ba-89665ea8708a@gmail.com>
Date: Sun, 16 Feb 2025 09:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
 <alpine.DEB.2.22.394.2502152149070.17391@hadrien>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2502152149070.17391@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2420
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/289696b5-d47e-4acd-90ba-89665ea8708a%40gmail.com>

On 2025-02-15 22:00, Julia Lawall wrote:
> I tried the following, in line with what I previously suggested:
>
> virtual patch
>
> @bad1@
> type T;
> local idexpression T *var;
> position p1;
> @@
>    var@p1 = malloc(sizeof(T))
>    ...
>    return var;
>
> @depends on patch@
> type T;
> position p1 != bad1.p1;
> identifier var, fld;
> @@
> - T *var;
> + T var;
>    ...
> - var@p1 = malloc(sizeof(T));
> + magic_init(&var);
> <...
> (
> - free(var);
> |
> - *var
> + var
> |
> - var->fld
> + var.fld
> |
> - var
> + &var
> )
> ...>
>
> @bad2@
> type T;
> local idexpression T *var;
> position p1;
> @@
>    var@p1 = malloc(sizeof(T))
>    ...
>    return var;
>
> @depends on patch@
> type T;
> position p1 != bad2.p1;
> identifier var, fld;
> statement S,S1;
> @@
>
> - T *var@p1 = malloc(sizeof(T));
> + T var;
>    ... when != S
> (
> <...
> (
> - free(var);
> |
> - *var
> + var
> |
> var
> - ->fld
> + .fld
> |
> - var
> + &var
> )
> ...>
> &
> + magic_init(&var);
>    S1
> )
>
> -----------------------------
>
> You matched the case that you want in the first rule with a forall.  I
> instead matched the case that is not wanted, and then check that the
> position later is different from that one.
>
> I'm not sure which is better.  My approach may turn out to be expensive if
> some functions include multiple mallocs.

I tried this approach on a large code base, and it seems to be 
significantly faster. This approach took about 2 seconds, the one I 
attempted took more than 2 minutes. Going to check that it matches the 
same things, but otherwise this seems a lot better.

Thanks for the help Julia,
Mats Kindahl

