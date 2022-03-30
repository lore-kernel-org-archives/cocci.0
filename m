Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62082C4332F
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 05:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/Bthg0jq8/Diwhpq69bZsSJ8jzbwEA8PqoPE66yQfog=;
  b=JoYekJ3chMmpqIEhV8W/lIQc2TbkjYoVpmPBtnLTm5op18m7QcjsI+JD
   aEe3jLRq8yICSraiDWIfmFsw+8g3r4/rvt176erLdWBLW/kljCJpqqma2
   OSXo4nxiLGBJQYO4wn8e5PVFJ//eTJErT9bnsN0kOPvNU0fSNe8Dny/dx
   8=;
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
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29209642"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 07:35:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5065FE171B; Thu, 31 Mar 2022 07:35:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DAD27E7D85
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 23:50:06 +0200 (CEST)
IronPort-SDR: bQrpwoOwSn6vMcyitGPbZIzRp8zzDTVRZiXrHGSqZWONRGUNT2N79e3EXty+8dWl+TXiEvs0uU
 2VwdA7cbUUa6zq6HB9VVI8I+bwiWF2B2jcvqGBB4nAuVYKCdxr4uSAP6jdjHYwSs1dzHg8Aet8
 b5yN5ljzv8+mtctUXcRqXmL9yBc7thWS5cL5RUEfVq5NvXizXHOnynOMgi/zDk9OE5l+UmBh+L
 zVIo00BAKlCg1uPVzUBbRVi9WJPcSIyhR6PLYs6B/4IFjhfRMKfZqXTHZJJD/p79+0n5VpxfI9
 yQcPNPWSmRdkLvWVbYY00JU0
X-IPAS-Result: =?us-ascii?q?A0AeAADTz0RifzXSVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFHBAEBAQELAYFRVn5XKwRPiy+KPYsqkT6BJQNUCwEDAQsBA?=
 =?us-ascii?q?TsIBAEBPAGESgKEVwIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBEwEBDQsJBwgKAgUODgVgAWEDAUSBT4F0CwMxDYI1IoNsAgEDEhUTB?=
 =?us-ascii?q?gEbHQEDDAYQOyECEQEFARwHCwcigmOCZAEDLgEOoiCBBD2LMIEBFgUXgQGCC?=
 =?us-ascii?q?QaBQAGDCAoZKA1nA4FZAgEGCQEIgSoBhhABhCeDF3ongimBSIEJgTd1giFCB?=
 =?us-ascii?q?Ic7IgSZEQEBgQ0sgV9pLwNTAZEiFqx2QzAxCgYBgiFzOIFBiU+Oa4V7M5ZEk?=
 =?us-ascii?q?giEdJFpIIx4g1SRFgaEVwIKBwYQIxKBLQFzDYETMxojgQFtgUsTOwECAQEBD?=
 =?us-ascii?q?QECAQEDAQIBAgkBAQKOHTeDO4UUhWQnNAI2AgYLAQEDCZFgAQE?=
IronPort-PHdr: A9a23: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
 dursysF1V84KtEyIqPUKexCyV0C3sqz
IronPort-Data: A9a23:qyHCea4ys6nJehMMhY1sZAxRtO7BchMFZxGqfqrLsTDasY5as4F+v
 jYbWDuEPPiMZTahedB2O9jk9UJU75Hcn9NmSAY4ryA9Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yip+5WDULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 OdgpaS7UCcYBLbJlcU9dSt8Ewd6OJQTrdcrIVDn2SCS50jPcn+pxOk3SU9rZssX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThE7Eq259LwMrDZOvzvlllxCvSAPIhB4vIQ6DL+cMB9Dg1j8FKW/3ZY
 qL1bBI1PU2QOkMRZT/7Droyxf6tp3rBLAFli2iHtYwo7jLY6xxuhe2F3N39I4TWH625hH2wr
 WXN9GXRGQAfLNXZyDyf83vqiPWntSfyR4sWEJWq9/tgmlTVx2oJCRRQW0HTnBWioku3WtYaL
 FBNvyRz9u4980ukStS7VBq9yJKZgvICc+h9A9Ux8SG88LHR7ie5IFogThhFbeVz4afaWgcW/
 lOOmtroAxlmv7uUVW+R+9+oQdWaaXh9wYgqNX9scOcV3zXwiNps0U+XH76PBIbw34KlQ2ihq
 9yfhHFm3+17sCId60msEbn6b9+Eo5HISksy+lySUD/+qAx+Y4Ghasqj7l2zARd8wGSxHgTpU
 JsswZD2AAUy4XelyXzlrAIlQeHB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGP6V0PuccLZCbzNMebhr5d7ex6ncAM8vy1BpjpgiZmP/CdiSfbpHE/PBbOt4wTuBF0zPxnU
 XtkTSpcJS9CVf4PIMueSOAa3rsmrh3SNkuCLa0XOy+PiOLEDFbMEeltGALXNogRtfrYyC2Ir
 Ys3H5bVk313DbymCgGKoNV7BQ1bfRATW8qqw+QJLbXrClQ9SAkc5wr5m+xJl3pNxPQLyI8lP
 xiVBidl9bYIrSaZcV/TMCAyNeuHsFQWhStTABHA9G2AgxALCbtDJo9GH3fuVbV4puFl09BuS
 PwJJ5eJDvhVG2bI/j0cad/2q4k7LEanggeHPiyEZjkjfs44F1aZpIO8Jga/pjMTCieXtNclp
 +Ly2w7eR60FTVswAcvTbsWp0F7s72MWn/h/XheTL9QKIBfs/YFmJjbflPgyJ81QexzPyiHLh
 QmTCBYc4+LKptZtotXOgKmFqaavEvd/ThIKRTmFse7uOHCDrGS5wIJGXOKZRhznVTv5qPe4e
 OFY7/DgK/lYzltHtoxLFbw0n68z4t3YoaADklZpEXDNWFScCr16J06A08QS5LZGwaVUuFfvV
 0+CpotaNLGONJ+3GVIdPlB+POGK1PVRnSWLqPpoewP14yh4+LfBWkJXZkHehCtYJbpzEYUk3
 eZx55JMulLn0kInYoSckyRZ12WQNXhcAa8pgZcXXd3wgQ0xx1AePJHRVn3s7JeUZ4keO0UmO
 GXP1q/LhrAZwVabNnRuTj7C2u1SgZlIsxdPlQdQK1OMk9vDp/k2wBwBrmhtH1oNlk1Kg7BpJ
 2xmF0xpPqHSrT1ms85OAjK3EAZbCRzFp0H8xjPlToECo5VEi4AMEIE8BQpJ1EUQ8mYZeSQCu
 b/FkyDqVjHleMy31Sw3MaKgRzoPUvQpnjAuWuj+dyhGI3X+STXgi66qI2EPrnMLxOsv0Vbfq
 7ACEPlYMMXG2O15n0H/I4af3LUUDhuDIQSuhB2nELwhRQnhRd155dRCx41dtC+AyzwmPHJU0
 /BTG/8=
IronPort-HdrOrdr: A9a23:V1Zhqqw5iRw+c7UQqVV7KrPwAb1zdoMgy1knxilNoNJuA6ilfu
 SV7Y4mPH7P+U0ssRQb8+xoV5PwIk80maQFg7X5eI3SITUO21HYVL2Kj7GSpQEIcheWnoU86U
 4jSdkGNDSZNzlHZK3BkW6F+rgbsby6GWOT6ds2DU0BceinUc5dBs5CZDqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,223,1643670000"; 
   d="scan'208";a="29181667"
X-MGA-submission: =?us-ascii?q?MDHmr5ANflHdaeIhGVMOEnwHYDBwYTAqCBWQkZ?=
 =?us-ascii?q?0UBLNEkhZCW++35vdCzQL5KeEe6xT4hZoYm9xrA/JDIgiHIkHg5hyUsS?=
 =?us-ascii?q?oWQ6YrnMQ13TqhoShSH2VcAfEvIfM8hccjm3mtYEogxvS20qtXQUl1xd?=
 =?us-ascii?q?hfEn5EYUNF1D9t2ysMshPfRQ=3D=3D?=
Received: from mail-ot1-f53.google.com ([209.85.210.53])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:50:05 +0200
Received: by mail-ot1-f53.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso15878995otj.0;
        Wed, 30 Mar 2022 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Bthg0jq8/Diwhpq69bZsSJ8jzbwEA8PqoPE66yQfog=;
        b=Nfga8Hiai6jnPWHrcn37JnCAYeEsSoYIS9lAUi9RUj2zZYm6zwUuleYAr7hSaiQ+g1
         ezHH1BNKWxE5sAnlDb/uVvp0fX1dtnGpx8Y+6IFrxHZxQaJY2tyB3TivVEKNXAe6UIsU
         Hx99eHfTEChpbiQP+3UPY/45nATjnpWrkSQXHOos+OBwIqEa6Z/H1Cf+fmpQCy7PF/y6
         r8aMcAl4DO8EOa36fBm9jnaV19bmtTp6vEv6abQBDv+tXv1DrOf/J+I3eH28D9Ru3QoD
         ucw4pTnSDYCTLLdjqV7iWlyghBr7hm1mpL+ZqHkcsQVfU6W9/AbMFC+hyAwt5tVsgDp1
         UVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Bthg0jq8/Diwhpq69bZsSJ8jzbwEA8PqoPE66yQfog=;
        b=hC8cH51Wta5zrbx9RbYMba2W/GT21FPamuRG20ZVpsY6KxFioa/qlw3zw5ygs6j0Et
         sxF/LvjpiYguCqha1jZLXvx4rU79OT99V6MzsvviQs663fW23QFaI0Rg7euq04swfC/T
         WiBA5d70b3cH6bfksGteV5ccfakfA7NgSSyqTbDHGXNqxjqQX2pM5evnQ872ZMfbdgH/
         i7jWqxZuw6XCR/uyz31OU30APTC5KGeR6bmMSFK3fKYnM858W/cWziUQSA3NlUOF9e/x
         OicBJZiaXKF+g8glL03OIgVGcc8NA/TRwCjXz+IlaUS7b1Rh6syBLQon+hdMjiZmjIPu
         HoRg==
X-Gm-Message-State: AOAM531vL593qH0G0LT6r7GTcHOXKP+HAwOgLNaXGnqP7hkfB9sy1l+v
	xNYE6RmoL5iPQeEdKjrFdaY=
X-Google-Smtp-Source: ABdhPJzYJPepEvTuy6SmKbubOCp4UcpWJ95SWPN6CgROFQTdx2QTEQRmi4KeYdD9Ta8dyzx18zTjfQ==
X-Received: by 2002:a05:6830:2478:b0:5c9:289c:597f with SMTP id x56-20020a056830247800b005c9289c597fmr4244500otr.130.1648677004423;
        Wed, 30 Mar 2022 14:50:04 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm10535874oou.6.2022.03.30.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:50:03 -0700 (PDT)
Date: Wed, 30 Mar 2022 18:49:59 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@oracle.com,
	julia.lawall@inria.fr
Message-ID: <62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 319
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1%40gmail.com>

Enhance the static analysis tools section with a discussion on when to
use each of them.

This was mainly taken from Dan Carpenter and Julia Lawall's comments on
a previous documentation patch for static analysis tools.

Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: David Gow <davidgow@google.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
Change log v2 -> v3:
- Changed the paragraph about Sparse to make it sound better (hopefully)
- Minor adjusts to make the considerations about Coccinelle sound better
  and be precise

 Documentation/dev-tools/testing-overview.rst | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index b5e02dd3fd94..0aaf6ea53608 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -146,3 +146,35 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
 
 Beware, though, that static analysis tools suffer from **false positives**.
 Errors and warns need to be evaluated carefully before attempting to fix them.
+
+When to use Sparse and Smatch
+-----------------------------
+
+Sparse does type checking, such as verifying that annotated variables do not
+cause endianness bugs, detecting places that use ``__user`` pointers improperly,
+and analyzing the compatibility of symbol initializers.
+
+Smatch does flow analysis and, if allowed to build the function database, it
+also does cross function analysis. Smatch tries to answer questions like where
+is this buffer allocated? How big is it? Can this index be controlled by the
+user? Is this variable larger than that variable?
+
+It's generally easier to write checks in Smatch than it is to write checks in
+Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks.
+
+Strong points of Smatch and Coccinelle
+--------------------------------------
+
+Coccinelle is probably the easiest for writing checks. It works before the
+pre-processor so it's easier to check for bugs in macros using Coccinelle.
+Coccinelle also creates patches for you, which no other tool does.
+
+For example, with Coccinelle you can do a mass conversion from
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

