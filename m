Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F57C433EF
	for <cocci@archiver.kernel.org>; Mon, 13 Jun 2022 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jZWzCgoz5Pw3mHE8/DxjotUDMmE2UXTU9cjooBfPmLk=;
  b=h8Sk2YSqmL3GM0lT/B3xGXTwc+LGQXq6e9a3H6q7hEGt/6Q3jmIgcI5G
   uDsQsLzPkSDCDDhsmoDb6aoEFPQkA9yjSWABMAMJ7Ae/DjqP+Hhh6LN60
   GLzRABTXEUXkRtCftD3IhW8aGJT6E4NSKdsH3SHA36++3vSHU3qC0f+a4
   o=;
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
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40717668"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2022 12:13:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38650E0038; Mon, 13 Jun 2022 12:13:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77715E0038
	for <cocci@sympa.inria.fr>; Mon, 13 Jun 2022 10:02:00 +0200 (CEST)
IronPort-SDR: tn5BRsN/ahnyezb0o9TdMfX7OT0+ZzlHJ1dY/WtAoSMoSveNe2ObTsZL3pOkCb3cJnBAEROhIX
 kx5SQ2DV/kFANchEGx9kHoDJIf9/xFooaGp59wAB1PnMDRGm9XCCrVxbc0KdKBxiJz6Hspvu8G
 G3ezKtek9YEbiZwFSKZ8iZufMClMfowPHknayKoQIqH0+92fcT1e/ozP5qOdZ0MFh+KKsy67Mb
 CGNQ1q1TbL2faR+/YFThsltbFNSDjabPePn4GZ2u/zc1yzdVt19f5ra01xEKRWFvk68S5Ykycc
 w8QcknRZNFsYhZKt/baTYeJQ
X-IPAS-Result: =?us-ascii?q?A0D/BAB+7qZif6rSVdFaDg8CPQUFBAkWgSongToCZoFXL?=
 =?us-ascii?q?gRPhE6JAIVoggchiyqHFwWMHgsBAwELAQESAS0CBAEBhQIChUcCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABY?=
 =?us-ascii?q?QMBRIFPgXQLAzENgjUpAYNjAQEBAQMSER0BGx0BAwwGBQ4HAwICJgICEBECE?=
 =?us-ascii?q?QEFARwGEyKFQAEDMAIBoGGBBEKKOHqBFQUXgQGCCQaESwoZKA1nA4FZAgcJA?=
 =?us-ascii?q?Qh/KgIBAYRPgUuHWXonHIINhD8+giCFeoJlBI1GikwEGQ8DAwIPFANHIwICA?=
 =?us-ascii?q?QELAgYGBAYDAQEGAwkCBAISAgIEBxgKEggUAwIGAiAFAQcFAQQDEgYMEQEIB?=
 =?us-ascii?q?gYBBAIKAQICBQUMAwERAQQCBgIEBAQYFAQCBAcGAgkJBwUWCwQKAhYBHAIGD?=
 =?us-ascii?q?AgCAgICAgQVBwENBQICBA8CBwYDCwIDBQcDAwQHDAYMDgEDAQcBBAUDDQQBA?=
 =?us-ascii?q?QYCCwMFCgIBAgMMAQEHBAgBAQICCgIBBAIHAQIFAwIDCAMCAwMCAgEBBBECA?=
 =?us-ascii?q?wQDBAIDAQUBAQUDAgUBAwMCAQMDAwIBBAMGCQoECAEEBAEBARECBwcCBgMDA?=
 =?us-ascii?q?gICAgUBAg0BAgECBAMIBgIDFAECBAEKAQUCAwkCBwMBAQIHDwIHBQIHAgIEA?=
 =?us-ascii?q?QUDDQEDBQIDAQEDAwIEAQIBAwMJAQMCAwMCAgICBQIDAgICCQMGAQcDAgEBB?=
 =?us-ascii?q?AUBBAMBAgoEBAMEAgQCBwIHAgQHAgEEBgMHBgQCAQcBAQQKBAMDAwEBBwECB?=
 =?us-ascii?q?QICAwIGEgYHAgQBAwQECgICDAIHAQECAQEBAQIDAgcFDAEBAQMCAwYCBQICA?=
 =?us-ascii?q?QEDCAgDAgEEAQUDAQQFAwcCAQUJAgkDAwkDAQEFAQMBCQMDAwIJAwECAgILB?=
 =?us-ascii?q?AMIAwMCAwQCAgICAQMCBwUIBAEECgICAgECAgIEAgEDGgECAwUCAgkMAQQCA?=
 =?us-ascii?q?gMBAwEBAggECQQCAwQCAQEDAgECAgEFAgMNBgEBAQECAwMBAgMBAQYHAggCM?=
 =?us-ascii?q?xMBAwMCAQICAgUCAgECAwICDQEBAQQCAQIBAgYBAwECAgMBAwECAgYCDAMIA?=
 =?us-ascii?q?gcBBQMDAgIDAQEFDwUCAQQCAQIGBQIBAQEEAQMEBAgCAgEDAwIOAgQBBAECA?=
 =?us-ascii?q?QEjAwQCAwEDFwECAQIDAwMEBgcGAgECEwECAQEBBQECAQEEAgQEBwoDAgICB?=
 =?us-ascii?q?gMDBQEBAgMCAQEBBwwCAgITAgQKCQMBBgEKBgYVAwIEAgIBAgICCgMBAgIBA?=
 =?us-ascii?q?wIJAgECAQUkAwEBDyQBAQICAQICAwQHAgEEBgMNAgIBAQEFBg0DAgMIDAIJA?=
 =?us-ascii?q?wICAwUBAgICBAECBAwKAQICAQICBAUFAwIBCAYFDQUJCwECAgEDCAEEAxECB?=
 =?us-ascii?q?gMFBQMDAgEKBQIDAQIBAQMBBAEDBAYBAQIDAgIBCAICAQEDAwQDAQIGAgIIA?=
 =?us-ascii?q?gMCAQQCAwMBAQEEAgICAgIEAwgDAgEIBwUBBgECAQQDAgIBAgcBBAEJAgEDA?=
 =?us-ascii?q?wUDBAEKAw8DBQMBAwMCFQoEBAEFCAQECQIEBQIFAwIEAgMDAgIIBQIEAwIOA?=
 =?us-ascii?q?wICBgMEAggFBgYhAQEFZJsZmAWNHp1Qa2CCeIFEmFGFfTGDYwGSbQyRf5Zrk?=
 =?us-ascii?q?QeWAwIKBwYQIxKBQ4F+MxojL4MJTgECAQEBDQECAQEDAQIBAgkBAQKSD4oZU?=
 =?us-ascii?q?TU0OwIGCwEBAwmFRCYTiywBAQ?=
IronPort-PHdr: A9a23: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
 hIJxfXzKoFBbuXG
IronPort-Data: A9a23:sBEiNq2pWsDCDbgIIfbD5Rt3kn2cJEfYwER7XKvMYLTBsI5bpzNRz
 jEZDDvSPf6OMDOmctx/YY7koxhV7ceBnYMyS1Q/3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW13U4
 4uoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt81sl
 u1slrOOcgAkA7XTxt8mX0Z6Pi4raMWq+JefSZS+mcmazkmDa3W1hvs3UxlwMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmuvjDLAz3qzPL+GzVG8bkntpwjjCAfE6RJ3rTKDD5Nse1zA17ixLNa+AO
 pVCMmAxBPjGSwZIGgwKKqIZoOHyoFn7Ixp3oVDNoqVitgA/yyQoiOS3WDbPQfSOTNpcmkKwt
 GPD9X7wRBAcLt2WjzSfmlqngeTEnAvgSYcKHfu58ORriRud3AQu5AY+UFK6pbyhhBf7VYsAc
 wob/S0hqaV0/0uuJjXgY/GmiGOZ4CY9ePVuKOo31RmSlJHv71m7K2dRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWppZS1puf8QdSaaXh9EIMSWcMXZVBavIS78enfmjqKH4kzSvfk5jHgMWiom
 2jikcQou1kEYSc2O0iT+FnGh3e0qMGMQFdqvkPYWWWq6g4/b4mgD2BJ1bQ5xaYaRGp6ZgPZ1
 JThpyR4xL5XZX1qvHLUKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9aJGKxP
 R+N4lkKvsY70J6WgUlfM9LZ5yMCnfiIKDgZfq28gidmOcQtLlDfokmCm2bJgDu3zyDAbp3Ty
 b/CKZr2ZZrrIatgyzWySo8gPUwDl0gDKZfobcmjlXyPiOLADFbMEOttGAbQM4gRsfzcyC2Io
 o43H5bbkH13DbyuCgGJq9J7BQ5RdhATW8umw/G7g8bZfWKK7kl6W6GPqV7gEqQ595loehDgp
 y/mAxUDkQOXaL+uAVziV02PoYjHBf5XxU/X9wRxVbpx83R8M4up8okFcJ47Iesu+OB5nKx7S
 vAEf4OLBfEWEmbL/DEUbJ/cqo1+dUTz1VjeYXb9ODVvLYR9QwHp+8P/elS9+SQLCB2xv5Rsr
 rCl0DTdXpdeFR9pC9zbaa70wl7o5Sodlet+UlHmON5WfEmwooFmJzag3PAyKsAIbx7Ew2LCh
 QqRBB4Zo8jLopM0oIGZ3/Da89/xHrInTERAHmTd4bKnDgXg/zKukd1aTeKFXTHBT2erqqivY
 ONiyfujYvAKmVB9tZUlT+RmwKc40NvYp7FAyzNiEniWPU+gDaltIyXf0MRC6v9Ny7tetVfkU
 06D4IMGa7CAOcegCFBIYQR8MbzF2vYTlT3fq/8yJRyitiNw+bOGV2RUPgWN2HMBduoraNt9z
 LdzotMS5iy+lgEuboSMgBdS+jneNXcHSagm6swXDdO5kAYt0V0eM5XQBjWsvMOKYtRId1Eke
 3qa3fWawbtbwUXGfjw4En2UhbhRgpEHuRZryl4eJgTWxoCU2KdvhBABoy4qSgl1zwlc174hM
 GZcMUAod76F+C1lhZQeUm2hc+2b6MZ1JqAsJ5o1eGzlo42AU2XMKCglN7/I8hlGqyRTeT9U+
 Lzew2HgOdovkAcdwQNqMXOJadS6JTCyyuEGsM+iFsWBWZI9ZFIJR4ewMHEQpUKP7dwZ3SX6S
 CoDwAq0QaL+PC8U5aY8DuF2EFjWpA+sfAR/fB2qwE/F8awwtt1/Nfhi5n1dov9wGsE=
IronPort-HdrOrdr: A9a23:t4PdTaMmruybK8BcTuyjsMiBIKoaSvp037Dk7TEUdfVwSL3jqy
 nOpoVh6faQslwssR4b6LO90cW7MBHhHNtOkPQs1NSZLXHbUQmTXedfBOLZqlWKexEWtNQtrJ
 uIG5IeNDSaNykcsS+V2njcLz/i+rW6GWKT6Ns2A00DceiiUc9d0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,296,1647298800"; 
   d="scan'208";a="16573326"
X-MGA-submission: =?us-ascii?q?MDGnFJSiQagt9rWP9vOtCG57efNsb0/ULQ5Qt5?=
 =?us-ascii?q?CSB7Fy5B66uDlczyB5zsVTpoWlakr8cj1M1PU+lYdRWNDdrVJhYCAkBh?=
 =?us-ascii?q?xDxISuRES8UL2a5HpyuYccfiaOMmjlp7YrjbmZwxRU7kAFad34M9uzz2?=
 =?us-ascii?q?QgMsGeIlCirK2+4nE6QVt25g=3D=3D?=
Received: from mail-pf1-f170.google.com ([209.85.210.170])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 10:01:59 +0200
Received: by mail-pf1-f170.google.com with SMTP id 15so5075121pfy.3;
        Mon, 13 Jun 2022 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZWzCgoz5Pw3mHE8/DxjotUDMmE2UXTU9cjooBfPmLk=;
        b=eYnjniZGIG1VbbkLc4H+4pxr7II/uiE5QUzdgkk8FjDZim7NHyrkQaJACWgS+VT8J/
         N5Hazh+NsG4Oq6jkk2ceOx9DRm9kGRi0VAETwfc1VwRKLZGgtxzXnryl+FH3Csi1/Vhi
         MU2rNA0bHK+/2q0S+XuWJfQYCebTP3WfWuKhmbYftBGxTqbOjUG3AoOw9mdzb1r7S1cj
         kZ344qTwXUNRPCMkVVlAJ8z8Sfv20pIkaQbHpimRpisj1ytbPTubIjjjHhzi66C+u/N/
         /U7pGptATCd5hcBargfGFbrwwijj5CyEYQPwC9w76XPpKybYxUTlrxUiMPOpWKtzrBT1
         6SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZWzCgoz5Pw3mHE8/DxjotUDMmE2UXTU9cjooBfPmLk=;
        b=fU88BakBD03ThgN5cTssqM6Lqc6z39L+WOWD90Z+WvDPkfM3WbOBdl05jgGEFIAa7/
         /SesbueeJ07hynUU+QG/TbYP6eYZFuEklDpWXyh8o7BHKrVdtkFA9/EDUC2bulWC7sMJ
         bc5sDnJMvowqBffvDaZkBNn+PgNcri3di69jTq4vq8hp/WdXTf8LsA7CWfaEhLyvMVuA
         dASu9YutNdWy8yuS7uAU9Eu2NkucsGU8uRQiTRXXfVPo3tOi1B6fCKf+11pX2f4UHCvk
         vIfy+ZRFzFct5EakO/PpSvvUbuORdF9ssZwAnC+da0WD76s2Ywm3TOVqxSzGEZqOV128
         zvDg==
X-Gm-Message-State: AOAM533inEEOtXJH1tPAAOv9+7FB+f+VINAVeVcX8y/eWLhvBmYBPjYU
	yDWgnyap2Uw/r0XN9GcAJaQpTyEZprQ=
X-Google-Smtp-Source: ABdhPJwip/iwh/bSl3Xq0RGH3xDHwUGJhANIMKdhvlGRKZdAtKJT95PIzG2rrw6Rb18tgoNsZDtDBg==
X-Received: by 2002:a05:6a00:a06:b0:51e:47f5:79ad with SMTP id p6-20020a056a000a0600b0051e47f579admr22192430pfh.53.1655107317114;
        Mon, 13 Jun 2022 01:01:57 -0700 (PDT)
Received: from localhost (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b0015e8d4eb22csm4386153plb.118.2022.06.13.01.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:01:56 -0700 (PDT)
Date: Mon, 13 Jun 2022 15:01:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <mudongliangabcd@gmail.com>, cocci@inria.fr,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <Yqbu8TwmaXdBiIBs@debian.me>
References: <20220613071243.12961-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613071243.12961-1-dzm91@hust.edu.cn>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] dev-tools: fix one invalid url
Reply-To: Bagas Sanjaya <bagasdotme@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 439
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/Yqbu8TwmaXdBiIBs%40debian.me>

On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Fix the invalid url about Semantic Patch Language
> 

I think what this patch doing is to point SPL reference URL from old
Coccinelle documentation (doc root) to actual SPL doc entry on new
Coccinelle page, right? If so, "fix invalid URL" may not be right patch
description and title.

-- 
An old man doll... just what I always wanted! - Clara
