Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E134C433F5
	for <cocci@archiver.kernel.org>; Tue,  5 Apr 2022 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7+lervbpy6gXxeBrivEVunvIrUU2KhGTP2hBrxL/QTA=;
  b=p0acRUs595/TEbG9Zc4gKOVsnHMGgWh6XPa+1USPGDxtppiV83QkXy//
   ULjkqityLVXjjOTNZNuDqVQvexjaYo7cYp88kL6rrIEuuHo0G+F/NdE30
   gyOqjijdz9URYCHlytGTp8PqEuQhI9D+PP6PSc7YUX6j0osOFbL60HxWO
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@lwn.net
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="30198136"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2022 18:00:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B984E0073; Tue,  5 Apr 2022 18:00:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B4BEE002D
	for <cocci@sympa.inria.fr>; Tue,  5 Apr 2022 17:50:25 +0200 (CEST)
IronPort-SDR: VU4SypMwUemqKBDOepUqWCHDFeP1t2aBdCirSsY7q5B9DXliuFIzUXjeulCjPAav2mBqUXd7Q2
 XIZmppyMiEiVaj+EmXiZe2JVeN4uYcBkKCUvgKXCHJqz+8iHg1TzFXYJk97ven+QHIcLIvBjqa
 s6utdmpDFOKdKdukKvwh2PUnK5DAylmXXHwtfmO4wGhOS0cijNsTAgLFykR++WSZEZXH3S5Hhl
 QDswuosAg04MbMQxrryyytRT1I8rRWFQZ6ZNVkCqvQ/J+fptEE+Z8AcN9EtjDkDgCDk4t3SBIE
 zxTlTpjJS+DlBFAJ7cOwQCli
X-IPAS-Result: =?us-ascii?q?A0AHAABvZEximBxYTy1aHAEBAQEBAQcBARIBAQQEAQGCB?=
 =?us-ascii?q?wYBAQsBgVFWgVUrBAtEk0eCKDCKZJFUgXwLAQMBDUECBAEBhQcChF4CHQcBB?=
 =?us-ascii?q?DEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEBAQkLC?=
 =?us-ascii?q?QcGDCMFPGRnAYFOAYF5BgQwDYI1KQGDZAECAgFAAQE3AQQLCyElDwERNgYBE?=
 =?us-ascii?q?oMEgmYDDSEBBK8ngQGCCAEBBoUTDYJDCYE8AYYQhCqDGXonHIINgRU2gnQ+g?=
 =?us-ascii?q?iGIASKbP4MKoh2ccURrg1OEFpVshXszg2KScZF+hHWRaSCQTZYggWMDghAzG?=
 =?us-ascii?q?ggmCoMkTgECAQINAQICAwECAQIBCAEBAgGOHBkeiBSGJCI0OAIGCwEBAwmFR?=
 =?us-ascii?q?CYTiCkBAQ?=
IronPort-PHdr: A9a23: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
 d5+O0v8OHKFmiW7D3iS
IronPort-Data: A9a23:cCeQ46PV+DuB1PTvrR2pkcFynXyQoLVcMsEvi/4bfWQNrUp332YAx
 mBOWW+Ha6neazD3ctslOou390gA7ZGGmNFgTHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DlW17V4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2nrv1r9
 I5V9qebTAsbM4nvtbomakBXRnQW0a1uoNcrIFC6qoqX0EuAdXbwqxlsJB1re9JJvLYnRzsen
 RAbAGhlghSrjOWsyr+nYu1zgIIlIdWD0IY34Sk5nG+FUqpOrZbrWonvovoJwQkLpdlQL+rkf
 NhINBFOc0GVC/FIEgxHUstix49EnELXeDpTo1O9vrsy+2GVzQpr0bGrPsC9UtiDWsxRmm6Kp
 2fM5W2/AxcANdXZxyDtz563rurU2yfkXsQUGaHQGuNWbEO76F0+EiFNTRiAivy1uEOaeP8BE
 HVN9X97xUQtz3CDQt74Vhy+hXeLuB8ARtZde9HWDinSkMI4BC7GWwA5oi59hM8O75BrG2Z3v
 rOdt5awX2Y36OXOIZ6I3u7M9WvaBMQDEYMVicbopyMr+dTmp4cv5v4kZoc/TfXr5jEZ9DeZ/
 txnhC0lwbEMi4gN2rnTEbH7b9CE+MChou0dv1q/soeZAuVRP9LNi2uAsgSz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOA0AY2TsV/rWrxpxZPmLy8Bhkhfy+F1e5bJlfUj
 LP75Gu9GbcObCL0N/4fj3yZUZtxlfSI+SvZugD8NYoUO8QqHON21CVvY0mc0gjQfLsEzskC1
 WOgWZ/1VR4yVPo7pBLrGbZ1+eJ7l0gWmDKILbimnkvP+eTFPha9F+xaWGZim8hktstoVi2Pr
 YYGXyZLoj0CONDDjt7/qtdJdw1VdCRlXvgbaaV/L4a+H+avI0l5Y9e5/F/rU9UNc319mria8
 3ejdFVfzVaj13TLJR/VOHR8bvXpUIom9SA3OiklPFCJ3Xk/YNb+sfdHJsVvJbR3pvZ+yfNUT
 uUef5nSCPp4TDmaqS8WaoPwrdA/eRny3VCOMiOpbSIRZZllQwCVqNbochGwpi0RCGyxuNdn+
 ++s0QbSQJwiQQV+DZaHNaL3ng3p5XVEwbB8RUrFJNVXaX7AyokyJnyjlOIzLuENNQ7HmmmQ2
 TGQDEpKvuLKuYI0rITEiK3Y/YekF+xyQhhTE2XBtO7kMDKc+nWlh4lNTL/QLzzaUWr1/oSkZ
 PlUn6ChYKVWwg4SvtouCatvwII/+8Dr+e1QwDNkK2qXPV6lPbVtfyud1s5Vu6wQmLIA4VmqW
 liC88VxMKmSPJ+3C0YYIQcoMraZ2fcPlmWA5Pg5Ohyitipsur6YVwNUMgXV0H5RK758MYUEx
 +Y9uZ5Htlzn20RyatvW3DpJ82msL2AbV/t1vJ8tALj01lghxGZEbMGOESTx+pyONotBaxF4P
 j+OiaPerL1A3U6eIWErHH3A0Oc1aU7iY/yWIIvu5mhlm+YpQtcyx1tV7jJxSAlJpvmCPySfJ
 UAzX3CZ543Xl9uruCSHd2SzHUdHCQHxFonZ1Q4SjGOAJ6W3fjWlEYD+UNphOGgd7GQaeDVHl
 F1dJKAJTh6yFPzMMuAOtYKJZhAtoRGdNuEPpSx/I/m4Ig==
IronPort-HdrOrdr: A9a23:TiYeB6ruYomhb3rL9xbP6P0aV5oleYIsimQD101hICG9vPb3qy
 nOpoV96feX4Ax6ZJhEo7290ca7MBHhHPJOjbX5eI3DYOCEghrNEGgB1/qG/9SIIUSXndK1l5
 0QEJSWY+eQMbEVt6nH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="30196474"
X-MGA-submission: =?us-ascii?q?MDHZcQR5yO0lOo02Nvn1sF4R5fWDxsIHBac3ny?=
 =?us-ascii?q?H/Nt96JsS54pZFso+bP82J8sIXak9uCBrytMGObrBKNU0I24EHcVyx/o?=
 =?us-ascii?q?KxtjQqqai0q1hlKHoK9fF2kt7VB0gh+1qi8byVBFeZw2EB28upGJfUSw?=
 =?us-ascii?q?ag4ndtrRlQq//LmU1M8lmBIw=3D=3D?=
Received: from ms.lwn.net ([45.79.88.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 17:50:23 +0200
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1B761608;
	Tue,  5 Apr 2022 15:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1B761608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1649173820; bh=7+lervbpy6gXxeBrivEVunvIrUU2KhGTP2hBrxL/QTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pCL0S9JpbndAJVkCNAkIKwDxISi6nnxklloexQ6eeoGjdVbCYbUcS2nMV1GpRvtu6
	 9NQ0lkceS1cH5tCqvEs/MOTgPSGrtE/fhm9G/sdeNbUoH6dv+wSeuUolH/qe3QCeZc
	 BGUIdIJR1dCJDXfeI3ecF9FM4J1yizFYN59Iixc4w6h1r6XGEoaCDoRx6+2dgdtpr4
	 HSyGRMADKpho8RVLVzR71/bG5fT0y0P0QzF/IUdgqI0K153OheSBzrRR0wL0+8ZYtI
	 5LUw4JAVkkPjZs7rzKwZfgjh2zF0RYX3KTXhpc/6XrHLGjD/uwVbPUBWuG0WyoOPJl
	 5XRazNzgYMahA==
From: Jonathan Corbet <corbet@lwn.net>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Dongliang Mu
 <mudongliangabcd@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, dlatypov@google.com,
 davidgow@google.com, linux-doc@vger.kernel.org,
 linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
 Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
In-Reply-To: <YkWaL26K7UjKB0sa@marsc.168.1.7>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
 <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
 <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
 <YkWaL26K7UjKB0sa@marsc.168.1.7>
Date: Tue, 05 Apr 2022 09:50:19 -0600
Message-ID: <87y20jedhg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 1/2] Documentation: dev-tools: Add a section
 for static analysis tools
Reply-To: Jonathan Corbet <corbet@lwn.net>
X-Loop: cocci@inria.fr
X-Sequence: 357
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/87y20jedhg.fsf%40meer.lwn.net>

Marcelo Schmitt <marcelo.schmitt1@gmail.com> writes:

> On 03/31, Dongliang Mu wrote:

>> Should we include static analysis tools based on LLVM? For example,
>> Clang static analysis.
>
> I think that would be a good addition. I haven't checked out Clang tools
> though, so it would take me a bit more time to write something about that.

That seems like a good topic for a future patch.  Meanwhile I've applied
this series, thanks.

jon
