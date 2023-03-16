Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A870EC6FD1F
	for <cocci@archiver.kernel.org>; Thu, 16 Mar 2023 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZyUqUgJ712sd7hB/1hJRuDlfBU9H2cZJd5fAh/yVhFg=;
  b=SrVWy5/HKfCv7U5PEAGlCDmeFv3etQoFK2BMPoR658EFFTWTxizzHrkt
   wpWoPPczw8BZiotNnr+fCyWqeA12ruWFCwuZogY9i9bmYhG/XpwqIAjil
   ezNdOwIE4N1atupl8Dx0Xd8gpy0qaB1vlIUJSk0yy/YV6Ms6C1vuJ7Qft
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
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="97645664"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2023 21:08:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44512E02A3; Thu, 16 Mar 2023 21:08:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D168E0010
	for <cocci@sympa.inria.fr>; Thu, 16 Mar 2023 21:08:08 +0100 (CET)
IronPort-SDR: 64137727_OshSHyEVhptMKJqJuh3H9zWAXiNC7iGFl1XjWuDpo7HWp2y
 BymuGQkmc0NgHQ6s9UKKsF/7BDgp0W+uj8WSgzg==
X-IPAS-Result: =?us-ascii?q?A0FwAADDdRNkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFORATGELocqhzqIaYFWFIEsPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4hEYChTUCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARgLFwcOBQsFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkdTPQMDIx0BAREmAQ8fBgIRFQICVwYBDAgBAYJ6gigBAzEHsTmBM?=
 =?us-ascii?q?oEBgggBAQaCY5knHywiU4FeCYEULAGNA4QwJw+BVUSBPAyDNYN9gQaDGYJnm?=
 =?us-ascii?q?HUKgTR2gSAOgT2BBgIJAhFrgRIIa4F+QQINZAsOdoFOAmUDVSUlBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkkERMFAwsVKkcECDkGHDQRAggPEg8sQw5CNzQTB?=
 =?us-ascii?q?lwBKQsOEQNPgUcEgQyBAQYBKCSdCYEOlV+wPTQHgiiBVYFZDJ8MBhMug2oTk?=
 =?us-ascii?q?wsOBpIjl2oggi6lTIFjATiBXDMaJIM2TwMZD44gGYQMjwkBPUA0OwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 xQM3NLsWL9bybdtJzgDtQ==
IronPort-Data: A9a23:FimUUKwKCBVshxR/Tu96t+dTwirEfRIJ4+MujC+fZmUNrF6WrkVRy
 WpMXzqBPveKNjCkfop2bIy/8x8Du8eBy9JlTwY5rFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOOU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEALjim4c3l48sfrZ80s05aqq51v0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPAyMx8AWsVILQc0f9dCGJK3
 6I4NB8kO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKlgHsqFGvSQo4AItNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2AA9AjL+/Vmi4TV5DVq1bzVbPzfQO2hQoZQxgWXq
 m/srnusV3n2M/TGlGbbqyvy7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDYtLETRCSg2O9ujUFcdNTF8dkyB2i4/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+/U6SxTXK69FCvHp+bPxd+mEXlJfDZaDcMRZVFdu7HeTJcPYgXnYvsLLUJYptjyBC223
 D2A6iQz71nysSLp//Xrlbwkq2j0znQscuLTzliHNo5Cxl4pDLNJn6TytTDmAQ9ode51tGWps
 nkegNS55+sTF5yLnyHlaLxTQ+H4tq/Zam2E2g4H83wdG9KFpCHLkWd4v24WGauVGp1UEdMUS
 BKO5VwMvfe/wlPzMvEmP+pd9PjGPYC5SIi7D6mKBja/SsE/LUeG+j1jf0idwyjknyARfVIXa
 f+mnTKXJS9CU8xPlWLoL89EiOND7n1gmQv7GM+jpzz5i+f2TCDOE98tbgDRBt3VGYvf/W05B
 f4Ea5DVo/ieOcWiChTqHXk7cg5QdSRjWMyowyGVH8baSjdb9KgaI6e56dscl0ZNxsy5T8+Yo
 SnvaVwS01flm3zMJCODb30pOvulXo9yoTh/dWYgNEqhkSprK4u+zrYtR71ud5ke9ctn0aFVS
 dsBcJ6+GfhhcGnM1AkcSpjfl7ZcUiqXqziABAebRQQuXoVBQlXJ8+D0fwG0+ygpCDG2hPQEo
 Lah9136RMMdSzRbEcqMVvOLymm1nHkCmdBdW1nDDclTdX7NrqlrCX3Vpd0mL/4cLS7swmOh6
 D+XJhMDt8zhkpQQ4vCQoYyl9qCHS/BfGGheFEnltYeGDzHQpDef8NURQdS2ciD4f0Kq3qebP
 MF+7ez2ad8Dl3Z067tMKa5hl/8C1oG+to1h71pWGVvQZA6WEZJmGH6N2PdPuoBrxrN0vQiXW
 FqFyuJFOIemad/UL1oMGDULNuiz9+kYuj3338QHJE/X4CxW/r3eX35CYDiKqihWd4VuPK0fn
 OwOhc8x6i6EsCQMDOqotC5uyjmzHiQyaJl/7pA+K633uzUv0WBHMMD9CDepwZShaOdsE0gNI
 x3PtpXjmoZz+0vmWFgwHEjrwuByq8kvuhdL7VlaPHWPuIPPqcEW1S1r0wYcb1pq3DBY9dlsK
 05XN0FRDoefzQdC3cRscTilJFBcOUe/5Ef09WosqETYaEuZDkr2M2w3PLe2znAzqm5zUGBSw
 +CF9TzDTz3vQcDW2xkyU25Dr9jIb4R41i/GqfCdM/W1JbsIShu7vfb2fksNkQXtPu0pjk6ep
 eVKwvd5WZemCQEu+Z8EG6uo/pVObiDcP2FTY+BTzIVQF0HmRTyC8zyvKUewR8BzG8L34XKIU
 8xDG8YeeCm9hQCvry8aD5EiO7VbvuAkz/tcd6LJJVwpiaq+rD1ovMju9wz7vmsKQspvo+k5O
 Ij+ZzKPKU3OpHp2ykvmjthIBXq8WvYAPDbD5eGS9P4bMr4+q8RuTB0C6aS1tHCrLwdXxRKYk
 wfdbavwzeY564BTs6bzM6dEXSOYFMjSUbmWzQWNrNh+V9PDHsPQvQczqFO8HQB3P6MUautnh
 4a2r9/780PUjokYC1mDtcG6KJBIwsGuUM58EMH9diBalBTffv7c2UII/mTgJKFZlN9Y2NKce
 DK5T8mOJO4lA4IXgDUfbiVFCB8SBpjmdqqq92v3s/2IDQNbygDdas+u8Xjyd2xAaysUINvEB
 xTpv+q1rMVtxGiW6MTo29k9a3O5HLPiZUfiX9j2qCXeEWSixF+P0lcnedzM9hmTYkRo0u6ji
 X4GevQ6XAu/sufEwbm1dqRs6wYPAi8VbfYYJyogFh0ft9x+JHELJ6IRPP3qz32SfjPajPnFW
 d0GUIfu5egRk9iJndUQLekPhjuiO9E=
IronPort-HdrOrdr: A9a23:H2LUKqrsUilWDs/Rj4yJRroaV5r/eYIsimQD101hICG9vPbo8P
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWrbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="50426679"
X-MGA-submission: =?us-ascii?q?MDHtrNCunu7lwXJqr7foecPCon5ELQA1DdeIhA?=
 =?us-ascii?q?iV0dO569rMxgyMuXZiVD+daLcEAjvOJoJ6jxfx3HNheI1U9hws9C90+X?=
 =?us-ascii?q?smkGYbp0rBPr+TllNW5JOuGIKmteMZItY/txLooWXlRbF5Qv1dDanxr9?=
 =?us-ascii?q?FLKPTye5FQaMI4g5dKIUhLGQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 21:08:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1678997276; i=markus.elfring@web.de;
	bh=ZyUqUgJ712sd7hB/1hJRuDlfBU9H2cZJd5fAh/yVhFg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=uamXZk6XQnNOSDIUTP2qfub4LEALwsm1XMuJNC+PjmcQMPLHLteqQzOHp4S9ITs0B
	 Ev+LfYw+sVY2DBQkXyW8qjDQi081sBKSkW52Fq1fy6thT7Zpj1+A7dzUGI5Sa/lvWv
	 hMVmdVwGgEjrELBqHZes1Fr58xh6oBqmhAEIhmGwSOSnNMdH+O2VKQPStyN2XdG5U2
	 PCc5B7GyDMuy0Y0R311UgJT84IuQNxqyreX6zdPaY4OaLxbiVUWK8kGd2XIsmysa/0
	 Rtjy82rfuNh1dlwKBZe8BW6SydFuM77oITxNXS6umgxi6VutMu7KVVk3686AfiGcr7
	 FZRk6igRbzTcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1qcFv32GmH-0108fu; Thu, 16
 Mar 2023 21:07:56 +0100
Message-ID: <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
Date: Thu, 16 Mar 2023 21:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0MEbJGSaiyScfOPZPwBBwq16kgkXOyIY0aAfBsztRRnxoUUPn3g
 n8eysQigjFkEvBs1lZrdO8gK8HRwlxKf6sJJZwA3xbYr0nEDM9PojZkN1qfYsHsGH2iegpp
 Lha8Bsm09JnNM/ls7TrGJWUc/olDduS8u2KFbBKiDmy3BZmu9U4x3sos4z2fUVb3ZQvCetA
 Y78l+uf0bzpj1NcsLxfiw==
UI-OutboundReport: notjunk:1;M01:P0:4FcYma6D1Ss=;SNu2qHEbCMinw395+BhLcWqyQF9
 JewwRdIhesRawaEq3zzP7KsVg0ZbeHTSOwVychON7haraZy/D8QkYQiPEyNJX+ewA2b0gdQyN
 lXx1ppJJGRw0u2syuucoIe4vC2BQX0aZk8Vl6+DbZdvd8UhHwkzJ44O9kEW7KsUvHP9a6Vt22
 P84AGpZzGOMH1rGFVxCkvXx705p/LoBiuDknKplUsHqsYKU6P9AnBozxD2K6zUVc1CeZ3ZC/E
 c853ipvWJVV5Ak0pjjKUtFl4eb3JNozGL61P4CJVf13UH1rjipJhAvhsb5xF6Pep0xluF240g
 5dhyY/rzWWSMQU8MytVOXihSigQgovsQOf/5DqVZ3vHfPO8Tu2mFb3d5ikrwvGs+Ffe8WEcju
 I3DA9deubmpKdy4RjugSebl3B71ZpkFTlaeZ8iSXwQHljNvwP5e1VkcvnOnl1ADu6mTjeiN5e
 lS6t1cSdUz+zxT+nXnRzevUJmeCe5Tl8dcIW+owiNlNL7/wf2anvVZVQM6BwNkq5qmOA0lYP1
 oOp+Yl8ha8DBNcxV4dNMlL2M+wMML26EdovFQNyIpemZ3wkiKsHdyrJ2Zxb3M8AOYkPlW3DWv
 LRnZb9ChCtj72n6YHEsGG5hUf7RwJQzT/3Fc1VZ4O2CySy2rtrjXrQVKDGHwHnzmRmGbpCV3k
 OPEraG1bFt0+vjNAv1x5BfUJJ24eGlku6D0tR+E0W9Vmww1QUcTw9kHTyp0i1hpAgvLAi7rs8
 1wmWjbm9rFjDNwb9uyPDwnx8yyRuxfF8RGkTeWM35G1fpucfisAJSIjLHUNYv+oF6TMzE8NUp
 Kz1ZXw5OQegeScZhzJiLZu2pCOAGBhoX1Wai5dnhlOyuKspm6Hcr5YNVpOmrvCs7DCeVJcJOV
 Yn6XaGlCTFqHiEQLOTfFXzvxRLAhct22JdbK9ZvJvPH4rVBHV+f0z8eASUgauHGvVZcVyKwae
 iY39JQ==
Subject: [cocci] [PATCH 0/4] powerpc/4xx: Adjustments for four function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 891
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5%40web.de>

Date: Thu, 16 Mar 2023 20:15:43 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
=C2=A0 Fix exception handling in ppc4xx_pciex_port_setup_hose()
=C2=A0 Fix exception handling in ppc4xx_probe_pcix_bridge()
=C2=A0 Fix exception handling in ppc4xx_probe_pci_bridge()
=C2=A0 Delete unnecessary variable initialisations in four functions

=C2=A0arch/powerpc/platforms/4xx/pci.c | 69 ++++++++++++++----------------=
--
=C2=A01 file changed, 31 insertions(+), 38 deletions(-)

=2D-
2.39.2


