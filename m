Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8580CC6FD1C
	for <cocci@archiver.kernel.org>; Thu, 23 Mar 2023 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nO9UAq5syAi4OLMKIu36ONW2Qf6NwtXFql+dlIwQ2Ss=;
  b=PjX8eH3wCUa9dHS2wdcEAD1H1e0eo3byKx0i7sJ7Jebp0nzGkkEfm+Fn
   6RVSdBqajLzF/t6Yh1PUWEQ+AAo6VHENL7XB0W+xl6MZ5wQ7Y+RsA5Qpx
   gUswJpg3Jdwcp5+akOTMrssxk0zx6N54KNq4S67cq89gteVJ01ZVoojUY
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,285,1673910000"; 
   d="scan'208";a="98796767"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Mar 2023 18:31:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5DE38E0D45; Thu, 23 Mar 2023 18:31:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B037E0D40
	for <cocci@sympa.inria.fr>; Thu, 23 Mar 2023 18:31:07 +0100 (CET)
IronPort-SDR: 641c8cda_i9SK38Sq1F4jEeOZj8cl+fjA+IqBaPDJ/gg9q27jSZZpdnM
 ByVyH1oQerChBnpodp8mNvdABfk4l8muVty44Dg==
X-IPAS-Result: =?us-ascii?q?A0FZAwAZjBxkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTkQEuA4QvhyyMIYQCgxY+DwEDAQ1BAQIEAQEDBDiBU4JzA?=
 =?us-ascii?q?oU4Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBA?=
 =?us-ascii?q?RgLFwcOBQsFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kdTPQMDIwQZAQERJgEPCRYGAiYCAlcGAQwGAgEBgnqCKAEDMQeWUJwXfzOBA?=
 =?us-ascii?q?YIIAQEGgmOZJx8sIlOBXgmBFC2NBYQwJw+BVUSBPINBiByCZ4Iqh1aGe4gqC?=
 =?us-ascii?q?oE0dYEgDoE9gQQCCQIRa4ESCGuBfUECDWQLDm+BSwJkTFglBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwshBlhrAgkjERMFAwsVKkcECDkGGjQRAggPEg8sQw5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNQgUcEgQqBAQYBJiSaPQGCVRIBUjtMJg6BdpJYkkCeDjQHgiiBVYFZD?=
 =?us-ascii?q?J8MBhMulwgOBpIiAS6HLZAPIKd6gXojgVwzGiSDNk8DGQ+OIBmEDI9HQDQ7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:s2G8L69K3u6xIHFNeQ9rDrUD53qTJUtcMsCJ2f8bNWPcYEJGY0x3x
 jAZXTuCa/eMZWvxLd5/Pdu/9k9S7MLWydNgTgZorH9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f4nW8kWo4ow/jb8kg3566p4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE7MxMLn80ALwkuclmOyJE0
 vVbLhoVR0XW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV695B8+ZBfybv5kHjF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUF8QrL9fVqvwA/yiRS1JjhFfvRWOfaG8xsp0nF5
 Wv222fAV0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1ZvbEfT+GokO1gl0zSuATGcozqwen0oOBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvVONB/jFGGYS/ErObF9lteLQBEcT5bPUfoWCNfu4GLnW0lsv7YZvpOeJNZY/XwHizsh
 S+Hpm4yit3/bPLnNY3rrDgrYBr2/vAlqzLZAC2KDwpJCSskNeaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQu74uq7UYGaC0Q8+d3XEy9hL0yHzFWy3yG4hTHqFzu5fJlcFn
 WeO5FwKvcY70IWCNPAqM9jZ5zsWIVjITIm5CKmNMLKik7AoOlbP/SdyaFSW0nylmUdErE3ME
 cfzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz+7bc2kl3yPj+DDDFbLEu1tGAXVMYgEAFas+1i9H
 yB3bJfRlH2ykYTWPkHqzGLkBQtVdSRmXc6q+pM/myzqClMOJVzNwsT5mdsJE7GJVYwM/gsR1
 iHiAh1r2xDkiGfZKA6HTHlmZfm9Fdx8tH83d2hkd1qhx3FpM87l4bY9ZqkHW+At1NVi6vpoE
 NgDWcGLWcpURhr9pj8yUJjara5ZTiqNuz6gBSSeTQYaQ49BXC3Mo9/tQRvu/nIBDw2xrsoPn
 Iej3QL6H7sGHhpuPP/LZKiRzne0h3w8mf1zbWTMMNJ8aEXhy6k0Ci3T39scAdAAFgXH/RSej
 z2pOBY/ofLfhqME6/zbrPmgg6bwNMUmBWtcPW3QzYjuBBng5mD5nLNxCreZTw7SREbf2fuEZ
 9wM69reLfdevlJBk7QkIoZR1ahkuufe/e5L/D9FQkfOQU+gUI57A3+82sJKiK1B65lZtSayW
 WON4tNqAqqICuy0DG8uIBcZUcrb2cE2gjXy6dEHEHf+7gJz/5uFVhxcBAnTqSp/KLAuDpgp7
 918s+Er6iu+qCEQDPC4sg5u+V6xc0MwC5ccislCAavAqBYa9VVZUJmNVg70+M6ubvtPAGkLI
 xiVpvHwuJVB9GX/cl4YN3vE7cxCj7sg5TFIy14jIQySu9zn3/UY4jxYwQ4VfC90kCpV9v1VA
 Xd6EXF1KYGl3SZatOIaU0+CQwh+VQCkoGrvwF43pUjlZkiPVF2VClYiOOyIrXsrw0gFchd1p
 LinmXvYCxD0d8TM3ww3a05vi9rnafdTrgTiusSWL/6pLqkAQwjOo/GRPDITih7dH8kOqlXNp
 rBq8MZOeKTLD3MsjJNhObaK94Y7aU6iFDRZTOBD7ZE5OzjWWAuP1AikL2GzfcJwJML2z3KoN
 vw2Ju9yU0WR6SXfiBEaGq8GHJFsltEL+tcpW+3mNEwGgZSlvxtrt5PcrBb/oGoRR/RvjscPB
 YfDfB2SEmGrpCV1mk2ciOJmK2aHcd0/Swmk59+M8cINDIAmnNx3VEMPjouPoHSeNTV48yKuv
 A/sY7Hcy8pgw99Om7TAP7piBQLuD//OT8WNrR6OtupRYeP1Mcvhsx0frn/lNV90OZoTQ9FGq
 qSfguXo3U/qvKcEbE6BosOvT5J23MSVWPZbFunVL3MAxCuLZ5LK0is5omu9LcRErcNZ6syZX
 DCHUcqXd+BEa+cFkTcRI2JbHg0GAqv6Urb4qGnv576QAxwaykrcIMnh6XbtanpBezQVP4HlT
 DX5oOuq+ssSubEk6MXo3B26K8QQzJ7ftaoamxnZsD6FEi+3j1nEtraKed/ML93UIiHsLSo4y
 cutqtvCmNCap6zCit1U22C3lgNCF25z2IHcYWpEk+ObSFmG4KouMukXd5kLYn2Rfuoey7mgD
 AzwgKAe5ekRkNiKndgQIDguY+tHOtEzBw==
IronPort-HdrOrdr: A9a23:riXfDagFvUMwKtmJHUiYxZyc13BQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW21dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,285,1673910000"; 
   d="scan'208";a="51068754"
X-MGA-submission: =?us-ascii?q?MDFpwFmxBy2PyMp9X3QwkVUUxWA7ddT8FqBt4J?=
 =?us-ascii?q?sol+m1sMzwxPsOVxlHUwp8smAa3P/JLD7OMgOtE/qSY3FFQMZtChrtMR?=
 =?us-ascii?q?vOHMhvqeQY1xLzRAEO6D0MXcb+sekli2DVITgaVIII3OS4nhv+6CAteb?=
 =?us-ascii?q?Qt0ksCtxPC7Ksj4fkuJSdCNg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 18:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679592657; i=markus.elfring@web.de;
	bh=nO9UAq5syAi4OLMKIu36ONW2Qf6NwtXFql+dlIwQ2Ss=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=N6z243j6jC0KmjRhHBXsdR7Q2Ho8OM0s05uwSFI8ivsE5HytvlG1zTbRrrkh7ExwE
	 OYp0wUiggH5yU6Es3HaWPz5haAPmvdJrn6jdOpzJ2WHGYR3BnoTdH9XuzzBTGXbVCW
	 gMr8FwjK+reLVcA9GKj47ORLZEcheZYW59E82VB8/kiBafRAEcOem7iZ2aO4f1JWSm
	 dhlTkuWxzfzWzmgP6m1+tt3IeytTbArDk34wtugohLn+iZSlw7FKqeViJh/x//SQwH
	 E8DPyKHlNq5Sxs3pTtyqublWTwXUTf/ZDTl5TrOQGvxEuKHBeynuvEBgexzueKHDAo
	 nAXDoFw8U+4RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Mr-1qQMYc1sXD-00yNIW; Thu, 23
 Mar 2023 18:30:57 +0100
Message-ID: <6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de>
Date: Thu, 23 Mar 2023 18:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Kosaki Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y7W9wGRh0MA8/HaErHl/S2kg9rrrcBU0ZJmC+X2fEGY79dWhCfz
 Xrek+UdnaBqdZMzalIHev0W9HKB0f12wXiTfTufGJAiA5q5b5WGChSk2iWrYCTPrRjzaBdk
 iA7tkocD1yXtgLM4lxQOSHvzNQ/DVR5j+gkz2NXGy8CDpISt2YQAPfyQOlTSOPXmMvL8Pep
 EQQjtpASiD2oXp3/i1s2g==
UI-OutboundReport: notjunk:1;M01:P0:kMB+s58VCWY=;qCru+X/jBxqO3w/tT77rw50Jgnk
 w2DRfMn8GQ18abUS/6CLdF1y0vNs4ucp6xugRZQPxb82Qx6HefowMeHO3uFwTspye/Lb+0Epc
 JqMsWmk5/Aw/3pn+Bk9Tg6RjH0xogfGM1DT1Hjb4S1/nofKIb02ylddP+3A/Gxntfskg8e8zb
 m62VMzjKWQ+yzvumu9Bx0+FLXidXxvWptwpvqdwYeaCz6ar5G2ucDFZALvzv3NJmZrBSjdXxL
 i0qKa4B+VrzuMktGj304QmQuzupfMG0zEc5GfTVqGmYQetDZ99MdhZ+TgOo7N5xeyZjKI0Vii
 pbCa5aV7guDH9Olqf8GzPlt8/NxsfTIPX00X0q9+1R8UKKN+mbXBAhTppzy79vKMwPtp+CVbW
 TiMuLo6eXcK7UYer01WynVWcgZffO/DyXobxlZ7KI6Q2GBU+kBB3+Bo99O5EL8BaAFWQCp5Xi
 s2qyV9ZcchJotEBYut96DXZkEiEJ/qR0boTpgunWMNb3ft9nXLaoVymaCX+8YZDGH53aho3Fi
 frqEGYPq7JqyopdwFwu6hqoh1NreHnUSXDHBslI+WTHuL9bmMsj06SLtr8DvKdyidj+XVRpLd
 m8VNqjypJupB+5dHfaM8sKVZEvdKZplVsFqQFFEaXM2xLO7uge3qijRpiTyZS+DgZnG4BBqsW
 F8Ohri0BDKDCu3aqb6mD0JulpUohiUBLtsErgD61q7/yPXt3cHIP+P4QkTmo5kgJWLQdv82AN
 5kj0a7+Pu2jaZ9aAbU6T8cDrSG/crN8C/nvnJaJywiP19GUvksRyFdOnZXXRgYGq7CkKnywSB
 TEJwuU5r5nzlcFJYerv6SFyqGgjMAFH2bjFww2u3ZlIP9dFUrNz7f0FSDwQnm3FkpgCX455p7
 88nuc0dP7p0K+OuCX2Kxl3zJVPQda93X7mMAF5zXyCbn2S1CG1/hfj3UZ
Subject: [cocci] [PATCH] mm/mempolicy: Fix exception handling in
 shared_policy_replace()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 913
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/6e9ca062-939b-af96-c8ff-56ad485d6e79%40web.de>

Date: Thu, 23 Mar 2023 18:18:59 +0100

The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cshared_policy_re=
place=E2=80=9D
that it was determined already that a corresponding variable contained a
null pointer because of a failed call of the function =E2=80=9Ckmem_cache_=
alloc=E2=80=9D.

1. Use more appropriate labels instead.

2. The implementation of the function =E2=80=9Cmpol_put=E2=80=9D contains =
a pointer check
=C2=A0=C2=A0 for its single input parameter.
=C2=A0=C2=A0 Thus delete a redundant check in the caller.


This issue was detected by using the Coccinelle software.

Fixes: 42288fe366c4f1ce7522bc9f27d0bc2a81c55264 ("mm: mempolicy: Convert s=
hared_policy mutex to spinlock")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
=C2=A0mm/mempolicy.c | 11 +++++------
=C2=A01 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a256a241fd1d..fb0485688dcb 100644
=2D-- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2736,13 +2736,12 @@ static int shared_policy_replace(struct shared_pol=
icy *sp, unsigned long start,
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0sp_insert(sp, new);
=C2=A0=C2=A0=C2=A0 =C2=A0write_unlock(&sp->lock);
=C2=A0=C2=A0=C2=A0 =C2=A0ret =3D 0;
+put_mpol:
+=C2=A0=C2=A0 =C2=A0mpol_put(mpol_new);
=C2=A0
-err_out:
-=C2=A0=C2=A0 =C2=A0if (mpol_new)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0mpol_put(mpol_new);
=C2=A0=C2=A0=C2=A0 =C2=A0if (n_new)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0kmem_cache_free(sn_cache, n_ne=
w);
-
+exit:
=C2=A0=C2=A0=C2=A0 =C2=A0return ret;
=C2=A0
=C2=A0alloc_new:
@@ -2750,10 +2749,10 @@ static int shared_policy_replace(struct shared_pol=
icy *sp, unsigned long start,
=C2=A0=C2=A0=C2=A0 =C2=A0ret =3D -ENOMEM;
=C2=A0=C2=A0=C2=A0 =C2=A0n_new =3D kmem_cache_alloc(sn_cache, GFP_KERNEL);
=C2=A0=C2=A0=C2=A0 =C2=A0if (!n_new)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto err_out;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto exit;
=C2=A0=C2=A0=C2=A0 =C2=A0mpol_new =3D kmem_cache_alloc(policy_cache, GFP_K=
ERNEL);
=C2=A0=C2=A0=C2=A0 =C2=A0if (!mpol_new)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto err_out;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto put_mpol;
=C2=A0=C2=A0=C2=A0 =C2=A0atomic_set(&mpol_new->refcnt, 1);
=C2=A0=C2=A0=C2=A0 =C2=A0goto restart;
=C2=A0}
=2D-
2.40.0


