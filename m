Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CDAC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+w8WpLh2sZOg7WVyg1bByO5rElATBGNM+mQSpz4HMSo=;
  b=IdCX2fqAwMcC846O7Oz0eRCSb6cAwzkMSru2bGB9MJDnhrbNTku5FGnE
   4f9QO2K+f2L5ybiMa7fq6S1acC9NXoXyG8UPlfbdJMpesH5VC5mhjBnwN
   bRG8y4gyfkIUZ6U0fuPWw97rbriD+zMKg8Z8M6LOkTCG//vHSaV096ZFM
   M=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99073056"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 16:30:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89B32E0D46; Sat, 25 Mar 2023 16:30:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B594AE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 16:30:38 +0100 (CET)
IronPort-SDR: 641f139d_Jy2rb26UBoImcxTwardiQBUddwhT/DqKPx0+g6TZrFH3LrH
 l2UFdAtzypmKN7WxBaoOmVxcEeJlEUGlnv86v+w==
X-IPAS-Result: =?us-ascii?q?A0FWAQDYEh9khwMP49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItgUsvBAtGhFORATGEL4cshzqIaYFWFIEsPg8BAwENQQECBAEBAwQ4hEYCh?=
 =?us-ascii?q?ToCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNCIIvKQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kdTPQMDIx0BAREmAQ8fBgIRFQICVwYBDAgBAYJ6gigBAzEHsSKBMoEBgggBA?=
 =?us-ascii?q?QaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgTyDQYN9gQaDGYJnmVIKgTR1g?=
 =?us-ascii?q?SAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQAIBCzs6P?=
 =?us-ascii?q?zUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNQgUcEgQqBAQYBJiSdW4EOlV+wPTQHgiiBVYFZDJ8MBhMug2oTkwsOBpIjl?=
 =?us-ascii?q?2oggi6lTIFqATKBXDMaJIM2TwMZD44gGYQMjwkBPUA0OwIHCwEBAwmFRgEBh?=
 =?us-ascii?q?XsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:RgL0pay77sDZ7FU+O87qKrPw5L1zdoMgy1knxilNoH1uA7Glfq
 WV98jzuiWbtN98YhwdcJO7WJVoOEmsk6KduLNhRItKPzOGhILLFvAZ0WKK+VSJcREWkNQtrp
 uIGJIQNDSfNzRHZInBkWqFOudl7dWD8L+lnve29QYJcekMA5sQlzuRpzzrdnGeADM2YqYRBd
 6Z6tBcrzStW3gGB/7LZEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51237344"
X-MGA-submission: =?us-ascii?q?MDGouvx/legiMW3hzZinyxsJRwm3Irek+6xxxD?=
 =?us-ascii?q?0426dPeELGirYu3yvWX0JQVcZ253eWeSpsVxwC00NF5IQiLIRfF9kKni?=
 =?us-ascii?q?b3LYPKz+FZQ6wiRd6MPN1/BtFwkp1rEgmBlMeLnfUzDQzsAaRetAYAw9?=
 =?us-ascii?q?bywWVdplIilr4rD38TiFmXuQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 16:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679758227; i=markus.elfring@web.de;
	bh=mnw3UxXN37BrMmqTaNoaZhH7eyrJQu+5+TVfPlBf654=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=fOW69DCExngxD/3gTGyGRsC5ERyUB3rbnOsM7SMMQhsC91SYcu6ymCYNcA5Jkkx8J
	 sqntIucdWbvumrcWhtOhcv1NzENroK6Koq0uG/bhayqycg1jzxg08lthW02gVwrlwz
	 gMxrhK233unFPzqy28+8OaV0qgoA7I6zCg9KQ9FgqD8CQ8AtPPJGrHn0qOTl5Z8QKQ
	 YcWlxOODB/RuP+Y67n7GedDxS590uycedy57jbwCsiRrnSxPCxMOxkgKIXsK0ZOwLb
	 L5+cCUuUbFp0zzY7jyD8WclmDott1BKADlPf3qd21svdegvWQIujXBA4h8cdxufG0q
	 japLUAY+eQoTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMY1D-1pvpyu2C4l-00Jhxg; Sat, 25
 Mar 2023 16:30:27 +0100
Message-ID: <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
Date: Sat, 25 Mar 2023 16:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
In-Reply-To: <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iNgK0jltlcaV4tYapYQGvW1/T3nlfbQGVAeyB74C0KYaYTfCOWc
 fi9nchrN4LuOa1DgAHsyOH+90BiUgehqQKyk5TNFsYLk0d0U5xh79iyglnXVZk/xqbpWuC1
 D2Q+ITQbPijDXhjrvxBSYKhUf57Ea4k9FzKmqqhfUSyubGwnMhPacLcOz6T4i61gdg+/2gU
 5GwIaC8yncIoqvs4rWgoA==
UI-OutboundReport: notjunk:1;M01:P0:LJ+eEHqAW8o=;OmpsWKz3ouNXB0x9MWwPHA5tWLE
 05vmQQL/n6bY4bZI7jOTT/n7B5TZJd2Jno8fK3s1uJpxMNlsY/Z7wres2kKI3evMrCIwTRLRk
 Jl/rODGFfhy7I1hyJhH2ld7BCdDm9Kz0CSjusFGdn7zo7QzUzJueaU4UaWvnGSRia+B2+5sU+
 Rr1M4SOQLHEewex4VFiOxw7cnk9h2NOeyLMJu7ugDVZI/s9dneeUhBh9VIc+Z3D9T2z5tSpWt
 YL3cmLeHUtlJjf76Yj2ETfO6ru4YtI/N+7nEqYNunu6n6vXEYCHjCInm8pSRdIpJG/SCxHSba
 I6EYBMVYDh2kIke7aqmt4y9HxYBMy3yZ1mmx4TIklw6ZcyXs76Xu3bzkyDe8Kd3i8aIQUk9OE
 omTvYd3vIvB+Afe/zeV7HhG1ATedqXT7cbsEN+JRcD5xCOHx49I8wDeuwIJQ9eEHaAbi8dRPg
 SMfQyWglx7QOyGTXpqddl95t2d7seCQN5hgQuIF9dm0SWDfwVxiexCdPfUR9XXBrnSIA8atAv
 vJ40rcM0PwDEFKuFWrcb+NkoImTzUZmKS4XznofjtGsk366YuJJo0/A/AhRoeOAalC+Wumve5
 TrGGpagvzth/7PUTpuancCBee+h0+vCGnjvPPhndnZ+8ht0t07f583Y0LMGy8URXS7Ib9Vrpe
 Km6tjx1WnyH/aqw8Dng/7SX+/7q1Qk2R9xNwwi5GSiIz6EmGUui64c+caWKZ7RGWi01RW2net
 MbeQVu1HnKCRJwX6R6QUzw6Tmrala8Izh0u+YOO7OO0gjIrnFtd1Ri1muxu9Jq/jB7OPC4EpQ
 r1Nipo/VtVLWL0TZIir9FxllRhSQUG/xUBZmNKxFcJ9Ie00hfoOA8aMVs2CcLtqIgWysvseFo
 wCFSD+pyXwOOFRPUze2xkLYScEFXzS7hdIBQsBPvlfXnTpl2mvj1DBoSh
Subject: [cocci] [PATCH v2 0/4] powerpc/4xx: Adjustments for four function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 952
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ecda8227-d89a-9c23-06b7-54f9d974af5e%40web.de>

Date: Sat, 25 Mar 2023 16:10:23 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Fix exception handling in ppc4xx_pciex_port_setup_hose()
  Fix exception handling in ppc4xx_probe_pcix_bridge()
  Fix exception handling in ppc4xx_probe_pci_bridge()
  Delete unnecessary variable initialisations in four functions

 arch/powerpc/platforms/4xx/pci.c | 69 ++++++++++++++------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

=2D-
2.40.0

