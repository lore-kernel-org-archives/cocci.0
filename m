Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A02C0218A
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8yVhy5gYid/2raYylgTdWDODKxVjjftT2M+wJ2pUjuE=;
  b=J+TA7CXi6k8O+JvxfHU+9tYmiar7sslXHt1fOadTG+/l24PXu9E3JLfe
   br/wrsHZzNJt9C7dVA+PJLcDc4ILR526m0oROT2uQMI11C6La3xAcsUaq
   fwo5N2n2zUgUdNwk3UmK04alb1JfI0T30Lau03QdKQz3FqfoZHBtQ7jVO
   4=;
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
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205813244"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 16:42:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6BA27E0D1E; Thu, 30 Jan 2025 16:42:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 60E1CE0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 16:42:17 +0100 (CET)
IronPort-SDR: 679b9dd4_yaLLTaemYcmOZBgvtdLJO9rAFfjUuYiFIbXHQsFgvtxqmta
 s+eRnmow8ZMkHwnBpiUQ1umKqQqd2mrN02qiNsw==
X-IPAS-Result: =?us-ascii?q?A0GAFgCUnZtngAwR49RaHgEBCxIMQIFIC4JEYnUzBAtIh?=
 =?us-ascii?q?FaPT4F0MIQ7hzuHVYxKDwEDAQ1BAQIEAQEDBIR2AQkCincCHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLDgwCJgICVgYVAQGCf?=
 =?us-ascii?q?oIwAQMOIwe3TIEygQGCDAEBBtpbHywiV4FlCYEaLoVrgmMBimInD4FVRIE8g?=
 =?us-ascii?q?lIxPogegmmCM4RMZ4c6gjmId45uUnscA1ksAVUTFwsHBYEpSAOBESOBJgU1Q?=
 =?us-ascii?q?TqCDWlJNwINAjWCHnyCK2sEBYEtgj2ERYRRhV2CFIFlAwMWEAGDJ3gcglcdQ?=
 =?us-ascii?q?AIBC209NwkLGwY9nkCEXzUBgXylSKE6NAeCOIFmgWMMn1wGEy+DcQGTUg4Gk?=
 =?us-ascii?q?nuYfKktgX0kgVwzGiSDNk8DGQ+OIYQtx3tCNTwCBwsBAQMJhUYBAYo7gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 iff/IcGng==
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:P9A/IqlLDkpi7eJqh2j7UgvvHv3pDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AJT9sAGm95kAEVM+qgVp7UfUQda7XOVKFnEXoBmq?=
 =?us-ascii?q?KMG9kbL+0WEWQw51eldU7zg=3D=3D?=
X-Talos-MUID: 9a23:IZzPlwQi1ZHVaarqRXTAizBSLZpk2p6gJ201jJU+mOeCMhNvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="107780516"
X-MGA-submission: =?us-ascii?q?MDGdGf3PmVTylCJ6I4IZjCbTJez8wsWZWRSvlR?=
 =?us-ascii?q?CGu0C9lvTnSZrIqNKQ9Q3CwOVV0k9pIIilyGGbqtJf+V51NTIzxdGy/4?=
 =?us-ascii?q?zvXZ/Wtldu/qXtL7mo6BScLQARIwvtMlBF2y9wjwxe1YZGAep9MZhhZW?=
 =?us-ascii?q?YpHD72jskQkU49trnQzY9C9w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 16:42:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738251726; x=1738856526; i=markus.elfring@web.de;
	bh=8yVhy5gYid/2raYylgTdWDODKxVjjftT2M+wJ2pUjuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P5L7pUV2vPGkDnuAD83o7npgG9tAH1EWdDzKe4TbVV8hmMouxJJ1kJ5cLjb1qIvb
	 UZi0iL9aav5cDnJeu0KjrPozLdxJRXQ8qdBRTdju8s9Qt5J5a5P5VgpHOiDFw+zpG
	 mEw4wmnBMtFhaAtGBfHH4PYpH1wCC+ZqtE02tkOncB5EQDfv/zG4VI9VYy//Tblwp
	 9XeTkkyaxHez0Tmrlt4ug6cKAneaAH1JfiYEw2+nAHNqouF55Eu1pTNNhgbK/guKF
	 C0PE88opyD4zeuoVAmHm41RE3q0o2p/MTY9lzR0Wd+m0b+vxUuMnf9LaurT+XbjRD
	 1zse31gCCB9jivFFdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1teLUZ2LW1-000VTW; Thu, 30
 Jan 2025 16:42:06 +0100
Message-ID: <97e3a722-e3e8-495f-b6e9-6d6137a02410@web.de>
Date: Thu, 30 Jan 2025 16:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Maxime Ripard <mripard@kernel.org>
References: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
 <2f86f8-3345-7be0-71e3-47e3ba1c754@inria.fr>
 <3su6bfoiyc2t4gmouitdogr2xo4v6nvpf6j2jzpg2uvwgngtrr@h3naxtnwhyqk>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3su6bfoiyc2t4gmouitdogr2xo4v6nvpf6j2jzpg2uvwgngtrr@h3naxtnwhyqk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GdlD0NtHoOzRiEMMfBHCE8iArCghqCZVSCWvnDX+KQZVwavDCG8
 v4Ilz1JuT3SwyYQz8o2ggkbv8fTK2XQBYuI2MbglP+rwuiOie8mBN1KUmgdxUYvFyJCQ5gM
 bW6BwJNhihsAr/KgbVe6t0kHAPU/ul3CV/UDzfF/GrRIC4QMM2CDcLWRoZvE/Ee+mdXsvSx
 iAO83fns22ryExr9cTj0Q==
UI-OutboundReport: notjunk:1;M01:P0:k89QlW0AkRk=;ERdM68hp7G1xYetAbKL9bOU1SOI
 Lt03k1ak4tCCKJ6J9hobrGNDKVYirV4xg1XylpOcA+5vweg3EiRuxNsJ/Hpv5Z9NaMDN0A15O
 d4bI3K9NeyVGxNJBNWuL8hMEPrGlXCrNYHS9qP0dtfiCfYIxPR45y4B7/apcVF0Hta9D8rYkT
 HTbHbCjSMQ6nMsNanoKvE/jAfpOtHuKDWe8iijecEHZxgMJT7mELJAm5ypG6k7fxKwJnMZdUm
 ZnRViK1lw0ts/h0CNf0YnWK8TF/GJ/IS0GZQWEqeQ+P8irubOKJKCZ71vcV+a/eZ197wQxbDC
 OssEkRppSIcpjF+iojoTp/VapKguJ0yOXodEjeoFg/ftXUUFAqmuValBsRFVQzLPDNgDgCISn
 0cLe4k9zRxMqI0HLD5XSAJUtMh/fdXg/6c0geL91xQ62Ui1yJgO5jq7KHrEU5CqKQUXzfl7o0
 wan/FBfUFyxSwx8J1vlj3E7yt1zTrdqyw0apinT16ePIo49Jr8tNWZS8mvMHD8XzgLwv1xOP8
 41PIAI+VxXZy8cm5IpDLNIjWQ3VXqRa4pqDbsvLMnOAjLO3rQd1TKq/I1OivCkDSBg6YWev0F
 NuUqNRSOjSJHYps1nueBhuIRtTz0CdGLPNL7NfHm0OerLzcDRDNP/sGGzlqqpXFv70/m0Hupr
 BXWj02GDlfz6SIyeB2VyVSyLV8egMCQAAKcQtC7/GoGQWiZ6EJ51VD4uZ1/OTHXBTypHC/lk9
 x/VW80g3QF06QBSnQFok77TtzT7+FUWqMcgNU0xYiNbOJ4+NvWBC1Hh/2SRMDga/ehML5kftP
 MijvxL0cZbZ6Pm2tEO9yVigckp1dKJ9WVZUZn301Hqh2tI5/Q+/D0dzukDQAui8Q0WLQoVPeD
 zord8sHGT3f6cC7poQeMuBiid8IuHV/U3nMmGlS8/TJL4QKFOOSsW1p1fd0IUExFTQFWRi2BZ
 9UpNswCbCb2VmVoHC7r6+x8T/SUfjAy4xrQcwXv/cK+6UpMmTpEYTqWQmF0uwe2xdiNObaFoW
 ucHo+kc9+MuYPvhflahWOJ65r7mSNGHSAPWrg3Zk278RZ6Vpjspp/CI/Z9vAxV/4KkMW3r/IX
 CBNAjbYgNe8Gf40KbsRYJ6AKf1MU9IK+u3M7kRdujqTfM3bK2taavHT6P8B6jCg3evFln3dyT
 2Ic84pNH6bfj/Gpup6EL7fWIFluyoWsBvmWqfOWxhTg==
Subject: Re: [cocci] Help to match variables with different names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2322
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/97e3a722-e3e8-495f-b6e9-6d6137a02410%40web.de>

> I've been testing so far with:
> spatch -D patch  --cocci-file test-ml-atomic.cocci \
>        --disable-worth-trying-opt --all-includes \
>        drivers/gpu/drm/bridge/panel.c drivers/gpu/drm/meson/meson_encoder_dsi.c

I suggest to reconsider the passed program parameters a bit more.

* May the operation mode selection be omitted?

* Are you sure that you would like to analyse two source files
  together here?


Regards,
Markus
