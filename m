Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ADEC0218A
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=508xwgjDLwg50n2/3oy3qwn0MrFMqmglAM/RjnutjFE=;
  b=uhf8zOSRe3V5VDS4RTnWqFsZzWmFerlYwzv9iZV1MwA226wd6gzsUoUL
   WNKiv03pBZF1BeqahC+ndD+CZmSI8oC/z3b0FRaEUUV2rU3SywknToQ6i
   gt3McMnIs6xVzu5jQfLunPKDFXgheeE5mRHbninlrxFLJRpJK82esDMwM
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238491"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A59EE0D97; Mon, 27 Jan 2025 17:17:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1D0AE0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 19:04:19 +0100 (CET)
IronPort-SDR: 679284a2_KdLxYIRtctd2Ev8EXveNsbPc5wroFPl60hcuoYyDmeGun5g
 NQvvZq8m02x3PGvCvCPJNU/9SCKOvxCV+DyuXLw==
X-IPAS-Result: =?us-ascii?q?A0F4AgDPg5JnhcNp+5RagQmBUwKBcFKBVzMEC0iEVo9Og?=
 =?us-ascii?q?iQTnC+BVoF+DwEDAQ1BAQIEAQEDAQOFAAKKdAIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew1JARABggcBM4IWLAhjA?=
 =?us-ascii?q?R4BAQEBAgEjBAsBDQEBNwEPCxgCAiYCAlYGARKDAYJCIwMBBLdDen8zgQGCD?=
 =?us-ascii?q?AEBBoJo2TeBZAmBGi6Fa4JjAYFsg387g0J6Jw+BVUSEPz6IHoJHIoIzgXSCN?=
 =?us-ascii?q?IEMjE6EQYRnii8JSXscA1ksAVUTFwsHBYEpSAOBEiOBJgU1Cjc6gg1pSTcCD?=
 =?us-ascii?q?QI1gh58giuCH4I7hEWEU4VbghSBZQMDFhABgyd7H4EQHUADC209NxQbBp1NP?=
 =?us-ascii?q?IMagUOZX45+i3KUXTQHhB6BXQYMoCSqU5h8IqhaMYFnOoFcTSODN08DGQ+OK?=
 =?us-ascii?q?hAJg1jCEyU1PAIHAQoBAQMJhUUBAQGHfIJhgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jRlPOKquTLRToFsuKH0Yq7AaV5oSeYIsimQD101hICG9vPb4qy
 nIpoVj6faUskd0ZJhEo7u90ca7IU80maQb3WBVB8bAYOCEghrPEGgB1+bfKu3bakjDH4dmvM
 8LT0E9MqyTMbEQt6rHCWeDferIjOP3l5yVuQ==
X-Talos-CUID: 9a23:DO3gtWEDeRVrav1mqmJq8UoOSs4pKEbD41jsYGG1MGVGE5asHAo=
X-Talos-MUID: 9a23:P7bwSgRQMYTtPlk9RXSvxzZzLeA2u5iiVhghg5xXsMucbjVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,229,1732575600"; 
   d="scan'208";a="107202566"
X-MGA-submission: =?us-ascii?q?MDEmjDyFfv4R9sbVuUk2nNVwSWfi9CjdqNXyW9?=
 =?us-ascii?q?u6R3oCymUyR/0xYiO+v5uUT+FJsQ44JUItLSkuSr+UbTQhn30OXu4P19?=
 =?us-ascii?q?ZEy8qFy7EtJUWXJQgY8itTqZaxLTVGvBUDEe20i1YKhfmCvI6okRGdDF?=
 =?us-ascii?q?LB3BJ9FLzYCbM3MoUwrbuFHw=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 19:04:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737655456;
	bh=eTuapbwK/KdvI8diNR5eurIEYnCZRL8MW3R/4gjq+6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dN6XkPpgjABscLcR3nYIXAz0bQMLNZxgbT67jyUfEivcJlWdPP2fqMzeJqdRFhXDA
	 FXaNasNNERyvl9jd3XW1t8+71Fl8VY/aeR33vSFgsEwpu6mqU180G5g+5ZkKWTeCgk
	 7Kq7Odd/pvaQzv52RtaphR1dxl6ib0q3x5fnXwG6xvOefakPg8ByZ7IUrAKDb0yPQd
	 zvjwg5lBe78jQX2NVh+K60iQSBLPW/bFnkWSyyf7PCzz2tTyEhg43478l7lUUF18/7
	 u9esbGiOIdgxqzhHPLljK3iNRG8S+j6P0H48nKAnX8efHquACXBRBMvVGCA1i32LvY
	 m2pigY9OxoHMA==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5892917E0E48;
	Thu, 23 Jan 2025 19:04:12 +0100 (CET)
Message-ID: <ae9d345c71e99ac56b935a18f02c2c01fc87b9e0.camel@collabora.com>
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>, Vignesh Raman
	 <vignesh.raman@collabora.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, 	mripard@kernel.org,
 linux-kernel@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, 	gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, 	tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	kernel@collabora.com, gregkh@linuxfoundation.org, daniels@collabora.com, 
	helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, 	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
 melissa.srw@gmail.com, 	simona@ffwll.ch, airlied@gmail.com,
 Tim.Bird@sony.com, 	laurent.pinchart@ideasonboard.com, broonie@kernel.org,
 leobras.c@gmail.com, 	groeck@google.com, rdunlap@infradead.org,
 geert@linux-m68k.org, 	michel.daenzer@mailbox.org, sakari.ailus@iki.fi,
 jarkko@kernel.org
Date: Thu, 23 Jan 2025 13:04:11 -0500
In-Reply-To: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <20250123135342.1468787-6-vignesh.raman@collabora.com>
	 <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 5/5] kci-gitlab: docs: Add images
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2233
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/ae9d345c71e99ac56b935a18f02c2c01fc87b9e0.camel%40collabora.com>

Le jeudi 23 janvier 2025 à 07:46 -0800, Linus Torvalds a écrit :
> On Thu, 23 Jan 2025 at 05:56, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> > 
> >  Documentation/ci/gitlab-ci/images/drm-vkms.png | Bin 0 -> 73810 bytes
> >  .../ci/gitlab-ci/images/job-matrix.png         | Bin 0 -> 20000 bytes
> >  .../ci/gitlab-ci/images/new-project-runner.png | Bin 0 -> 607737 bytes
> >  .../ci/gitlab-ci/images/pipelines-on-push.png  | Bin 0 -> 532143 bytes
> >  .../ci/gitlab-ci/images/the-pipeline.png       | Bin 0 -> 62464 bytes
> >  .../ci/gitlab-ci/images/variables.png          | Bin 0 -> 277518 bytes
> 
> 
> This seems excessive.
> 
> We have a few images in the tree, but they tend to be either the
> penguin logo or various source SVGs.
> 
> Not a set of random screenshots or whatever.

I can only agree.

Nicolas

> 
>          Linus

