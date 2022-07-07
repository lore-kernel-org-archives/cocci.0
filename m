Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064C3C43334
	for <cocci@archiver.kernel.org>; Thu,  7 Jul 2022 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M1oG5oUmnr35YGtqgzU4uDkjckn3fYI11GMFMUJGPd8=;
  b=jh+c6KxSyKPFqjdIc6AaSiiCKYe758gHYX/iCxZ7gmYCNY0ZeUjy4Nsr
   Kkd8pH2K4x6lLuwiGhLhjgWAPTWnX4QctPNKUvZv4UfbYRT8MsHPEj8Oj
   vY+tOwpLq4IFWpWVHcTDvMp5BSIm0W/JSNjzrdWlzLL7oPvODQM4SW3g9
   0=;
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
X-IronPort-AV: E=Sophos;i="5.92,253,1650924000"; 
   d="scan'208";a="44745510"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2022 19:38:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7EE7E0356; Thu,  7 Jul 2022 19:38:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E9BF2E0092
	for <cocci@sympa.inria.fr>; Thu,  7 Jul 2022 19:38:30 +0200 (CEST)
IronPort-SDR: 9o19WQ6lRNMGz26J3oypPAoFcNRzlWknxtT6HJweJA0PHJ62mMbzdTYmgKW/6tfe6Cjap6zaBr
 JGg9DBn7mPSmGbJvVz/jiEeKbLPOZjASV/nid7az8dS/wYnWIS4j8Uo0JEVwOm2uBkR4Vml0vV
 4N8xCbtaNATSdLBxyqs4xS06pnKlEgKQq7UEnU/lYz0Dcn6hJk+8P6hT8yiT8DhLPJPo6N0Lb0
 cmtyKDDnAK1BMOSPwPvy8r2B44Rj/Go+UiwVnFZa3LJEn0vqwwcphFHZEHidCq0bHYMbwVRsYL
 3grGYPTgh5uyKPhruDrGmARz
X-IPAS-Result: =?us-ascii?q?A0AiAAAqGcdihk7ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgiSBVy4EC0WETpBfLgOEJIcOhxyKO4FoCwEDAQ0/AQIEA?=
 =?us-ascii?q?QGFBAKFTQIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETA?=
 =?us-ascii?q?QEBDAsJBwgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEEC?=
 =?us-ascii?q?wsODAImAgJXBgEMCAEBgnmCZQEDDSMHrR6BMYEBgggBAQaESx8sIlKBXAmBE?=
 =?us-ascii?q?SyKXgmEFScQgVVEgTwMgnc+axoBgyUZg1aCZZsBJgQPAxotLxKBH24BCAQDA?=
 =?us-ascii?q?wcKBTAGAgwYFAQCExJNBhwCEgUHCgYVDhQcEhIXDA8DEgMRAQcCCRIIFRMYC?=
 =?us-ascii?q?AMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQAgLCgMRB?=
 =?us-ascii?q?AMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJg0NBBEKB?=
 =?us-ascii?q?x0DAwUlAwICGwcCAgMCBhUGAgIYVi4NCAQIBBgfJA8FAgcvBQQvAh4EBQYRC?=
 =?us-ascii?q?AIWAgYEBQIEBBYCEAgCCCcXBw0GGBsZAQUJKScQCSEWBgofCgYFBhUDIUcmB?=
 =?us-ascii?q?Qo7DQIoNDY8LB8bCk1NLAkiFgMEBAMCBgwOAwMiAhAoAQYyAxUGKxUVFgYTD?=
 =?us-ascii?q?CoqHAYiARsCnRyDflnAPjQHghSBPYFEDJ4yBhMtllYOBpF7lnYgogmFHIF4g?=
 =?us-ascii?q?X4zGiSDN04BAgECDQECAgMBAgECCQEBAo4dDAsCCRWDbootPzQ7AgYBCgEBA?=
 =?us-ascii?q?wmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23: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
 HLrYqBWXho5G6FCYnk=
IronPort-Data: A9a23:EgEiGK+S5UKwX7nqf0bhDrUD6HiTJUtcMsCJ2f8bNWPcYEJGY0x3m
 2cdWTiPMqqJZ2vwfN4ladix9RlT78DRyNRrGgA+pXtEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9j6mJUqYLhWVnV5
 out+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z2
 dN9jZuCcCkSDKTnl+IHQRMGFQN3MvgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8oRz4Us
 6VJcnZSPnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2TtY8DhWZg2KiiG973V
 5UWTWF1XS7YSAxPGQkdEqNhnbiR0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc8NZG
 3QTyBMAlpo730OtVMv3ARuaqXHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWFzj
 A7YxLsFERQ+7OzMERpx45/O9WvaBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmgn
 FhmTwBk393/aPLnMY3lpzgrZBry/vD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxZXBtbtUV8vdzX3WKAnoIF1Pz6nVWNE7qQE/d6TNCxzxohZPgKgNvGAgfx0B3jgsI2e3P
 xG7VfxtCG97ZSb2M/YuPepd+uxzg/GoFNL5W+rSY8YGa5cZSeN01HEGWKJk5Ei0yBJEufhnZ
 /+zKJ/wZV5HV/gP5GfpH481jO5zrghjlDi7bc2qn3yPj+HFDFbLEuhtDbd7RrtlhE9yiF6Iq
 4o32grj40k3bdASlQGOodJIfQlWcSRgbX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRoxZybXF+
 G+TQEhdxAatjHHLM1vYdX1pLr/iBM4toXU+NC0qHFCpx3l6PdfxtvhCLcNvcOl17vFnwN51U
 +IBJZeKDMNPfTKbqT4TWp/w8d55fxOxiAPSZCeoOWBtf5NpSwHT1MXjew/jqHsHAiat65khr
 rfm2g6CGcgPQAFrDcD3bvOzzgrt7CZHx78oBxPFe4ABdl/t/Y5mLz3KosU2e8xcew/ewja61
 hqNBUlKr+f6o7gzrIvDi5eCotr7COB5BEdbQzLW4LvqZynX+m2vnd1JXOqSJGmPUWTp5OO9a
 O8Tw/ylaK8Lm1NDsoxdFbd3zPtitoW1+OIAllxpTCfRclCmKrJ8OX3Yj8NBga16wOMLswWBX
 E/SqMJRPq+EOZ++HVNNdhApaP+PiaMdljXItK1nJULn+Glo8bDBXUgLZ0uAjylULb1UNoI5w
 L596ZBMtFHl0kInYoSckyRZ12WQNXheAa8pgZEtBtO5gAQczFwfM4fXDTX74c3UZthBWqXwz
 uR4WEYfa3VgKkv+n74bEH/QwaxCiJ5ItB0iIJru4biWsoKtuxP19EQ5HfcLosB90RhNle5+U
 oSuH1MgPr2Apl+Em+AaN11B2Gh96Nmx5UH7jVcE/IEco49ESUSVRFAA1S2xEIz1Po6SkvW3P
 F1V9Yo9bQvXQQ==
IronPort-HdrOrdr: A9a23:zCf9y6hXyW9LfSINQDXId7nmLXBQXv4ji2hC6mlwRA09TyVXrb
 HIoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW3FdAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,253,1650924000"; 
   d="scan'208";a="18831986"
X-MGA-submission: =?us-ascii?q?MDEOehjxEPTWrUj9C09eerF59cPB+Pe1kXUwsA?=
 =?us-ascii?q?B8Je4Ra4DrFU4tWN8GvgrP9kDGnst0LTmWqvuMO42BDxwmoBlcElPhXa?=
 =?us-ascii?q?gXMbFuxXSjObKTFhcqieCZLjaYjESAr2ewkxy2J7CegB5/VsFjqQua1v?=
 =?us-ascii?q?SiJDJf/yBzZTFsVBSAuLB2qA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:38:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1657215507;
	bh=5bhow4bXw7UqTiThEqxCuc/x1f2ZUN4whg5R+sF4vyk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=jSMjgbcC8Vt6h9Q5hb3LbNvopOkix8p05m0m3qpYuYe/MEcv5FX5QKGuRXAeVGpw7
	 qbKMqIapmVUVjRTpc2Ct4pMl3YmLqdxJkxjtG3tent9YLWMEGag7APMVMf9FK7SJB7
	 WqScXtrnSxtqdPzx+6wHVXdbTo1RHXQ4YPTCY0ac=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([2.244.151.22]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1nZ4qM1lWH-00aUMm; Thu, 07
 Jul 2022 19:38:27 +0200
Message-ID: <a4f59524-acdf-3431-e4d3-de9aa90655e9@web.de>
Date: Thu, 7 Jul 2022 19:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: Philipp Zabel <p.zabel@pengutronix.de>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <20220707092030.3319988-1-p.zabel@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <20220707092030.3319988-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+hBpCpJ8GDXYi1M8ywKM9Cg+ItbvuJtfzRcQ+BwUejuJrZvqNmA
 GmWS2o1Nb3dqzXPKUXFJqD7NuhBp279jzO9zcKNMPkOr6SCbk2ZqDSOZTmUndJ3kpTPFUJf
 mcj2Gpho0u9EHj9cMjvi1+WZ9SbQvHdN1fYbopVSsWtDU3yr9IWXyOyA4V+zQ+4DdGdNPMp
 FHigc9yVU7/6a7HSsAgeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQWHaDlpkIA=:LrBKhq21uRx6UAghxwZGff
 hfX8l185G30RYz/oOPs6dvoRrnVdsSjsuYk5V4T3JvKUUg9CebOr11uc4FIsRlNvLwVovIiOS
 icUBL7noIfIl2606qfiIA4C42dUcVhFd4phTn5UHp0gdkst7wrwPosx1ryB92t7PqhDp9LnhS
 Zx6sPP6vc82NSi1+m0XaOFFfNQPYeCHzVdKvV5UXEAe3J+LQEXNyddyV478TrYWmrNrI6KD4B
 HqKLqVZcyCPxRccA8h1DAnArX1yEHCbKxWitV4m1OkUPh1ZJr6P+9zHL6O5EdLGHK1sT1B4+E
 XFJvucjdTmVbxVMDilh1UAnAtNDTvOA3Nfv1JCVwovuTx2nBZdGqy4YT3x3To58igKePkqwD2
 HusyqJT/u33VU8DzIuZPOczFRvvWyJkJcXo8DlOddcvz5lc1Qtz+RVXjZVDbYSDA5POF0UP48
 hK4afiCWuTNKKpNzqu+lcnOiFN6k0CIGsRAcUtYDU/8jHD4c7moulTN4fMvyI/R0qBn1B90zV
 xhUmTAn1wEEOEssr6AB0GTD4v71YWt0KppY1fMbI2MrVpCq9QQwXHiWoIAslhXPXV2dWF7xsV
 jI3Tj6ehlM66bnEWcG2QfDHHQqYE1psc617YdrXqtgc3XN0p7h5H3C0z85J9mnpElMG5zwGab
 7HfQjEnjuaoZ7URz9VGMJIBe4hQL7TuAdi2+Ypa6cbm7K3hqu/s79+rNGM2hL+5RPwiqh+aC/
 AzNcscRYM5Fg8p33i6Vwqy7a+DGYgBMY+8+i0J3Kg7JoClXj16GqFYR6w8pGMsFlLA2XD7Tb7
 1AjL6Gq1GP10VmoSb6DRr9ia7FA1Lj+dxEtq/8Z7dN4rVRc/dVrAr4d0EFNYk/9aeOjRMCQQ0
 Hr2IVa06jmVPhOqh9WFdwKCbEhqs7GwR02DwAr9t5tqwU56nUSRozVXEEMzsLVEE5kxnGoiv+
 QibbhW73y6ey8JWi+n6EK0OMYjA6fzj2yz9z0lCggSTWv6+JMpgt6olH3X7UvIdxz9+QuEP1D
 yLAb9qzgS3GOKSV8y0CIcExduGv87Vmuu+2hjpr8VDGpTX8/O5yu2UYRSQ7bHE0SN0SZ/Xtim
 BaOpqbIrhj1EUZlunXeeepocA9OoHvZf3rT6r/Y3ZZ9m1e0iI6tUEOatg==
Subject: Re: [cocci] [PATCH] coccinelle: api: explicitly request exclusive
 reset controls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 487
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/a4f59524-acdf-3431-e4d3-de9aa90655e9%40web.de>

>  scripts/coccinelle/api/reset-exclusive.cocci | 49 ++++++++++++++++++++
=E2=80=A6
> +virtual patch
> +virtual report


How do you think about to support also the operation modes =E2=80=9Ccontex=
t=E2=80=9D and =E2=80=9Corg=E2=80=9D?



> +@depends on patch@
> +expression x;
> +@@
> +
> + x =3D
> +(
> +-devm_reset_control_get
> ++devm_reset_control_get_exclusive
> +|
> +-devm_reset_control_get_optional
> ++devm_reset_control_get_optional_exclusive
> +|
> +-of_reset_control_get
> ++of_reset_control_get_exclusive
> +|
> +-of_reset_control_get_by_index
> ++of_reset_control_get_exclusive_by_index
> +|
> +-devm_reset_control_get_by_index
> ++devm_reset_control_get_exclusive_by_index
> +)
> + (...)


Did you order the case distinctions in the SmPL disjunction according to
the call frequencies of the mentioned function names?



> +@r depends on !patch exists@
> +expression x;
> +position p;
> +@@
> +
> +*x =3D \(devm_reset_control_get@p\|devm_reset_control_get_optional@p\|o=
f_reset_control_get@p\|of_rset_control_get_by_index@p\|devm_reset_control_=
get_by_index@p\)(...)


I suggest to reconsider the influence of data processing according to
the SmPL asterisk functionality a bit more.

Regards,
Markus

