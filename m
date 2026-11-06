Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5E606A326
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=QxLUbMH0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:to:from:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3iBS3zV8WHqjwbVMxtCLtEp/LBn1asFltapZVO98Z9I=;
  b=QxLUbMH0mgM2LcfxE6kSMh3uieCD2YoM6ru6wz1QgV+Tig3OV+RTZ/Hc
   ER1U+6NcShoKXoN7ztHVRuMvJU1eO9nc8jcdwf7PxMdFPrRpYLtWpreaE
   SjPDMD5lnUR/lYQqQKabuLr9sS3K18Ky/SYNKy+ZVNmxEjJaOYBp1SsAl
   c=;
X-CSE-ConnectionGUID: Vn4D81GpQImJa/9nfX3+DA==
X-CSE-MsgGUID: kIuBwpo7R6OY54zwWrpwLA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323807"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:33 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DDA9D81CE1; Sat,  7 Nov 2026 11:59:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 770F2812A5
	for <cocci@sympa.inria.fr>; Fri,  6 Nov 2026 22:07:56 +0100 (CET)
X-CSE-ConnectionGUID: riOrQsvsQ+62DqhbDIkwNQ==
X-CSE-MsgGUID: JtPjp/+mQCW+6z4joWYtrw==
IronPort-SDR: 6aee41ab_/ewNo/FS5Rz7I06KgsSHtZ8rf80w03E1eBhN5ZD6VfCdaYH
 E0uxVI0auLjBAQdahc7clb22fpPQZotfKCzj+Aw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EpAgAKQe5qjXf04G1agluCP4FrNAcISYRYkXQDoB0CD?=
 =?us-ascii?q?wEDAQ1RBAEBAQIBA4R+Ao4eAh8GAQQ1BQ0BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQUOO4ZPDYwaATOCFiwNfQEBAQECA?=
 =?us-ascii?q?SMdAQEpDgEECwsYAgImAgJWBoMVgiMBBiQnB7wteoEygQGCDAEBBoJq2UuBa?=
 =?us-ascii?q?wkVgQoviGEBhhSDaHonG4FJRIRAPogfGYJRgiaBDIgajyZSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSVDA4EGI0sFLR2BIyEdFxEeWBsGBRIgKkFDW4ESgQddgSsoXQECH0YtF?=
 =?us-ascii?q?YF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxkCxoFG?=
 =?us-ascii?q?kcIAgsCDHQoERATHR4kLwUcJj4bCjZtPTcVGQSTdYNDXQGBXxFPHgs6km2zT?=
 =?us-ascii?q?4QqoV5NqnEuh12QfalEggAigVwzGggbFYMiUAMZD447g2nLCEcyPQIHAgcOA?=
 =?us-ascii?q?wuRaActgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Oc6t4qy52Kvqz3oXxa56t+fbwirEfRIJ4+MujC+fZmUNrF6WrkUAy
 zFMCj/QbvfeM2ugLdskYYiz8UoD75HVyoVkQApq/i00HyNBpOP7WeiUfxz6V8+wBp2aHRg/t
 63ySfGZcZtqFieEzvuJGuK8xZWp/fjQHtIQMMadZGYpA1MiE3974f5as7ZRqpZyhtSkCB+6t
 9r3osnOUHeowDcc3lg8sspvkzsx+q6t0N8klgZmP64S5QeAzyN94K83fMldEVOoGuG4IcbhH
 44v/JnhlkvF8hEkDM+Sk7qTWiUiXr7IMAGSvWFdUq6kjwIqjnRaPnETaZLwwW8O49m4t4gZJ
 Odl7PRcei9wVkH4o9nxZjEEe81IFf0fqeWfeRBThuTIp6HOWyOEL/yDlyjaN6VAkgp8KTgmG
 fD1tFnhx/1M7g676OvTdwViuigsBNPqG5kmoW979HKHV9o/QZrvYqbVw+YNiV/chugWdRrfT
 88QaD4qNkicOkQefE8ND445muKhh325eD0wRFC9/PJmpTKJkEorjOSraYOEEjCJbZ09ckKwr
 Wvu+mP1DxUfNceS03yO9XfEaurnxnunAt1PSubinhJsqH+P/m4LT14TbHCE4qer1ky5ZONDM
 VNBr0LCqoBpqBzwEIisN/Gim1aPuRUXWvJLAugi4UeMzLDV6kCXHAAsSjdeYdginN03QDYw3
 xmImcnoDHphqtWopWm1876VqXboZXRMdD5EfTUDUQwD5tDipMc4jnojU+qPDoavj/rvICru2
 AnJ8nISnrUZoe8IyIOCqAWvby2XmnTfcuIizi73Nl9JAyt8bY+hItb0tQGCvLBYNoGFSV+Et
 XkA3cOehAzvMX1vvHLdKAnuNOvzjxpgDNE6qQI2d3XG32j2k0NPhagKvFlDyL5Ba67ogwMFn
 3M/SSsKuM8IYir7BUOGS5qrDNgty+DpGrzYaxwgVfIXOsIZXFbepElGPBfMt0izyhZEuf9kY
 /+zL53zZUv2/Iw7lVJasc9BiOdznkjTBAr7GfjG8vhQ+eDAPS/IFuhaawXmgyJQxPrsnTg5O
 u13b6OioyizmsWkCsUO2ddLdQ5YHmtxHp3stc1ce8iKJwcsSilrCObczfllM8Zplrhc3LWAt
 HyseF5q+Hymj13+KCKOdi9CbpHrVs1Btn4VB3EnEmup/HkBWryRypkjWaE5R4R6y9w7/8VIF
 6EEX+6iHsVwTi/2/mVBTJvl861nWheZpSOPGCuHYgkCVYJqHTbN8PC9ZgC1yjgqCwypv/Afu
 Jyl7BvQGrAYdjRhDeHXSfOh9Eywtn4jg9BPX1PED91QWUf0+rhRNC36i8EoL/E2KRnswiWQ0
 yCUC0w6odbhjpAU8t6To4y5tKasTvVDG3RFE1nh7bqZMTfQ+kyhy9RiVMeKZTXsa3Pmyp69Z
 Ol6z+DOD9NfpQxk67FDKrdMyb4yw/DNpLUAlwRtIyjtXmSRU7hlJiGL4NlLuqhz3YRmgAqRW
 H+U29xkKL6MadLEElkQGVIfVd6998oowxvc0fdkB3/Bxn5T3KGGWkBsLRWzmHRjDL9qArgEn
 8YlmuArsjKatDR7E+yorC5u80a0EkchSIQi75ETP5/qgFEky3ZEep3tNRX165CuNfRJFEkTD
 WaKtoX8nL5jwljwQ1suJCKcwctcmpU8lxRYx3ASJ1myu4Tkhdkw7SJo/g0IXgdeyytE4tlRa
 0xAFVx5GrWKxBhs3PN8ZmGLHx1NIDa7637B4QIFu0OBRnb5S1GXCnM2PNi82Xww8kVeT2B9x
 66ZwmO0agTaVpj98QVqUHE0tsG5a8J68zDDv8WVH86lOZ0eShi9i4+MYVs4kTfWMfkTtmbm+
 9YzpP1RbJflPxE+u6c4UomW9YoBQSC+eVBtf6tTw7MrL0r9JheJxjm8G2KgcJhsJtvL03OCJ
 e5AG8Ztbym6hQGy9m01JKhUOLJlvu8b1PxbcJPRGGM2mb++rD1ojZHuyhbDlFIbG9VArettK
 6f6VS6zLWiLtH4Fx07PtJZlP0S7U/klZSr9/vyEz+ESM64i6MdAXFEV6eartHDEaAE9og6lg
 wfYQ6rwyM1j1oVesI/+GYpTBwiPCI3SVcbZ1CuRothxfdf0HsOWjDwsq37jJBVwAbQKfdZ8y
 IS2r9/82X3asIYMU2z2n4eLE49L756QWNV7H93WLn5IuzmrQ+7pvgU+/l6nJaxzkN9y4tetQ
 y26YpCScf8XQ9Js+21HWRNBEhoyC7XFUYm4nHmT98+zMxk61RDLCPiF9nWzNGFSSXIuCq3EU
 wTxv66j28BcoIFyHyQ7PvBBAaJjAVrdSKAjJszQtz6ZMzGSuWm8mIDezDgu1TKaLUO/MpfK0
 cqQDFy2PhG/o7rBw9xlopR/9E9fRmp0he4rOFkR4ZhqgjS9F3QLNvkZLY5AMJxPjyjuz9vtU
 Vkhtof55fnVBlyosCkQ4egPmi+aD+0Kf42lemVwrgWMcSCqA4WFCbplsCxgi5uzUiW21/mpc
 Lny5VWpViVdALkwLQrQ2hB/qeJgyv7ew3MT9Fq7mMv3a/rbKatfz2RvRWKhSgSee/wgVyz3y
 awdQGdITUW+SFX8C4BrfHs99NT1et/w521AUBpjC+ozd2lWICOsBRE/1yzOPmU/Ufk3
IronPort-HdrOrdr: A9a23:zuxLEq+8xHM3bwKMjRZuk+DLI+orL9Y04lQ7vn2ZKCYlEPBw8v
 rEoB11726RtN98YhAdcLO7Scq9qA3nhPtICOAqVN/JMTUO3lHJEGgI1+TfKlPbdxEWjtQy6Z
 td
X-Talos-CUID: 9a23:/4JJfG5YYGmncbRly9ss7k8zAPk+bGbkjymKD1a4A0pIS6KzcArF
X-Talos-MUID: 9a23:It9NGgXTRH5vXLLq/B3wvDN6c4Rt2o+RSx4fzZcBhPiYLzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,199,1787004000"; 
   d="scan'208";a="304275632"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE2gwDK0g1PY/37t/1cZRQrkq6Iol62dpEuUF?=
 =?us-ascii?q?n7XCKALSpDgQxF39WDCvEH4i14qxRBnSBB6Efb0e3HlmUGwyoaUTe9N9?=
 =?us-ascii?q?WNja9WleCBt4Yu8JldawcnCi/k3qz5jet6Oc0njpNFPjsfVMpBdKmQAX?=
 =?us-ascii?q?yq+ANFsMWg2CUUKJtdFQUJrQ=3D=3D?=
Received: from mail-244119.protonmail.ch ([109.224.244.119])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:07:56 +0100
Date: Fri, 06 Nov 2026 21:07:48 +0000
To: Julia Lawall <julia.lawall@inria.fr>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20261106210740.3317795-2-ca@modelmiser.com>
In-Reply-To: <5f30dd50-a764-8e8-8b27-5c26ad10a7dd@inria.fr>
References: <20261106193517.3267013-2-ca@modelmiser.com> <5f30dd50-a764-8e8-8b27-5c26ad10a7dd@inria.fr>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 55b28e43f2ee1046bf209bed4a35a021ea0b29c1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for device nodes
 in devm_ memory
Reply-To: Chad Aldreda <ca@modelmiser.com>
X-Loop: cocci@inria.fr
X-Sequence: 3784
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/ZO_fQO7mt3aB5JFMopSf1w>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026, Julia Lawall wrote:
> Have you sent any patches based on the results?  I'm not an expert on the
> problem being addressed, so it would be helpful to know that the semantic
> patch has led to patches that have been accepted.

Not yet. I'll send fixes for a few of the reported drivers first, and
post v2 once some of them have been reviewed, with links to them.

> The problem you have when you work on a subdirectory is that it doesn't
> know where to find the header files.  It should work better with a -I
> option.

I tried that, but the header (ipu6-isys.h) is in the same directory as
the .c file. With --include-headers, -I include, -I include/uapi and
-I arch/x86/include, on drivers/media/pci/intel/ipu6:

  --dir, with or without -I drivers/media/pci/intel/ipu6:  no report
  the directory's .c files named on the command line:     ipu6-isys.c:990

make coccicheck M=3Ddrivers/media/pci/intel/ipu6 loses it too. It seems to
come from --dir rather than the include path: in a copy holding the
headers and ipu6-isys.c, --dir reports line 990, but adding
ipu6-isys-csi2.c, which also includes ipu6-isys.h, loses it. Unless I
am using -I wrongly, is the header matched only for the first file that
includes it?

> Could you rewrite this in a much more concise format?

Yes, I'll do that in v2.

> Since you only support org and report, you don't really need depends on
> org || report everywhere.

Thanks, I'll drop them.

Chad

