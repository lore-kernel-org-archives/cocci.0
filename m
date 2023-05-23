Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4090AC77B75
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=KQWZiErfTWjAy6g2KlvwW7HYzN+3L6Oyncuebzf+EYc=;
  b=qyvFkHDXgV+Ps20sXyyJ0UMUkEYub7HRzUntJnz4S0GAT4RZXkbd0kbb
   zAvnT+bTpA9jFpOpWil2w8jqej/YcLliV29c9RQCALfOTxwr1iWAmsYUy
   q5dD3D5JsB2G/dIiAJntzRKItq6HbjRAMK3Sl2E2HeTcolGqoWLF3Eh0R
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109317010"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 22:11:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5916E7316; Tue, 23 May 2023 22:11:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1184EE00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 22:11:46 +0200 (CEST)
IronPort-SDR: 646d1e01_mgzxtC0FMk5f0rGEzCTP2iBgM1tZGoj1YYmLz+onkyOMI4j
 BNRu6M/lr2zvFhi5YWtz6+nliffb2JjwzzYmYdQ==
X-IPAS-Result: =?us-ascii?q?A0FTAADlHG1khw4P49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YIueFMwBAtGhFKRCYEGg16HMIdEhGeEA4FWFIEsPg8BAwENQQECBAEBAwQ3A?=
 =?us-ascii?q?YRHhV0CHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?2gdAQERJgEuAQUCERUCXwEMBgIBAYJ6gigBAzEHrV2BMoEBgggBAQacDR8sI?=
 =?us-ascii?q?lWBXgmBFS0BjBOBGYM3gSEPgVVEgTwMgzaDfYEGgxyCZ48tjQqBMHKBI4Eog?=
 =?us-ascii?q?QICCQIRZ4EOCGaBc0ACDWQLC2yBO1pDgWkCAhFCDBUEAVgCgQQQARMDBwQCg?=
 =?us-ascii?q?Q4QMQcENwshBgkdNS0GXQcvJAkTFVMHhCsDCgonJQQOAxkrHUACAQs7Oj01B?=
 =?us-ascii?q?gMLHwYmHwKCAwSBCXsHJCSgM4EOgnbDcjUHgi6BWoFdDJ8WBhMvg2wBEpMSD?=
 =?us-ascii?q?gaSKi6HNJAnIIIvpWGBZQE3gVwzGiSDNk8DGQ+OIBmEDY9IPzQ7AgcLAQEDC?=
 =?us-ascii?q?YVGAQGFfgEB?=
IronPort-PHdr: A9a23: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
 JdcEtezu3QqG/lcBkk3RbQ/
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:a4mZr6gGni73eh6iZfGHpU6r83BQXgYji2hC6mlwRA09TyVXrb
 HNoB17726NtN9/Yh4dcLy7VpVoBEmskaKdgrNhRItKPjOW3VdARbsKheCJrlHd8m/Fh4lgPM
 FbE5SWJ+eQMbEQt7ed3ODXKadC/PC3tJ2PpaPz/k5Qdi9DVo1Bwm5Ce3ym+psafng6ObMJUK
 a53KN81kGdRUg=
X-Talos-CUID: 9a23:M+Aac2xHQNwkXNdFzRt+BgU1Hpk1fSfx/UvtOkblKmdHbeDPakK5rfY=
X-Talos-MUID: 9a23:AIPuPAu5TTMv5flZgc2nrgx7GOtN6v2SGR5du7cnhOOZFhJ9NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109317007"
X-MGA-submission: =?us-ascii?q?MDHhSinSdEbmXS3Umnl2vrXzEArH/m5uhYnwRP?=
 =?us-ascii?q?QyVlRWVUiAsfIZJgirWF8qBYUcZkD02KU5T2DELONpVLhN6FTChtgPN5?=
 =?us-ascii?q?tp69z/WElUE9XLBiQ6SgZXuFyzNaNLiviMJOdMpLhbthhryEeQqj1FCc?=
 =?us-ascii?q?KhTPafIS0QHsqZIF2a1W//Pw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:11:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684872704; i=markus.elfring@web.de;
	bh=2UBgmsE0lRTC4ZZw+6pft99nQduDiYt00H6BWryB1fA=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=KbwmiGqCtUYZn2aFTU1etm4r+bTxyrdpEPkct7b0gAsPUrAXG73nD+OBquqU3rttb
	 H0BbHCDb5EdCy9ESKeH6wVimnkukBd2oCoHnPaz3bMWeKoeXMMpjLDy18kADCRgR/q
	 lxkyvG3xyvlA2LiyxUdqCvSN8zlr7NZTJz8jtOVmuNkC4Xdz+CFD8j37vQkTg2dSMj
	 UPs8atKCLpy9p8E7WA4s92otN7OvRIm5T9UtJmbjdhD5p0SJ30LrTsBmIlEwpfjqde
	 QG7k46yBbo1082+8QUZgP6UdHs8T2eHbGPh7bv1CeL/PX8epouwGqcgU85yBURtNRo
	 +wO7LDS1/AH+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1qH9Oy1d4y-00tFb5; Tue, 23
 May 2023 22:11:44 +0200
Message-ID: <8f0bcb48-7677-340d-282e-27f6fe063c6b@web.de>
Date: Tue, 23 May 2023 22:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:13H8L4N2THdC6lDo4SsbF7dg+eEyup1yxyOJ/lNpE3HOJu35xcu
 G5YwtBEwwHOILFjqlqRUiNiSpgLWXA/9lfGvkyuddv8GEd1lOa3eBo+lTpsynRvPncFa0Da
 rCnaX9lNPpwZqWonDQBrte+lIs59xgokwAfpeSdGSeRhCh+M1VaC1s+BO7NI5GBTPG0djWm
 YgV+q3LOw5OT0hh/xr0cg==
UI-OutboundReport: notjunk:1;M01:P0:lStSMXX01mA=;iFegeRwYjnKoA43MAWuIE53moSB
 13QR9/zkKdQW8nJEsXECaKa6Xqy1PVVPxrwmvAKa6jLlPWBqi+gQiOtTpFnhUx+1ckp+OlQ6K
 vWdAtmNuTTBiJ03loxBLJuWsW+Kg8do5A8tJoV+eTZzF6EMqki2yufpjUM4Bkk0FySG880ie2
 6RvBx/Co68PHSe8kY/6Qkfb0N+hS+gdAe/evKFnb22WfVtIYPudjrz2kmEnbVSVIaVz2FpdQk
 SswTpUzKxXAdHX2EykKgR7ooIwF33GYc/VYm7Q8MsVhCAZ2DMco9Xtgq73CKnetBC7jJeekGb
 VEwOzG5XtmE+QMNXZQmEr44aX4gf45a/gkVymnW9VriNsAwnZlNe9dy3eahy2P8C9mPZpOdoO
 KB0R2MYOLmR0febDMLPdnAFn1M4Czl5x1o/SCJBYAv5N21/1yfWn0VSsjFB4PsP2NMyVB2dRX
 e8dyskr2V53eWusbnMKGPJv5ggSwboP/LC98BVOe71iSN//jvolrh79Sj6glmZ2lsRy4qHSso
 M/WRk1bc9tkoBcKU7DDVyl/LZ+Uf4RbdJxhDxNfZeo5Fs9/9hWChQbAg2HY0V0ueuRzTWpd+K
 mWtj7FQGRUiu+JMzUx9Abvzfv0/7iqti7+DMq3kz51SOXLO1ydO+u88PINuL7jiJcoJY6AfHC
 ZQCSk8dSR/l2+hWj9edhhEAfeeuLagVefSIJQ25K7/ot6ZgRzVkgNe7ESzJ0Ncgar/iIcdAS2
 sAozOct1u/BrSWfHIPlopljZb1pdS/NJ1tiZWpitXnhAXSNW4hyYhzNLOuaPmPyK7gNZMAt9C
 MWcxKXdqeE7LV9bDth5x0vNHQbtkWEWbx+56lMTSCF1/bm0fpmJ27WmqKQv6pQAlwZ6wrV3VF
 3BVVpqhH//EzhXeWK1IWIXFEz6RZbakGx6thMr/ANaHzVF1YGctLUMQ2cmpYBU+EpYsjxi+Bj
 hzk52A==
Subject: [cocci] [PATCH 0/2] fbdev: Adjustments for fb_alloc_cmap_gfp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1152
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/8f0bcb48-7677-340d-282e-27f6fe063c6b%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 22:04:33 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Move two variable assignments
  Convert a variable initialisation into a later assignment

 drivers/video/fbdev/core/fbcmap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

=2D-
2.40.1

