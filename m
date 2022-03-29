Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F195C433FE
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QpqqAPwXMV7VT51UYWKaBPgknrObFDs8Es/GevAG7kU=;
  b=hbkAQkmVoYtrx9w0/bg0dVfNG90pGESRWSkVne2CiNb8FNWkjR/VjAE1
   juyQfK3Xyea9ulQlD9g4obyZqHo0wwMBb5t8QZgJluVcbSknPFPhTkfrb
   aIm6iSikYBjwA2GRBELpr0yOSlz4uld0bJAXv+26QFsZriqhS/JXQmgQA
   s=;
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
   d="scan'208";a="29007457"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 08:39:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A6A0E7D80; Wed, 30 Mar 2022 08:39:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 466FAE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 01:22:40 +0200 (CEST)
IronPort-SDR: cr5RLSCzS31SdNPBZ2CK5X4x+c381yza+XVUXlF8R3+SBROFFx/+0htq6QkurKrLwPwPu3q8xG
 hcdaK1M9SMS36nz7YLCRI/fjYIxmPyeolEdJafLsNMzRxx1v6/ihhcEzH+h+cYcJ1SqasksYAb
 N9VccPNMYC3J2YjAtDoJFkGhGLlcL6BvUO9FGzaQHnuhp8qcYJHmCrrlw4AOOo/NGQQY2rw/lf
 K7HLUFHE0MoOoBeVSZvr6fnWZGOGlXTu1aBUOASnyv0/IkSZqLoYip9sDU+SbGXHDnHHRkPFb0
 lXBfQmi6qTNAP3tbYNbxfG0O
X-IPAS-Result: =?us-ascii?q?A0BfAAAJlENif7OnVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYFRVn5XKwRPiy+BS4hyiyqRPoElA1QLAQMBCwEBMxAEAQGFBwKEU?=
 =?us-ascii?q?wIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBDQsJB?=
 =?us-ascii?q?wgKBw4OBWABYQMBRIFPgXQLAwQGJw2CNQyEAgIBAxIoBgEbHQEDDAYQOyECE?=
 =?us-ascii?q?QEFARwHCwcigmOCZAEDLgGibIEEPYswgRcFF4EBggkGhEkKGSgNZwOBWQIHC?=
 =?us-ascii?q?QEIgSoBhhABhCeDF3ongimBSIEJgiyCIYgBIgSXfj8zAVMoEwETFyECMiBZR?=
 =?us-ascii?q?4E5AZENFK1PMDEKBgGCIXM4gUGJT45qhXszhUORAZIDhHSRaSCMeINUkGsLh?=
 =?us-ascii?q?HwCCgcGECMSgSx1gSAzGiOBAW2BSwlFAQIBAQENAQIBAQMBAgECCQEBAowug?=
 =?us-ascii?q?W8MFhWDO4RZhh8nNDgCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:O8tyW60W3fRNE4ZkjPbD5T13kn2cJEfYwER7XKvMYLTBsI5bp2cDz
 GsdUWmPPvrfMGr2fN5+btzloEtS78eBndNqTQBp3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX6
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt49/6
 9V9lZyiciQ0AfX2lcccECMADz4raMWq+JefSZS+mcmazkmDdHq1hvs3UxBwMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmezkDLAz16zPL+GzVG8bknRp1zrUCfFgWpvDRqTW+YZw0zI5h8QIFvHbD
 yYcQWs+PUybPEEn1lE/NpYEse61iGjGcxJIl1mavY8R2jTUw1kkuFTqGIONJobiqd9utk2fr
 WnH13/oBwkTct2Z0zuMtHy27sfLlDzyXIY6Bry9/ORjxlyV3G0aThMMPWZXutG8g0+6HtVec
 gkao3V/66c180OvQ5/2WBjQTGO4UgA0BNRzE90a6BO26bfruzyUJWlHdGZdd4lz3CMpfgAC2
 liMltLvIDVgtryJVH6Qnot4SxviaUD5ykdSNUc5oRs5D8rL+9tu10mWJjp3OOvk04ytRmuYL
 yWi9XBm390uYdg3O7JXFLwtqxmloITOSGbZDS2IAzv9tWuViGNZDrFEBHDe5PdEaYGYFxyP5
 SdV3ceZ6+8KANeGkynlrAQx8FOBt6vt3N702wUH83wdG9KFpSfLkWd4vmgWGauRGpxYEQIFm
 WeK0e+r2LddPWGxcYh8aJ+rBsIhwMDITIq5Bq2EN4cSP8gvLmdrGR2Cg2bAjwgBd2B8wckC1
 WuzLK5A8F5GUfQ2lWLoLwvj+eZzm31mrY8seXwL503/jeD2iI+9RrACP1+DBt3VH4vVyDg5B
 +13bpPQoz0GCLOWSnCOreY7cA5XRVBmWsieg5EGLoarf1s9cEl8Wq+56e17J+RNwf8O/s+Wp
 SHVZ6Ot4ACg7ZExAV7aNC4LhXKGdcoXkE/XygRxZA7xgCJyONzHAWV2X8JfQITLPddLlZZcJ
 8Tpse3ZahiWYjiYqTkbc7fnq4luKEaiiQ6UbniqZTE+e9hrQAmQoo3oeQ7m9S8vCCurtJtm8
 +fwiF+DGZdTFR5/CMv2ae60ywzjsHUYntV0VRSaL9RWfnLq74U3eTf6ieU6Ip1XJBianmma2
 g+aDA02v+7Ip4NpotDFibrV/YisGup6WEFdGjCDv7qxMCDb+EulwJNBAL7YJ2CDCDus9fz7N
 +tPzvz6PPkWp3pwstJxQ+Rx0KYzx9rzvLsFnAlpGXP8aV70WL5tJ3+x29YW6v9Ay7pfjguBW
 kyV/+5cN7jUatjuF0QcJVZ8Y+mOiaMUlz3V4ahnKUn2/nUrrr+OUEEXOBjVzSIEc+ozP4Qiz
 uMs/sUR7lXn2BYtN9+HiAFS9niNfiNcCfR57slCDd+5kBcvx3FDfYfYVn387qaJZogeKUItO
 DKV2PfPiugO3EbEaHZvR3HB0fAH2cYLsRFOiVgDfhGHw4WUwPAw2xJV/HI8SQEMlkdL1Od6O
 25KMUxpJPXRo2052pAbB238SRtcABC5+1DqzwdbnmPuSUT1BHfGK3cwOLrQ8U0Um46GkuO3I
 F1FJKfZvTfWkAXZ2yIzXQtiqqWmQ4Uup0vNn8eoG8nDFJ4/CdYgbmlCekJQwyYLw+to7KEEm
 QWu1Ol1YKz/cyUXpsXXzqGEgK8IRknsyHNqGJlcEWBgIY0YUD630DmKbUu2f6uh4hAMHVCQU
 6RTGy6Ea/hyOOtiYNzW6W7g7oKYRMIU2ec=
IronPort-HdrOrdr: A9a23:6TqMkajIczGT3KfaznK8De8HiXBQXvcji2hC6mlwRA09TyVXrb
 HLoB0+726PtN9xYgBapTnkAsO9qBznhP1ICOUqTNWftUzdyRaVxeJZnPPfKl/bakvDH4dmvM
 8KE5SWSueAdGSS5fya3ODSKadG/DDoytHMuQ4c9RtQpMNRBp2IIz0XNu9TKCNLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="9990374"
X-MGA-submission: =?us-ascii?q?MDH7+sqjmgPTXytjXVdpZutP0FQgPs9rXfNNB0?=
 =?us-ascii?q?c/YC1qXbObHeCAJ5i8xmmKhg1PKt+bLJfmyseeeN63TSsyRgeLygFR8T?=
 =?us-ascii?q?g9AcQDaNVxvNe/ptdTNpilrsUQXauZ7Myn3i502QP1fhk/Y7Qt2d7l1L?=
 =?us-ascii?q?HvmHGJ3cxIu6S6kbtvOm/qSQ=3D=3D?=
Received: from mail-oi1-f179.google.com ([209.85.167.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:22:38 +0200
Received: by mail-oi1-f179.google.com with SMTP id r8so20550242oib.5;
        Tue, 29 Mar 2022 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QpqqAPwXMV7VT51UYWKaBPgknrObFDs8Es/GevAG7kU=;
        b=VcDxO8qvQWw5GbBfG73UfmNJXuF5cW5bBU2Mxd1Ye0e/wAvQp0V/4uLuI9mi4aFOvi
         8rLVNAbCFXzaez+GOUvJnkbmxtauuKUojy0PS5ee1RKtoNiigjLsy6sZkBcJmlhp06gz
         LspK2FG0NrGx7KMkZW+F2leRMEOMmE+yor5d+5hVYOG/5B4IjN5iItf4xKBh8aSKtfMd
         XaL5FtVJ7KOHhye0b0JeiMuBmswZjq1bh5O/25ODjo1cWhQCtI99+462rOWTj3H5zNBT
         V2y2a/6TVQwwdVjfRXPfdrVXKpUWZ0/092pGazQtTP0t7MCCAZ07srzkIYxxNstGGMVo
         X07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpqqAPwXMV7VT51UYWKaBPgknrObFDs8Es/GevAG7kU=;
        b=rK/sJaI2HwpcXEmqfOc1HWgiX2V8oGWNGOBjoJ/WZYaDONwMTOt81aI6a6Re3fiiyD
         F1PwP+OOzwQCNC0j3QBYV+X8mDZQdVFzOtYDrn9w/ZgjyU5fay928iB6DH/sV7VBTmXg
         JVwubHTOwYgWqZXp46JtdT+o+FMxRopy832y3xZLdqrM6dZv8SD/lzMX/VlwJdP4uS61
         ws/0c7E9rzDbJFCPQJu2vKOdWJ8cG0GWUu/CEE4iNJiHt75MMWsZo9mHzXe7FQhfuLvX
         xr2/+o+qOPXwNtgqI7U6+J3O0zMVUui8fWVdb/9fgOEm3+/UsGbIl7Y3jYcjtUA2YArS
         yDuQ==
X-Gm-Message-State: AOAM532y8fVaM+HTqM2F4zBI7yFp54qbepLjYKmBjlOst2wE0EiZwtNj
	eWQcng1zmDvfVi0j6z0jvpE=
X-Google-Smtp-Source: ABdhPJwLwdyr0zHskTf4h5I0h/Ib3yG+ow7VZ1snYhxwk9oPN1BT/f87G57+3qxMYvrf++beR0LDkw==
X-Received: by 2002:a05:6808:140b:b0:2ec:f41e:a4c6 with SMTP id w11-20020a056808140b00b002ecf41ea4c6mr674496oiv.17.1648596156540;
        Tue, 29 Mar 2022 16:22:36 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id u22-20020a4ae696000000b0032158ab4ce9sm9231964oot.26.2022.03.29.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:22:36 -0700 (PDT)
Date: Tue, 29 Mar 2022 20:22:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@oracle.com,
	julia.lawall@inria.fr
Message-ID: <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 1/2] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 308
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1%40gmail.com>

Complement the Kernel Testing Guide documentation page by adding a
section about static analysis tools.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
Change log:
- Brought generic tool characteristics to the intro paragraph
- Made explicit that these tools run at compile time
- Added a note of caution about false positives
- Updated Coccinelle info to make it sound better and be more skimmable

 Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 65feb81edb14..b5e02dd3fd94 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
 Some of these tools integrate with KUnit or kselftest and will
 automatically fail tests if an issue is detected.
 
+Static Analysis Tools
+=====================
+
+In addition to testing a running kernel, one can also analyze kernel source code
+directly (**at compile time**) using **static analysis** tools. The tools
+commonly used in the kernel allow one to inspect the whole source tree or just
+specific files within it. They make it easier to detect and fix problems during
+the development process.
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
+Coccinelle is another static analyzer at our disposal. Coccinelle is often used
+to aid refactoring and collateral evolution of source code, but it can also help
+to avoid certain bugs that occur in common code patterns. The types of tests
+available include API tests, tests for correct usage of kernel iterators, checks
+for the soundness of free operations, analysis of locking behavior, and further
+tests known to help keep consistent kernel usage. See the
+Documentation/dev-tools/coccinelle.rst documentation page for details.
+
+Beware, though, that static analysis tools suffer from **false positives**.
+Errors and warns need to be evaluated carefully before attempting to fix them.
-- 
2.35.1

