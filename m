Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECC5C77B6F
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gSkA26wrxyRy+QosZCxwgxJGwRdIBWtCkPnIMmQcM3U=;
  b=DIBLU8J4xheC2BKv1Un6BVnKEzX+wZPN4Op5ZHIuEtudk3NP4YhiJrjH
   LI5FAZuO86bNbPg9UtOk4vtCs8WCxxuPjrMltPGWFzc36zAPP7a33Pn+2
   RhWWhh1U1LO2aDGCQh2dmXv0SoGczW8Zlec5aInMpgZESDe5hhUV2uqz9
   A=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102469461"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 16:45:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62B19E7315; Tue, 11 Apr 2023 16:45:54 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DA78AE72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 16:45:52 +0200 (CEST)
IronPort-SDR: 6435729f_vLI8VGj0LFRqAsA0ICyGXhSf8yXIvOxlaumg2cdfE38Prl5
 7y1R4DeLtzuSG4/wo2DaP2NudOjPvLlvhOjsvkA==
X-IPAS-Result: =?us-ascii?q?A0EmAAC1cTVkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGCCKEKYgeiRJpg0eObIRohAOBVoFAFigPAQMBDT0EA?=
 =?us-ascii?q?QIEAQEDAQM4gRGDNgJrhFICHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEVYOgQYCAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQESAg0HMx4BAR4BAgIBIwQZAQERJgEECwkCGgIfBwICV?=
 =?us-ascii?q?wYBDAgBAYJ6AYInAQMOIwcMBpAsnBl/M4EBgggBAQacCx8sIlSBXgMGgRQtA?=
 =?us-ascii?q?YxKP4M2eicPgVVEgTwMgQmBPjA+gksXBBiBRoNbgmeJd4R1iwg8CoE0doEgD?=
 =?us-ascii?q?oE9gQQCCQIRa4EQCGY5gUBAAg1kCw5xgUljTB+BXAQCFD4lBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwsfBlhrAgkjERMFAwsVKkcECDgGGzQRAggPEg8GJkQOQjczEwYFV?=
 =?us-ascii?q?wEpCw4RA0+BIh8GBCQLXnwKBgEmJJ17c4E5IJkVrEs0B4IrgVaBWQyKDZUAB?=
 =?us-ascii?q?hMvlwkOBpIlLocwkBUgjTOaTIFjOoFHDgczGiSDNhM8AxkPjiAZHoM7MzeOU?=
 =?us-ascii?q?gE+PzQCAToCBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:3J7j5qsS+Jzistc+1lrEQHXG7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53106092"
X-MGA-submission: =?us-ascii?q?MDErbyXCMUs9eGBN2NCH90QAZgjDR6CkYgC2vG?=
 =?us-ascii?q?YDEtIdMIXIivvOxjXFnI0+wqnV47uq+7oaO94x57556v1iWNlU6m77pr?=
 =?us-ascii?q?vUw0tQRGVCCIVND8KJgwXBs9aSJzsCTKJtNo1qKQrQ/RSj0Xnl9VrKnJ?=
 =?us-ascii?q?MOhXE5QNqGvHLWg6U1RAMrYQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 16:45:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681224338; i=markus.elfring@web.de;
	bh=gSkA26wrxyRy+QosZCxwgxJGwRdIBWtCkPnIMmQcM3U=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=brOGIuIzL8jkpWV2+9PMLpz6rUpA6nUBkmosSyTchGco51wubdEShCyMBygLUCVQZ
	 SEUqgJvGs8vJBwtIn0rG5f4qJ1xjNjG0TUf8q0FM46r46ITTtByOWZqCAYGQZ013iD
	 HADwCgioc1cTyLAFTH/ajeWmqzsbn4igcRRKpkMc/vfBZ0MJvSLtXGA7NRXUs5teNV
	 G2O3ITOycm9NLkvi6iiuzyyVzuNBNwVJohXZ4rs3wFlHl73g3c2s726ldjOTCMrOY2
	 imlIhWOGy5zfzb3e11mSzJCqFApPAYUjlEUKz131d0nU4ymNQ/8FJw0aIQRJwH7hIh
	 szsQJhb6QUuYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgANG-1qIp6y20B4-00hj3N; Tue, 11
 Apr 2023 16:45:38 +0200
Message-ID: <1c1e48c1-9812-721d-855d-4000f84f4f3a@web.de>
Date: Tue, 11 Apr 2023 16:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Felix Kuehling <felix.kuehling@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alan Liu <HaoPing.Liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
 <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
 <c265e914-4ba4-1af8-a504-21dd859f0226@amd.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c265e914-4ba4-1af8-a504-21dd859f0226@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c3lsOpjID8jL3Oq1OuNPlFupaKFJEUYs5sYP2WRi6EXZDxCr37j
 g6Q3cZ8ic3h+AY9l5o4UhG6ZV0/3f8KSXLYfmSkNjbySIPuvxA87u35TK88Uqj/AvRleCTr
 tqJfxF//FtccrMshElC69lFfdM3S8BuVwrOAohKlDyFQ+6p5bM3R70itICEUNfAuvWQYNpK
 dra5I2bPfnIVrxsJJ1I5g==
UI-OutboundReport: notjunk:1;M01:P0:8I9ibC6Rfw4=;NJe/3h/4+YM5um0qr1wjmVsIT/7
 21b9/fOj+8T4fEvYARG9rzpat6nBQlc9q0bjBLnkTpIUEqtYTv9rHGNysKu970aVIlJW28zMb
 Qmjs4ZwvjWdt5xb381oVYjgmVxB7dnjtgBSjelPRmClzgq0gg9FTFGvVfyEDAyO9okNsHr2qm
 zWp/qJyyu4YT7fyOiTV1q+CaKM7wLZnMSLV5MEKPVfhKJz0hWxTitStjvfN4D+Gbh17BBReFZ
 c3YhCOwVbr2ZLFFJ9x3wYAvejc1Zagpi9YFd3XRXeo71cbh4h8e62UkZpE5KCuX/so/2E/ivc
 R8GpvgjM5arti+QbyFBTW0jTGz7SpA0LRHQjpBDX2KA7hMIpQolxsyYlNLlIp+KV56B23sJ/M
 JkEn61/6agnaV+vBvMY0wzgE5WJpGTNJpMXMcMH1jAiEHLYIcwLAZauWrUASbfnw+kjFswBls
 AydHoiVKWsbweDsTBVVcpv75tmy77HcH62pFSYyICJ1KNcRe5o0OKphh1Skq4nBKyPHtfOm4e
 zT0XfybGwnFMyfVUI4zfmdw0DzjYLiFQ4g4r67N8L+yvLoYIU/saCfykZkwNZliSZra1qhSYp
 2pNxafCEMCoklhLQ8CQ4UVsmdiEyKo/vsfeN6rr0drvrQAX1aT3PDnE3L43KHjhoJQ2s/OV55
 LZT6XnUTlOH/0dBUYorHhnBc2XOJH50xk68OLnDG1nntzjUkOJtGurs9er03S+dnwjfJIMqY6
 6bA7nGP5pk10nDG9U0pmVMAhJCNA6f7Cr74qQW9DrzIqGt/hSFY5CMhC6007UDXsrgvRKy4Uj
 RYFJfVX8S+FtaGP+9eu4WX4la2tTFErg9Ix9e3InRpP/fomO5UiOi0oekPTdrWTctNILKTpKn
 e/0cUJIwqREI7lKO93a6O4HlGoPQAIDUiACDYTV0SNrD1ZZBipnlgvp9l
Subject: Re: [cocci] [PATCH 1/5] drm/amdgpu: Move a variable assignment
 behind a null pointer check in amdgpu_ras_interrupt_dispatch()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1035
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1c1e48c1-9812-721d-855d-4000f84f4f3a%40web.de>

>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -1730,11 +1730,12 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu=
_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ras_dispa=
tch_if *info)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ras_manager *obj =3D amdgpu_ras_f=
ind_obj(adev, &info->head);
>> -=C2=A0=C2=A0=C2=A0 struct ras_ih_data *data =3D &obj->ih_data;
>> +=C2=A0=C2=A0=C2=A0 struct ras_ih_data *data;
> I'm curious, this only takes the address of obj->ih_data.

Even if a null pointer would accidentally be returned by a call of
the function =E2=80=9Camdgpu_ras_find_obj=E2=80=9D?
https://elixir.bootlin.com/linux/v6.3-rc6/source/drivers/gpu/drm/amd/amdgp=
u/amdgpu_ras.c#L618


> It doesn't dereference the pointer until after the !obj check below.

Does the used arrow operator indicate a pointer dereference?


> How is this undefined behaviour?

I guess that another information source can be helpful for such an issue.
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers?focusedCommentId=3D405504153#comment-405504153

Regards,
Markus
