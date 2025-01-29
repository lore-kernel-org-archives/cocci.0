Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6D1C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:to:cc:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FcyH+VlucP5kvmW5p8A+5e+7L6kmJYsOyBwMj5V9+/w=;
  b=vXg2WVJuF1YDSZBiuXqsbeBMWZ7Ll6c3Hq5C4vKYsdLqg7dvQIMUezEe
   iWvQ++sGvmLYlZtFMrU+eaKUUOLmD4ys1CJEm4xefgtCXMfOIVvIUn76W
   IVs+c9cfxkWcCHnYwOVSwGRpg/KfSzixFRCuM2v93JOdRwITfetz420gc
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205505350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 09:06:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D60FE0D1E; Wed, 29 Jan 2025 09:06:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EE4E0E0D1D
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 09:06:39 +0100 (CET)
IronPort-SDR: 6799e18f_8jxtE7cj1eaJCn8BS++6r57L/jmPOmB7E9zcGtDqjLqnTx6
 NyjXJMe7T79L4DUa2Xxs4aOJmf762AI5+ncOYcg==
X-IPAS-Result: =?us-ascii?q?A0EDAAC64JlngbLdVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBFOEVogdX4ZTgiGBFp0EgX4PAQMBC?=
 =?us-ascii?q?wEBQgIEAQEDBIFMgzSKdwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABASIZBw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDYEAF?=
 =?us-ascii?q?hEdAQE3ATQCGA4CNQEFAQwWARIigmCCZQMDqAmBBUKKRHqBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJCQEKgQYuAYhNAYFshEODOXonG4INgRWBO4E3dmmHNYJpgRSBH4Uzm?=
 =?us-ascii?q?SiIEgk/gQUcA1ksAVUTDQoLBwVhA1U4AyoLDAsUHBUWMoEBe4JHaUk6Ag0CN?=
 =?us-ascii?q?YIeJFiCK4RchEWEUYJDgxiCFHqBF4ZoHUADCxgNSBEsNwYOGwY9AW4HnHI8h?=
 =?us-ascii?q?AIBexOCS5MYHYN8jUmCH59PhCWEb50kl0STDgEuh2SQaiKjKH2EPAIKBwYRI?=
 =?us-ascii?q?4FEOoFcMxoIKAiDIk8DGQ+OIYkNxQRDNTwCBwsBAQMJhUiBAIlPgUsBAQ?=
IronPort-PHdr: A9a23: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
 IOp6XVa1FA7BOM=
IronPort-Data: A9a23:loHPfqMAScGs3OTvrR0ok8FynXyQoLVcMsEvi/4bfWQNrUoi0mdRy
 WAfXGnSPP3YZzChL991aou080tUuMPXzNIwTXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQTNNwJcaDpOtvra8kM34JwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGX8KEm0nd5OC3ooNI1I4sh6Cz1D3
 sYhfWVlghCr34pawZq+Q+how9ogdYzlZdxP/H5nyj7dALAtRpWrr6fiv4cJmmdtwJoURLCHO
 JpxhTlHNHwsZzVVO10eDJ43tOyonH76ciBd7lWPqsLb5kCJlFEsiOW2aoC9ltqiXOdKxBi2o
 Gj81kPhIz8iCp+l0Wef/Sf57gPItXimAdpNRePQGuRRqFaUzWcSIAYHUEOy5/i/kE+3HdxFQ
 3H44QIrpKk2sVKoF5zzBkLo5nGDuREYVpxbFOhSBByxJrT82V2rXjYvbjl6dtUm5NcYSDZ22
 3Szpoa8bdBwi4G9RXWY/7aSiDq9PykJMGMPDRPoqyNVs7EPR6lj3nryosZfLUKjsjHi9djNL
 92iqSE/g/ANjpdO2fzkrRbIhDWjopWPRQkwjuk2Yo5HxlIhDGJGT9X3gbQ+0RqmBNvIJrVml
 CVV8/VyFMhUUfmweNWlGY3h5o2B6fefKyH7ilVyBZQn/DnF0yf8JtAIsGAmdRY0bpdsldrVj
 Kn76VI5CHh7bCvCUEOLS9jpYyjX5fGwRYq0Ca6MBjawSsUoKV7elM2RWaJg9zuwyRBzwP9X1
 WazfsGrAnIXQaVhx3zeegvu+e5D+8zK/kuKHcqT503/j9K2PSfJIZ9bagfmRr5it8us/l6Km
 +uzwuPQmn2zpsWlOnGPqeb+7DkicRAGOHwBg5YGKLbSfFA+QTtJ5j246epJRrGJVp99zo/gl
 kxRkGcEoLYmrSyWeVe5eTp4ZanxXJ1yi3s+MGZ+dRyrwnUvK8LnpqsWa5J9L/Ft+f1B3MxEa
 aAPW/yBJfBTFRXB2TAWNqfmoKJYKR+EuAOpPgieWgYZQaJOfQLzx4LbTlPdzxVWViuTnukik
 oKkzTLeEMYiRRw9LcP4a8CP7lKWvFofkcJQQUH3JoBZQxjy+41hKgjarPw+E+cTIzrtmxqY0
 Ae3B08DhO/v+oUazvjAtZqmnayITdRsLxF/JHbKy4q2OQ3x3HuR8aUZXMmmJTniBX7JooO8b
 uBr/tTAGfwgnmcSlbFjErxunJkM1/G2q5B0lg1bTWj2NXK1AbZdI16D78lFlotJ4pR74QKWe
 Ea+yuN2CIWzGvHOMQAufVI+T+G5y/srtCHY7q01LGXE9SZHxue7fnsIDSacqh52DeVTC5wk8
 9cDqcRNyg2YizgWCPikoB1Q1VyxKi0nb/16mLAcWJTmmyg6+GFkOJb8MBL70LuLStdLM3QpH
 AOqubr/t+xc63fGIlUOFinr/OtChJ4xlghA430cKn+oxNfUpP8F8ydA0DYwTzUPzgRNibtrN
 lczKkcuB6Ov/ihptudHTWuDCwFMPzzH203Tmn8itnzVcFmsbUPJdFYCAOeq+FtD1XBxZR1Zw
 e2o83nkWjPUY83B5Cs+dkp7ofjFT9Yq1An9tO24PsaCRb8WXCHEh/KwWG82tBfXO8M9q0nZr
 +1M/uwrS6naNzYVkpIrGbuhyrUcZxCVFlNsGcg70vsyIljdXzWu1RylCUO7IJpNLsOX136IM
 ZVlI8YXWimu0CqLkCsgOpcNBL1Jh98s2ssJf+L6BGwBsobHlAFTjrDrynHcilMoEvJUquRsD
 qPKdjmHLH6cumsMpU/Js/t/GzSZZfsqWVTC+d6bocQzKoI7keBzcEsN/KO+kFeLPSBGoR+Fn
 gPxSJXH7u5lyI5TsZPmOfwZDheZNeHxeb+v2121uY4fa9ngDNr/7VIJi1j4PjZ5OakadMR3m
 I+s7v/2/hLhl5QnX1/Jn6KuE/Fy2vyze+5MIOfbHWJ8nyCSfOPNujwto3uZL75Nm/NjvviXf
 ROyMpaMRIRESuVjy21wQAkANRQkUoDcTLrq/AG5pNSyUikt6xTNdo6bxCW4fFNgV3E6PrPlA
 VXJoNeo3NdTqbpMCDIiB/1LB5xZIkfpaZA5du/e5CWpMW21vmys4rfStwIsyTXuOEm2FMzX5
 ZHkRB+nUD+QvKrO7s9Ssq0snxkxIUt+v9INfRMmy4Yrswy5MW8IE71Me9FOQJRZiTf725zEd
 SnAJjlqQzn0WTNfNw7w+pL/VwOYHfYDIcr9OidvxU6PdiOqH8mVNdONLMu7D6teIVMPDd1LK
 O3yPlX1Nxm1h49qHKMdv6Prx+hgwfzeyzQD/kWVfwkexfoBKe1i6ZCjNFMlue/7/wXln0XRI
 m00WGUCR1u0IaI0Odg1YGZbQXn1oxu2pwjFrk6zLBL3sIWBy+hB1fi5PPv8ulHGgALmO5ZWL
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:I1V686l6DlqNQs5Hu25S0OZvxVbpDfL73DAbv31ZSRFFG/FwWf
 re4cjzsiWE8Qr5OUtQ/+xoXZPrfZqyz+8R3WB8B8bBYOCEghrOEGgd1/qb/9SIIUSXnZ8/6U
 4JSchD4bbLfDxHZKjBkXOFOudl64TCzbuhj+XfyHkFd3AQV4hQqyl8TiiUe3cYeOCEP/YE/V
 ini/avawDPRZ1uVLXGOpDNZYn+m+E=
X-Talos-CUID: 9a23:oD2HoG2ZZaEKDrhxjUKw37xfIJsXKiP27HDrPUa4WX5HRbfJRHSqwfYx
X-Talos-MUID: 9a23:/ltrmQUxbQQQ26Dq/CbOm2s8GsFi2Y2JEGEjqatFgdHZLyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205505322"
X-MGA-submission: =?us-ascii?q?MDHxNWhVstbMz2+AEJ2x7yP5dFBj1AK0Lj0Tow?=
 =?us-ascii?q?wA4VR1rgl80INp60GktZMv3CxWJ0FQfB7sppbvoQlqlXYXEJcOBZ7bKd?=
 =?us-ascii?q?3L6EXzVKG3HKN96HC2tHky4fDZ+kCXa7feV9HGvGdrjhsjjWNDEyUntj?=
 =?us-ascii?q?Cch+Pf59bubXJyUMkEcWvRiQ=3D=3D?=
Received: from mail-vk1-f178.google.com ([209.85.221.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:06:39 +0100
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51878d9511bso2464896e0c.0
        for <cocci@inria.fr>; Wed, 29 Jan 2025 00:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738137998; x=1738742798; darn=inria.fr;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FcyH+VlucP5kvmW5p8A+5e+7L6kmJYsOyBwMj5V9+/w=;
        b=gcrFt41tYSXaizvWDuS14k5ImVao5ouzdCgtw6MtyD7dcywnaZ4GELQCxFQ8ixar2X
         UP356cWouk7aeQajU2GwUcNjthGa7ak3aVjvy+ZIt1ohEpj9ehzmOOehTj1goiSykFTA
         lKmNZT6TFK4WMM9F+0ycR0GUndE2EfJ3Rp330=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738137998; x=1738742798;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcyH+VlucP5kvmW5p8A+5e+7L6kmJYsOyBwMj5V9+/w=;
        b=a2XuMtf9C/Cz69Xn3WRVpO1+h7A3M/aLidxkfig08ggcu/eNFyAJxR0gv128a3HPp3
         P3lY6drgx5fSujD69QrPx+5+NcT/8jp5vmV5PpCEGvfaaU5tmZa6U4vLxksyZky/wJLX
         idMKZAFchOnxWrQ9SOSxHEawnmMRkmlUEUkPouTTpvplAv1JihSTnoxms8IwlluNTra9
         tMt/0+M0c+dtEhTYz9Jixjz+r4jqcft1XkcTJITzFvOt1um5AizMvOfPnIlDep5vPEyw
         eJ1qD9OaBDKiNbvP9Kn8brku+X3rsNfoV8VXFUYYwLFNubnLWLzp+lRvU9n3PtCRgfJI
         5hfA==
X-Gm-Message-State: AOJu0Yzzg1hVXSzZ42Ptx5MpVVPvPvjaf0+UB9RN5aO57p9uTANIYqyy
	zyQagpyFGd2WqKPFW2dh72mCcLPLZtjjPAQLBd4qlILxcoAvkU882IM8Ag1YhA==
X-Gm-Gg: ASbGncvkVHZirFsLKkbVBQuqA2HOtK0zTZhh/8vs1Wy1UjHfoYXAGDY5TZa+5odLufp
	rtUbBBOwItUvdxyaHB68DHVudJ/CkU0DjiR8W6MpxwOEho1VpoQhvRUGBuUOKWA5hT1e4WuPPwW
	+Pu1qNvPBvKglxeV0y85qu+6E40bt3q3I4VbudQOf/xPb/IJFMfyBiD6sWmn2svyniqXI9HCN0Q
	m9Y7HsCwgdqD5O1f6WQfwU+C4ZiDWo+jSNNeO9KCfi0A2t2+sw7aOzcdX7nltZKdTJg0K5ahroW
	dc+YGtix5goMlKjngWEzf0q0ChpPVQfGHfkQ6mOY24zPQITZ1a/jZpPqwXM7glY4gQ==
X-Google-Smtp-Source: AGHT+IFK50khhAgifSpitDSJLyVWkbYxa6S3mUoF4I0tGEENFeZwK5SNmYJxc87tRyPIg5fx4/BVlA==
X-Received: by 2002:a05:6122:3212:b0:51d:eb9b:6b5 with SMTP id 71dfb90a1353d-51e9e30a6a9mr2408091e0c.2.1738137998164;
        Wed, 29 Jan 2025 00:06:38 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51e4ebbde5asm2020023e0c.31.2025.01.29.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 00:06:36 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 29 Jan 2025 08:06:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
X-B4-Tracking: v=1; b=H4sIAInhmWcC/x3MQQqAIBBA0avErBNUSKmrRETZWBOh4UQE4d2Tl
 m/x/wuMiZChq15IeBNTDAWqrsBtU1hR0FIMWupGKt0KRsfjFcedvD+QhTa2Mc5Y5eUMpToTenr
 +Yz/k/AFZt/+mYQAAAA==
To: Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0
Subject: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script: Create
 dummy report
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2299
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250129-secs_to_jiffles-v1-1-35a5e16b9f03%40chromium.org>

When running cocci in report mode, eg:
$make coccicheck M="$dir" MODE=report

It returns this error:
virtual rule report not supported
coccicheck failed
make: *** [Makefile:251: __sub-make] Error 2

Create a dummy rule to avoid this error and run the other cocci scripts.

Fixes: 551dbd1ec7ff ("coccinelle: misc: add secs_to_jiffies script")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
index 8bbb2884ea5d..2d85dca16418 100644
--- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -10,6 +10,7 @@
 //
 
 virtual patch
+virtual report
 
 @depends on patch@ constant C; @@
 
@@ -20,3 +21,8 @@ virtual patch
 
 - msecs_to_jiffies(C * MSEC_PER_SEC)
 + secs_to_jiffies(C)
+
+// Dummy rule for report mode that would otherwise be empty and make spatch
+// fail ("No rules apply.")
+@script:python depends on report@
+@@

---
base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
change-id: 20250129-secs_to_jiffles-26756c671f0b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

