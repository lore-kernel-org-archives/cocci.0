Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8286606A331
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=psV93aqH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6QzkgOsI6hSYSvZ2Rxelwg+aI/i/gSPdT9ful7PeE/s=;
  b=psV93aqHb1QZKvIybyuPoVVKa7coOrwLcBSZIKg2Fs0Jioteysrx5fFd
   Sw7ORc3QWAFFZw74CZfHhjP42obix6yBiCEaevQFqMXP40Ey0XhrXiUNT
   z5CXawJa1mAByOudtXIADD3vqqo28mmI3Z99939QZ5UBWqvjMIvmcuHpT
   w=;
X-CSE-ConnectionGUID: FjgCKnrITVCdYBt5DebRDQ==
X-CSE-MsgGUID: L4IFxbCxRt6NV9+9romSeQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323006"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:58:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AE13781697; Sat,  7 Nov 2026 11:58:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 51CF981363
	for <cocci@sympa.inria.fr>; Sat,  7 Nov 2026 11:55:30 +0100 (CET)
X-CSE-ConnectionGUID: kpyzkuJ/SDql0hph8CPbRQ==
X-CSE-MsgGUID: twL0n7u2S025NHY+SiPzog==
IronPort-SDR: 6aef039f_amGjSc5z+O792/iDpUvipd8HgtITMiIuMzzmyA0ter6X7i/
 T303WuT6Xog7c9TpNB4Sgi0piPqbp3RwTB4BaNQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ExAACwAu9qgA4P49RaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBC2A0BAtJCIRQiBuHOIF0LQOcTIFVFIFoAg8BAwENSgQBAgQBA?=
 =?us-ascii?q?QECAwE4hEYCjh4CHgcBBDAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECA?=
 =?us-ascii?q?QECBAMBAQEBAhABATsHDjuGFQEFNA2MGgGBJIEmAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEAQEBAgEjHQEBESYBBAsLD?=
 =?us-ascii?q?gwCEQcOAgJWBgEUAQGCfgGCIgEGEAEDECcHDQa9KIEygQGCDAEBBoFZQdhRH?=
 =?us-ascii?q?ywiXYFrAwYVgQouAYVzgm4BhjQJgz96Jw+BVUSBPAuCeT6CYQEDGH9HPz2CY?=
 =?us-ascii?q?IJqgiaBDJdAUngcA1ksAVUTFwsHBYElEDMDKi8tI0sFLR1wDCcSDx0XER5YG?=
 =?us-ascii?q?wYFEiAqQUNbgRKBB12BKyhdAQIfRi0VgXYCglGBIwJbAgFJQQ4HRVMJJUMSR?=
 =?us-ascii?q?yQiCBIJARMaLAqBGjU8CSYEOxUMZAsaBRpHCAILAgx0KBEQEx0eJC8FHCY+G?=
 =?us-ascii?q?wo2bT03BgQLGQQ9kziDcy0UFgJ7FoE3sVKUZTQHgjmBaoFoDIowlT8GEy+XU?=
 =?us-ascii?q?xCTDi6HXZB9I41nmzqBaDqBXDMaJIM2UAMZD4M7iA6CWYQ1gQuDVcVuRjICA?=
 =?us-ascii?q?QEHMgIHAgcOAwuFRAEBjCIsCIFMAQE?=
IronPort-PHdr: A9a23:NWQJ1RPLDBtX+83bTaEl6nYmBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvqor1AaCDdqKo7Ic0qyK6P6mATZBqb+681k8M7V0HycfjssXmwFySOWkMmbcaNPMUWkRM
 f8GamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj4lvJrwtxhfUrXdFeOZbyGd1Ll6Xgxrw+9288ZFt/ilRof4t69BMXaDndKkkU
 LJUCygrPG8y6MD3rxfIUBGB5mEbUmUYkxpIBxbK4RTnVZrvsSX0q/Rw1jCCMcP5Vb47Vi2u4
 rlkRhH1kCsIOCI3/2/RisxrkaJUuwmhqABlw47Ve46aKvxzdb7AcNwARGpBWsFRVzFdAo65c
 oACAfYNMfpeooLgvFYFswewChewC+Pu0j9Ih2H53asm0+Q6DArK2BUsE88SvHjIqdn4MroZX
 +Kow6nS1TjNbP1Y1jjz54bWbB0hr+yCU7JyfsXNxkciDB/FjkyKpID5Iz+ZyOYAvm6G5ORgT
 +KvjGsnphl2rDe13McsiZTJhpkIwV7L8SV5zpw1Jdy+SE50fNWpF5xeuDuAN4t1X8MiWHtkt
 ik+yr0Io567fS4KyJs8yh/RdfOIaJKE7Q/9W+uIJzpzmX1qdq6liRmo7Uig1vPzVtOy0FtSr
 SdJj8fBu20Q2xHR6sWKRPVw8Emj1DuOyw3f9+BJLEE1mKbFNpIswqI9m5gPvUnAHiH6hlj7g
 LGZe0sk5+Sk9eLqaajoqJ+bMo97kAD+MqI2l8y8H+s4KA4OUHaf+eim073j50L5TK1Ljv0wi
 KnZsYrVKd4Vpq6jGwNVyoYi6wq/Dzeh1tQUh34HLEhKeB+BkoPnOEnOLejmAfuinVigiilny
 +7EM7H7H5nALmLPnKrucLt79kVS0hA8zcpF6JJRErwBIOz8Wkv2tNHACx85NBG0w/r9BNRzy
 IwRQniDDbKHP6/KsF+I4PwgI/WUaYMLpTrxNeIp6+DwgXI7g1MRYKmk0YEKZH23BvhmJl+WY
 XvogtcPC2cKuQ8+QfTthlKYSz5TZGuyX7km6j80DIKmA53DRoGrgLyOxyq6EINZaXtcBl+RD
 3jkb5+EVOsUaCKOPs9hlSQJVby7RI4vzx6usAv6xqFmL+rV/y0Xrojj28Jv6+3SkxEy7z10A
 N6H32GDVWF4hnkISCMu3KBjvUx9zU+O3rR/g/NECdNT5uhEUhw6NJ7Z1+x1Ecr+WgPHfteTS
 VapWM+qAT8rTt4pxd8BeF5yG8++gRDbwyqqH7gVmqSVCJAs/aLTwX/xKcVnxXve2qcvgEEqQ
 tFROm24haBx7RDeB4vOk0WEi6amb6od0zDW+2uZ0GWBollUXxNzUaXEWHASflPYo9v36U3cU
 7GjFbIpPhNcxs6HMKRKcMHmgE1eSvn6INrQbHq9m3yoBRaG3r6CdpbndXgA0inFE0gEiw4T8
 m6GNQcgAiehpHrTAiR3G1z3bE2/udV5/Vi7R0N85gWGdUBt3vLh8Rc9gPuQRvcW36kJomEqr
 DAiWB622NndCvKBoRBgdeNSe5d1/FBA0XnxtAFnOJGkaad4iQ0waQNy6mbnzRZqEc1tlcYwr
 XUlhF5XILibzUgHWjeWx5H2NZXIJ2O08B35OP2e4U3XzNvDovRH0/8/sVi2+VjxTiLKkl1i2
 thRiT6H44nSSRAVWtT3W1o28B5zo/fbZDM87sXazy4kKrG65xnF3d9hH+450lC4Zd4KFaqeF
 xLpVeAeCdKvLuMChFWjKB4Jb6hJ7KBhB8q9bLOd3bKzeuNpnTaol2NCtaV0yEGR7GxRTuDS3
 pAK6+6V1E2LWmS0l0+v5+bwn40MfjQOBiy/xCzjUZZWfbF3dJ0XBH2GJsqq2pNhipSrV3MwG
 EeLIVQA1YfpfBOTawa4xghMzQENpnfhnyKkzjtymjVvr6yF3SWIzf6wPBwAcnVGQmVvlzKOa
 cC9kswaUU60bgMoiArt5ED0wLJerbh+KG+bSFlBfiz/JWVvGqWqsb/Kb8lK4ZIu+SJZNYb0K
 XWTUL3guF031y35Hm1R7C82fXemt9SxnhB3jn6cMGcmtGDQKol7wRbS4sCZROYEhGNcAnMi1
 n+OWx7lY4rMn53cjZrIv+GgWnj0U5RSdXOu1oacrG6h4mYsBxSjnve1k9mhEA4g0Ca92cM5M
 EeA5Bv6fITv0Ly3dOx9eUw9Tnr18clnAcdTloUqhZcf8WcXjNOZ8DBU9AW7ecUewq/4YHcXE
 HQuysTW/ROj9UltNHOPyKrmW3/bzsYrNLzYKisGnyk66c5NEqKd6rdJyDB0rlSPpgXUefFhn
 z0ZxJPC8VYiivoS8EooxySZWPUJGFVAeDbrnFKO5sy/q6NeYCCud6Kx3Qxwh4LpALaHqwBaE
 HH3H/VqVQp59MZiKxTh1HPp64frUMbdZ5Qfu1WYngzBgO5cNJ8q3qBT32w9Yz275CBjkrJzh
 AcmxZyguYmbN2hhmcDxSgVVMDH4fYJb+z3gi7pfgtfD2omuGpt7HTBYFJDsTP+uDHcTraG9b
 lzISmdj7C7GX+ODTmr9oA98onnCEo6mLSSSLXgdl5B5QQWFYVZYi0YSVSk7mZgwEkarwtbge
 QF3/GN0hBawpx1Sx+ZvLxS6XH3YoVLiTz4uS4WEajdS4BtD4Uj9LsGUqO5+VXI9nNXpvEmWJ
 2qXah4dR0QAQE+ZHBbOOre05N/P2/eVDKyyIrGdBNfG4fwbXPCOy5W114Jg9DvZLcSDME5pC
 Pgj01ZCV3R0SIzJ3i8CQCsNm2fRftaW8V2irzZvoJn1o5GJEEr/oJGCALxIPZBz9gCq1O2dY
 vWIin8xIGRd0Y4Qg2DFwv4T0RYb2SRpaiXoAboHrzHEVq6WhaJdSRIWDkE7fMIa6qUhwkxHP
 tPdgd6zybNyyPI4Q14XUFv8hoSifsYXJ2L7bVrBCB/NP7ODQF+Di8ilZKShVfhbl+5TrQX24
 D+dHxalNTOG3y/gUxTlWQ1VpAecOhEW+IS0cxI3THPmUMqjcBqwdtl+kTwxx7QwwHLML28Vd
 zZmIQtLqfWL4CVUj+8aeSQJ52d5LeSChyeS7vXJYpcQv/xxBy1oluVcqH0kwrpR5StASbR7g
 izX5tJpplinlKGIxF8FGFJWrS1XgYuQoUh4EaDe64UGRnvOuh4ArC2RBxkMu9p5G4jvtqRXm
 b2t3Or4LDZP9c6R/NNJXZGObpjdbzx4bFywRG2xbkNNVzOgOGDBilYIlfiT8ifQtZ0mst32n
 5FITLZHVVszH/dcC0J/HdVELo0kO1Fs2bOdksMM4mKz6RfLQ8AP9LXOTPGPGrPCLDiDjL9LT
 wQFy/X0IM5AU++zk1wncVR8kInQTgDIWstRpyR6cgIuiEBK7WQ4UWA5nU7oIFDIgjdbBbu/m
 Rg4jRF7aOIm+WL34ls5EVHNoTM5jEg7ndiNadW5bzP7aqu9D9k+48vcsk8sLtXkTgwzYQDgx
 SSM2x/bSrgXg7YyLAhW
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SfrszaF8HAii1wvGpLqEPMeALOsnbusQ8zAXPo5KOH9om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLfD1HZKjBgDWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AGdSQz2sbWqeS2q073hOBbcsp6IsmamzPz2ryZHS?=
 =?us-ascii?q?UEGIxSKWVGXSo8pldxp8=3D?=
X-Talos-MUID: 9a23:Pyxa8Al41v9d580ZN9lydnp+K+Mw5fuzUntVy8ggm/jHDi1IKTCS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304322818"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEhprcgstmzGJHI0jqX6fUd63byCXzCX2pMNw?=
 =?us-ascii?q?mn0VO63nDn720yCxJhLDO0pZlvvBwYw5CJd7ETwJozRBVgnCscuqAtl/?=
 =?us-ascii?q?XhK0ojp3QaH27TCgmeXuZi9aXJ2w/e/CzV8gMp3sk68gGJTwBeu+tzGV?=
 =?us-ascii?q?iFwpJkSbyQZJCL/gEf1B98HA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 11:55:27 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1wqt162x39-00gwwy; Sat, 07
 Nov 2026 11:55:27 +0100
Message-ID: <2148bc74-0558-4eeb-a66a-e903995df05f@web.de>
Date: Sat, 7 Nov 2026 11:55:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chad Aldreda <ca@modelmiser.com>, cocci@inria.fr, tools@kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20261106193517.3267013-2-ca@modelmiser.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261106193517.3267013-2-ca@modelmiser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRPE/nykOWUNZXnOxGzbdSoEEQAEk9jEnqsSMiasonToWFzWmtq
 bMtsCVIjIHZ9Syc6kpQ/kTiZKi6PC6rHBBjkmIKzDXMdiJbpwYeRPQQH/mw5n/QGj8N1FbZ
 pRvsbOVrUeWrLhqzhHH16o2lRNvTe4RjENOFV0gkzNVXNnbnAyJNxq7QHd0pyZswZd6PsSw
 XTDzZp3US2NfG9yf6k/jw==
UI-OutboundReport: notjunk:1;M01:P0:a1MtagUpoPg=;IF74glW9fFClojY4UQ/IXS+L6hL
 UwLRfAAMQAsJEgU15XXcqKfQ2HXP8QS5slKmRLDRoOlH7Y3/Co/w4jKYF/crlpPjZYJoWMERH
 KYgH7yaUPhgVnHAllFAEnTtqThHfs03kvH/00lKgjcfyEZJntmqEUte7VJKJf8dGyKrOTVnXW
 Zq8hKiLwAYdSMeaD7To2KutnFICVG8eGwIJ9gI59a0wGT+jN38TxxrZ4hKXrEPYrEUfjoxO2b
 KfVV3H8XJyfg64Dr1GH5KQ/JBU3Wi2UiVYExabbVQDLTAvti7VXGIdUtk2VvfcL5L15JBY0p9
 dlysKcVIJPCWKLBlzPR75mfsqdv21kBF/TIohcBGv5NaR5BfKVmvDFEiNzODOO/NFARYjV2Gh
 ei0dwq5WeTS9RBseLBCzE/2XecA7llvMjvGyI6nvWxIjrAZxSbZLloM/nPpw6ytPSoBc4Ev6j
 29Cp7AOnxYPrT2ZDm8rUk9DN+/d5fo+znzV6V8H5HX3kyrCdvajgDrjah2rtJGnGupz0XsiMx
 ExJgj2xeES11PLiNI5Tew8im6040oYWKnI9A9CDQSNI1I7+q3xCuufDQs4BuUJ0aHk7C0PdQ2
 zkQSwM9zWQPAbo6ZPdKc01/X8YQLK1CHYz0+c1n/ftwbGhyl+3Nh7MBZFbkn+MmwhLkqjKCW0
 TfujqUYky3g4bTycpvZmRoNZot6C15SLt8jkmuqVs5NRe9YUXFN+l4BUZvPbZ9TZxKL5n6+6X
 3YkQBXcVczoTex8cbXEc/Vsno0kekHUt94fhIdpyFtDK2AYVL5hy8T7kZ4Szwha6MPtEoaZBk
 LsRGfv0MkQ04AjW+zf9wO/upxxqmvAkHZC4DzKAvbogtqTYftlbvDgXVhPdGVe2bFzzN33CaC
 2lOAVqdAw5hYpPZ8xUMmS4oV+XiPthGDM7tKCAjB7xYEyquWghwULE4UuZnnuATpnHq/Kx3tT
 ZxCeMH44Qud5ds3XQlShKgjNclGSlHaxengOHfdyABdT8JUD4pvpMPJJPhHmq8+DarATUGkk4
 ii6demJKfllnbsFXEI/SzlTkcBMgjl+IU5aRzDOlymzrPB6IrC4Ww/BGKUR+puRSRHhttfy62
 8NUBSxuvTHeZLgF9Nn1zSQ/Z3S2BsO5PWGxHqlKrD3hw4QdVu5Rta5mxKPGwvUHrbgO30LKn8
 l7Sws0B7PFlOeKO0kanRgNdnZsIty0NZn+94cTzsuzpU5i4DC4NT4ozg5jyOmuA8EJovsMzL7
 71UVXWge+ffJVJTGWE/uuawo4KEDxA8xv3BJYy2St3By+4TpvcakzfasOCJ3bEsNAj4pe4/d4
 GqHAZZp83C6Ho3C2b6i1IiN62HZbnPP8QFIk6tUvE+1O36y5WqtAEO4h8IVlF7yMxkUjqTKXH
 W+PycIQRRCX3gOwisE3IMz3qr5i+xX4DhkShGnkl1MYCfQIEj/ggIFD+l9R+b3ZwoCugQFDww
 MDavTbo39bF+Y8kifpFhVmv2bTquLjPc01xdagSFzQna+icfjqhATgAfDxiWic7CadlXBM2me
 vPSRVHMeaCoZk3wBMZz23yUsouQsQ5J+no6F9bcmMof0mieSX3xFun7CoIIhgXbvD6Bu7b6zw
 vYko6PVqZErnW9pc1zBb4t8pb5KLGFKkenhGhOpP91wmmxsW/YKfxTGIkx/tavUr8Sztl9Xff
 iPpDga/4S/IlK01yGWyGto3WKICOuNJoxoI7jY72djz+naJP7+bZiolRUqIe5DqvrAYMmWIiy
 B5eY9GjI93w/NNoED8dvPbAdgO5itEap7cX2cAtAFcURnt2cmF5wynG/gcJSpefCDPCmC0qMa
 EkfNp8iUcjGAwJuJcWlBNWmTbj02bovHn0KpamFwYn+Zex/bGd58VzbngTn2agjN6k4sv2ufP
 /NkQxxpK1lhnRY6/0GZM6f0ITVqIhUdhhS0FDjCSeffHvZ5AtVJZL08SKR79SnlwcRnF3GpKD
 KbFKTUN6qARew7r6WL2Fg+Qlbh0eSbD+BGkfLJh73tJqQCRJgwD9BTfiQgla8ODUwePaSXemD
 LpATereXyqc+qmzAEIwi7M99zElLckJLmwonehl5AfmVQrrnJqO7EaAJ46GgpyCbhY8ID1XVG
 xEhksoRER+xSapPWt9tCVNDaAgDEUtsLjbe78bsklTyvQu8LcBmuMV9iKGEFAsdDlYEZN1gkL
 wnyVAyMbIuVF7acByoKltY/2bqmtnWy7/lF5bi0ZufAWZUiepBAuZfVq/MHmsIpiWdKhmJDwp
 TwAcPedW8fAfIWyxNgt+LfxTPuI/KUFCWIF+HFfCJzLQKeUJAxWZuCD4uhlmuPZafcdd/7Rr1
 jTv5GY4cIVYiCNFJMfh1vN77EfVxk0ItNEYCENaFV10qwwzQ2ZsjdUkIo9iL0AjLz6qc+/LI5
 ChRtviWPRvtea5XYr6AhUYmuHGemox2598949OFkTfHzJAmKf+z2KgZywnG9LFKtVOoYWuZCW
 +phwomY5/bB8ln1yLTRRqGYOBWdQhslpkd7EqUODYI6TAIGXqRh4X2UKNy4gw0SWKx3ZM6LRS
 CK4/pgx7zbN+e0ffuKFk4dp3/dOadPeg1I3T5STAKXgFiOwNzCNa+5kLDPskz0mrFBvpU3oHI
 lx1QP1yc9E5wfzPEK0CRR9NgmLkGkEbfRvkrrpUWyD3E2LLZJaom4HBu+rZuxMI33Jlw3k8PD
 wmUmo0KqbmRzfIoUy0q7VgVxLEsGzhDBv483FdhHEa1wDVPIqW0cv7SD4vIBjOy+VQZt3/OVJ
 P4wTKZv/ewKuudx1tJ1bSZTgcl4uudE+gSfG9oraUK3HWEyiHmw/U7PGR1MgO3TdqXsRMdhWs
 Pgt5ECVf9IJXm2SzX1e6Qoio9agYr1jGcTldq2vCFhwD6oXLery2GjM/GkIJtnFpVDmxIQ6C3
 TIKlgIi7epskSQKUo24KfEp+1fWZXUPzaHiTm7Q9cTJFReJl9ctDCGxFMh6Wnyaub0Qt5TypI
 c53ToPF75nezaN6saOIvDgKfnWKUumHZUcRaFxRpiLH9SiW1VapzKBBU40QwipLXovwzHoLam
 HJwZ/g2SY+IUwx4CRfGzJdu9S2rlmUzv0DP3SpKt3a2Fs8+Leq+bZkIBoBSMP4atT7KH1MNZ8
 qLwUzLsWwZZ69P76rwHaIMNgqBKTNxIR/8BiPekQ0IW7TnnlQyDp7ZxH6hhlEmzTBOgKcrLF4
 JZ9Vq1X8VN4advUlwXRK008L6uPSQoj+1KYRa4/5QDion0JabPB6Rf9FaC2OBg18hE14q9Rn5
 Qw+akHvbJWX4iLC1RVMkiDqBmJjjNiT9kkguD1dl6QfvabB2rqCbU+tpKbzv7UyCkmWZ6j60J
 yOxDGIsjk9MZUPz+Q6TjBWolOOuFl2vkAJIC7TMvsn2rKPB4ROt0gW2QUeG8uQyMVZYRuVmE3
 M+jg11cLfIgzSPyNG3XtbaSrf3K1JccGL7k7yTnZGBB7Bi1rqWvKTB/AEGtfO5NdD1FzkqGef
 vkDMKiSVmBkV7fMcnvpbgwP4kfWZ6nNZOYrZ6ohbJt7uEOrp/s/aIZXeWMWNZ2fyHrBTJOix+
 DNIdkitiOcz5zQjZJVB6vzI2g2NQy93gmvYQj9L8RcRAI7nWZJZfWkfOibKEHQ4CnXlk6S/1N
 7CILaprUyEVJZE4lVSQ3/uhkQ6bAOwJAXR6JZdFOWCZoN0F0RTn8lC84R821DQZEdlClf0PDZ
 v7T24S+xFfPpfh8LaH+AclO/tK17zDYkTmoZTSRUBpi1aUykKg9xjn2cqjhEqumnjgnKZsC+A
 Y6tqDsgqW6f4uWGt4xVQjcgH9CPZn2or3EhyGbKGDriqfG0gPWUGzoI8/z4I3Tt1xh5AnMGAt
 CIyRvdRQTyUpgL+8xr9/DPPtmB1aPWIwJLu7szGYiZWkEl3lbCFNN/QV88UzIj2jkwznYszaG
 5l+/IobjCUAarcjNDbjJv6qWu6/usRJdFZmdpki4FRkxbFhm7deK0KRO+zsZFBRB8+2Dy+rvG
 GPCqgprLNvtkyqR/jSfBxNZ9uBpDkt+WBgpDgeRpLGXObRa57g+QY9lLl9S1R68tiNOTvwPho
 Jq/CpXxa24e62LYoieQ2uYYzHsH1z18zgahX+rO0Oa2gN8YNfNKGaIvlLjik+UAs4f9CQqm0h
 rTYQo3Sp+oEovHa6rQu9FHTPf+/cejL7stE/dkkp8iiee2Ii5Z+lOxpXPSeEDS+ksURs4FoJE
 IlfVLQ44TIKDPkEVkJyraL8GfUB9mGfd8Hiq3P9NGnw9apNpBvU3u5R8nlFUUsAUwFKjcEqML
 Gw6TfNHHMvqpG7ahjHYqNSfSNGWo7YuJf8NtQGc/hOdTPPqcQiHTM30KeoUQ/IeIXdxGPeTf6
 WT+fIdcKwGtMA60JhUbZbvl3hU5aPwEP3Zz1njVP5QgLKjHVTyxsgEFVEASoaarLjndJhehBU
 zVGcl1DMw7DurrW2L0Y3mPJXHnt2vv52gMNirU5Z83tBLFvxUBSBghOJuvOXmgoGZWr1mkWdr
 H1DBjWZzsC2S50Qu35452FnUT9spDxsywozOsJZMGp1Kmyrz1F/ajJ2t7WNcMH4vPuEptuCT6
 Eun8jfeXsL0EJ8sSZbBA5zhZVpsk+nDip2otCWXzaxAAIc2JeSQZiIT4TGEFqVB+qlTTqLtvD
 NRgODm2hdaHpl1QtqoWDYvaVT069zSOkGDeZKwAlTB1bc+PRS7FCo0KnVX703zl23goBDDSLl
 MifsQjiMgvMZhfmPCi6cuBJXftTZiLLjagGkXes2IZkLPm6onSKrglkVOHjZ96flkFFryyWYM
 tZCS9VTzekN/dwb6Bs47hqe2Uq59xFkr8aGFbwfKaN1J1j4ViIrkY1UALvcYGj90sndn1LUZK
 oN5pONy5z77DtOt1+EKCpZqgvDuxuxgcXiV4uwAnXpy56bZuCorJBVCqImi60TfdlLuRv7nOu
 7WCMr5uw7Z1AgN+YsziPxwUzpkj3/DRbAx6qgnvpdglEsKz/zJYGH5IDr0YdsXnawkYKUnwCH
 PzbRHk9gaBi/gvWlSbM8Ei2SyDTaUoNmsQxFe7LSSVWIP92pdaGIGe4oowODLy/nIVj+tK8G6
 DgPN8rG6KZLVYqbc8627k3t/p1TWralNzZuB7pMci3hKfRfQiZWGrmlbQPV/+mk1jkEyZgkMo
 zlpHTj78QG21561mlmhGsMZZCLuTwclNHMg6zEGsOBblmD6zYXrEBgdu9x412Zj4OX7jFSXX2
 5Icpw4Cst0XVSBz4kVCMCgdHgnRjfLwLqcn5jtDfITBsoR1SNc4D2Fn1YWC8ywhEVuJ4atg7s
 DpXybm6GGEJ4vK2GoTgmFtrq7jZRb6eqmwWWaFdGAUlDg2OduyvPZSXzhdhGGkxna0ELfGaU+
 4o6nE/z7/pWynn2FH93iaqoHeYN802olGhryU3N6BJOve2cp8eoVYLC1JgEZ1aYIixtEYjYxG
 Q8KBp/rX5IX90+udKfLp8N3ZfSz7xuHJzTIcw/P4LFPy1Ym43zfMvrJEk0TaIuaK6cPdqV9gq
 8PJg2na8Gbrg1JOJOT9/n9fZePt5ZaMT6MuWM/nwTQpAbtc5jR3VOC/NOnmh1MFlicHIzfnhE
 +R3tNT8U102wDn4DRHfVMRsma7S46lBEkb+stK7QvBVap4oOve6oE2DUuHh7J6RL3tb7lcFfx
 ZuOVZcNr0Lh4SiUVDsBilL4hCN1Wdwt/EnixbsR/buD8weg9gG4bSbqzfvJGNG6Uo+XGCQYkc
 rxi/WJn627/d6x2844QX8g6RaDXA0C1ubcbuAID1SzKsDMAEJ/OOQ1WQd39JnsPTm12Ud3SDd
 GaquqyLHQwq3B1ophc1jYqvDdYei7AzzFkakga1b23OPIVkmpFnIzt3M6+Lgnpjien4/kWzJn
 qSIOwLEjm3XO9617UXTfFlc1/XcsXk7CVUz/9ZEfkvL+B5i29F0gnM4L0EKceJtH4ttkIi4+7
 NUqLVpAlXeStDi5CgpbFd3CwVg3Y/n2YwmpfgjX+V0I6UxXDImf0RGxMjU1/J1eLQRfHiBhAL
 eop8j75iswV9e+Fee6JBBSwJKfi7Q/280sMd+9vJ040z8jPNFBEyBMHn8v5lfBnKpArLNDUG9
 4zzPaNBv0TMGxRb9fSNz++zArpBWLltSKAyKQcVEiiQut933MueoQNaJ6ZtDIB4KNsb7th+Ye
 7acUdT0Kju+8LCmXRdaNWLWOVnZyIvo41kF3MLHG4EuqQpz92o8pz4lsc8mTDexhq8pbyLvXa
 svEkJ/kZztjl0MFaIsY80cUe82d5jUZaW/LEFPBkeiulcKfCPjl0JwO7RW0/UYXBV90vDgGkc
 7wOJDN6V9nZ78p7yc19oa/UGZR4zlTgT68lVCdlWVFbQX/TzCyDLoPqSU54rAZPiRXIFLDPB2
 zRoYEDrwkqCsoGKySOQdd385Oe6j06hMGu+9uhfDXz5fMrpDIOft4QrAXMAFoorrJ6BzDjOjz
 3KbAP4unsQYTJfsA7+2H6BecnAyzPEP7fcd/EvqEu7+8kjjYVo+9sVHqeVsYy1RF9BMSAZ7tf
 eL8S+2NJOAGqTKMUKGNumbo1daTHcFl6U4L32/P5nOTxI9L1Dr5vXDpZhrE0u2aw/3ePV/L3q
 Wg3RmE+3qRo92vJgnplo7l8y3iBk6MBirUNor+enSoevvR135XMSNq51F4LXGYyQ1LaOaqS3k
 paI95l24zMHnqS1g9xgUFGwiHjoHmP7UOcgRXyNXnFnFAlCgFGuKDb2OLOO33UucGi7KWo8lj
 CVmopZzNj2w3BAbM0blbAwXtCM38UMkHic8f1zIwGiSOs+nHmyhNtq5w9L7ojfHQ9X6FWdKaV
 pwXb334wFuP0ANpCYXMIwfLpwNrN6Wa54hK3TON1EEJw8NO7lTRExSgwrRtquT7uIdk+rnuu/
 WbidZDXlh5W8I7gBugZTVT7gfNbWO6gd97zyjmwpWWN/v0/h4VtN7TdmFd1TEa/RcdRB0OKd4
 59MzH+4dInMUdGF+pdm9Sg/rCWklgmbdnvqmaCLkU2id52AmV/bX0kIblJ86T1cqgIcYigX4b
 keDDqpg+7je+lrBrQ6XjUKQkeSmPAAU7M515LK8Luhq0orEEisT0tOEApqUgvWymoO0UZjw2q
 NjS4vyUxeQrC8sZIvvSTfwgTcW7WuqzgGCVPP1d0xZVHPq54+KMSRn+v7TdmKQv57x61KerQT
 k41GuNO3Xq/p0BXhBHPhg7v/Aq4bE434ZkG/Wv/uz5aL3XlI5Syz5R628OzDGhAU6AqShtDio
 qdfd80RWsvB0QkmctssPxBth45/jbJM95ZjkVP/MLOm7hllza5eYUXhzrPkXYDcjwASkU/eph
 nNvJAd1jRUcVlvASaFX5GypXXpWz7AkAoMpXxBHzadpsl13PU4to6ic62f2/Ef8WINSjJRmuj
 acz/+AxiQSmiZARvB6K+GEkHMYMyUfTU64BjswHBuL2CpV3QZcxUTH0qN+9awS5K0DC9JLa72
 td3w/8
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for device nodes
 in devm_ memory
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3765
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/PXi_n_mDZfdyLHHs5dXEZA>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for your contribution.

How do you think about further collateral evolution according to the prese=
nted
source code analysis approach?


I suggest to use the word =E2=80=9Cdevm=E2=80=9D (without a trailing under=
score) in the summary phrase
(and subsequent messages).

You propose something for device nodes.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/driver-api/driver-model/devres.rst?h=3Dv7.4-rc1#n9


> A struct cdev, struct miscdevice, struct video_device or struct
> v4l2_device embedded in memory from devm_kzalloc() and friends is freed
> when the driver unbinds, but a file that user space holds open on the
> node outlives the unbind. Its later file operations are a use-after-free
> when they use that memory, and for a cdev or video_device so is its
> close(), where the core touches the object and the v4l2_device the
> video_device points to.
=E2=80=A6

How many data structures should be touched after a close() call?

Are there more system dependencies to reconsider?


> +@initialize:python@
> +@@
> +seen =3D set()

Such a programming interface can look appealing.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ea58efe355dea21842179=
54248a01f5dc5995d24/docs/manual/cocci_syntax.tex#L697-700
https://docs.python.org/3/builtins/stdtypes.html#set

But further constraints should occasionally be taken better into account.
I guess you would like to benefit from parallel data processing with multi=
ple
processor cores.


> +@alloc depends on org || report exists@
> +expression x, e, e2;
> +identifier fn =3D~ "^devm_k[mzcr]";
> +position p, q;
> +@@
> +
> +x =3D fn@p(...);
> +... when !=3D x =3D e
> +(
> +misc_register@q(\(x\|&<+... x ...+>\))

Would such an SmPL disjunction be redundant for the passed argument expres=
sion?


> +|
> +cdev_add@q(\(x\|&<+... x ...+>\), ...)
> +|
> +cdev_device_add@q(\(x\|&<+... x ...+>\), ...)
> +|
> +video_register_device@q(\(x\|&<+... x ...+>\), ...)
> +|
> +video_register_device_no_warn@q(\(x\|&<+... x ...+>\), ...)
> +|
> +__video_register_device@q(\(x\|&<+... x ...+>\), ...)
> +|
> +v4l2_device_register@q(e2, \(x\|&<+... x ...+>\))
> +)

Were these function names ordered by their usage probability?


=E2=80=A6
> +@script:python depends on report@
> +p << alloc.p;
> +q << alloc.q;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
=E2=80=A6

Can such a control flow pattern still be refined?
Would a temporary variable become helpful here?

Regards,
Markus
