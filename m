Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F60C05027
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cAh9SAdIVPuTSBDmu4u9RCnscFXE7ILBPyiZguQaBso=;
  b=BrJzB5IGrMhnQZxyW0yOv+kABPYaa6F9+NioiEohM+ngqEQbgFC+fqCi
   trnhk+v80dsp3Wq3OITryQ1Dk1eBw+en/3ec9LApWNyqu9RvFu8sw/uiJ
   z2janmhn/yCSSucMpVB/hq0oWPRgIEv8g4/Qi4mSzNkqjnz1FO16+gtFk
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89934979"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 19:01:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB0CFE7441; Sun, 29 Jan 2023 19:01:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC3B1E743F
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 19:01:34 +0100 (CET)
IronPort-SDR: 63d6b47e_4Op5xb0P1QrBqnsDdgH6y9iS+ZqjiYr/UruCXjtU5GUr+uq
 XyRmc1lxw77cYEEVbfRBCsbXquDJGw4ZqkzDs+w==
X-IPAS-Result: =?us-ascii?q?A0GaDAA7s9ZjhwMP49RaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBCFYuBAtFhE+RIoQrlzyDFj4PAQMBDRQBAScEAQIEAQEDAwE6gVOCcwKFJ?=
 =?us-ascii?q?QIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaC?=
 =?us-ascii?q?RcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECR1M9AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCe?=
 =?us-ascii?q?gGCbQEDDiMHDKgzgTKBAYIIAQEGgUABmkgfLCJTgV4DBoEUKgIBAYx0gzZ6J?=
 =?us-ascii?q?xCBVUSBPIJTMD6CYgEDgV6DWIJnkGGCfYgKCoE5dYElDoFGgQ8CCQIRdEAlB?=
 =?us-ascii?q?A4DGSsdQAIBCzsyCj81CQILSisaGweBBiooFQMEBAMCBhMDIgINKDEUBCkTD?=
 =?us-ascii?q?ScmaQkCAyJiAwMEKC0JIB8HFREkPAdWNwEFAg8fNwYDCQMCH09wAi4REwUDC?=
 =?us-ascii?q?xUqRwQINgUGGzYSAggPEg8GJkMOQjc0EwZcASkLDhEDUIFNBC9egQQGKSadG?=
 =?us-ascii?q?YMtLIJ3rnGTUzQHgiaBUoFSDIl+lHkGEy6Wfw4GkhyXTyCNMJpDgXkjgVwzG?=
 =?us-ascii?q?iRPgmdPAxkPjjmEDIELkRFANAIJMAIHAQoBAQMJhUcBAYZaAQE?=
IronPort-PHdr: A9a23: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
 IUDQPlXWQ5sfhv/IltoFpoOLcUvNg4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LYcv3KAfJmEAQznlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46288383"
X-MGA-submission: =?us-ascii?q?MDHYjy+dLuaFs8UrJxnzoCpkuU34Ni/v3Xq2Zy?=
 =?us-ascii?q?3RNjCI/h7tp70D9QBmc8x26HaqhSjYp5Kp2UsUkMRzZzuV+oD3ZOo10s?=
 =?us-ascii?q?/3M2/vEZoEipUMbw0DcnSpzy6xOYA3NHsfRjgynHYsmRAZwP4tvKfV/V?=
 =?us-ascii?q?DU8MxbziUHWHoHJ27De5mrYA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 19:01:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1675015292; bh=0SrjidDHeMdrAKJ5vkYOjWC5OmGnMve3dAcl6eYt4to=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uzmhy9XC4G/hE8qaaHLjusKM3djRqX1JejEBNugmnK/uxBrylT1RmGQHODwEpJGRU
	 VTjuHsMePX8DjUa6KRMOC6VTxEMCgvYxZFw2bBubneQgVb7Yx73/q0fDWF+t2bBpWq
	 fnyWucK1T3ljG35WI/X9ghUD/2w1u6o0AJL2jCN2KIc3CLanhMLxb15MSouxib4LVE
	 VGfu1ihimnqXYqIutkvqbwdxnTVt1J9b585cy+EuRKJPtAHheQrzEaGYcB6TZxzAue
	 i2P2UyY+5Hu7oevrJ6kw5800/Gqa3kaO2x46fT57lYVA660gFgrjSkbSKLi/12Fk1j
	 R3ImRx8VVskPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1oiAXf1JDf-00eb7i; Sun, 29
 Jan 2023 19:01:32 +0100
Message-ID: <0913ebfd-6ec2-722a-fc17-e609ce0b8770@web.de>
Date: Sun, 29 Jan 2023 19:01:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Luca Coelho <luca@coelho.fi>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GksfNx1DL0gqi1SeBMVGo4RWkwVSlsd79PkJBCUJaDnvFd50IUB
 HUHSF01RUBdgvG6RyvyaujG5lSbzendq345d0+OFuVKsDkVx+IBEuMu1GN4KtUWD257xR5L
 +TeuNHBUxbiiamJr6o/vHZAv564ebhCoUeV4dBnmObscFnE7iuhTStO7oDRzZMCC8EfYMrr
 D5abemJ/F0bsXp2i1t7eQ==
UI-OutboundReport: notjunk:1;M01:P0:XyzUwkCu1Dk=;UjzfLd1yzZN6rG3C9cpF9+Lh6Io
 mWWq9bmOhq1n1CtY4quJ0i5kFD5aKoHToiLRkEL0LAN10sp9dXh7Cj6n4F9KCsB8cZDuKSe6X
 +fYE4Q/5L/Wye40wWMIe9Sc6QnouVsP/fb3uJbazcq4qCFrTu2TTyUjo5LfcaMLEReLKEXwqN
 4UtcY5LiIyDooFJDwguqWFS+3fsvOwNswPS0K2QNx/2zJ7UQJi6jzZijTjkFnw/S+L2YSQuXg
 JO/h30TzspLYoe/un1hhFC1XUjD8bfuI3sXkpAR7pIn1M4EBeiSFbw++qvkPSh2wn60buicOJ
 /wrfcHNiRr0SzSJrhOeiKAcpPZO390avbJsxKSDH3vRYvw8sit8wiwlXW7CcjebBBS1l86iP4
 4CaOdiERKgB3t8BUqHxivJ1/udrpSTVnGJmSYiEQHyUjKbpp6U4H5z8enuS0wK/rCCOH9KFEt
 wQX8cc+6EXk28UnFygMdgdb4bLrlZoBdzxEc8fOV+umtooEbVXyy2CiwUb7KORvr6TbXeR8um
 hlmnxSe8L9gam3LTZCc40R7yr0ipRGa77gFZCZFwSYvBA41fbSo1k7UG0zXEtIFK3PSz0S4R7
 cCi/iVxp+hG78hB362mb51ZCb5MhXLF06+W4vS9ICyPoi8wrNGLBueyiZFztadY/Fsps7PSX3
 cT4fjOlbVZHdACiZ0xmK/FxLprfSdD/nBjnb1l1QKBGx7GXLLkFO9K7gyyMhxaGD6hpdKL0rp
 QoW6IxHzIots6dzm6B8NQT7AgBbj/zGC1tIkMKOdu4N8a9QusZQdC8oIn7vJkGsq0+yK5rBvl
 Yn+QzKFob+tZvt43/U5xOabo4Ghfa1Xu93F6A2V0C1K0nFByN6rP2wcvjgElBrNAq39obb7MW
 H3k5Q7w61f73LlfSXo1xEMPQzatZ/Flz7T3KoW6L14K5RAXUmHx6bFhdXeUh6y+wqJNLWEtez
 s3iQJg==
Subject: Re: [cocci] Adding a parameter for special macro calls with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 837
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/0913ebfd-6ec2-722a-fc17-e609ce0b8770%40web.de>

> @macros_noargs@
> identifier m;
> expression e =3D~ "dev_priv";
> @@
> #define m <+...e...+>
>
> @nested_macros@
> identifier macros_noargs.m;
> identifier nm;
> identifier list il;
> @@
> #define nm(il) <+...m...+>
>
> @@
> identifier nested_macros.nm;
> identifier list il;
> expression e;
> @@
> -#define nm(il) e
> +#define nm(dev_priv, il) e
>
> @@
> identifier nested_macros.nm;
> identifier dev_priv, f;
> expression e;
> expression list il;
> @@
> f(...) {
> 	...
> (
> 	struct drm_i915_private *dev_priv =3D e;
> |
> 	struct drm_i915_private *dev_priv;
> )


I suggest to another look at the isomorphism =E2=80=9Cdecl_init=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b9603af4eca7f4c771d57=
a3861855332e9bb1c4c/standard.iso#L465



> 	<+...
> -	nm(il)
> +	nm(dev_priv, il)
> 	...+>
> }
>
>
> The idea is that all the macros that are implicitly using dev_priv,
> will have a new argument where dev_priv is passed.


Your description evolved for the desired transformation considerably.


How do you think about to use the following SmPL script variant?


@macros_noargs@
identifier m;
expression e =3D~ "dev_priv";
@@
#define m <+...e...+>

@nested_macros@
identifier macros_noargs.m, nm;
identifier list il;
@@
#define nm(il) <+...m...+>

@addition1@
identifier nested_macros.nm;
identifier list il;
expression e;
@@
-#define nm(il) e
+#define nm(dev_priv, il) e

@addition2@
identifier nested_macros.nm, dev_priv, f;
expression list el;
@@
=C2=A0f(...)
=C2=A0{
=C2=A0...
=C2=A0struct drm_i915_private *dev_priv;
=C2=A0<+...
=C2=A0nm(
+=C2=A0=C2=A0 dev_priv,
=C2=A0=C2=A0=C2=A0 el)
=C2=A0...+>
=C2=A0}


> After mangling a lot with the rules, I can see that this now works,


This understanding is nice.



> but only if I select the vlv_dsi.c file alone, like this:


This observation will probably need further explanations.



> Of course, I can work around this by using find and running spatch
> individually in every file... But not ideal.


The Coccinelle software should take care of corresponding source file sear=
ches already.

Regards,
Markus

