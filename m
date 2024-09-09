Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDC8ECE57B
	for <cocci@archiver.kernel.org>; Mon,  9 Sep 2024 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EBlqzeibcHmLE8jmEMvY/kGvwXFkAdrNBvVf/DUWlqQ=;
  b=ut/htxsxFV9in9UMdIBwPVjqtk8GCc3YLt3dVbLQ0p0fAmHw6gbiaMyZ
   VeOEDA2gRRzLnrTvQvFinJuviqWb223DYUdJfJzfbOByUlvs4BowqJSkV
   GPdQTztksrGc47OkPSyp5j9GuUc+Wk7kQ6miZkGt4u9H9Wn+/ZeB0k7g4
   E=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,213,1719871200"; 
   d="scan'208";a="182134949"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Sep 2024 11:43:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43AA0E0CD1; Mon,  9 Sep 2024 11:43:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 42249E00B6
	for <cocci@sympa.inria.fr>; Mon,  9 Sep 2024 11:42:57 +0200 (CEST)
IronPort-SDR: 66dec320_vWM7VLdxmHQQ1QqNn7q05KW7u9uU/MoObLByifXINcJFXGX
 nXipuBbygLYHqs31pksE+/IHrVdFRetq3zGsJQg==
X-IPAS-Result: =?us-ascii?q?A0EtAACswt5mhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYnUzBAtIhFaIHYcvgXUtA4Q7hzqMQIQIgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIFUgnQCiXYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBOgcOCTKFdQ2CYwEQgRKBJgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR0QBAQECASMEGQEBESYBBAsLFAYCHwcCAlYGARICAQGCfIIwAQMOIwe0S?=
 =?us-ascii?q?H8zgQGCDAEBBtpZHywiV4FjCYEaLgGISgGFTRk7hDonD4FVRIE8gRSBPjE+h?=
 =?us-ascii?q?Ao5g1uCaY5tFoMNghAKiVQliGhwjjNSexwDWSETAVUTFwsJBYk5Ch+BWoEAB?=
 =?us-ascii?q?SEEJYFFJoEjgXCBBQiBKxWBBgKCV4FnCWCEO4I9cGKBDYE+gVoBRoEUBoFXM?=
 =?us-ascii?q?BskC16BRYEFHAEXBhUEgSYFNwo/glRrTjwCDQI3giklboJegS8EBYEHHUACA?=
 =?us-ascii?q?QttPTUGAwsbBj2reoF5cgFSO0yCHQ2NM4Uzsnw0B4I2gWKBYwyYTocDBhMvl?=
 =?us-ascii?q?z4OBpJzLodgkGQiqHuBZzqBXDMaJIM2TwMZD44hGR+DdY8KAbwwQTU7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhW40amEBAQ?=
IronPort-PHdr: A9a23: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
 Kx+t6Rm1V55lzH1bn4r3jY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:P9U1k61AWk9VBOnNJiD5oAqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:fCl5h2HVGJJ3zOXLqmJ28WVTI9AMQkTs62vCPm6EMUYxebKaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ATTwe3g7TRb4UpzOHjOSvuZ+DxoxtxY+lVRAyiK8?=
 =?us-ascii?q?pgMSEKRMrHxmRhheeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,213,1719871200"; 
   d="scan'208";a="182134926"
X-MGA-submission: =?us-ascii?q?MDELOBnogRnJpQFRCCpamQDxJkSn8MtCx51jVo?=
 =?us-ascii?q?4qPCsoWD5ibo325VHi4qRavyNzgx+YJA540OOPlkg9kV+nYhRjEUbnSF?=
 =?us-ascii?q?AGOlioP+vNoYCtFbgmRXHNBRkkm5I3T+9I6oBjqVLv3QLNgUUaPJyMTN?=
 =?us-ascii?q?sRMxNe5eF+FJj9j1ufRzIz1w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 11:42:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725874946; x=1726479746; i=markus.elfring@web.de;
	bh=EBlqzeibcHmLE8jmEMvY/kGvwXFkAdrNBvVf/DUWlqQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jRuMaP3kv/79914X8WkyFcRufIcKEX1mn6+C3ACulpE1FKCVk4WN2pliQPxLddu5
	 2iOcXpyeEShRv5pJnxYaV5bQF73LcEBCQRIQhgFcEjrNzPjIG54dqi2N1Xoomm/AF
	 RAvJHyXe3dbJOnt7OjtZnErFGqo1X5Rrx91P1SHFt5Yz4XQoHgdavxivTw4Wzbc0Q
	 BUC3P4OHjZ4dXpTpSC1zJwpgeHsv4qNBUMWscFh9iTAiUmCZv8fkKrBUCYY7/sKom
	 13beFEvK/fSEBlsHH8kyANynfLlsOaA2wX/nYZMmzppU1N9g/maHX1cyfw7+YQb19
	 WlxX4ZOzuDZHSIzLVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1sl7o90LFL-00EbI9; Mon, 09
 Sep 2024 11:42:26 +0200
Message-ID: <d4136720-e6c8-490b-933a-4a884412b38a@web.de>
Date: Mon, 9 Sep 2024 11:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
 <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Content-Language: en-GB
In-Reply-To: <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FinRSsoYLcUBzW5CselKtDxWi72MFZcC3KilliEKBsQUeKXYei
 FR2I8NrqAgdIr7ze6KALJPaM7wknBcUXSmvlGyO7sm9JokMjRgJonKx2kUM2LDr2R2qlBew
 oHpIeeJnmJltdTUQ2q2AREeQHxSuBS/F94J2yTpY+UIAZtqw2TB5gH2spYfpgruDPCjvV+f
 dPM9jIAK7/z0nl5PCkokg==
UI-OutboundReport: notjunk:1;M01:P0:4mNfO0uCz2s=;QgAKWGK+oCVd1C58nJsisjfUumH
 UMZmClwq9WwbmEwKs0+o3InvaH49mHbVoA43aHpnciXuMv++wM97ehl85Nab5/LXN0js53AiO
 EzYUt9sYSBwxlWlR+9nFnwyG/TDN73Kv8BkgsREn3EA7hFIbppbXE+zmt+MabpUhiIK66iJ03
 aXjpemLGO7cZhg5mcC2VGg1tf/bs2hdO0PmiGFxOATsywO80kwExz8zHnPHQAZrsvG0i7a+sA
 xSjvaCOz5t84lyOuaL7csvkuQ7lp2PghHkcDb0ZfpBlN/J1zmj+62HIPRyWS7HwGWYFJcZFpg
 k+FAOoQ7JazBLKMLigp+yG2X6dO7PVjV4uGwAwkWNCvrrnGtNfHQQGjg0bD+resJXlx2Voqjv
 OXRlDX5OPmmPXiDJrqk/sLY8LVVTphwEXblDdXb9RqoyRlmYxusqGpcF+SUiPpAOIAe5xGo8+
 5TCdEqgocUXf2JbtOgJ9ayZ8JrLKFbYe6TPdJpyOrI7nyxTG6HKgi9dE/Gnw4KG8/4kWZPy6k
 Pw+99s3sXF0SR0OxlIP+Fkl4DRslS1Vui5yj4jzEwiZaVoNp/jPG4SRBkdzWycNAlIPr8h7pB
 AiUokGue70Z16SqzBH+ZJNWb7CwJu9whs/ZITLd1cShfdDaXav+gEVWBa4EtRNMprGrKZsQwO
 oGpFqHnJSf0ZYOP+xNVgjLETz0/LvRK5H9LcsqiXRaB0K7sx1IH6hgEixESofMowET5qtP8BN
 DnvYQwP227HLP4OM7L50krSK+sVZ0p2IGxOMUUtgTaUvVJY2vP7dORRcd8kx3dyEcCov491na
 5yIA4CEHwoVpxpFHGIbbbRMA==
Subject: Re: [cocci] [PATCH 1/5] drm/amdgpu: Move a variable assignment
 behind a null pointer check in amdgpu_ras_interrupt_dispatch()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1865
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/d4136720-e6c8-490b-933a-4a884412b38a%40web.de>

> Date: Tue, 11 Apr 2023 10:52:48 +0200
>
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Camdgpu_ras_interrupt_dispatch=E2=80=9D.
>
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cdata=E2=80=9D behind the null pointer check.
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: c030f2e4166c3f5597c7e7a70bcd9ab383695de4 ("drm/amdgpu: add amdgpu=
_ras.c to support ras (v2)")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.c
> index 4069bce9479f..a920c7888d07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1730,11 +1730,12 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_=
device *adev,
>  		struct ras_dispatch_if *info)
>  {
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
> -	struct ras_ih_data *data =3D &obj->ih_data;
> +	struct ras_ih_data *data;
>
>  	if (!obj)
>  		return -EINVAL;
>
> +	data =3D &obj->ih_data;
>  	if (data->inuse =3D=3D 0)
>  		return 0;
>

I would like to point out that another software adjustment got the desired
development attention (on 2024-05-11).

See also:
Commit 4c11d30c95576937c6c35e6f29884761f2dddb43 ("drm/amdgpu:
Fix the null pointer dereference to ras_manager")

Regards,
Markus
