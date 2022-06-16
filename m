Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA94DC43334
	for <cocci@archiver.kernel.org>; Thu, 16 Jun 2022 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PsdgUw7S3BXfObTHYofBOLjHkr3OGLvkowQ+e4b5sys=;
  b=Yb4n7ASsKgH77q9Um00R1vPz2iYmt0ZhirElC5trYWRB4+f0ePEBUlPK
   lxg2VxzZHYvMZv0gIDkFyhl5+P3qalariNHWzUuamsYRTLpscbZGzAcUd
   //fsxFq9sTpAOq8xV9VuDxRGALrI/CMewcy44l4KcgzV2dBHdMxPNKrpp
   U=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,304,1647298800"; 
   d="scan'208";a="41262274"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2022 08:33:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B0D2E5D6F; Thu, 16 Jun 2022 08:33:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76513E00BA
	for <cocci@sympa.inria.fr>; Thu, 16 Jun 2022 08:33:00 +0200 (CEST)
IronPort-SDR: tVVB7ZpISan7PLieMWL3i53dSclUNc5P46PylfjaU//qWFN7EbioCJGvIEZcxI+5pi0zC1zMRc
 Dkhyyg97Pev+s/mTR35lu72OH/cHrwC2Z1qmLU5KehYhLsIT4SbNM0rl65toSNsEnAt38kIEWU
 MAW3fZW+mJnjuh8yFYqIEiHbklylZtSuy5kToo4AJYv5NXx+BVm9wInCCDjcqBsb9iLoSlLIIf
 nzqlF2pp1WnpzWu92dkw7TN3Tx14C2RUZ344pjwMeL3wVqwjuIh4HKPKgyVHxz52j3d0ZR/oP/
 nCAgEuxCqG9+xGejda7pbVkc
X-IPAS-Result: =?us-ascii?q?A0AHAAA5zqpihwQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYIjgVcuBAtEhBE9jmeCKIQhhwmHHIwhCwEDA?=
 =?us-ascii?q?Q0/AQIEAQGCD4JwAgIChUkCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBA?=
 =?us-ascii?q?gIBDBcEGQEBESYBBAsJAhoCJgICVwYBDAYCAQEXgmKCZQEDDSMHkmicFH8yg?=
 =?us-ascii?q?QGCCAEBBoRKHywiUoFcCYERLAGKV4QdJxCBVUSBPAyCRzA+gQ+DNYNWgmWZH?=
 =?us-ascii?q?SYEDwMaLTQSgSFxAQgGAwMHCgUyBgIMGBQEAhMSTQYdAhIFBwoGFg4UHBISG?=
 =?us-ascii?q?QwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDFwkHCgMdCAocEhAUAgQTHgsIA?=
 =?us-ascii?q?xkfLAkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMFDw0BBgMGAgUFAQMgA?=
 =?us-ascii?q?xQDBScHAyEHCyYNDQQcBx0DAwUmAwICGwcCAgMCBhcGAgIZVgomDQgECAQYB?=
 =?us-ascii?q?B0kEAUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxYZHRkBBTYnB?=
 =?us-ascii?q?gsJIRYGCh8LBgUGFgMjTCcFCj4PKTU2PC8hGwqBDxcqBiIBGwKZfXE+UaNUo?=
 =?us-ascii?q?Bw0B4IUgT2BRAyeLgYTLZZTDgaRepZsIKcVgXeBfzMaJIM3TgECAQINAQICA?=
 =?us-ascii?q?wECAQIJAQECjh0ZHoNuii0/NDsCBgEKAQEDCYVHAQGJOAEB?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgVdKw==
IronPort-Data: A9a23:HhrxTqvxpwMMWseggxAzazXlr+fnVHpYMUV32f8akzHdYApBsoF/q
 tZmKWHXOq6CZTb0KI1zYNi09RlQ7J+Hn9Q1TFc4qChnFiwVgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52LBVPyvX4
 Ymo+5OGZgf8s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnYfvbTkTIv2So/omSh59Oj0iZ5ZYpqCSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXr
 7pCcm9LN03F24paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcBgmZo2J8TR54yY
 eIAVQpXRR/qZCERJ2YnLYgMuOyY30HGJmgwRFW9/PdrvTGKkmSdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 1dL3hQUsfhsz1KQV97YdgHk+kWa4AFJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaWCkeGmRCO
 rihwIqBONB/jFGGYS7Mru/P9lteLQBFcTVdOUfoWCNYu4GLnW0lsv7YZvpOeEJfpv78AzXr2
 S2KoUDSbJ1M05dQiM1XEXjtij6hoN325dov+hnaW2io9AwRWWJIT4mv9ESd8vtKaoqUJrVgg
 JTms5jAhAztJcjc/MBofAnrNO/xjxpiGGOF6WOD57F7q1yQF4eLJOi8Gg1WKkZzKdojcjT0e
 kLVsg45zMYNYSbxNPAnOdzhUJtCIU3c+TLNCaC8gj1mPckZSeN71H02DaJt9z2xwRZ3y8nTx
 7/BKJ7xUR729piLPBLvGrtDiOZ1rszP7TqdHNj6yQiqy7yTeDacRt843KimPogEAFe/iFyNq
 b53bpPUoz0GCbGWSnSJreY7cA5bRVBmVMieg5EGLYarf1s2cEl/UaO56e16IeRNwf8K/tokC
 1nmBye0PnKk2SaYQehLA1g/AI7SsWFX9iJqYXR9YwrxhhDOo++Htc8iSnf+RpF/nMQL8BK+Z
 6JtlxyoDqsdRzLZ1S4aaJWh/oVueA711x2DNWypbWFnLZJnQgXI/P7ifxfurXVfUHDo6JFm+
 7DwhBnGRZcjRhh5CJiEYvyYz2S34SoXltV0UhaaOdJUYkjtrNNnJnWp3P86Ks0BMzvZwT6e2
 1rECBsUv7efvII/ttXE3PjWo4CsGup4P0xbA2iCsefob3aHpDL7zNYZAuiSfD3bWGflw4mYZ
 L1Yn6PmLfkKvFdWqI4iQbxl+qIJ4Ye9rbFtyAk5Tm7AaE6mC+87L3SLgZtPu6lKyuMLsAe6Q
 BvWqNxdJKnPJ87vVlIcfVJ3YuOG3PASuz/T8fVsfBSkvnAqpuLfXBUAJQSIhQxcMKBxbtEvz
 9Ahj8hKuQaxvRwnb4SdhSdO+mXQdXEND/c9upcBDNO5gwYn0AgbM5nbFzOw/5yFLdlBaxF4L
 jiRjavEprJd2kubLyttTyeQh7IFiMRcog1OwX8DO0+NxIjPiMg36xsNoz45eQJYk0dc2OVpN
 2k3bEB4KM1iJduzaBSvgoxtJ+1AOPFd0kn21kdPi2DTCUWlPoAIwKvRJs7VlH31MUoFFtSYw
 F1c4HnoW3DmcakdGwMsDFV9paWLocNZr2X/dQPOIyhBN4Y3a3zpj8dCoIbORwTPWasMuaEMm
 QWmECucp0E22e78bpDX07Wn6Ik=
IronPort-HdrOrdr: A9a23:qjnU9KzS265hyJ6cJCHSKrPwCL1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,304,1647298800"; 
   d="scan'208";a="16906752"
X-MGA-submission: =?us-ascii?q?MDFyZoNMD0c5QjJxrblSOT9zGeGWayPY4TQqTv?=
 =?us-ascii?q?4B7j5t2ggiUp7a7WtdMF4EdW1Z+IprRIPHs3mqz8b1pdgKRolZB094Uf?=
 =?us-ascii?q?Kwrey1F4b6UI+p8pv4tXy3RgM8V+8eH9xjAiFIN/6Xa8KSlljpFelbfP?=
 =?us-ascii?q?iABm8uJramtfxy0oF6GcDVVg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 08:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1655361178;
	bh=BXE46EaZKz70i4SyTxs1PHXjQpSY7YpOXO/HebvA1H8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=oHpQkAYmTsum7ze5p+6R/P6Nqc1RGBGhuSBHHonAg2+JgRVWLXyTIIXpLO82PJyui
	 uZjM2sz+k4g7MARnWOCVL2tTt3mgtt0BShuz6TfYMU1p0MuvLKAei1bzWm5VLK8MaI
	 HiwyGS9Y/PQr8MKHFTmThNdydWNQTHeRHCj8O4HE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.30.241]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1nPuCY3if5-00cLVj; Thu, 16
 Jun 2022 08:32:57 +0200
Message-ID: <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de>
Date: Thu, 16 Jun 2022 08:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RtorUc8frXfGtc/0JaypTmH2XrtidGfr6lRijw1+CgrSWJ8paoU
 MOPj4dafuGn3831XmyoBGq0X/AIGxTsbf9JFJjicnxtd7+L+FDw0vick1IKyjHHCRH/HXjx
 fH5uG5eFIcLowD8UplG1bavuIv+nMPS8ddELiSgTEKzJoC/Y+0yrKLTi2KBlBXHc3uwJluH
 VbBmPiKw35eda+SWc/6Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H2ch7Qt+HGY=:sjDgNQTdGPQ1enlFddO42p
 gFFES7Q1+pVaf94XXXvOPpNT7St1AuDY2cH7f61MUvtnhaDOkmui/X7ayjNxPPLQDTdvsrv4e
 s2oEWOI1fLlCrP5jwchsWC4f7dU8VecziqjwZTXhww1cNJhKd9TllxR+Lp/Z0aI8j0vCoCbce
 tLCWUmW3rWvMDzOymt8rmr9TTrJBEFneFztLpPSsXWkSYQlZUeRpEeUjePcfazYl5tXTRfPCo
 K36jdOnBZrhfA9xjG3+ZmEQuD9+sSrCLTvMuP++6bO56oyBV0HAZF7SoogIzPy/nlxID2RuvE
 gk7smSZyKzCj3pmPsVSOpNi1W9vvRxXl2aJJaIKVKONtJHknjORmRoR1ethI8BN33COF/HbWv
 9whp8vz80PbwgjhZ/8VYB3sLIxDzHEoVLPCfYEt9FVoFtmW2QD6RnT/BGPZJuRtYcTr0659Be
 N2UBBJEEbjITmRtEMItDSQg2H575YKvUSnMxMSjIvlOaASdiwbL6SYx0xhThZYoeqYcVCvtmp
 dQE2COG0RooxadBpjVLO1DB1w29cKX96ZTpVYIrpKNFIKTyQf8HVEmpZCLSTBOcQwehavp1vT
 dJD1Y+CQTQHs2v1xb+Ju/XvK6ucoyx9sU4WVIOi6qv/IS/uGOmsGsx5l8gCZ+VrUDmoBHkwo/
 goIJiDYiPG1zaFqtgGKpW8R7FSDouNPbT7ZJg+Pwiu+TUhi6Adw1rhbp0i0CR3LrMS97X8BV6
 GkaeQU2LKqUIPeez6y+jzBleN6TadtEZmPUmN5+DHnEon2uMtYWZt5UP9sHK61G+oMinoxR0u
 TBKeCc/Q9BpeGCVHoTbAlx0D1IWNHoSweYrg855ATxcMXyOxGIyR2299/GM8IMmbD5lLLf1CC
 j2xyNCr7Pe5j9hQ/GtQa04d+on25S3MPLBy571l5Q93Lu/1jeUgnKCV5uKlCzP4PrquVMbpHs
 QVIMvbXOHdt8pgKRe0D+uSUADdur6so3ct3MR60Sv/VEWijUu63yT+yKI+F/9VXUymIHZiDah
 3jhuXJGp218Kuwdace6McCEKVfsTT+//U5zH1keorbAXT8dVO6Fqzwdjp2ki/RiYakoijjlPS
 HDBLAwV1Hpn41IQZkp5GRTHof4/HhgguSXE/ybMTCYLnGB3qm54y5kNLA==
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 445
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/6aef3ee4-d934-daff-7145-73ac563d2fb4%40web.de>


> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it. Also, an expression's
> address is likely to be non-zero in every test expression, not only in
> if statements.
>
> This change aims at detecting an address test in more complex conditions
> for every test expression.
>
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v2 -> v3: Apply Julia's suggestion to have a more generic solution + ada=
pt commit message and file
>           name to this new solution.
> v1 -> v2: Moved disjunction on the condition itself instead of being on =
the
>           if statements.
>
>  scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---


It can be determined that the proposed approach for the detection of
questionable source code places is incomplete (also because of the current
development status for the Coccinelle software).
Thus I suggest to reconsider the usage of the word =E2=80=9Cevery=E2=80=9D=
 for the patch message
once more.
Will further adjustments become helpful for desired source code analyses
and corresponding transformations?

Regards,
Markus

