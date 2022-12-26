Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EB8C4167B
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aIE5D00QMEudAVr/ZGTLkM6u06YIh7qY0R5N34syWx0=;
  b=LW3h707wKAR+bnZ5Kfy5gm4V1u+DK6y7dBPARPP33q3w5ra6mMnwjXxu
   huWVIZqnxoxKU368JcYZnGyQeJCbSF0NKBREjE3hTTaNktKM4WXinPLGQ
   dHOHq3TCH9ukLUfGwvSirxYhWYPMrRGKNW9Iyd4dqSrGAaIIuixuU+ao6
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@mailo.com
X-IronPort-AV: E=Sophos;i="5.96,276,1665439200"; 
   d="scan'208";a="85104272"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 21:44:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02AAAE0133; Mon, 26 Dec 2022 21:44:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D1276E0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 12:40:54 +0100 (CET)
IronPort-SDR: 63a98846_KC+OYeQ7Z04U7N4+z6t6gnWkuhX2jWVd227V89elr+G+IuP
 HzaoXmPX+x/wLKQjXhvptaIkOOfQFf9HRgu3fhg==
X-IPAS-Result: =?us-ascii?q?A0EjAADch6ljmA82ttVaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIsgVwvBAtFk0mCB4V9kgWEAoFWgX4PAQMBDUQEAQEDBIR+hRICHQcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEBAQEBFQkZB?=
 =?us-ascii?q?RAOBSKFaA2COCkBdYEIAQEBAQEBAQEBAQEBAQEBAQEBARYCfjkBAUsTBgEBN?=
 =?us-ascii?q?wFwTQEKCIJ+gm8DMQevJ4EBM4EBgggBAQacUyJTgV4JgUABjHGCTmmBIRYGg?=
 =?us-ascii?q?g2CUYIsiwKMMoxpCoE9fYEnDmQ3A0QdQANGMgpBNQYRSyIJGhsHgQoqCR8VA?=
 =?us-ascii?q?wQEAwIGEwMiAg0oMRQEKRMNJyZrCQIDImYDAwQoLQkhHwcmJDwHVhIqAwIPH?=
 =?us-ascii?q?zcGAwkDAh+BSiUmBQMLFSpHBAg2BQZREgIIDxIPLEQOQjc2EwZcASoLDhMDU?=
 =?us-ascii?q?IFPBIIWLyidDXsTFKYqn0SDeKEjqRMthyKPdyCiWYUFgWkKKYFcTSMVgyJPA?=
 =?us-ascii?q?xkPjiAZg1mKZjwxOwIHCwEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
 TOSEkvkeD+EkmuxP/hAGeRFjSWcehdZvdPkGis=
IronPort-Data: A9a23:kR4AnqkC+eUIktIL8GRYv33o5gySIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNDG2GOquKYGOgLt8lOd6xoEsDuJ7Xz4JjHAVkrigzF1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTres1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82MyYzx8B56r8ks15q2o4m1A5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1zB0wNINcYod10OmhP/
 vcCDD9RMSCq0rfeLLKTEoGAh+wmN8auYMUas3BkynfSCvNOrZLrGfyRo4YIhnFt2oYXQJ4yZ
 OJBAdZrRBjafTVKM1YTD9Q1m+LAanzXI2AA9wLK+fFfD277wCIu1IrKPN3uJPuLBp1yolaXv
 X72xjGsav0dHIfDl2fVri3EavX0tSfyR4sWEJWq9/tgmlTVx2oJCRRQW0HTifK+gUW/c8lOL
 lQdvCsot6k7skKxJuQRRDW9u3HB4lgZUttUFKsx7wTlJrfoDxixG2MJdSMbaIcdt/Q/RDchz
 HuGw4zZLGk62FGKck61+rCRpDK0HCEaK24eeCMJJTc4D8nfTJIb0kKfFYw5eEKhpoepQW6tq
 9yfhHJm74j/m/LnwI2VxzgraRqUr4LIVWbZDS2IAzr8s2uViKYOgYilrFTWqNhaJYCSQzG8U
 JUsntORqbxICJiMkCvLS+IIdF1I2xpnGGON6bKMN8N4n9hIx5JFVdsNiN2ZDBw5WvvogRezP
 CfuVfp5vfe/xkeCY65teJ6WAM8316XmHtmNfqmKMYMfM8MpLl/ZrHAGiausM4bFzBhEfUYXZ
 M3zTCpQJSly5VlPkWrtGbd1PUEDmnhmrY8seXwL50/7j+fOOCH9pUYtPVCUb/w06OufqR7Im
 +uzxOPXoyizpNbWO3GNmaZKdAhiBSFiVfje9pILHsbefFsOMD96UZf5n+h+E7GJaowIzI8kC
 FnnBB8BoLc+7FWaQTi3hodLNuqzDM0u/S5hVcHuVH7xs0UejU+UxP93X/MKkXMPrYSPFNYkE
 aNXSNbKGflVVDXM9hIUaJS3/sQodw2miUjKd2CpaSQ2NcwoDQHY2M7WTi22/gk3Dw2zqZQfp
 Z+k3VjlWpYtfVlpI/vXT/ON9GmPm0Yhtth8ZXaVHekLSn7QqNBrDwfTks4IJ9o9LESf5zmCi
 CeTLxQqhcjMhI4X7Oj2gbuOvtqrGbEmH25xPWrS3ZCpPwb0o0uhxo5hVr6TXDb/DWnbxoSrV
 d93/drdbsIVvQ9tndJnMrBJyake2YPel4VCxF45IESRPkWZNLxwB1Kng+9Nj/Rp7Z1Es1KUX
 kmvxIFrCY+RMpm4LG9LdRsXVcXd5/Q6gTKI0O8UJn/97ypJ/Laqd0VeEh2PqS5FJotOL4IX7
 rY9ifES9jCApEImAvSeggBQ0la8HHgKfqEkl5MdWYHQmlUKzHNGasfiESPY2syEROhNFUgIG
 QWqopT+qY5S/Wf4SEprJ0PxhbJcob8spCF1yEQzIgXVu9jd2d4y8h5j0RU2aQV30iR41/l5K
 zVpPRctJIGl3TRhtO5cVU+CRiBDAxy4/BTq6l0rzWf2cWihZlbvHkYcZ9mf3Rk+3TpHXz55+
 Lq49j7UYQzydpus4hpoCF9XlfPzaPdQqCvAoZmDNOaYFcAYZTHFvPefVVAQoUG6PfJr1Vz1n
 sg0zuNecqahCDUxpZc8AIyk1bg9bhCICWhBYPN59pMyAmDuV2Cu6AeKNnyOVJtBF97S/W+8L
 v5eFMZFehC99SSJ9z4gFfEtJZ1wl6UX/9YsQO7gClMHlLq9lQBXlqzs2BLwv0IVZul/sN0cL
 9rRfg2SE2bLinpznXTMnfZ+OWG5QIclYVTu7vHtqMEMTpIKj/FyVUQUzLGPnm60NTF/9Em+p
 zLzZK7xzs1jx79znoDqLL5xOgWsJf73V8WK6AqWsekSXejQMMzLiRwZmmPnMytSI7EVfdZ9z
 paJj/Law2LHu+wQf13CupzcCZRM29q+bNBXPu3zMnNeuymIA+3owhkb/lGHOY57q8xc6uanV
 jmHRpOJL/BNYOhkxVpRdyR6ODQeAf6ubq7f+AWMn87VAR0ZiQH6PNer8EHyVl5idwgKBczOO
 leh8bLmrNVVt59FCxI4FulrSc0wakPqXaw9Mcb9r3+EB22vmUmPoabmiQFm0zzQF32YC4zv1
 PopnPQlmMia48kkDe21srCeejUSF3k43a81d0MZ/Jh9jDXS4Kvq6wgCGc1uN32WunWaOFLEi
 PXlaWIjDSK7VjNBGfk5yMq2RR+RX4TiJf+gTgHEPCqoh+OeAYqBBLwn/SBli5uzlv0P08n/Q
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:4l2itqvxhfyKBctW9SV6y7P77skDdtV00zEX/kB9WHVpmwKj9v
 xGuM5rsSMc6QxhPU3I/OrqBEDuex/hHPJOjrX5Xo3SPjUO2lHYT72KhLGKq1fd8kbFltK1u5
 0PT4FOTPHZSXBnkMeS2mSFL+o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85078743"
X-MGA-submission: =?us-ascii?q?MDHQePZC86AG50YJYu/+vHNxW7DguKZLlgg6mP?=
 =?us-ascii?q?VcPoS2MsHiv/c9NkmlVembhsn0L+FJEfJXO0get2IKO0alpqNe2gxY2r?=
 =?us-ascii?q?DgaIj+yrmsNQIJuzudxwUIGbg+XsWjkosMvqDi3z+vHn+82nhJEHoYIb?=
 =?us-ascii?q?R1Z/ywmAJSPtvJ6o2EygetKQ=3D=3D?=
Received: from msg-4.mailo.com ([213.182.54.15])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 12:40:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
	t=1672054854; bh=QXEpXdS92hvyGJurlSR2i2Ob09JMchOtOH1qQF/RGNQ=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type;
	b=YFcMlkF869kIfoRAuQibKMOhCGyWlR5ChmTm1Z201HC+buaXPFn/O1lIdDCeu2Nnj
	 F1sd1FZNsF5a31yieEDytsnu6xR9ZlBm7rUDJN5Wf+MXzMmlxErQkq4DjOeu5GXzJO
	 5Dzncw1WMQwoltHEEkZ+8oBvq9H/8FXIYNqoE6Zo=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
	via ip-206.mailobj.net [213.182.55.206]
	Mon, 26 Dec 2022 12:40:53 +0100 (CET)
X-EA-Auth: adL/BIG9YIrbBZkyKpUv7mpvbbYQY0lB3VFfNE3VCfssviRh5dBEFeTfbH1Ia1zRCyeregw9qDTsgA9YpgLy8559XVjLxz9H
Date: Mon, 26 Dec 2022 17:10:48 +0530
From: Deepak R Varma <drv@mailo.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	Praveen Kumar <kumarpraveen@linux.microsoft.com>,
	Deepak R Varma <drv@mailo.com>
Message-ID: <Y6mIQIubjvg7aX11@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: api/atomic_as_refcounter: include
 message type in output
Reply-To: Deepak R Varma <drv@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 794
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/Y6mIQIubjvg7aX11%40qemulion>

A common practice is to grep for "WARNING" or "ERROR" text in the report
output from a Coccinelle semantic patch script. So, include the text
"WARNING: " in the report output generated by the semantic patch for
desired filtering of the output. Also improves the readability of the
output. Here is an example of the old and new outputs reported:

    xyz_file.c:131:39-40: atomic_add_unless
    xyz_file.c:131:39-40: WARNING: atomic_add_unless

    xyz_file.c:196:6-25: atomic_dec_and_test variation before object free at line 208.
    xyz_file.c:196:6-25: WARNING: atomic_dec_and_test variation before object free at line 208.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Correct word test to text in patch description. Feedback from Markus.Elfring@web.de


 scripts/coccinelle/api/atomic_as_refcounter.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index e63d52408b86..bbe5b2932933 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -55,7 +55,7 @@ identifier fname6 =~ ".*call_rcu.*";
 p1 << r1.p1;
 p2 << r1.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
+msg = "WARNING: atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))

 @r4 exists@
@@ -88,7 +88,7 @@ fname@p2(y, ...);
 p1 << r4.p1;
 p2 << r4.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
+msg = "WARNING: atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))

 @r2 exists@
@@ -107,7 +107,7 @@ atomic64_add_unless(&(a)->x,-1,1)@p1
 @script:python depends on report@
 p1 << r2.p1;
 @@
-msg = "atomic_add_unless"
+msg = "WARNING: atomic_add_unless"
 coccilib.report.print_report(p1[0], msg)

 @r3 exists@
@@ -126,5 +126,5 @@ x = atomic64_add_return@p1(-1, ...);
 @script:python depends on report@
 p1 << r3.p1;
 @@
-msg = "x = atomic_add_return(-1, ...)"
+msg = "WARNING: x = atomic_add_return(-1, ...)"
 coccilib.report.print_report(p1[0], msg)
--
2.34.1



