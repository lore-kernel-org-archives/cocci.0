Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F35CCFA13
	for <cocci@archiver.kernel.org>; Mon, 10 Nov 2025 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=b9NDKwzQQ1r9Vj7IDrX1E1oCeWjkEje+TUxH2Vdg1/I=;
  b=PED0yqYabqPbPZbJiC1FHNvVkPFN0/e8KvszwSQuZTK/FebttuuoH0F6
   kcdRRVWGJTLubP05d6OV7fHt4y0feVp2FrT2fI8Z6KoqEDbxvhZRF/4fq
   pZPQ4jcl++tq3hhXGIgj42dEg3r2i9T432PbVkvt2Y4oZdY0dx0vi3GG6
   c=;
X-CSE-ConnectionGUID: /uIS16m5ReardbRZ7vEymw==
X-CSE-MsgGUID: RyfrhMkoTdWWBosMG8i/eg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,293,1754949600"; 
   d="scan'208";a="248496895"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2025 16:10:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C25C9E0C55; Mon, 10 Nov 2025 16:10:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CB1A3E0171
	for <cocci@sympa.inria.fr>; Mon, 10 Nov 2025 16:10:18 +0100 (CET)
X-CSE-ConnectionGUID: i5Ki5PFARMqgYTlpg3ZfFA==
X-CSE-MsgGUID: RbR8zhjFRf6i6ltRohcyqg==
IronPort-SDR: 6912005a_0ZBGj0jM8v+tPaR2Wji1Z6ymVmtILsk5S83kG3n5I1YGplD
 JQjQHRvtKysG0PpMaDwdGoofIE3ouDvvavBNBfQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EqDADJ/xFpeA4P49RagQmEEGUdBlgzBAtJhFWPU4MNg?=
 =?us-ascii?q?1KPEYh5g1ICDwEDAQ09EQECBAEBAwSCDI9QAh4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CW4EsgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAg06bR0BAREnNAImAnMBAYJ+AYIiAQYQAQM2Bw0GrkqBMoEBggwBA?=
 =?us-ascii?q?QaCadd2HywiWYFkCYEcLoVugkobAQVuiFSBRg+BVUSBPIYXCwMBgiuDDoJpg?=
 =?us-ascii?q?iaBDoYnkxqBShwDWSwBVRMXCwcFgWMDgQtuMh2BJEEYcT1Xg0kiaA8GgRKDU?=
 =?us-ascii?q?YkeD4omAgELbT03CQsbBj2UdIN3EyoBAZV5swE0B4I4gWcFgV8MiQiBJpU+B?=
 =?us-ascii?q?hMvl1IOBpMFmQaOCJVghVmBfyOBXDMaJIM2CUYDGQ+SITO9EEI1AgE5AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0NgKYf5f3BYAl5
IronPort-HdrOrdr: A9a23:8J5irah+9YXHbCOoUwEcFdVP7HBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:ZhKF32zFzBcvf6b4lSoCBgUVR+MkL0Xz5U31OkCJNWJxR+anR3G5rfY=
X-Talos-MUID: 9a23:bFr/kgm7k/z8PbUetQ2NdnpYPv048aSsJnoDz5RYv9W+Mix7Ki6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,293,1754949600"; 
   d="scan'208";a="130455911"
X-MGA-submission: =?us-ascii?q?MDHhXlwB9dBuvj04/NHn3kmUK1gQJVpNhWYwhr?=
 =?us-ascii?q?b0E54UXZ2t3qOYlLyIUEOl9lDuxssGQBO+e/QtGJQumuB1A/0WiXRQBm?=
 =?us-ascii?q?d1tOJA6QavxS7Bg3JSt25w+zYFuBLWz3kwVcJODCdXAxk2yn5vzwLlVd?=
 =?us-ascii?q?x85E8MZacpfOyaIbf6nE/6ww=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:10:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762787417; x=1763392217; i=markus.elfring@web.de;
	bh=b9NDKwzQQ1r9Vj7IDrX1E1oCeWjkEje+TUxH2Vdg1/I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KFMO9gxDJLpcHJ5RTt52eDVJtgOTTo0XTTCVjRKqIRizxBI0H4XcTvK/dFxcpAqZ
	 C9Sj4Bh7sa8xhSfSyA+dbmQX9FTwZlxyqMtM+PaOpCj6ZddHfE/Sdvqh5zgi1K1eZ
	 eLDGFIjwroonNigPFNnEkIqF9xxhbqJf2zqxy+2ZRPoIlLC5FCU45nK4B44rDUue+
	 94d/cO7S1P8cRqzUSCJ1cGBIwT3oDmLPOoXSfWhH8ah5qsPut3m6KOqhVWKyEOj40
	 y0FsD4Z3AS8pP4fHCvneU5YTi93uV8/ssye1/EAyC0QgON24Kj+Ad+phuvEshHHYP
	 rPN02DO24Xr2D2MahA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidDH-1voGFD3wFb-00cqnn for
 <cocci@inria.fr>; Mon, 10 Nov 2025 16:10:16 +0100
Message-ID: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de>
Date: Mon, 10 Nov 2025 16:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y6EGPJGswdabdwBo5hzwH9MadfMZCZXPVfx0nizdWnoUec6DfSI
 Az/LBmxDVKFDhDvPOv06NW64Yu206t17iTD+xDMUyJh1X4U/NBJvaWlvjEodqwlUwErecmT
 eUvkI5bM5LWk9wzk5Iak2j40esG5PgmGIEALmxXKFYUfSz8N9COfU19pHO1kA31+j9vRqxL
 2tZJv6K8JYpxgsjol01Vw==
UI-OutboundReport: notjunk:1;M01:P0:iZ60Sym42+U=;vjubUVLLN9V6oVA0NzMjgBW5mIq
 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
 6e4gHOjFSZvfNQ==
Subject: [cocci] Moving string literals with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3156
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/a2551ccb-edd1-403c-bcd6-3f9cd5381bcb%40web.de>

Hello,

I would appreciate if another source code transformation can be achieved
also by the means of the semantic patch language.
Thus I tried the following SmPL script variant out.

// See also:
// crypto_rng_show()
// https://elixir.bootlin.com/linux/v6.18-rc4/source/crypto/rng.c#L82-L86
@adjustment@
constant char[] last_literal, literal;
expression context;
@@
-seq_printf(context, literal);
 seq_printf(context,
+           literal
            last_literal,
            ...);


Unfortunately, I am wondering about the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci combine_selected_seq_printf_calls.cocci
=E2=80=A6
plus: parse error:=20
  File "combine_selected_seq_printf_calls.cocci", line 11, column 12, char=
pos =3D 267
  around =3D 'last_literal',
  whole content =3D             last_literal,


Under which circumstances will such data processing become better supporte=
d?
http://www.en.cppreference.com/w/c/language/string_literal.html

Regards,
Markus
