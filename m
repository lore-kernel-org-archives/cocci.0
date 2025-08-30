Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83228CA0EFF
	for <cocci@archiver.kernel.org>; Sat, 30 Aug 2025 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=po9YepRIPiIi/uu6plyfJlFEf3g9Jra4b8InN8MIXpo=;
  b=jIN32RWoLSqRU82RuVv7ftAoqRDXD8gg1U6Ca0CjbxzbGQo2UuHfux65
   qeNJ3S5HCIQQXcqNcsstNkKtIxV9NTrXjaXEo1Ajb2U4h5OWSJhW5+1Tv
   ok6mgFpjxk9WWMEir+yEoihK/6K22wKcDrHvCNEPMVq8aQjnnVlxBudQ8
   I=;
X-CSE-ConnectionGUID: EyeG2X1GTI62FNmALDw63Q==
X-CSE-MsgGUID: acA6o73RQgGLwuc2TZIwPQ==
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
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="236733367"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Aug 2025 13:37:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62286E0B0D; Sat, 30 Aug 2025 13:37:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E45EE0172
	for <cocci@sympa.inria.fr>; Sat, 30 Aug 2025 13:37:15 +0200 (CEST)
X-CSE-ConnectionGUID: aOZMsphRTnOPIsCMR2XaDg==
X-CSE-MsgGUID: B44synnETdu6rNeHwFB4eA==
IronPort-SDR: 68b2e26b_lH9AlY17aoKXw9OChZ4saObMRvb6YfesZ0VBJIrhwzls+WT
 Xhm2In3AyWk2Hs4Fd5EJ/h8nvCK6/7btDDPeM1Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FyAAD34bJogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCPoEBBlQzBAtJBIRRiByHNIIkhDuHKYdoik6BVicCDwEDAQ1EC?=
 =?us-ascii?q?gECBAEBAwQ4hEgCjCcCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw4KMYZPDUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwINBzNEAQEBAgEjHQEBESYBBAsLGgImAgIgNhkCAQGCfgGCIgEGE?=
 =?us-ascii?q?AEDDyYHDbRMgTKBAYIMAQEGgmnXdR8sIlmBZAMGgRsuAYVrgkYeAYpjJw+BV?=
 =?us-ascii?q?USBFScLgkcxPoIfgnGDDoJpgiaBFoNYiCqEMIJdiCdSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDA4EPIw88BS0dgSd5gweBDYQdK0+CG3KBdT4ZQINTHgZrDwaBFRlJAgICB?=
 =?us-ascii?q?QJDPoFvBhwGHxICAwECAjpXEIF9AgIECEACAQttPTcJCxsGPZVGhGiCMZZdj?=
 =?us-ascii?q?HGBNqEIPTQHgjiBZ4FkDIoulT4GEy+DcZNhDgaTBZkGjA6Beps5gWg6gUkMB?=
 =?us-ascii?q?zMaJIM2EzwDGQ+OIYQzN4QpuApBNQIBOQIHCwEBAwmFRgEBilCCBoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:5EVtpa5P6dDT9jfongPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:V28nmGxEKITLmU6Ey3W1BgUdPfIAaWXd9kvWBHeZEk1McuelQHOfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Anp+x6Q+eGUyYWdV/i4o+UUSQf+00v7+/DkYgrZk?=
 =?us-ascii?q?b5dOiOAxvFR3BgR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="236733361"
X-MGA-submission: =?us-ascii?q?MDGCsBoDbaEL59WoeyOVYw9k0g/4lNJs+VSSiA?=
 =?us-ascii?q?nB8ph7Sr0DQLvnj8vEWPgz1lSMvDFTNWLh6cU0l4bj7od9iaUBRiwgYN?=
 =?us-ascii?q?a3hvYy0bMrexUdBmRV9zGSSKDNwb2TFMrbVEMlKH9RlohmpfmDrnbArg?=
 =?us-ascii?q?4E+ezKrEhQ7E4brcX9lt0GuQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 13:37:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756553832; x=1757158632; i=markus.elfring@web.de;
	bh=po9YepRIPiIi/uu6plyfJlFEf3g9Jra4b8InN8MIXpo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UDyajAIEHi9Op7KjWYEyoTib3PnrEYXIUslN6M8RZ+AJafdzLBzEdGIwN5VI/Hxb
	 9xFdZSuWCYhhtJP8b8vOi/iL9SXAFPCpmb7JKJcG5W7AdxbtEl6bZ3ONGYtsHXdBW
	 Hj1rySFETga/QyrmGDGde3/J30kRcok077YUPuJDdREKQTrmBgULk2+rtZWUWWHsl
	 sHFzIMUPcaxDZDbLwTPUqsuIS+x4loNYs5mADhGUfx4NqWMNN6GR+LWI+e/GJPNNT
	 PAqOa9TqjpqozfT5v0oiLwkbL3lPxpy+DyPA4KXXElPQ6WoYJJW7M7vX2r4vKu56/
	 zl7zkPZbtTK7bx9xyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.198]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YNJ-1uqQDZ1Avh-000VbA; Sat, 30
 Aug 2025 13:37:12 +0200
Message-ID: <fa82455f-6294-4200-ad6e-c31add12b303@web.de>
Date: Sat, 30 Aug 2025 13:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
 <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de>
 <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
Content-Language: en-GB, de-DE
Cc: =?UTF-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
In-Reply-To: <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+W8tzf62ZPGP67mfEc0otiVZm2H1rwsb6BslM9qF8/8qWTyyp54
 2hqwwNKIT2rERiqQpcFAsYy8JtJdN9p37jrqOQ6CeiegreIoYG/+5BDxdt3IOLaJiVFT91n
 +gHpWP9XVyQH1FIP2GFqdgLK4K5vRzo2y0CGySXKJI4E3wZRfR5jqRmGLEE1ztYIHlwlpE2
 BN1cM5yGAnVZGuZtVbdxQ==
UI-OutboundReport: notjunk:1;M01:P0:jdmghmiqvJo=;Tokm9M5KR9uwsdEG06upnCgWtlk
 +M6bYQ27+6dKU6/R/0eBB/G476TZdhsuw9ApmJl1kIZ9xI9Ly7k/Okcip+kEf2NJNtoTkXjJD
 +B1XREygnsdCJtV6G64oMu9XFXmz6g7cSFxENpQEh308CIsYGsuaLAcywve+pyl01UXu+tzV9
 4MFFhKdVCMKiSlii0lICQZGcQ8L9GpIXIlcNBrKB32oXIooDfTmPrU3GlFoHPsFKFHeSLLsyO
 6p56WSulTMWzbdiq1a+PW08sufpVe+D2IERPGeDGwlxez4ilVXB/EFQ+jpIa2cSzYwMrbmLqJ
 ArOKYmIUOyckhKtf3OdO4fEmFFcbNXWx+jd72oEVdpFXx8fsrcSENsNvxNQkSSB3RbLCjIANF
 UcElyYMQPGZ2UJfL7oxjiMSFnQbmfOYUQ3YdcYSTKRquG0oEw4LfWmrRbePnDaM7pg2DyXeV9
 zsPzd8dbr3+ytR34for1w2hDk895soPjq+NteLVU69iY3R6Rlnhn4PEqcFGM9QBfGLTIOrlZL
 k3QJobzP6YwA5FlKOdtwzyAT3Ec3oXnAmJm6PUDsnI5WTPdG+LeLOSk/mp2SrNIK+FBWNxCxP
 TJex8iDEXg5Y+HpptxnFosE4xMn3YzvfOlk2scXs9w4dd0H3Vay+s+8mhO2bWnFVl4H8Gkec8
 Aro7yg3LIu65fueSmPT49uyX45j2Xz9lWAludULDb7/uWBUHmBGZOHICpvGIPdHx4NIYESzvD
 iMFDnJDDTusDkyCjpY09H8EcTOc0zzlWxVucXJpGY0v+/aXAjGPL2Cirvwdqka8GwdjLgcWr0
 XFXPbTgKl+NJDJsWnuufV70dIcECiAsWC2gLUY0ssK2mz0GN+pl5zd6Eg7945ExV7kKywoX2D
 6FXPXmdaS0aDTP8oQG4/iN5MqAWu/bOwuI5rwQ6zFKOAn0T/p02Lb+QeR/532tAPyHhfIV4hU
 l0z0AvpzjE3CF/Lzn5ECrgwttzSRD2zM7YsG/v29Dg3X5F+WSqI1AoXTNuDwpTLw1OIBjZrs0
 I5eYgorix6wWpiE4wViOVmyi/76zhYJsEN3tFJoFJx4dL4FY/28nEO6pDyJZJU+VJftWUBdfn
 aXFnGiyhoYf+6iWTCpPfW8kOXKgHfz/i0CNHm5UAovbVVrPg+PRoxiKCmLmHxDbayTL9gJiaT
 KQgqBC2ov0VO95yXv8dVo8CpHW72zD+KfhNZpVo/d2dgSQrdxxonPCyWCYnXhzpwfIvNVTOKk
 MxqA/eO7sq5g6jzAMFvfNlFyYpkNYRtfylH1/E/n2uT1D/cT2ywbNh2SK1K1wwQ8jKW/jDv6e
 buFZhaO3bHHIOGevgyFKKPD1J41l3mUmSIbu2ot5ARF9+b1pJtM1UEKOJAEvCL89cXtzDE7Kb
 ztbRfW62aA6/KaxqHFsAvbxhXCsNNyVB+KeqtqRVT9wYKN4IS6GX/8DRQ2sUHwngzMW6Dke2m
 64UG+6MJENcrEJBiC+g9wSfLy3YsXkjxatpCyBmhQ7arCZjKALqaWRWMN1kGzdH8fYP4XoxoW
 EWrnleuxeIE97c3DfIRz0WmfaOC8Ex+6rKaNGqdH6xCXuD+lMnANbOhpEQABsWlvzBSN/dO5c
 s27lQD3jEaOCBLiZshSRd4o3UCkzb2ybO2JqvpTfIheDVWOtMYU9wS4OiuwXtklG3beVGPpB1
 seScU7LjXr6LziLMSHkSRCVUZVPXu46+cK52wjkVRKi117W4dkfxdtqTVRdhYzZrfPHix5sLt
 ZQOmO08r+U2HhUCFzCMs6z1BIr4UcwshFHJ8lZJgxifBx0Xxa3ZEyeegNDsy/E5UvH4dg2hxi
 FHOsvGpsp7B4zm5mHEUpfmcytD+gUHMvOHV3YhHyoYWmuYXmIqoaKobntTo2WDzo6IjAOW/Vr
 e03QoNtrO4NdiQ3EpXelP66ZgJ337Hfrn2ezVntarA8fFnxjT+5VyuHat2ngDRqk7aI/GMvi+
 gf2YwRYsVRXtw6r+58Y14XyVUvRrKMXHYCnwZrWbZPV/rdyYEybQkWVUmcG26BIGJnD/E6CnI
 BzgnAH8Xz2s53bYRbLdoXsye2hgWX0YT2T4rqbVbt0JtmhAgnjf0c9f0naUJAM+0bI6mVMlnU
 sMnpTLfgHuiBu+26z30H2VRgdPUEMk4xpzV4lCmU7TfenRPU1ycy9QqMjN3MSaEsGz7jnVi5d
 AVNMCes/8qhjd7gVl91Na+8ubSnExsUv22aNtJodrpnyUshDuXzIuRyhqK6Mm/fKcFsc2Sc4p
 I7emochPWnr10QlEdZ/0Rap39ihPhCo1tSzo+X6ICfZeT9UureEaZbW81s8R5h9sC0zQiNR5Y
 2Mg6wWCVKKPmH1igtsnDNBSRkTtbINHo8aR00VupquAe/AQXTC3eWYcz2vSSPtO9nJIFkkUxS
 Z9uQ+VelSpVQU3Akx0nf3Xrsx/PAPyKIWxaMsYAfC8w/QVYQwTgLsJZKaKsHJrq5rkuK1pi3V
 C4tCx2YKlcG9nEy4ih6xH/dO4+8aF+yyiN1UIyrnZ5esveBU0W3LZMSdJcGjjYD8ZwVQfTPk9
 Ps9iNCetvnNUIFg1socqIyoO7trEq4nrS+u6X7IFHq5SelmkczWabyEybGBgsRqqSr7aG6iQu
 /Z0OF/MBQm1+YD9GxdjftpKSMDFohlqI97nOPlderXDPTnDzxduLcJy7CNl4ErgCtt3sw2ifm
 hc6iKmawwQEQzDj46fyonAOKneGh/sK0+WkDyxX9SLepZGon3S8dFJzPbOy+f1BhTW5klRrk+
 Nf6kcuaLuMahjGfrZ9MsBQrLRVmcS0T/wWdFOJHN7EBspW6uj/jdDrlSNOExyKL+FcDLouVKG
 b12fjH4+gqQNFEJ+DUotdIUAxa72gXiLwHnYN4nmqXI1tJFOUyYzG9GPjg6hYFhO5//wR1Iba
 U7sP6DWvRV3XZwm1fOaI7a4AgNyf1kWchVi8hsst/6L9MwKZx8gQCkOLAaTXV4K6aIvmJaRLV
 wbwVGtPBn+hJ5hqYU9fU6cAuzts43mfvZPjZweACbuOScBLDum4cnNBcWU+qUN9JZpgp/FpNp
 NgcDNLv8XjplSdVC9APKkRc/R/CVs+aeH9idjWmSwNiArFeWY3Ig99NHQSOSyMPF9oB04VN7e
 /TNXzvl2aV7GyVLN2BMmh9Bll1RXBHmFHwDRV5+zt4jGVCjElPfD8K38NMJ8hdC2IlyY3U3X4
 admbne891hOGju3B3TdpClXxb3LNZNM4TKLEgmwqsr8PH7Nk6VXHdPEgC8+sCnHGtFQnmBa3N
 Tl3GEDQOVcibqnbqLy2rlWwi58KD8joZCupP5F+KFTxL17hbmAtlJy2z8l8PQHh3SNTdVUJhj
 qU60po+RnEwFE+N/7uGjaRhuRIxkqfOqm7Qd6pIl4QkoZ9/YIxjHvJMNDJjorSICLXtNARC51
 OO6u85S5eJJOhoCc9ASESAvqC6W3JUK3218Y9xqW/cXOSboIa5kO51hS5HWhGuCuTmSYIhX+y
 jHNyniFmpqg1OtNrmLGpQ+MzMBRFV0R69DL9He3qM1/rHmQo/fkjWuF5j3sG2BOsGeSiMpt9J
 VzL2YrQtj1ZkKC3iNR5vzHH+Gp48T2AxPjSPaefh3mhea8Qd6wKutZPUho9cc0iMZLWzMpXIE
 QI85dKZTb3KI1LOerjHRzB4IFThaQCq/k0Jm6ZtTjcTUhFJohTtCQirfWc5fma82H9hiGQTM9
 Ti6AWp9B44eMzPY9XWnBW1cQc/Mz5tZrFt9K7y5sWMDtxE7Zeja1rEmRxbyt+n+NNu3dqWdjJ
 LVd+DWxOgIYYJlTicXhVBooJiMtqI3A8Yxtp4Z3FArPTakXIwD6RFJRwYlAe6LZRgvg30tHGA
 RhhV6/MwnL/PBRNzz1E+avMfsyAV84ayc5SKEFCBkhdX4OMLQZ3Rwngb1kbdBUDKFdGZz3Oum
 o5piHsh5pxsBsMfL/MBDvNlJ5rXRkAz2PBkvOnIBA9PDFVzd7DVHGrW3GiWGzVepk0XK7bnc+
 3l3d/Dq8GCu+p9BrvZJB6mTB9dIIwjhRL0tajbr4J/AsXct0lsW8puwPx9jYE2h5Y8H+0FZ06
 C2g4Ne5pe7DaKu/IM+xA7IoU6Z2QyoSz3Qiyhz4z9sPHOS56N/2YWji4zfPDf3T4OmyVQNy0D
 Y2guDIwpELJncQ/ZGYJ/YhjaEtrypIcej/UfcF9wMGkDn1FVFe5h0hEVbvwnEDgTA+Bznp3S5
 P+wk/m0xsrFEuexsnftT4K6tRIMjutbo8VDsKrz0cp8gLYd9EBRDiEn7fmx1Sh+kajvT6Ltxa
 6Q65JY53ldY8DoAaESMnoFggTD4CUoFOnLN6hzhj4Q5ssITA1C086vStNvQWAgTsDJYvCQE3v
 UzMP2BONcqfj/r7LZSus/LiF2hv4ussGRlykGn7VyZCsF8xVKpeyO0MHUMnvosAijKaZS5kNR
 R+Vy82YzXL98SU/q26Rt24x2YjkauybwjcjZSQBO6uBWlnTq4Sj1jRb5Vl/SwjHxW+0PCOKgm
 QVYUX4RIXokbw6opAhA8ivDtdVcyuPX2F9L1c2GKtKxzM+GuTZ6ZZj3sk3M9ugYXlffaTsM43
 dKDBI6dOKbPc5nkWiVRWPzQwxWOnSAHr7TwhiwqMLbP2EJo46BCwj32+NKZN7pRSegnNsmXaO
 Xu6Pl2z15bFd4DGuWl5I/Ax89852yO07TE74iuHkTD4zwLrXMp5SgD58QhPQNiE+03Vd26Fj3
 hNmPVd3oa5cqaoErfgKMw0lfTySSu3WY41IcnV82sgujOC1dhFVCw7COe9rVSm35hqA2rA6gz
 DJUJ4AehdSeAvQY44aIesULnsDFz7TFfhRE6c0Zz1BapKm2hLVSTxa3FvmkCMSiKE0VUtzVM8
 3kq52ICEDg
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2985
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/fa82455f-6294-4200-ad6e-c31add12b303%40web.de>

> I guess that another SmPL script example will influence corresponding development ideas.

// See also:
// [PATCH v6 1/7] ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
// https://lore.kernel.org/linux-sound/20250814172222.9448-2-ramiserifpersia@gmail.com/
//
// tascam_probe()
//
// https://wiki.sei.cmu.edu/confluence/display/c/DCL19-C.+Minimize+the+scope+of+variables+and+functions
@adjustment@
attribute name __free;
identifier i;
type t;
@@
-t *handshake_buf __free(i) = NULL;
 ... when != handshake_buf
     when exists
+t *
 handshake_buf
+__free(i)
 = kmalloc(...);


Regards,
Markus
