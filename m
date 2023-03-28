Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB57C76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Bpc+U1JZw1rig1wEi1m4daN9Z/jpZSmb05psxPUyl0w=;
  b=l6vEETBj9ShKOcoLA/Fa+PNq6vTXvmT/iCib4bd3/9aMNWtsrXk2TbkF
   DHF1pPOS7qMnP47iOctgnxGtP7bcmpIvMzItZPZSGqR6NcCV+T+mJxuM3
   vG9EQJYPzxvDuAnZThMKjI6YA+HzyWHbcSlGlSQPQhWxzClYoQTlJo7BL
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99576399"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 19:17:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6EB99E0D45; Tue, 28 Mar 2023 19:17:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FCD1E0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 19:17:31 +0200 (CEST)
IronPort-SDR: 6423212a_cPMjlKOxRtDkpCsNG/QL5cAdeYpec1YO3/w8lDuXmGR2BA/
 u6R3vHuag7cU0hBIDhJZP1SMLHcyRJLvWqpLLzA==
X-IPAS-Result: =?us-ascii?q?A0HbAgBSICNkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTkQExhC+HLIc6hGeEAoMWPg8BAwENQQECBAEBAwQ4hEYCh?=
 =?us-ascii?q?TkCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBG?=
 =?us-ascii?q?gkXBw4QBSKFaA2CNyIZZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTP?=
 =?us-ascii?q?QMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB689fzOBAYIIAQEGg?=
 =?us-ascii?q?mOZJx8sIlOBXgmBFC2NBYM2eicPgVVEgTwMgzWEC4QRgmeCKYdVj0YKgTRzg?=
 =?us-ascii?q?SAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSAlBA4DGSsdQAIBCzs6P?=
 =?us-ascii?q?zUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNQgUcEgQ18CgYBJiSdU4EOgnaSWJJAng40B4IogVWBWQyfDAYTLpcIDgaSI?=
 =?us-ascii?q?y6HLZAPIKd6gXojgVwzGiSDNk8DGQ+OIAwNCRWDbo9IPzQ7AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBgyKCWQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:ApdebK3GmVfZjijJ6iaqBwqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99576392"
X-MGA-submission: =?us-ascii?q?MDHIMTKeJ7A9NboPT0oDQx/RMiiLD3mhiPyjg4?=
 =?us-ascii?q?QxLYQ7w+HixQoTcvPNBfwpRsB1I+gf7EpZIoNQZc9rP/W5tS6Y6Ex2sS?=
 =?us-ascii?q?BYN7/arb77I6t0Odck9OjHOJK68d7x7r6ubXWueHisk7rDnTiTbUY2EL?=
 =?us-ascii?q?oM0jvOXWuK3EHy/L8N3ALB/g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 19:17:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680023850; i=markus.elfring@web.de;
	bh=w/2uNMl1KX2jgPywO6+eEF6wu8T/V/mHXVOfzRQZtS4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Ym4W9zoH3MhB5/DleBdWfBI7+aWajz1OGqsFRNNI4sORnYGRt5kLsChTgUE0hSh6o
	 oPetZeiEVllzIK2IZbXhtUJN925zhrIPQBrOSKOS0TAZRzSLBxuYTnAb0WlIaNFVnl
	 g0etg8tty/OYxxO4vCgmqK2yq6bftIzrYXwoVEcrwWvxwQzz4XysH5fhEJGnhrOmKD
	 v2zslNc6y3tJ2by8+fV/P+H92domyGUeTF5w6V9vT8F5teo1utZVb1uPn9xqlaA4Yx
	 i84B5246hCLgcQ5mEGsV4gHmbQr5yZeRlrZ8t10t90x2daNkxcMJbHbG+IYL2KZdUw
	 HO6W0PY0MAVuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1puSVO33Qm-00Unpv; Tue, 28
 Mar 2023 19:17:30 +0200
Message-ID: <7dce2d53-9066-e26d-9e4f-e923226611d8@web.de>
Date: Tue, 28 Mar 2023 19:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
In-Reply-To: <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:avmJgY1SCLe4YYARC1gqJFm0Whcsi/9f5JD+tR9ODFN8Z0nPceG
 65+dUiRGvXkxisrR0EwmXvTk+myGNST+Ntj3RD7ofu3QKo/+C1EjpEcZarZlYIqbnmVmP5G
 5oltGk209IBnqpM6S1w8+DZ/AGA53zKdbyxlETUL0W3+nOTiqipfg3++fXW9eogd0eUSnaw
 0EoVBHx6+WuoL/8neDB4Q==
UI-OutboundReport: notjunk:1;M01:P0:66mQZuA/PL8=;dZyn+kW+b6qTnrHuUhurfpacp1n
 UNjIGhmcSJKlNnrjePY61vvwywoUkMSemcHg7//Ck8xgG6ii2bGEqe024f33oFGfh9wYEEEsU
 d16jRZJKIcQsMQgy1geKk0SknJpl9Id8cqQXR5zmytnqaoPRqKr6+nq11bqe9xFtVOYL7knLc
 Q0gHbwtqbrW3JtWDPHom0+FWNs6hskuPyu2czXSgLCR3NkjAcZFreanFJQUfSWUTEM/gFyhjn
 Dttb+5jjEmhpaKKkzs+EnORON6Krk2joUw6jh+LIBxRC+LJxFcTP0ba6qMCTo97t9XodlBbST
 Pu9IRZYh4ZSt7Z99zKCL86WpRHYCq0xE9lodcxH+TIyu1+vzmwQPHUoCtLVKe949SEpif9C8R
 p8eslzwm3Tcz+1c50ENQvivnO60hybJ/mi5XW7nm2XtwqVYSW41oP6mtNmP6yyKUpEivthrT6
 mraS7SpSSiEiYcDlsT0rHkxTyakV5Oj846ahlLJLdF/1StuJRXi6n5pYfn6x6Uf4zypD0YzrP
 FCBG239MRk/3PkU/QaZ185oEUP842uo28F9euGsoQgI2IgWoK0sVBWXYdk/6WkfDIjMhtf3Mx
 a6Sq1BVp1wOWrO3vEYyjm/qRXUu2JMQK9+4guYnJrxe3UcfTfnZ681lvghwgcRsvrCrBqvMjJ
 Z6i3gQjvY8fvdtPf7IaNcmgsJqzwHhVxxXlw1QExgO/8tT1lTZYxnFdJcJE7EwACdeALqy83X
 zgBvNDzqyJAY1TTSDJ8OnTng2f0o4cQoDrr5QfxKFaBlr+aMCpTkJ14R+6aYjvaG0nvsuUv0q
 0jTo+gptpvHhyMCxsmPck4fD4FxxlQBtBinbzqrQDdS1qgaudvnwdOvjsMecin5ntcl0V/WhX
 wk2Vz7evYQs9tRCB07IOLWPZAd6xHlinxdr6ywyeBjLTRdM0kxW/WUvyT
Subject: [cocci] [PATCH 2/2] ARM: Return directly after a failed kmalloc()
 in init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 973
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/7dce2d53-9066-e26d-9e4f-e923226611d8%40web.de>

Date: Tue, 28 Mar 2023 18:56:31 +0200

Return directly after a call of the function =E2=80=9Ckmalloc=E2=80=9D fai=
led
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/kernel/atags_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 2f08ab08e68f..1c7441f3af85 100644
=2D-- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -56,7 +56,7 @@ static int __init init_atags_procfs(void)

 	b =3D kmalloc(sizeof(*b) + size, GFP_KERNEL);
 	if (!b)
-		goto nomem;
+		return -ENOMEM;

 	b->size =3D size;
 	memcpy(b->data, atags_copy, size);
=2D-
2.40.0

