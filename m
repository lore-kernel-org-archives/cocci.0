Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48F8C433F5
	for <cocci@archiver.kernel.org>; Sat, 30 Apr 2022 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZFpADMpNUy2riU4+N7JTWxLSuEp4zLRopZiAue0Sesg=;
  b=WGieHPnlPrvead+Jtksi5tYCrV/fek7gqrUVdbXLucF/y/RyX+CFt16f
   DiMBYjAcENQdpqGukKoeUI0zmZDN5ggAMjbQcePylNx1ccrZyLFIDJRtc
   DcbL1lvVvD7IEmUfjb/kXeJvlo1nrmrjQGIxvGg5GFgXY/UuJ2fGEBVEq
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@messagingengine.com
X-IronPort-AV: E=Sophos;i="5.91,187,1647298800"; 
   d="scan'208";a="34054175"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2022 10:05:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A535CE00F5; Sat, 30 Apr 2022 10:05:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8039BE00BE
	for <cocci@sympa.inria.fr>; Sat, 30 Apr 2022 09:48:16 +0200 (CEST)
IronPort-SDR: 8ET62wkE7yJqd9z9JVfTQqw0s1Wb1HzdKOnnU0Aa4hk2neIykRxJw3HcNmM3l9lCR4jaI4/kol
 k6ejtk+0MEozEIPw/XOVrk1X3CyC1rsPOyNrmKZEC5uFUSGbPVWrHoxm0o+5TxDBhOvTfMutok
 gWL5mJG/LmmGN+rlkJdKoewNXUjSdmdDdK0Z7R1OR6SV4FR626rWjEIGG3TofbMBKKv30VZ3/P
 nf2k6VdjjLywZ/BU01wshIcCKuSHzQarazGacLq6hh5hwMpAXQICEqreSbw619GPlX+ceVdK1S
 03lZJP2s5c85o+OrKk65ej64
X-IPAS-Result: =?us-ascii?q?A0BfAQBN6GxihxwEb0JagliCJIFSLgcIQ4ROiQCIDp5eC?=
 =?us-ascii?q?wEDAQ1CBAEBhQIChTECHgUCBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEARMBAQEBDQsJBQgKBw4QBUFkXwSBSwSBeQYEMA2CNSkBg2QBAgIBI?=
 =?us-ascii?q?wQZAQE3AQQLC0ICAlcGgxCCdCSuUX8ygQGCCAEBBoYJgVwJgTyOWSccgUlEg?=
 =?us-ascii?q?TyDAz6IG4JlmDdskmiDN4w9nnsIg02fbQZCg2KSZZINLZEGhS6nG4F3gX8zG?=
 =?us-ascii?q?ggoCIMkTgECAQIBDAECAgECAQIBAgkBAQKONoNZinAyMTsCBgEKAQEDCYxnA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 sz0x08=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Oork+6HzjR02Usg8pLqEL8eALOsnbusQ8zAXPiFKOGZom6mj+v
 xG885rtiMc5AxhOk3I3OrwXpVoIkmsjqKdg7NhRItKNTOO0ADDTL2Kr7GSuwEIcBeOkdK1u5
 0QFpRWOZnVIRxClsDq8GCDcuoI8Z2i3OSQnuHO3zNGRR1xZ8hbgTtRO0K+PglMSANLBYU0Gf
 OnifZvln6FVTAsYsO3CmJtZYT+jtfA/aiWBSI7Ow==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,187,1647298800"; 
   d="scan'208";a="34052574"
X-MGA-submission: =?us-ascii?q?MDFHOLc8l9igdThX6YPT2+s7fs/qNEGo6YQCuc?=
 =?us-ascii?q?dGWHzkr+8+Lu2aD2XImlBstBjtl/vs13TGu6Gtn+5b5gf/msmvoIAhlY?=
 =?us-ascii?q?aD55a9tt3xI6RnPpzw1mT8IL2K8xlCPjjTzzTJjYnJGRnChtfEx2WrLy?=
 =?us-ascii?q?Covk3QfKCQOV/J4pLhO/M8Lg=3D=3D?=
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 09:48:16 +0200
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 66B8E5C0118;
	Sat, 30 Apr 2022 03:48:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 30 Apr 2022 03:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651304894; x=
	1651391294; bh=ZFpADMpNUy2riU4+N7JTWxLSuEp4zLRopZiAue0Sesg=; b=F
	5lrgzGcuMx9mm60H01rA02mgRiyjGEBznrdLP+7DEcGxzkKrEVmiGO6Rfkb9TbPd
	RNkVkck9BWGiLhmhs/nysWJdbZ+phTZ+pgVKoJ8o9bz4EbKSQ4wyxi87nl5ndt8v
	eTQLIqdUqV1YdG/esSlrFEup2B8uT678ZunOuzoOTq6SilK6IO7TegkeNTgsdYxL
	LfW/33m2bHQS5Xvg/JHAsUQwj/xdfqSKcjTALUqiuEcJCz7mSv2VXN5GTcxnEOT6
	cdzBpTzphV93/3VFkxvrLZYPU+GCnPAE3jkgT1IkiiOLn4XGUlhEMstusZKwXVlY
	rR5Jyef7bofb8kS6GTmSA==
X-ME-Sender: <xms:velsYlBw3Xt7nn5a_BDYeEKDz9DanKYo3V_BJGs3yvyd-YR9PSak-g>
    <xme:velsYjjO5uFDCmt4bGUcgWqe4GhdgAGjCDEXZK_8UErxUR6TagYHh-fFfO72ff1lX
    VPBgRAkSRXIDLBC1N0>
X-ME-Received: <xmr:velsYgl2jC98YL9hNRTFGjC2RX4AwpyKvu1tLe5AmjvKBsnaX_qnimi5goHy9V69EMZUGuzhlQsYIUcDgMAO5SOVC_1lUuC1mYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:velsYvzDCVSwQqVHOs_snB2kZpuH-9-ri8QbNnzga4LwDvbVvzoJqQ>
    <xmx:velsYqSe0P5ei0BuPcIzQZh1R7Hjor0p7SDqIbYPfONFON5SadOnvw>
    <xmx:velsYiaAceUm1vNUAoi9uaPoaAhgloYAX2OpiAoIWGBN3rp0EGxwSA>
    <xmx:vulsYtHyWD-AXIRk0WcCds9ejukXBUHsrL4c5ma87oi5UnsEdOrZtg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Apr 2022 03:48:10 -0400 (EDT)
Date: Sat, 30 Apr 2022 17:48:06 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: Wan Jiabing <wanjiabing@vivo.com>, James Smart <james.smart@broadcom.com>, 
    Ram Vegesna <ram.vegesna@broadcom.com>, 
    "James E.J. Bottomley" <jejb@linux.ibm.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org, 
    target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr
In-Reply-To: <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
Message-ID: <eab847fe-8d17-1a38-b55e-e68a2f6a1829@linux-m68k.org>
References: <20220318145230.1031-1-wanjiabing@vivo.com> <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-987175101-1651304886=:14454"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] scsi: elx: efct: remove unnecessary memset in
 efct_io
Reply-To: Finn Thain <fthain@linux-m68k.org>
X-Loop: cocci@inria.fr
X-Sequence: 363
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/eab847fe-8d17-1a38-b55e-e68a2f6a1829%40linux-m68k.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-987175101-1651304886=:14454
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 30 Apr 2022, Christophe JAILLET wrote:

> Le 18/03/2022 =C3=A0 15:52, Wan Jiabing a =C3=A9crit=C2=A0:
> > io->sgl is allocated by kzalloc(). The memory is set to zero.
> > It is unnecessary to call memset again.
> >=20
>=20
> Hi,
>=20
> Nitpick: this kzalloc() should be a kcalloc() to avoid an open-coded
> multiplication when computing the size to allocate.
>=20

Seems like kcalloc() conversion could be a separate patch. Perhaps it=20
could be done everywhere using a coccinelle script.
---1463811774-987175101-1651304886=:14454--
