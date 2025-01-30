Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3DCC0218A
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KfcyC7Wn0FvAn3TlvSq5YYbu5VmRp6G/vS38WWV6yzc=;
  b=FbHxhswOCSBHjRKyidLudq5xNMlEg0tL1ApaVKTghfgMSBtU6L4c2h0E
   CbT7yHu4xttOPIts/RYEaAXoJGhrIFwQsssIbPa8jxaYUHNrfaymBbOzm
   1Td+2X/092lMfUyUtR8wiCYNFAjOk/baMFauIilMR8FuXWV5CXqOXno1z
   U=;
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
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205810821"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 16:30:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54673E0D1E; Thu, 30 Jan 2025 16:30:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D17F3E0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 16:30:37 +0100 (CET)
IronPort-SDR: 679b9b1d_2rjS1WhR1Xa75NVr8lLhMbg0YEhG6jG+idbehPy2hrNSGg8
 6k/SOmO5F1nMC+iX9UkjEnqE2J3ht/ueJ4zT+1Q==
X-IPAS-Result: =?us-ascii?q?A0E6HwDAmZtngAwR49RagQmBU4JEgVczBAtIhFaPT4F0M?=
 =?us-ascii?q?IQ7hzuHVYpMgX4PAQMBDUEBAgQBAQMEhQACinYCHgcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjBBkBAREmAQQLCw4MAiYCAlYGFQEBgn6CMAEDD?=
 =?us-ascii?q?iMHt2l/M4EBggwBAQbaWx8sIleBZQmBGi6Fa4JjAYpiJw+BVUSBPIJSMT6EQ?=
 =?us-ascii?q?4NbgmmCM4RMZ4lziHeObVJ7HANZLAFVExcLBwWBKUgDgREjgSYFNUE6gg1pS?=
 =?us-ascii?q?TcCDQI1gh58gitrBAWBLYI9hEWEUYVdghSBZQMDFhABgyd4HIJWHUACAQttP?=
 =?us-ascii?q?TcJCxsGPZ5AhRSDI6Jtom80B4I4gWaBYwyfXAYTL5dEDgaSe5h8qS2BbgIxg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OLRaEC8d5QjU8AgcBCgEBAwmFRgEBijuBSwEB?=
IronPort-PHdr: A9a23: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
 DTfpJhirgP/+tQ=
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:j1mEeqOqZflYEMBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:e7biZWMB1ZcO3O5DcgNm2VYTP+8fc17ayVz3YAygBENPYejA
X-Talos-MUID: 9a23:F6EaHgmmljgHIo8lEIB5dnpoav5a7b2WFnlUuqg64/e0NilPABSC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205810782"
X-MGA-submission: =?us-ascii?q?MDE2R/1jVPlF0RgrjD8Zp4kRSY0hISMZRhvKJL?=
 =?us-ascii?q?SCuBp/3IQV26Giz0FUR0iLp2fB6jG2EGDraxYMPlusO7A+eFUA+CDjBj?=
 =?us-ascii?q?H6qb54pP5m/IQm24IYTPOBng3XJ3vAD0IXh+LAqgow/rJYsQcBLP5UfG?=
 =?us-ascii?q?lJT2MyKyV5oW5InqyCM+i9sg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 16:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738251032; x=1738855832; i=markus.elfring@web.de;
	bh=KfcyC7Wn0FvAn3TlvSq5YYbu5VmRp6G/vS38WWV6yzc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MeCxgvHjC7Is9lRAOkMtaVUn6LLUb2gHFsNsgsUzIgDhnmypA00fbkvV14Udskuy
	 STEELXTyzRNbe0NGVmdQ0KMfUpbXYmAwb6u2JCKxUeVvycBwrbK/d6BvVX/CdVNF1
	 7iIjVpLiBQwyY5+46tN0z9m8RKoueQeJ9h3lI3Nm8IqCln50ZCJvSYdxoHrV9w9Iz
	 sDcqfIO4Q2NBmRXwSKQViD0fKsrOdkMNHbzD5BZELfMtS2k1StnlyJFYhLg+H0lgI
	 LflrPtJcaVEs8RFuWNRCbW3Nz6uX4gvPgyWqmrOjAVyFEwqEO2v9mT8lGPFp87176
	 DH2HS3IZ+j78X84vXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1tjb2w0ey2-00CuXk; Thu, 30
 Jan 2025 16:30:32 +0100
Message-ID: <1e4a54dc-2ca2-438a-bcf0-362e61d4eba5@web.de>
Date: Thu, 30 Jan 2025 16:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Maxime Ripard <mripard@kernel.org>
References: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vQ22teWOI3/jx+1SDSGU2wKigIfvL9ledhtZK6k/Rg+iyTgkM2C
 fpHffMEZ+9zh9w3hXs18txbNEqNdWmTwymCjeCQawAhs2OIqoFVHJ5gZbRqVBRJGu6gYFQj
 5UT3/oRFPlnmnkUIQj7ugxnsnk/m1ZRopw2xWBx13WwMNlIgRdcKVwnTT5Azg00m68KIRml
 bUvyrK0AUqWS7R8IZEOSw==
UI-OutboundReport: notjunk:1;M01:P0:1bllh0URp5A=;VS6Xdfq4rgjTTvHG1NGd3k0dNTP
 BIBV+7+V6bLDde/SiYSyXr0YQd8LEBSookAQAnI6Er5h7Oap0ZfMfLsgMwxVqgo3OHl47ldbk
 lXivpoGcIm/bbSRK+DQcpzqxHwNLgh4k2Ho3+Egn69E7ZvtBUaXncTlb4icSmA0cpGt9wHQEg
 Bl4r9LfnR1nrl+nUEr8NGMG9jJFfmiMp/ktKsYe04UUXFF/IOnG1Q2mehmO47ff+ziGl0om41
 U5qcDnJbfTUsot+o1XflnVvrKtoT2s5G+jpcMfwb4aULsxtLvs0QyJeU1ox8WMyDqVVvZlYOT
 95eghmVRLDBofY+z5tvFt79leYSH+95t4fdd452/+R3VMVdp0vknNtFrIK6/eErwPkjBbm9Ng
 GOaY2jO4pYtQuc/6HijGmCR1yw7X9My51RWda66oNEu3S79evDw4Dw1ptY/+HisFNyu7KCg8f
 7LL8NWKZ88xFx/o8uaiKdORgqnjfSNA+Y7OVNdbO7xNNt5bG7FH5ICkV6ft2dDLjPxLYTQzg/
 +E99VKDEABNUqpTiqxgEvsQrIt7CO+nshrWFO9Cv7MKQ/S2wbpncFMHKHaSJgDddyAPWCGzpq
 Nm9vE3P/41BQ6QnZ692OHW3HqmoVsi3syesWS2/4UOdeNMnl/vMit1VTOpJrDxCZ3jQdZWh1o
 TKujjCFQ0n9rDSl3rryAa8/TdU578T7NVuYQ8fWQueIjkEifemHXoPLsyS9j0WC/jykIPaI6B
 4DzcTGZc8AVql7Z32XGx2b/JjnZCrq3ZqcvCUi4aTi037gvVp/hObVGmhtXG/9DJ87n/oqK6Q
 bJUt/La9y7SpKPTYPmUt0YxNT4Lul16kN+y1aCJWnFNCgFVZsGsA8/qtYXRLjfcmXyWoOXwE9
 0mscCwNmHjfLyOBl70Hkc0s/LRWqybnxs394tRdWIjLGaOONi9nZwzhQgpBIvwlx8F9actrZT
 ESAKNvrYqbJNyL3d5o8rcHK48JFJ71aN6175GigUChLEiHH75bRkhk2WDmrjBkDaWSGFoTtS6
 0z3H6pxYDYO5UFqAvqWoOSI8jOiimUXAtvZ9FcqvyDRru71r8hk3LBHlYa6+ZaYpXKQBOt1zo
 44fN48mGxu3nI0sbLVOvGSkAJADr4V5EDEShV4QxjDHIHoiiGhreaMB7zETMadyhEO1YXDMGy
 GW8aYfXUKpIeK5R0zVv959E23tPKuXPNTXeIjlRR98w==
Subject: Re: [cocci] Help to match variables with different names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2321
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/1e4a54dc-2ca2-438a-bcf0-362e61d4eba5%40web.de>

> virtual patch

How do you think about to omit such a requirement for a single operation m=
ode?


> @ bridge_atomic_func @
> identifier helpers;
> identifier func;
> @@
>
>  static struct drm_bridge_funcs helpers =3D {
>  	...,
>  	.atomic_enable =3D func,
>  	...,
>  };

Do you expect such a data structure to be defined in the same source file?


=E2=80=A6
> @ depends on bridge_atomic_func && stores_old_state_for_state_only @
> identifier bridge_atomic_func.func;
> identifier bridge, old_state;
> identifier state;

identifier bridge_atomic_func.func, bridge, old_state, state;


> @@
>
> -void func(struct drm_bridge *bridge, struct drm_bridge_state *old_state=
)
> +void func(struct drm_bridge *bridge, struct drm_atomic_state *state)

 void
 func(struct drm_bridge *bridge,
-     struct drm_bridge_state *old_state
+     struct drm_atomic_state *state
     )


>  {
>  	...
> -	struct drm_atomic_state *state =3D old_state->base.state;
>  	...
>  }
>
> While it works great for imx8mp-hdmi-pvi.c, it seems to not work at all
> for panel.c unless I call the identifier atomic_state instead of state.
> My understanding was that identifier was meant to match any identifier n=
ame,
> so I'm a bit confused as to why changing its name would affect the patch=
.

Are you sure that you do not accidentally overlook any extra context infor=
mation?


> Any suggestion to improve my script?
It might help to test smaller parts of it a bit more.

Regards,
Markus
