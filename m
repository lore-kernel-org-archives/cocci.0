Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBECC433EF
	for <cocci@archiver.kernel.org>; Tue, 29 Mar 2022 07:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9qRB0II6Ytegh9oDXsqAEWbvdBJG2QMLk1XoynhcSdc=;
  b=XwAZs/zmPnEzaTacAkcr56iqEgqTFVptZIMJpo/ZMBnXamhsh7dzuqTS
   qUP+E73sCd0cSN9ZTv9/jjuE6FUOaddeuXL9hXLAMUJiFMzxyTCTeM97e
   OIqeWgbhw4iTefmieizP47euj4za0CMWkIX6Il3qDGW694CGJU90RmahA
   I=;
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
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28809415"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2022 09:17:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0E94E4372; Tue, 29 Mar 2022 09:17:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 18772E436E
	for <cocci@sympa.inria.fr>; Mon, 28 Mar 2022 23:20:06 +0200 (CEST)
IronPort-SDR: 4uWOkSxGoHAyezKiRvLb6iLMV6FPl+V0AtLfPk+kU0peTjJ1g6dXwmYXF4NhWK/khaDWbCs86d
 ZNlfBuSs6CJS/0S4aCk5Jrpr4bV751QIgdSJDuM3wGFf/bvEns5olmG3eqPXOvQrpmmjnmY4cu
 mMFRK9uG+YJOsbdW0JcvvVpKyfr06X/KRLQhTh+eWzBuNkjnbzlnnzY3uTHsbH2rHYWNMWzL/d
 t1S0W2QPdb7eTYC+YKe/YysOigK9BceQHjAzdCTT8/qpsYpKMc2aYy+K9ze2RFetb72aIFVN/g
 e73yU26eF6YS+IfO/L4zdQqH
X-IPAS-Result: =?us-ascii?q?A0AmAAB9JUJif7GnVdFaHQEBAQEJARIBBQUBQIFGCAELA?=
 =?us-ascii?q?YFRVn5XKwRPA4x3iFQeiymGNIsKgXwLAQMBCwEBOQoEAQGFB4RSAh0HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoCBQ4OB?=
 =?us-ascii?q?WABYQMBRIFPgU8lCwMEBicNgjUMhAQWKAYBGx0BAxJbEQIRAQUBIwsHIoJjg?=
 =?us-ascii?q?mQBAy4BDqFkgQQ9izCBFwUXgQGCCQaESQoZKA1nA4FZAgcJAQiBKgGGEAGEJ?=
 =?us-ascii?q?4MXeieCKYJRgT5ugiFCBIE8AQGFfSIEl3Y/NFMoExQIDwEgAi4EBBxAJmOBE?=
 =?us-ascii?q?AGRDRStTjAxCgYBgiFzOIFBiU6OaYV7M4VDkQCSAgGEdJFoIIx2g1OQawuEf?=
 =?us-ascii?q?AIKBwYQIxKBLIIVMxojgW6BSwlFAQIBAQENAQIBAQMBAgECCQEBAowugW8MF?=
 =?us-ascii?q?oNQgmSBdTuFZCc0AgE1AgYLAQEDCZFgAQE?=
IronPort-PHdr: A9a23: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
 wOFnDRHdS4HUP94+ppX
IronPort-Data: A9a23:l+r8Fa7s+LTah6nltsM3wwxRtOXBchMFZxGqfqrLsTDasY5as4F+v
 moaXmyBMvqMZmKheN0nYIqw90JSscWHmIUyTlZopSEyZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yio85WFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 NVJtLGCaz4XB5SSwrQCXyZzPmZOH4QTrdcrIVDn2SCS50jPcn+pxPQ3SU9vYtJe9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9E7czwJ18c6EHP6tH0p1k5TTQF/0rRZeFWK7K4N5EwG4YicVHHPKYb
 M0cAdZqREWQPEUTYA9/5JQWnL/5ginALQ9ktUOqi6U66FLNwVdKz+24WDbSUoXSGZ89clyjj
 mnB9G/4KgoLMcSWjzuD6HOlwOHV9R4XQ6oXHby8s/lr2RidnzNMThIRUlS/rL+yjUvWt89jx
 1I8+i4vgJoQzXKSd4enDwK0n1Wp+S4+co8FewEl0z2lxq3R6gefI2ELSD9dddAr3PPaoxR6i
 TdlePu5VVRSXK2ppWG1re3J9GjrUcQBBSpTOH5cElFtD8zL+dlr1nryosBf/LlZZzEfMRr5x
 SyNqkDSbJ1M0JdTjM1XEb076g9AS7DMRw8xowLWByert1wmIoGiYIOs5B7Q6vMowGelorup7
 Cdsdyu2trtm4XSxeMqlHbRl8FaBua/tDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74F0NtMMLYSvyNfIvPepd7vjGK4CwSrwJsdiEPrJzjmRZKWdrAQkyPR7Bhjiz+KTSufhnZ
 szFGSpTMZrqIf0/kGDeqxY13rgsySQzrV4/triqpylLJYG2PSbPIZ9caAXmRrlgtMus+VyJm
 /4CaZbi40gACIXWP3iPmaZOfAtiBSVqVfje9ZYLHsbdeVEOMD96W5fsLUYJIdMNc1J9zbeWo
 BlQmyZwlDLCuJEwAVjTMik4MuK2B/6SbxsTZEQRALph4FB7Ca7H0UvVX8JfkWAP+LMxwPhqY
 eMCfsncUP1DRi6WqTsYZJj56odlcU3z1w6JOiOkZhk5foJhF1SZoI+6IlO3+XlcFDezuOs/v
 6akiVHWTJ8FcAJoU5TbZfep+FWusCVPg+l1RUbJfoJedRy0oohnIiD8lNEtJMQIJUmRzzeWz
 VfEDhIRpO2LqIgwqYGbiaeBpoavMu1/AksKRzmBvejqbXHXpzPxz5VBXeCEeSHmeFn1oKjyN
 /9Iy/zcMeEcmAkYvod5FYFtx/1s6tbqoYhc0V04TnjGalKcCoRgLGOD6s9Bu/Af3bReowa3B
 huC99QGa7WEPMTpTAwYKAY/NLjR0PgVnnzV7K1wLhylu2l4+72IVUgUNB6J0XQPILxwOYIj4
 OEgpM9GtFDl20Ryao6L3nJO6mCBDn0cSKF75JsUN4nm11gwwVZYbJ2AVyL7vMOVZ9NXPhV4K
 zOYnvCe1bFVx06HdHtqUHaUgrUbipMJtxRHilQFIg3RyNbCg/Y22jxX8Cg2HlsJlEQZi7orN
 zg5LVBxKIWP4yxs2JpJUVeqFlwTHxae4EHwlwYEmWCxo5NEjYARwLDR+Nph/Xz1N0pZdzlfu
 baZkSPrCGm1Os722SQ2VAhurPmLoRmdMOHdsJjPIihHN8BSjfnZbmuGam8Bqh+hCsQ07KECj
 fc/5/5+MMUXKgZJy5DWyOCmOXA4RxWNJWgESvZklE/M8acwZxnqsQWzx4uNlg+h6hAEHYJUy
 yCjGy6XaymD6Q==
IronPort-HdrOrdr: A9a23:egOSLak2wcjZomnqCNne9+HUgJfpDfId3DAbv31ZSRFFG/FwWf
 re+Mjz8SWE8wr5OUtQ4exoXZPrfZqyz+8X3WB8B8bBYOCEghrQEGgB1/qF/9SIIUSXnY5gPM
 9bEpSWY+eAamSS4/yKhTVQ0OxN/DBEys2VbCvloEuFhDsFV51d
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,218,1643670000"; 
   d="scan'208";a="9870420"
X-MGA-submission: =?us-ascii?q?MDEJjlWCrm6AI58dOy29peUc6J6X2YxQX+ucFn?=
 =?us-ascii?q?DrilDp3UI8sAWBU0a6OgluWj3stvdeBDxcyDjwUU87uTpiFDkrzbhqpT?=
 =?us-ascii?q?kMiw/O7RVlKhenzpWGdlywJT5CK/5yKXEAsfh9W6/EjHKXpTrzPu8Y5i?=
 =?us-ascii?q?SAF3/igwdGlWA5tjeKPI3rUQ=3D=3D?=
Received: from mail-oi1-f177.google.com ([209.85.167.177])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 23:20:04 +0200
Received: by mail-oi1-f177.google.com with SMTP id v75so17091285oie.1
        for <cocci@inria.fr>; Mon, 28 Mar 2022 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9qRB0II6Ytegh9oDXsqAEWbvdBJG2QMLk1XoynhcSdc=;
        b=dxqQd6nql5QXzoESlASrLi1QNkobaBAfzSkh02IyFE7xIQp9LayDWrLjad2/e4NV3e
         xhjRuCUBFwECfaR20P33Z4CpX1MdPjRdQRUuTFiOJFcKXeBjA5r+bizltdaNZWuiSWD6
         hn1f33L5SfUYyaf5iJIsYYAl/bx+r9sHzE1xKxI4L2A6dDqoobwqfBGMLODhu52x7k5D
         QHqWvOHY9zBJ3N9mSrpxkEqkw5dBK70UBub3nxP9Zqnztjjy+jv21M5JKOtmDNr9/cF5
         B5PQm8obEdKDAtVCwldxSMJh4cU1a5C9t2Aw6KmO9bB0SAvfuTQvRrz4YjkoE0rpSa29
         dRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9qRB0II6Ytegh9oDXsqAEWbvdBJG2QMLk1XoynhcSdc=;
        b=YcqN4OAu2p9mSm7NIPeMcILxm+lRBYXnacThDlCfzTReffTKDBkgwj8m/Y3jT3xB90
         fWx1m4GO11k80S6HB+EtbJfyVltUUH8Rz3uMA2CorYpbWbT0qS7q6UknLk6kEoycZng0
         igt12jzUwVYbfyQbFfWpiVk22mIkP3VKoCirXMtnZZV71kWl/FllZ0X1x3zovGU3Qtrb
         EEikGC/vj+DxjtUAWmeaBDkUW99kRH3sfmvEH/M7lKL8e50LFbelseoZ+PGypkrTzM1A
         9N1+wiYbBRQLeQvg0o7qo+rsCYmSGHTkVNH08DxXSiRqDQVl6bS/MCvUcGYZtz2t/qSl
         TvLQ==
X-Gm-Message-State: AOAM530g+Yh3r3sKGq/PDH13p40+CHcn/q007nN+wIZRD2YGhXujrRvk
	10w17DFHogxLPjDWEtX9tdQ=
X-Google-Smtp-Source: ABdhPJyfDVaw45zbC+ieRzXi6qjNPLAoCc7QpjVc07EsaBBdS2dXFzBmXSZZyWt4sD5iyArPPUtkew==
X-Received: by 2002:aca:705:0:b0:2d9:6bb6:5b0 with SMTP id 5-20020aca0705000000b002d96bb605b0mr621876oih.11.1648502402818;
        Mon, 28 Mar 2022 14:20:02 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id q9-20020a4ae649000000b00320d35fc91dsm7408930oot.24.2022.03.28.14.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:20:02 -0700 (PDT)
Date: Mon, 28 Mar 2022 18:19:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Message-ID: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 299
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/YkImfPbNOzQBq5ZD%40marsc.168.1.7>

Complement the Kernel Testing Guide documentation page by adding a
section about static analysis tools.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Hey everyone,

I think this patch can be a good addition to the documentation as
discussed in the thread for the testing guide documentation page:
Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/

If you think it would be worth it, I can try making something more
elaborated. Maybe provide some guidance on when to use each tool.
I've been studying how Linux device drivers are tested.
Here's a post I wrote talking about some testing tools.
Link: https://marcelosc.gitlab.io/how-is-linux-tested/

Best regards,
Marcelo

 Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 65feb81edb14..b00511109a9d 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
 Some of these tools integrate with KUnit or kselftest and will
 automatically fail tests if an issue is detected.
 
+Static Analysis Tools
+======================
+
+In addition to testing a running kernel, one may also scout for bugs by
+analyzing the source code semantics. Three tools are well known for serving this
+purpose.
+
+Sparse can help test the kernel by performing type-checking, lock checking,
+value range checking, in addition to reporting various errors and warnings while
+examining the code. See the Documentation/dev-tools/sparse.rst documentation
+page for details on how to use it.
+
+Smatch extends Sparse and provides additional checks for programming logic
+mistakes such as missing breaks in switch statements, unused return values on
+error checking, forgetting to set an error code in the return of an error path,
+etc. Smatch also has tests against more serious issues such as integer
+overflows, null pointer dereferences, and memory leaks. See the project page at
+http://smatch.sourceforge.net/.
+
+We also have Coccinelle as an option within static analyzers. Coccinelle is
+often used to aid collateral evolution of source code, but it can also help to
+avoid certain bugs that have been expressed semantically. The types of tests
+available include API tests, tests for correct usage of kernel iterators, checks
+for the soundness of free operations, analysis of locking behavior, and further
+tests known to help keep consistent kernel usage. See the
+Documentation/dev-tools/coccinelle.rst documentation page for details.
+
+These static analysis tools support running tests on the whole source tree or
+over a specific file or directory.
-- 
2.35.1

