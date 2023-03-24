Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2A0C6FD20
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DaBVcf9ZR5m3EN+z+7rOvu1IcnNBDxitWT7zdeC+Y8o=;
  b=vveTDY0Ed0IfGaGErO5j7XfumC1RCH5ecNRbAnSZfng5TqL3unQmesQp
   Lj/lxFbJLvv4pT/slnVBlPtNTNNGYc5AsuEoTi4ZbDHXMzN7THvd4Tjok
   MaVicx+epZqUzGo7MYb3nn4I2rU6cN8zZWCiHRffwABLVW9LYweF//C4O
   8=;
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
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98976347"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 16:42:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BA860E0D45; Fri, 24 Mar 2023 16:42:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0D8C8E0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 16:42:25 +0100 (CET)
IronPort-SDR: 641dc4e1_TE138HKH9y/DXavtJO/IljK7X+nuE0Q3RBP8T2J0m/IIGyd
 mujnTSDzxJjlGuTpwHoF8BIaCXpqb519ehgRHCQ==
X-IPAS-Result: =?us-ascii?q?A0FIAwBdwx1khwwR49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORAS4DhC+HLIwhhAKBVoFAPg8BAwENQQECBAEBAwQ4gVOCcwKFOgIdBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QB?=
 =?us-ascii?q?SKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0DAyMEG?=
 =?us-ascii?q?QEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQeyVH8zgQGCCAEBBoJjmScfL?=
 =?us-ascii?q?CJTgV4JgRQtjQWDNnonD4FVRIEUAScMgzWIHIJngiqHVocRiCwKgTR1gSAOg?=
 =?us-ascii?q?T2BBAIJAhFrgRIIa4F9QQINZAsOb4FLAmRMgQglBA4DGSsdQAIBCzs6PzUGA?=
 =?us-ascii?q?wshBlhrAgkjERMFAwsVKkcECDkGGjQRAggPEg8sQw5CNzQTBlwBKQsOEQNQg?=
 =?us-ascii?q?UcEgQqBAQYBJiSaXwIBgmgBUjtDCSaCBJJYEZIvng40B4IogVWBWQyfDAYTL?=
 =?us-ascii?q?pcIDgaSIy6HLZAPIKd6gWkBM4FcMxokgzZPAxkPjiAZHoNujwkBPUA0OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 +SPzjI=
IronPort-Data: A9a23:sXgxGaLJxJFCJIMpFE+RqZElxSXFcZb7ZxGr2PjKsXjdYENS0mRUy
 GROD2rQO/rcZ2OgeNklYNi1/E8Bu5KHzIQ2HAcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWCfg71s9JIGjhMsfnb80kz5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuWHnC0fc/HU0NAIgaw8xrPE9e+
 t0fN2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GuI2wH9gnJ/cLb5UDMly8gzaL9EODKOfy0HcgIhk+Ti
 Fz/qjGR7hYybYHDl2PcrBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+aLegify+l1L4RN9Vb
 UAZksYzkUQs3GepYMv/Dgy0m0OBvCc2R+d+A+Ib7x7Yn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBWmUHXFq9Fir1y1uEkd+hEXRFfDFdOkfoWSNVuIi9/unfmzqVFo4LLUKjsjHiMR3dq
 9xghAs3nbEIl9ML2s1XFniY3Wv99/AloiYf7wnaWCea8xlleIOgbYGy5jDmARtoKYGEUh+es
 XJCl8X2AAEy4XOly3HlrAYlReDBCxO53Nv03wYH834JqmXFxpJbVdoMiAyS3W8wWir+RRfnY
 VXIpSRa74JJMX2hYMdfOtzuWpl7k/K6S4i9C5g4i+aihLAuJGdrGwkxOiatM5zFyxdEfVwXZ
 MrEKp/1ZZrkIf03lWXnLwvi7VPb7nljmT2KHM6TI+WPiPTHLH+TVbofNlaSJuk2hJ5oUy2Fm
 +uzw/Cikk0FOMWnOne/2ddKcTgicCZnbbir9Z0/XrDZfmJORjp7Y9ePmuxJRmCQt/8I/gs+1
 irhARAwJZuWrSGvFDhmnVg4MOm1As0v8ylrVcHuVH7xs0UejU+UxP93X/MKkXMPrYSPFNYkE
 6NXSNbKGflVVDXM9hIUaJS3/sQodw2miUjKd2CpaSQ2NcwoDQHY2M7WTi22/gk3Dw2zqZQfp
 Z+k3VjlWpYtfVlpI/vXT/ON9GmPm0Yhtth8ZGbyGekLSn7QqNBrDwfTks4IJ9o9LESf5zmCi
 CeTLxQqhcjMhI4Xq+v2pL22gLqoN8BcHUNqOXbRwpjrFCvd/0ulmZRhVsTRdx/jdWrEwoeQT
 sQL8KikK9wBvlJBk7QkIoZR1ahkuufe/e5L/DprDFDgTgqNCIo5BlKkwMMWlKlG5oEBiDuMQ
 kjVp+VrY+SYCvjETmwUChEuNNmY9PcunTLX0/Q5DWP66AJz/5uFSU9iBAaNugMMMIpKNJ4Z/
 sl5tP408wCfjj8YAuSChA1Q9EWOKSUOaLV4l5c4BISwtBEn5GsfarPhCwj3wqq1VfNyDmcQL
 AS5uo/+lpVH50+bc3MMBXnHhuVcopIVuSF19lwJJnXXu9+cmPMH5QBdqwo2agFvyjRGzONBF
 Wx5PGJlJai13mlJheoSe0uOCg1+FBmi1Uip8GQwlUrdVFuNel7BCEYfKNS91hkV3EwEdwcK4
 YzC7njuVAjbWf3Y3wwwaBZDkOPiR9kgzT/yspmrMOrdFqZrfAe/pLGlYFcJjB7VAckRoknjj
 ssy9cZSbZzLDwIhk5cZOaK7i4tJEAulIVZcS85P5KkKRGHQWA+j0Ai0dnyeRJl/GOzow2SZV
 epeftlCRjav5hao9zo7P5MBE5Vwvfwu5ecBRI/VGH47g+OhiQRt4b3t9XnYpW40Qt9Rv943B
 aHPehmjTGGBp3tmtFXcjctDO2biX9ggYTf4/eGq8dcmE4AIn/FsfHoTjJq1nSSxGyl28y2Eu
 DjsY/ft8NVj7oBwk6/HMLRxNy/tJfzdDO23oR2O6fJQZtbxAOLyngIyqGi/GT9JPLEUCu9Fp
 Z7UvPHZhEr67asLCUbHkJy8Fo5M18W4fMxTFunVdHB6vy+zaPXA0is52VKTCMJ2yYtGx8ydW
 QGHRtO6docVV/dj1XRlUXViPChHOZvnTJXLhH2bn62ABCFIhEaDZJmi+GTyZG5WSj4QNtesQ
 kXosvKp/ZZDoJ4KGBYAAOp8DoRlJEP4H5ErbMD1qSLSG1zAboluYVc+vUFIBfD35ni4/ALS5
 JXYWl7heR70tKygIBS1dWBtlkV/MZq/qbBYkoEhFxpelD2wSmILRQjYGYtTEYlay0Qey7mhD
 AwgrwIe5eHVQjlONxnxiDgmssFzGcRWUurEyvcVE494pst46E5swFesy8u430pLRw==
IronPort-HdrOrdr: A9a23:NPbhEatxT8P52AQYXc23gA4N7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHjJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniEhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98976340"
X-MGA-submission: =?us-ascii?q?MDHfjEnj9qYk0L/U+31MoJ8ET8OIx0Eezy8411?=
 =?us-ascii?q?KuL8k+fiMC2z5QHErFQGZL5XAHHlNy+IrMdCfiMVk4b17Kcuia6VEsqG?=
 =?us-ascii?q?msBmnHgRNvQOGfKWUokoQrSBFttCMa9fLR2ZwNc44CPRv6XkEws9bXL9?=
 =?us-ascii?q?6TXeoCuioPPlV5e0jCr0Deig=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 16:42:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679672541; i=markus.elfring@web.de;
	bh=FUV2j/mIf5N8XPN4ZSnuoAgV2XPJ4du/+8E5iOw21GE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=CmGDJ26d1oBm/eLP+uPRlSqY9AxRFhYVdcezhQ5SumpjP/rjERfzme/gqW8+n7ppR
	 V+pq0CRmNQp+gm2Sf0joxqU6bfqwoEum2HkaU2gIoNC8K2dOx0Oei2xU2ZgQ1x3MFS
	 uh33scL0oPivOih/mmyiwftdMOI74fPNKd6jQrtBAVqnaWZBLhapzp7yCopx8THxpt
	 NaLsNHImtF5htWvcNEf03a/132yZbRMWxHX0mhuIPTg1we+FTui+6tTbI5xtWbusMR
	 43Bs8j5oCvsxe1PYR7AFhPolhOpx4ezvLLTAeCUydFXKxIkV2+vjegH0dhGh5/bmZa
	 T7baHf2iwvyJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1qfR420z7z-010c9g; Fri, 24
 Mar 2023 16:42:21 +0100
Message-ID: <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
Date: Fri, 24 Mar 2023 16:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
Content-Language: en-GB
In-Reply-To: <e6656c83-ee7a-a253-2028-109138779c94@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wURbRRzJDKLNkPhJ1aQ657prHwMd7a6I/FrJ1on0Fmq6FFRpdPk
 39ANyg6ItpDWjPmHE25D7kHn5uS5WBOmM+M25MDJ4dsJdV5ryq/ZfVUF6rHp1P9n75GTAKf
 CYfFUR0ZJpy+yFNqsWjzMgSSCB+YVB3TbiMZJNIJEeQAfeH3EhtZ+1817F7a9mxBnGJ1R/H
 PssPVlr9gm3S0yS//lpbg==
UI-OutboundReport: notjunk:1;M01:P0:b19+0278Ywg=;tTKXU4Z/YC7y827AGxG0kqqf12m
 4iAg9dGO0b1IIUR9YuyTbRp+nYLKCtWXPcnmwH0RuttZRL+ugOi1OiqnDJruRbSH0omlWRRcz
 WZNgAbsJ2ifHN8/Y3mRGDweAIsgT1m+2T0gMcHCdiMR/Wa8Yu0GOR6RQ1sPLkSDz8i+SgltYd
 MOZfOh7loWcGNzTWYM2gk+PQhYULzl/oU642rJe0Y4jDpMtfMEO7GLEB33nJms85c2KWMYVMH
 jmtnmjjarJaMHfBeI5q60aXLM2ogu11C7ye9ZEQ2Utc2I4Qy4wvFw5c5Ji85YKARMEpdLrSG9
 7Fjrhh8ankaPhAPwdnBufailZV3FBJNjf7TmMDVnoEUp75k9EBZo4801bDWXyZTA2kmhdcP9c
 C9aJvRyHa7TaboVzRGldb7keC5SftA8XUSXLPpr4QfU8K49Ll4Tds40r0MRY8zPnDUIEUQfJo
 G2f1ODwSIBacJCHcBxDciSE19LzLN4iOCROhC5Go/kHI0SECvv6Scy00sQwbwFGfvaB8gb1bF
 m/3gVgAhbyLSTi7hZGU2MlIP/Ry7d5eOP+78gMp5VaUqGjHO/qrjxoELbTGm14gJoa9Xf1ihm
 3YY4UrSBzBCuyCh59vs2aZHpn95izOQhlSH5JDl2/bvB6/Kxtu7SbjT8D4NKFqHC+6sqv39hn
 1XRx/hwn78ACx4v0QBvvfcLhOjgsqNjEsLiv97zlxo8AWuzeQi+YUf9sYfqXCTgcx1jg43h+m
 2KXWH3LyG1mIQKPARIDDc5y8Cjw13E3oWdA1UNJYQP/BgQ6c8B7lJyFVINx/ILhGmvaNRmfrn
 SGPjgfvz2RYegIXUY6+RfcgpQCZgi+/ehHsCz6W7EUhcvtzJT/Yj9r4tHLrHNdQ/qM7lFpoDP
 yLzCA9hQAAgLmONmvjfmoQfSl24Bdt0bk9EjD16Xox3Jja+axgTDsWfV5
Subject: [cocci] [PATCH resent] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 917
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ea0ff67b-3665-db82-9792-67a633ba07f5%40web.de>

Date: Sat, 18 Mar 2023 16:21:32 +0100

The label =E2=80=9Ccleanup=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cdm_validate_stre=
am_and_context=E2=80=9D
that it was determined already that corresponding variables contained
still null pointers.

1. Thus return directly if
   * a null pointer was passed for the function parameter =E2=80=9Cstream=
=E2=80=9D
     or
   * a call of the function =E2=80=9Cdc_create_plane_state=E2=80=9D failed=
.

2. Use a more appropriate label instead.

3. Delete two questionable checks.

4. Omit extra initialisations (for the variables =E2=80=9Cdc_state=E2=80=
=9D and =E2=80=9Cdc_plane_state=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 5468c36d628524effbb89a9503eb1a2318804759 ("drm/amd/display: Filter =
Invalid 420 Modes for HDMI TMDS")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eeaeca8b51f4..3086613f5f5d 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6426,19 +6426,19 @@ static enum dc_status dm_validate_stream_and_conte=
xt(struct dc *dc,
 						struct dc_stream_state *stream)
 {
 	enum dc_status dc_result =3D DC_ERROR_UNEXPECTED;
-	struct dc_plane_state *dc_plane_state =3D NULL;
-	struct dc_state *dc_state =3D NULL;
+	struct dc_plane_state *dc_plane_state;
+	struct dc_state *dc_state;

 	if (!stream)
-		goto cleanup;
+		return dc_result;

 	dc_plane_state =3D dc_create_plane_state(dc);
 	if (!dc_plane_state)
-		goto cleanup;
+		return dc_result;

 	dc_state =3D dc_create_state(dc);
 	if (!dc_state)
-		goto cleanup;
+		goto release_plane_state;

 	/* populate stream to plane */
 	dc_plane_state->src_rect.height  =3D stream->src.height;
@@ -6475,13 +6475,9 @@ static enum dc_status dm_validate_stream_and_contex=
t(struct dc *dc,
 	if (dc_result =3D=3D DC_OK)
 		dc_result =3D dc_validate_global_state(dc, dc_state, true);

-cleanup:
-	if (dc_state)
-		dc_release_state(dc_state);
-
-	if (dc_plane_state)
-		dc_plane_state_release(dc_plane_state);
-
+	dc_release_state(dc_state);
+release_plane_state:
+	dc_plane_state_release(dc_plane_state);
 	return dc_result;
 }

=2D-
2.40.0

