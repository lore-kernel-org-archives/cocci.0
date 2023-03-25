Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F3BC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H4O7I7U89VgCVFR7wY17xZJO7ab7/e6FW69SyyJzmHc=;
  b=b5Ju8BOsSaXdcZNLd7B7S5mu9X+3nday/yOt85WbDhbRdx7nAmFG3oSZ
   3RKamJl7B5QDuY/A5BUlLlpuwoRp2UTBVH4xqA4oi6kwdEEB73dyo2wTv
   SXi9f8tAUek+aBujrrcLO6sMT4UUgE/7w5B04M4eqopiisodW42xBMJRh
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99059183"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 13:22:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4AD4AE0D42; Sat, 25 Mar 2023 13:22:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD90BE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 13:22:02 +0100 (CET)
IronPort-SDR: 641ee76b_+7msHQPb8CZaymh5j3jPXxipbBuylNNaQ2LsdzWQFNYEbgh
 xYq1/OTpCuC4//+gzkt7sfZ4NeCpP+vghFnGp/A==
X-IPAS-Result: =?us-ascii?q?A0FCAACv5h5khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhBY9kQEuA4QvhyyQI4FWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBU4JzAoU6Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkdTPQMDDBcEGQEBESYBDwkWBgImAgJXBgEMBgIBAYJ6gigBAzEHl?=
 =?us-ascii?q?T+cF38zgQGCCAEBBpwKHywiU4FeCYEULQGNBIM2eicPgVVEgTwMgzWIHIJng?=
 =?us-ascii?q?iiHVocliC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sR?=
 =?us-ascii?q?A5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgkcgAVI7TCYOgXaSWAqSN?=
 =?us-ascii?q?p4ONAeCKIFVgVkMnwwGEy6XCA4GkiMulzwgp3qBagQvgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?BmEDI9HQDQ7AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23:ahTxMR1/xflZitc4smDOQg4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo68x3BSSDc3y0LFttan/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys+5DfeRtEiTW+bL99I
 hi7rhjau9ULj4dlNqs+xRzFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0Q
 rNEAjsoNWA1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVTi+6
 apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSGxcVchTSiNBGJuxY
 YgBAeUOM+lWspfzqkUArRW+BwajGOzhxyRUhn/vx6A2z/gtHA/E0QEmAtkAsG7UrNLwNKoKV
 u661rPIzTbeb/NNxDzz54zIch47ofGNW7JwftfaxE4oGQzflFWQqpHlPyiP2uoCt2ib4fBgV
 eOpi24osAxwrCagydw2hobUmI0Y01bJ/jh2z4gpP9O3UlJ7YcK6H5tKsSGXL4V4TM0jTmx1v
 Cs3xLIItIK4cSUKxpor2xzSZv+GfoWG/h7uW+acLClliX94Zr6yhhW//Eu8x+D9SsW50UhGo
 yRDn9LRtX4NzwTe5taaRvdj5EutxyiD2gLJ5u1ZIU04j6XWJ4Ylz7M/jJYev1nPEjX1lUnrl
 qObdUsp9+614Or9eLrmvIWTN4pshwH+LKsunsu/DPw9MggJQmib5f6w1bP98kLiWrlFk+M5n
 rHYsJDcO8sbura0DxFI3oo98RqzESmq3dYCkXUaLF9JYh2Kg5DsO17UIfD4Cfm/g06rkDdu3
 /3IOafuAo/OLnjei7ftZ7lz60pSyAopzNBf4Z1UB6oPIf3tQUD9rsHXAQEhPwyy2OnoEM992
 Z8GWWKTHq+ZN7vfvUKQ6uI1P+aMfJMVuCr6K/U9+/HuimM2lkMcfaSyxpsWaHW4Hux8LEmDY
 HrshM0BEWYQsQYkQuzqkg7KbTkGZHuoWa84ozMyDoO6Cp3Ybp6ijabH3yqhGJBSIGdcBRTEF
 XbuapXBUfwFYyKfCtFunyZCVrW7TYIlkxa0u0uy4L1jP6Lw+2VMvpXnxdx0z/bOjhx0+TEiS
 4y+3meRB0Zqk3kTWyU70bw39U9wzEvF1rZ1medED9Fe+9tGVw47MdjXyOksWP7oXQeUW96TS
 0u9CviiDyswSN15l/oHeUVgAJOPih7Z3iylK6AYnfqHCcpnoernw3HtKpMlmD793647ggxjG
 5MXXYXHrqt29gyJQpXMj13cjaGhM6IVwC/K8m6Hi2uIpkBRFgBqAu3eRX5KQEzQoJzi41/aC
 ae0AOECOxFC1NXEB69EcNzvgn1ZSf2lNNmNK3mplTKIDA2TjqiJcJKsfmwc2CvHD01RtgkJ/
 mudcyU6CD2gpW32EzFkU17iMAv36ecrjnS9Qwcvyh2SKU1s073g4hkOmfmVUO8exJoBvzo97
 Sp5FhCx0ro6EvKmoAxsNOVZaNI5uhJc0H7B8hZ6NdqmJrxjgVgXd0J2uVnv3lN5ENcIl89it
 34swAdoTMDQmFpcazOV24zxMbzLOyHz+h6ocavfxlDZ1p6f5K4O7P0yr1irshuuEwIu9HBu0
 t8d1HX5hN2CKQMIUo/qFGsz+QJ7ob7yfSQ3oY/ZlDVtPaSyrj7eyocxHuJ2gh2kftpZLOaFD
 FqoSpdcXZLxbrV33QT6C3BMdPpf/6M1Ic68Iv6P2arxef1lgCrjl2NMpoZ0zkOL8SN4DO/Ox
 ZcMhf+CjW7lH3/xikmstsfvlMVKfzYXSyCawDLnGZUXS6l8Z4cNBk+xLsfxytg01PuPEzZIs
 UWuAV8LwprjXBOIbEHmmyBU214Wp3OPhiayiTB52WJMzOLXzGnFxOLscwACM2hASTx5jFviF
 oOzisgTQEmiawVBeAKN3U/h3OAboa1+KzOWWkJUZ23sKGokVKKst72EasoJ6ZUysCwRXv7uK
 VydT7f8pVMd3UaBVyN7zSo4airsl5H3hR18h0qCIXw1oHeRdcxrxBjZ7cDRXrYLh2BAHnMnz
 2CKQAT0NsLh5diOkpbfru2yMgDpHoZedyXm18LItSe243FrHQzqmvmyntP9Fg1pmST/1tRsS
 WDJtEOmO9Otjf7ld7s6OBU7YT20o9B3EYx/jIYq0ZQZ2HxAw46Q4WJCi2D4d9NSxaP5anMJA
 z8N2d/cpgb/iygBZjqEwZz0UnKFz45vfd6/Nykz0zg+8tsMJaOa9r1CkgNqr1D+oQ+bMp0f1
 n8NjOAj7nIXmbRDnQM3zTiGRJ0WE1NZOyPEiBmCqdyz5vYyBi7nYf2700xwmsqkBbeJr1RHW
 Xr3TZwlGDd58sR1NF+fmG228Izvf8PcKM4CrhDB2QmVlPBbcdhi85hCzToiI2/2umcpjvI2n
 QA7l4/vp5CJci1s5P7rWEcCcGevOIVKoG+r1PwO2ZzLuuLnVpR5RmdRBcGuF6j3VmtP86ygb
 VvGESVg+C3CQ/yFR1DZsRgg9zWVTNiqLy3FfiBGi4o4AkDMfgoF3FBTBmRf/NZxFxj2lpy7N
 h4nu3ZIuw++8lwWlKppL0WtCD6A4ljyLG1sF97Ha0AJpgBauxWPaJPYsbg1RnACuMP961bTT
 w7TLwVQUTNZAArdWQ2lZOP/o4Cbq6CZHrbsf6GIOOvT77YFD7HSn9rq249itV5gL+2pOX9vR
 70+00tHBzViHtjB3i8IQGoRnj7MaMiSoFG9/Dd2p4ax6qajXgWn/oaJB7ZIVLcnsxmrnaeOM
 fKRjydlOH5Z0J0L33rB1LkY2hYblShvczCnFblIuzTKSercnapeDhhTbC0WVoMA96UnwgxEI
 tLWkPvw0aNkyOE4ARFJWB2pm82kY9ALP3DoNF7DAxXuVvzOLjnKzsfrJKKkHOcJ1qMO7UL24
 GvdTxyGXHzLjTTiWhGxPPsZiSiaOEYbo4ShalN3DmOlStv6axq9OdsxjDsswLRyiGmZUAxUe
 TV6bU5JqaWdqC1ChfAqUUlI9Hl4Nq+pnyiD7u/XAokbu71nD24n8oASqGR/0LZT4CxeEbZtn
 zDOq9d1v1y8uuyI1yYhTxdE7DpGztHu3w0qKeDS8Z9OXmzB9RQG4DCLChgEkNBiD8Xmp6Faz
 tWnfE3bNzpItd7Zr5J07y38N8+NdnYsY0KB8N/8CQwYUXi0OGuZi0EPyJmv
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:1c4XT6CUJssak6XlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99059180"
X-MGA-submission: =?us-ascii?q?MDFOLcddSFcjE89AdUWAWml4UGSReEyfNncSt0?=
 =?us-ascii?q?N+nuAFMxMmVbm+c/MgfEctmfHkUDW8GOrPDW79g+8vKnwDxy177G1suw?=
 =?us-ascii?q?AjeP+zuILRKuzJmfUAmCXK1rZILkjgT/7ydS79H3WSa3n8/KX2qIkDDy?=
 =?us-ascii?q?TgYyWZTPobHfs6BuF63qDAFw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 13:22:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679746920; i=markus.elfring@web.de;
	bh=6M5g5kjW0Ss8WpZ+tspkp7fgSF6IJSxFJds66VBa9mA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RkdyYJLyoe/Kqb8id3L1OBNxIzd3rIiGFM+OdrlUiujUThlFNRp/IN5tlr0wDjStj
	 117M0OYwfxfPH3obmg8wYIDHDn0o3h4h6GbUnhXQcH4z3vy8J4sz3uBUNMw74n1mwI
	 fTbx3bJ4wBegGmL2dQZKUTOeBioU1hoOahkXbio3nmSynUTovvMAV0BkcNTk94khFo
	 RifKjmP66wnm+5E64bpzaQ0rA8RsSIfCeXJcVi6pdCEp2HBJ/ltGgacbnHA7UQ6PO3
	 7da7aqerTaL4KFIRIROlZPP3YOnneRlO/Cw9tLtCSerVoamU3TlXw2/HhULcwgkZyg
	 t+/IJGBMg2IdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZjd-1qC5Kv2XTJ-00cupo; Sat, 25
 Mar 2023 13:22:00 +0100
Message-ID: <13b4a57a-5911-16db-2b6e-588e5137c3aa@web.de>
Date: Sat, 25 Mar 2023 13:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, linux-bcache@vger.kernel.org,
 Coly Li <colyli@suse.de>, Kent Overstreet <kent.overstreet@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e33f264a-7ee9-4ebc-d58e-bbb7fd567198@web.de>
 <d0381c8e-7302-b0ed-cf69-cbc8c3618106@web.de>
 <157b8db9-82f7-85e7-3bbd-7ef3a1797892@suse.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <157b8db9-82f7-85e7-3bbd-7ef3a1797892@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i888j5WBn1jxwh3Og5wbXwIxAgNEAx/8MotgOox1wnS+n2148yX
 YTm9MTwGfk4bpT+TpjtL733EFSSo6L+2LKbe1Jm7/tgtekANZ5aqEwCSpXsZ6L86BRpeI5n
 vF0BpSRWQbF+GpcKOtE0MK5TA0m5z3d6qrKZnc4dnRy9cNQXzNFtfMcFTq4L9YGKz5EpwI0
 ChNqH4c5JXXVzVi6Q/qyg==
UI-OutboundReport: notjunk:1;M01:P0:Hf4hrEWvFGU=;stoukisTvn+ktEBp2iarh9xyO8a
 xxsU3aB6SaP8FMRGks9E/zvcmA7yVkC84iCHuFItNqAENse30FFSrIRGoWxC1C7bMRgD6IhDP
 mzbwy80VW78ioOZ0mC+JQeKSnT7WQh48Iqd5ZobdFYwE9jEkcsUY1Cn1+KWUzdrEGsfoz0KM9
 FDiFq5JMOgeFK74l6AXw6RvEppT0KH5grGGEJi69+IbSuhQwLGVXvE/4KA3xgiTwXBG+ig6pC
 A7nTrWCBB79mMXKI6DOr3z04+fGpOKgQHb70/Ri/b68DrY9ROpgfWKfMDsnWKsAQqIVuDOdOX
 9BrygacYHpFiTCnP3Pxz8vwic2Qs4iWRRWKmdYEbD0Pb+YVJm4nVHKxKLhZPp3NMMqxVICUnr
 ahQJluAEPayZPu+laEZpBYcCXu0WGSWAauGqz7VYMGeJu9WqBavX3R39YDba/lCr6z04QT6td
 FFfZzKJIfgOXEQZfT5s6Tw0eyYjc2mD9uvsDpmdmfijWTaVxFBUv/FUTcvCaAIifPNTyOoOrD
 mZE3mY6dj5QFh8TG4H2yQEuy6L4EH7dgH24z4b71G2CVoKakpmvlBgyLQGP1T/Tw+YIPYpxJv
 t1R4qVfC1YxaRNjoRi/F1Bho45v3BHuRZk4SuRn1jzdiM08xHwq1rh1GhblscanGgbV1V1R0O
 3WyG7dLhJdNlZQhim9Npcfcx8odY5zz0aVqGThUMxJKuZ5OvcPqU37BE01lrX3OHpyuUSPdGV
 LhwVKuZCrRmQQQDMmXJkniESmOrGjB1ltr0kR12Gt44e9jgfCo8M6BG/gG5svPNyNxSq+aRbO
 P/um7ZYQiLCdl/qONSOElKqRmaRQ0iuuK2tuuAtC2UgfWNP+irBX5S04xFy9r5kZ+n+lRrzPf
 kS4IEZXdOv1u+EzUT9efNLxmJ3UuNegXYt1C25JeRIqcpF1CJTV6mXWSw
Subject: [cocci] [PATCH v2] bcache: Fix exception handling in mca_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 941
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/13b4a57a-5911-16db-2b6e-588e5137c3aa%40web.de>

Date: Sat, 25 Mar 2023 13:08:01 +0100

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cmca_alloc=E2=80=
=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed function call =E2=80=9Cmca_bucket_alloc=
=E2=80=9D.

1. Thus use more appropriate labels instead.

2. Delete a repeated check (for the variable =E2=80=9Cb=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: cafe563591446cf80bfbc2fe3bc72a2e36cf1060 ("bcache: A block layer ca=
che")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
V2:
Use another label.

 drivers/md/bcache/btree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a989a..c6a20595302f 100644
=2D-- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -921,18 +921,18 @@ static struct btree *mca_alloc(struct cache_set *c, =
struct btree_op *op,
 		if (!mca_reap(b, 0, false)) {
 			mca_data_alloc(b, k, __GFP_NOWARN|GFP_NOIO);
 			if (!b->keys.set[0].data)
-				goto err;
+				goto unlock;
 			else
 				goto out;
 		}

 	b =3D mca_bucket_alloc(c, k, __GFP_NOWARN|GFP_NOIO);
 	if (!b)
-		goto err;
+		goto cannibalize_mca;

 	BUG_ON(!down_write_trylock(&b->lock));
 	if (!b->keys.set->data)
-		goto err;
+		goto unlock;
 out:
 	BUG_ON(b->io_mutex.count !=3D 1);

@@ -955,10 +955,9 @@ static struct btree *mca_alloc(struct cache_set *c, s=
truct btree_op *op,
 				    &b->c->expensive_debug_checks);

 	return b;
-err:
-	if (b)
-		rw_unlock(true, b);
-
+unlock:
+	rw_unlock(true, b);
+cannibalize_mca:
 	b =3D mca_cannibalize(c, op, k);
 	if (!IS_ERR(b))
 		goto out;
=2D-
2.40.0

