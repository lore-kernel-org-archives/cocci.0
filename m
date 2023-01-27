Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96149C38142
	for <cocci@archiver.kernel.org>; Fri, 27 Jan 2023 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xG6q/D7KFdIh2DegHIjes89Ern79onbP7cmDqAqze10=;
  b=JLBy+n1ynN3kMiQl5/OucCHQ1XyQw8FjGWG4Gv3+TFvoR34jfDcgwy2D
   oWzNVMIFm/yDKUTnL7UhQe2n6VDX8VAc4vLboL87u3LmuTHBvUvgoNAry
   HZLhD8PCTe8lSybiLn9xVlGuS6RntTUiZ3xlnorHApEqCSu6ikZGj/g1z
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,251,1669071600"; 
   d="scan'208";a="89820972"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2023 19:35:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D601E0294; Fri, 27 Jan 2023 19:35:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AB7BDE027E
	for <cocci@sympa.inria.fr>; Fri, 27 Jan 2023 19:35:01 +0100 (CET)
IronPort-SDR: 63d41955_g3PxIRhbaFVygxuOYXKQq0D57KlLOawzgOm+VcppqIg/NDL
 hytpwHFRhAK7lqYgNvZTN9e3rV9lpM7aASjdXnQ==
X-IPAS-Result: =?us-ascii?q?A0ERBgDRGNRjhwMP49RagQmBT4ItgV4uBAtFhE+OeoF3M?=
 =?us-ascii?q?YQrhyeHLwOKORSBLD4PAQMBDUEBAgQBAQMEhQAChSQCHQcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOEAUihWgNgjcpA?=
 =?us-ascii?q?RFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1M9AQICASMdAQERJgEEC?=
 =?us-ascii?q?wkCGgIRFQICVwYNCAEBgnqCbgEDDiMHjhWcF4EygQGCCAEBBpwJHywiU4FeC?=
 =?us-ascii?q?YEULJEnJxCBVUSBPAyCRzA+g32BBoMZgmeQYosNCoE5d4ElDoFGgQ8CCQIRd?=
 =?us-ascii?q?EElBA4DGSsdQAIBCzsyCj81CQILSisaGweBBiooFQMEBAMCBhMDIAINKDEUB?=
 =?us-ascii?q?CkTDScmaQkCAyJfBQMDBCgtCSAfBxURJDwHVjcBBQIPHzcGAwkDAh9QcAIuE?=
 =?us-ascii?q?RMFAwsVKkcECDYFBhw2EgIIDxIPBiZDDkI3NBMGXAEpCw4RA1CBTQQvXn8KB?=
 =?us-ascii?q?ikmoj9sGcJuNAeCJYFRgVIMnncGEy6DZgGTGA4GkhyXT6gQgWkEL4FcMxokg?=
 =?us-ascii?q?zZPAxkPjjmEDI8/QDQ7AgcBCgEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
 UPv
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:Sc0Qea3RDr/WIVk5TLkFRAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,251,1669071600"; 
   d="scan'208";a="46215767"
X-MGA-submission: =?us-ascii?q?MDEk5P1wN2Y9PzLsUM5VgyqNX4zwvRfN2zQYOE?=
 =?us-ascii?q?Nl1x3B0Q0824X2tl1gyjDiM5kkVUt0lspSVwAYbvn7tARf5Taz4Bw5Hc?=
 =?us-ascii?q?ghdMqElmgY0DJxfEqwFO7ZkBd6bCfAC3nfF+CSSvtKSRuhSjY+DKGXqT?=
 =?us-ascii?q?wyv+UvxAPOhstOVqOCVVN6FQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 19:35:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1674844494; bh=xG6q/D7KFdIh2DegHIjes89Ern79onbP7cmDqAqze10=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=eyKq9ySjbezg/njk5tQz3ISG/ZE5yzD3gAWqrIOWbs4xJXvMaC5fojyDDhJyTrApw
	 8qT528YuFcrsTy+cfAmOMqMpLYV9dtUS8BC6UY47yrg46mWz9PELMLvXAluXtF1vV/
	 BcllrWpTuYb5UkfwacAfK23yxXKFXvWopnwli7DVlYVjaXPP+eJJnAyhyGIkPsrRGn
	 Zkqo9F+mS9PUr2ECdbp1N1+3wzzP/d0mHeQkPx596cpRYBpxYVzSNAZmMgQP8Ig/PQ
	 fN5vWO4C60chiB3akpuRuTlC7yc0kna1Hu+tK6KtMFymfSqKurLt5AiSk2yBPF8/aW
	 2EZyf0xi1pILg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL4K-1pOnUY2zDg-00EMLh; Fri, 27
 Jan 2023 19:34:54 +0100
Message-ID: <031b3fb0-f413-0165-f79a-87e6306ad3fc@web.de>
Date: Fri, 27 Jan 2023 19:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Luca Coelho <luca@coelho.fi>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HjNp/IFtja0+ECMfXLM2t97l93QrZ/L/LPu7zNdBeUdq/tl0j5n
 ArS1cnfQK7ZkXS0JWBfctnYvEZbhi2s86grKE6oBIsrjnbLxcJWFOBMmoBzPRFpGcSpwOKs
 ShiLu+lvjzeT2Nl1FGaOaWbmbBo8vUCNCc6BD3i+YOFta1/EnURpkpN8KrS9t0Tn6HoWOW2
 f2t52aiJkmqUKVvLbdRkA==
UI-OutboundReport: notjunk:1;M01:P0:b3IHFAdU13s=;WHpIew6MKhoWqWQW0E7mSzkXJ4d
 4Iw8vK2HvtqYHBt064CeQ5sSoeYGlsxMN8sEjYRw8g1dHNfC9sbh/MI9cq26kO388V+iWBHAy
 oL9EUMVOcMOT73l8uwwKkmi3Nkp53z9li9ZFVqKI3z0utAccTpjZ2d0ngHvUfCNRG8fyz91bw
 2wK/3Q+KGxOwzIa4mR6XUlZ8FcBqhGO/IGMQTkglkYN/MdxNDXFGlgw5/2+mnAYm8pcvDSYg9
 PwQ8PUK4nrVs/OzflVB6p0dEezn0GV051HPzsml3HB6BZQJ7+RTQF0Re2TdxgJhvhl2npc3RR
 UlMT/YgxuLipvF2+/2qRFTTc/H/i6dOaQJRYpuWtbVdqWYvz7VuEE94h+NDUqKFYqw28kEPCA
 V+dTIowmunzrwomxOAe8UV1/nABQ9dF/An/x/ClKcqD3Ogz9p8E/URsokn6kv6ooswFcV0bdb
 QmvDkllRx9ARa+WHa+0kQ8Rarr7FvIW7LkA6hNuzPKeNaCkXSV21jm+1gg0GKoapsGdquo4oJ
 750109SjaW8FTpkyAo1f0oWvZdIQqVNxaj1pqenIxbyFC8A7a5AslWmib4FpGDxjmy8RVrBy8
 hsub23MTZ3z2CqzdBWNQ+vv7hXcKGbvgGmYujLX1pyh1WsgjN26MpQYot2ImyOwxVBrKHsAFf
 PeIASc96SewWpEWNloMPU2kbiycBEotAxI8AYbhjPiZylx1HWJ2LsedgNubXLEX8eFplNgR+f
 MIbxGZ3XBJSnGZ1D+0iXoNn3tvnAfnwVmZlaiA9hZa+aZn6EgOiFTD7tlaZ2N+qgXHBSX0sLt
 ybqKOtCA3hZUKq9VM6pefUB6QtP++viwRnxdcDKMRLYCNFnpRk2MzUfj/bGSeac+KU1ub28Lt
 aYy7kwQN6CYDVaPqcSCYs8VZpA/+AzaiFjqb9O0s1mNBopkBAMr2rx2kQXhZT2YubtaW89UHw
 JBq4pQ==
Subject: Re: [cocci] Checking selected macro calls with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 821
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/031b3fb0-f413-0165-f79a-87e6306ad3fc%40web.de>

> So, I'm trying to find all users of macros that have this construct.

Do you find the following source code search approach helpful?

@display@
expression e;
identifier call;
@@
=C2=A0(call(
*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_priv
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0 + e
=C2=A0)


> My problem is matching the nesting in the macros.

Would you like to take any restrictions better into account?

Regards,
Markus
