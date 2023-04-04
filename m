Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA55C6FD1D
	for <cocci@archiver.kernel.org>; Tue,  4 Apr 2023 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fdYuZva8KWG81td0wmU3w5InzWC9DD8k8oQoGCs0PnM=;
  b=DDcDlp8xdHwK2V9Yb9nFNLvs7biKgCejgJvc7eCCKBHKEOg1do3cq8C4
   NP4OKCXW7G3q88sIXnH0AEuW3B3rMpBpmLRPfT3S+jmhzr/W34LrSu2vf
   CQhloek6xg1maN3FqQusgvn6dXyDOTPuHDWMzzd1VuSgmBi47AgjovLxh
   s=;
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
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100585514"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Apr 2023 10:00:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82C2EE0269; Tue,  4 Apr 2023 10:00:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A1C38E019E
	for <cocci@sympa.inria.fr>; Tue,  4 Apr 2023 10:00:25 +0200 (CEST)
IronPort-SDR: 642bd919_P6r2mRIP0Rg1MbvGQXmlnmfvFIOAdShOfXIVSzxdsf6kNqB
 1q0+oswqsCtB5Y8/UX9zmOzsrJYoUpXthKr24ng==
X-IPAS-Result: =?us-ascii?q?A0EkAAAH2CtkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIFKIFLLwQLRoRTiB+IYoRghy6HPohqgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEgguCagoChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNyIZZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkdTPQMDIx0BAREnDyUCJgICVwcMCAEBgnqCKAEDMQesSYEygQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJUgV4JgRQtAYdIHliESYQwJw+BVUSBPAyCQAcwhGyDcYJng?=
 =?us-ascii?q?QyBHYdQhD+KT2qBNHWBIA6BPYEEAgkCEWuBEAhmgXtAAg1kCw5vgUqCfSUED?=
 =?us-ascii?q?gMZKx1AAgELdT81CQsgBlhrAiwREwUDCxUqRwQIOAYcNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGgQYLDhEDTYFHBIELfAoGS51+ehSVTR+SJp4TNAeCKoFVgVkMiGuWIgYTL?=
 =?us-ascii?q?pcJDgaSJZdwIKI6hUKBYzqBXDMaJIM2TwMZD44gGYENAQKCfI9IPzQ8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBgySCWAEB?=
IronPort-PHdr: A9a23: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
 BB5dF5R6KKd52VUj6cnc4SuxmVoJ6+IlnTAh9Q=
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:fK1IcKHCGHUSDq1gpLqENseALOsnbusQ8zAXPjNKOH9om6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK/yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4pgPM
 xbE5SWZueAaGRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="52088509"
X-MGA-submission: =?us-ascii?q?MDG3y0g+NRbL0Nc91/c8srzlfGVKSJmgWFLklE?=
 =?us-ascii?q?mRYfg5FjFpF+TzEDGQ90X4cX1etGpCd4qJhIR3G05EHPN4fRPq9sWaln?=
 =?us-ascii?q?+Htyhqfcb2rUq2XBhoLG24osWzkgfqOT1O8x6N7W7QZPT6zxW42+HZir?=
 =?us-ascii?q?FLUL4nEBBIIwPUpZf55fticA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:00:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680595224; i=markus.elfring@web.de;
	bh=M5n9mFlhCbXglBBsH0m1lI34CUJxuQdEBvKTnqPf7e8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=uXj1RvYQFNosZ+EaOyta2G28aJPAIucY9OMUwGHA+jrL5/1GksyCeS9CfWNryXwFJ
	 zcQNvr6pF4jR9yA+QrtKXNnoOiIxEnnF98myJGbHWF+kPLXFwyFdyoL1UyJl7Qm+Vz
	 bnI3sy7E2ratLqkacedPzhtMRmcP9p4CdXL7qBZWpjBhnf2PVqm565Vbqcrof0xmbX
	 G9n3gNhgSonuP6XNEtBRQXxxjcmvYKhemeWSkUVD/hnXkyIbLTnktEKH9TiN2t6JgU
	 HKZdZYSmKK1RFYcMxq1TihcNmEW4CoyXX18xqkDRZetKFd04X/LfG1rzxPKM1LXVx/
	 xMBBWoZWkKdBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1qbIho0mKi-00s5mj; Tue, 04
 Apr 2023 10:00:24 +0200
Message-ID: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Date: Tue, 4 Apr 2023 10:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgPoouMRwC0EwSM4itbhAKC5By2eUXuspLNvZZg+q1XtpCaA/i1
 IMyY7j7lRCelFjclrmPw7jkb2Qa5AWODYq8sXD8UNcXxqcg3JAgHMVKDyt21qowL/Flv/1N
 fB87Z49o3FLyj/bF5gOrwjoa0fExVa7K4EABHkonQnOgYfPyFo0XcxkRe3X4L/kWawiwy6+
 2XjGMqrVb+a0QJ0zF5wGA==
UI-OutboundReport: notjunk:1;M01:P0:vbVhmhKJ9+E=;MZim0/+UaqO3zg8tTOZF7ddfHau
 5dRGsyO9ZWZCIKnGViGpp98rkhcrgXb2muKOs3F3rNYkDuA9XZMmjvlxxxwEl9d3D/OS7cIot
 IUCKdYZHx65mY+QzeG3zntPijlluf1FQ3rPvd2sgSzklKf34O6HQWS2boL1VWxBqhWmcXtA8B
 Qmmh6UOrML8Edo3UTLg/35zCdNLHLW+AQyphPEVdeOzvBLI1RGyKJcEazaK/p6wtNZjDhOVKQ
 e0MXb5SKsY5M/aQjZXBb8HYrNFxiNwN45HiZJZeeO8vIKLz+ZFEBEezaCWx3dgPPzPCfZoREn
 48FVFffSItN6cf7YClKWztS5tHRJrfJhcFdSsRohxjOOE8xd23NaxyUruS/zojI+n7kj640OA
 sIFtdGVgUo7YCokD5axtMaZhcgurjDgP3mqp69rrZEbMntdXHONUM3DYbKtzhWE4/vOXivD3m
 uxLYh8Sf7ThZbYUboszM1iLZ7gAQft09HL36GTrFxTV2e5MpB1t0HnrfmN7ezbbSGVNYBmA1e
 20CTuV94hjFqvUAphsID0wCakWsuE8f1R7EXlYOGEYPOgkb41ti/jSv/oOaGo1xPAH+1SBDY6
 KluCggoIjOpXPvbRnVUBrlVjOztV67CumblJvtxrSsvI3pUakfyF/Ps4yJ2Vt/a3PRXtQyYWl
 +1mn7Ksquj6ue5lfZ4P4e4BXmzdAzf25kOFbeM1DHYyZf44+Cr751BFo2OWcmQwvBhtAEvnSi
 MarwRusdSwzAhQ7QrlE4Cqdhrz3t4Dt+gN0A/MIv3uewJIAGHnb1/tIgevDRZBCk8M2vKFM+q
 B3fEpd0u1XVfc6vllJQWnEcfKfF8akKmjIY3vQAtIGLp21losiCjF+LG2gHRJ3nm7IG3PE48/
 RDWdX5tlnjMst7ys/FTP1+zNxKeUmI7vBgaFAsVOrZigQQJntpXpwUpPN
Subject: [cocci] Reconsidering repeated checks for error pointers (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1002
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/8f785de5-ebe2-edd9-2155-f440acacc643%40web.de>

Hello,

I tried the following SmPL script out also on the source files from
the software =E2=80=9CLinux next-20230404=E2=80=9D.

@display@
expression call1, call2, storage;
identifier target;
@@
*storage =3D call1(...);
 if (IS_ERR(storage))
 {
 ...
    goto target;
 }
 ...
*target:
 if (!IS_ERR(storage))
 {
 ...
*call2(storage);
 ...
 }


7 source files were found where a check was performed for a failed functio=
n call
and an opposite check is immediately performed for the same variable.
I guess that pointer checks are repeated at these source code places.
I imagine that such code should be reconsidered once more and improved acc=
ordingly.

How do you think about to achieve any more adjustments in this design dire=
ction?

Regards,
Markus
