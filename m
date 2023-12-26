Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F4C4706F
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=5cebwKoru6w46JtNcIdTgv4EgAKBq9AOC7czA5/Wbwg=;
  b=bBeLbZzeWeVJBgW0NDmtgClcQoVIsTn4zkdWYcK9kODKOtdkFx5hz8Jm
   2dqvfNKqsuzp6LWVN1Nv8A3BZsyCrQkewU4CPCErn9uoOb7OY1h2b0Cwp
   UWSMRAmApoTPo6qFvCiXvx+exjKXQC0MScN0lfowaSDVi+MJpat3wEFgU
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144071351"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 19:24:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1C607E0AF1; Tue, 26 Dec 2023 19:24:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 406B5E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 19:24:20 +0100 (CET)
IronPort-SDR: 658b1a53_5mHKOvHwZoC+yv1MGeHEum0GHDGeiUQZvn13/EMzGUrU5k5
 KBYJVTPyFMjiYEGR+2u1shzl+niqcBmq4pws48Q==
X-IPAS-Result: =?us-ascii?q?A0EbAQBIGYtlewwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4f1MyBAtIhFOPQYF1LWGDXYc1jDeEBIMWPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ3AYFTgnSHOAIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABASQYBg4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?2sdAQERJgEuAQUCJgJeARICAQGCfIIrAQMxB657gTKBAYIKAQEGr1gfLCJWg?=
 =?us-ascii?q?WAJgRouAYgaAYVng0GBIQ+BVUSBPIEUgi2IHoJoiRsHMoIdg1CRV30FQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgy8KgQE/Dw4Rgj5hNhlIglgVDDUEN?=
 =?us-ascii?q?RF1ECoEFBeBD24bEh43ERAFEg0DCHQdAhEjPAMFAwQzChINCyEFVgNCBkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpHzIJPA8MG?=
 =?us-ascii?q?gIbHg0nIwIsQgMRBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?xAbKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmRQdTKBNMgiqwQ?=
 =?us-ascii?q?JRBNAeCNIFggWEMnysGEy+XJg4GklMBLodQkE8gqEaBeSSBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gDBYWg3OPR0A1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NzuHvKubDI1LQtvqaOOuljrx7skDrtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHzJYVEqKRcdcLG7Sc69qBbnnqKdjrN/AV7PZniChILKFu9fBOnZrwEIcheWnoNgPM
 xbAsxD4bPLbWRSsea/xhWkGNA9x9S9/Lmvnvq29QYXcegnUcBdBxwSMHfjLqSafng/OXKzea
 D32vZ6
X-Talos-CUID: 9a23:ZMLrXG2FPLyTo1q6Ni4ijbxfH/4eVWGBiyrpMWjpB2w3cYyOY2WA9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A6Gap9QyZVfLcsuX9go0T9USg45yaqL+rT0AXiJR?=
 =?us-ascii?q?Xh5m7Bw5WIi+zjw6vY7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="75374291"
X-MGA-submission: =?us-ascii?q?MDHbDuLczKvdNLAT0Jz+4BhKzFghnjTpVafx1G?=
 =?us-ascii?q?+qDr19uLAnJ5nBjvEbEfMZhkx81BnT3QDGozF7sJAr8SKGD6/BfrxKQx?=
 =?us-ascii?q?Oc4MFLAXvinbX0R936wLaJtnEB9NYZPqrVsg4JjXG+6zpZio7bGcGd1/?=
 =?us-ascii?q?pXUdwc1zJRuha/C/N5WZYQ9w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:24:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703615055; x=1704219855; i=markus.elfring@web.de;
	bh=f/Jl+Efb4DezWv7JjmB2u06F6X9iJ9wWuCDtqZqFeRI=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=sXGNVCypFGIAsK2RhOYeKeJcBXK67emWhsnUVXWiS516ZyuRkp7swYAV0uPfTp/s
	 rf4/PxzykXj5No3yhYFHysooCljMX1Yc7znaiaz4B0eAgQGlK7rj38hdFkIiuy56J
	 bmKQCEPGLwIO4O+mSGRvEaCkSvwqoLa3xO3uTI5l0VlB/glh8EFeN13xluHtoTXxy
	 w0BsIZ/+mkgffR2WBfCDQA076d+IgxOtivut6fSRkSwrnCXSyZj59Ff5aoctIPUyd
	 KMKrodkijx2nsde3PY5Kd9a2nEIEJ/zPTRCJZKpv45nmV4z4tZai4TPMTD38Gw4P+
	 Wbu/RU5+TVUEZBtUjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvslx-1r151E32WN-00sV6f; Tue, 26
 Dec 2023 19:24:15 +0100
Message-ID: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
Date: Tue, 26 Dec 2023 19:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, linux-input@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 David Vernet <void@manifault.com>, Jiri Kosina <jikos@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K8fF/UijAIywnS52YDqNMULxk3+NZg9vn/tgRlNElb24o0WwTPy
 VrprFxvBxar+Yk/bUyDiW3oFnHnY3d9QkFy4oTSTjHa+DVPlGrkiLHcX29RQV/JRckCY7tG
 tURb2Nx0wHr7uGfDz3PyL+uKqEFOyNqfdV4m/IyWF0bu/qPDYbW3StSulfsTU4PtarOzrSZ
 thlRopo4UMn+BP4/reC6Q==
UI-OutboundReport: notjunk:1;M01:P0:ACMj+myOfk8=;jpf3JzHWCKMdYEDE/lVe892U+x4
 +ohp9E/66yrl6WArelsmeCzCtQLU5fI+nQz7+zbw8Rh7E4VS27xlSmLkUV5qOh2xnr6qIfy4Q
 3dy+CqcHiggMWvfaECy2Z6m3vxQ9Bm0Mc5dyCpzFmkQzVujDTRaSu7DIVbCNe21prKltoKpXb
 tdocUzGGyrxAtCz8mFjQL3ZDccW8JMS8bw4ZkghMy4kpgCn2GkN2sjxSiwBbHV6nX0zRsZ0op
 QbnDeY5zK23XqNZovTNe+OHJudY1lRWl6kHVDBtaUM3xAOHHLd7O1v98JfVSfXaYXJzgG4/pK
 BDshva6Z4zkX+TQxn8Ft4yehcRikfPJ0NhDQW5K3HkxykkW6o09ES8fdGs/nKA5WNdgQalVG1
 rFtwmh18kyx720dpBmhBcKqdu71ptDhEPPfdOk8mLJhlvxOvVVBH1vMBqBdDcjUY6s8J7o0Nd
 RLXVJ+bKBzm35jVdHDvLMzCUAbVJRYz6kURg7LnIPXfyXsnwUOtujb+yPPbb+1oRa4KloCizJ
 XFX0IGTJn2hIoSJOUnw0XGX7Ztpt0femIsvtemDdevZ0cAmIX3BvW2m3tjUX0g3TqmdILQQ2u
 YFg6ecDBEb0LpRy+SY5iaXrE7GKrO41zkVDwI32FG0l5Q5yR6Y/ey/onqVUyjNDdR5kERT1jf
 kt5JmgkuFbGtQt61GghABhN220XPNDtW6WjNRsoRYaqWDYcXoeim83XjKVapCm2gRt9Xyjzdn
 KBngG0gisHHl3IVS6KTFtGXXJ+lAUGsqERTaHsanM0N5Ue0UWO3obSXYryiqe+6wUB0VTX+IU
 t6FCx2S7nGCeseWuES59HYJybPKMQJEJVuSreQn2CvV9mIHPrQTyiORK4uLp+U/UWU0aTahmB
 Lhv7kA4oulJjI6g0RQA0wVC0fEzAksp+9AltVkfGI0P/MnG5P8tWuMIuVCJn7swQbV4NwKM3R
 h08qWA==
Subject: [cocci] [PATCH] HID: bpf: One function call less in
 call_hid_bpf_rdesc_fixup() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1402
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/3203eb44-6e69-4bda-b585-426408cb75ee%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 19:13:25 +0100

The kfree() function was called in one case by the
call_hid_bpf_rdesc_fixup() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hid/bpf/hid_bpf_dispatch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_=
dispatch.c
index d9ef45fcaeab..c84fe55be5ed 100644
=2D-- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -118,17 +118,17 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev=
, u8 *rdesc, unsigned int *s

 	ctx_kern.data =3D kzalloc(ctx_kern.ctx.allocated_size, GFP_KERNEL);
 	if (!ctx_kern.data)
-		goto ignore_bpf;
+		goto dup_mem;

 	memcpy(ctx_kern.data, rdesc, min_t(unsigned int, *size, HID_MAX_DESCRIPT=
OR_SIZE));

 	ret =3D hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ctx_kern)=
;
 	if (ret < 0)
-		goto ignore_bpf;
+		goto free_data;

 	if (ret) {
 		if (ret > ctx_kern.ctx.allocated_size)
-			goto ignore_bpf;
+			goto free_data;

 		*size =3D ret;
 	}
@@ -137,8 +137,9 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, =
u8 *rdesc, unsigned int *s

 	return rdesc;

- ignore_bpf:
+free_data:
 	kfree(ctx_kern.data);
+dup_mem:
 	return kmemdup(rdesc, *size, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
=2D-
2.43.0

