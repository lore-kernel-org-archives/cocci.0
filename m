Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9CCC10F16
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GyvJhSUTnJSHoKluvMT0lpWy6RdmSHXDI2XI055HQe0=;
  b=hftX+QDnmJwc0gof6xYr+pUQJxik1AfKLFkvqorr+kWLbIIhL38epjSi
   ypdR/6zfVxfbOYEylSoECK3ML+gyBJwImeKXHnDsrC41zC+wacFP1Lkr/
   t8NNVY+zd8AAH5hzohOCrOZBHrhO3BTUOpA+h764BwP6jnvDPiZ/sgYp1
   U=;
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
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164401935"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 15:15:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A166E0141; Fri,  3 May 2024 15:15:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9902EE0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 15:15:21 +0200 (CEST)
IronPort-SDR: 6634e369_oLqDiODDH9mOC92QzO4JbewwzxHmXo1GJJ3l/VuOcnPrdWW
 doOy012aj9REV9yxaA9xA5UDzk1nI19GwS82YQw==
X-IPAS-Result: =?us-ascii?q?A0EvAAAc4jRmhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDf1QzBAtIhFaIHYcpgXUwhDuHOYdPiHGBVoFAPg8BAwENQQECBAEBAwSCC?=
 =?us-ascii?q?4J0AoguAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMXBw4QJ4V0DYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBA?=
 =?us-ascii?q?QIBIx0BAREnBAsLGgIfBwICVgYBFAEBgnyCMAEDDiMHs0iBMoEBggwBAQbaW?=
 =?us-ascii?q?R8sIleBYgmBGi4BiC0BhThEhEAnD4FVRIE8gwM+iB6CRyKXeIIzjHBUfRwDW?=
 =?us-ascii?q?SETAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDCAQDRAMgb?=
 =?us-ascii?q?xEDBBoECwd1gXyBNQQTRAOBOIl9DIMxgXcphCEIQ2wVg3aBeA5ig2GCWx1AA?=
 =?us-ascii?q?gELbT01CQsbBiIBHaUygXAMgSmjY6EgNAeCNoFggWEMn0QGEy+XOA4GkmiYY?=
 =?us-ascii?q?iCjHoVJNYEwOoFcMxokgzZPAxkPjiAZH4N1mT1BNTsCBwEKAQEDCQGBVYNwA?=
 =?us-ascii?q?QGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OdjFRalWBITST6GC+6Ej6N50ewHpDfId3DAbv31ZSRFFG/Fwz/
 re/sjzpiWE7Qr5P0tQ4exoWZPwOE80mqQU3WB8B9qftWrdyRCVxeNZnOjfKlTbckWUnNK1vp
 0OT0EKMrzN5C9B4/oSjjPVLz9q+qjizEnhv5a4855Cd3ANV51d
X-Talos-CUID: =?us-ascii?q?9a23=3Ac9rQsGmD27gDfDnv02cRcDgByTzXOSDjw3vreHW?=
 =?us-ascii?q?cMEFkSOGURWOM3fJny/M7zg=3D=3D?=
X-Talos-MUID: 9a23:JC4bUAuBw6K1VxQU3s2nnzBmFt9U/KGVJkUVjZMLptCobHd1EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="86319416"
X-MGA-submission: =?us-ascii?q?MDFAkaHMsbRIuCACc1a819JimuTy1iN1So2jrr?=
 =?us-ascii?q?WaV+5UEII/OPvGGlI8VyCvMyJmGkWFI7oCVg8B1NU8K5JP+wBO31GdXl?=
 =?us-ascii?q?xLVRKesFfo1LTOnOD4JIY6R+LZPcZ2pJXLP1lbTt+ttHj1AtbnCgYKkY?=
 =?us-ascii?q?zLoPi5n5wp2F4fTa7WTcZyjA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 15:15:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714742117; x=1715346917; i=markus.elfring@web.de;
	bh=GyvJhSUTnJSHoKluvMT0lpWy6RdmSHXDI2XI055HQe0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oW1lcpiEAGoK5V6pxTq5mQKwchdmXYZNYgL0+e8igDGWJ5KR4/viDauKCLqcuzwO
	 MNHaJqUCO+P5nJ7qvn2xM02dV9AKc/FautH8vdJnvKrZexB+F8VNTCKym8yEy1QbI
	 CXINUYbCzmskJ2XDNcoZbB2o2HJwYWikBwtNlgOYx9TS6o2pAhjOQVJxbnc4w+0g6
	 lu3X4uBs3wljmx4TDB3jzUpLZT/IQ92kN9/idGxW/igFTtEUa4w8IOOAWcbfsavyM
	 TWI6jG668kcLdcOeXf/1GR5utI4RenSDDLFmslFCJopOZ3YCt1mPLNV7+Oc8Jb7iE
	 746wvzlVmv+hZeJ2qQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pUK-1s0A0J3Leo-006fQb; Fri, 03
 May 2024 15:15:17 +0200
Message-ID: <bac341fc-e0ad-4e0b-8ea9-69ce8a5ff791@web.de>
Date: Fri, 3 May 2024 15:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
 <20240503121530.GV7636@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240503121530.GV7636@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RVZcr28cCqfMGJAuE7eJMSeLtH8xtdxLFBqbDZurUcawOh5UCYv
 Ll0wYpl/lg3S4WenxQQAIDMGUY8m9jiO+AcTj/6IefdiMYwPZL3otXcbr8wBH4+4TJYdr2x
 2LyEmoKhPfJ4oJVPF0O3HhMKIwJrKpPNIMjWwv6TrNiklswEScH6RSk8TlIS4GZ46jAC+P3
 BMhr+DGfy8dz8vk/5RJmQ==
UI-OutboundReport: notjunk:1;M01:P0:MMCdNs+aGKk=;9OnyQZD8hHFHzWpauEj5eLVutYu
 xBUK+mXG5u5q6JPV0YJq/XzUh3RySx0z9F9OT18L54U9OFZ5pd1q7FRUryKFn3YBgnEE+Wwh9
 rMrktFkzL7TGp8j8HefPTV+cg7UJWxu4beZAa4XGyxqGy9v8OmwsaP30lRrzlU17Jz161VC95
 4F4TW62Y4QCbq5CenP6OtAo80rOVMtUu562+RIIrRyOYma8q2mxtcwAZq3ykcaPCatuVkAxNu
 V4yvgNEfCfIsLDFDuqDlDyhrpb4h5VPvkKY8Ve0dQ5ffgC+txsrvRVr6bfiNoxUIlK8OzSe4a
 dl9bYY1fcncavhgyUsFtKOWk8f+Tdfsw4K/oKUf3lhFDcJoIAlE3v0qmF2msn79w/DgA0hl/z
 rHR2HeWsUOKld4o+fP7X8eIvJIglX8I1XhTMgH8aTLDaO2TcE4MZ+EbClrnLjtq5mHedoMJnJ
 3x3WdnJQuPb+Cckbec1h/KlWB/bl4tgo/sB70uH4zz44DQxGzpeikL2otQnyx95Odq/f3w5o3
 4nT6asze2P+cjaoTTu5oooovaRt6XvQsnMSs1emih6sM0WXhUyvLwzzPnLqbarzdqcJx9IqFM
 aPpDEeOi2MGXVUnzSoSrE8aUO55ZjrrUd6TX4UKEbfejV2git5f/b8GqY2UazLIyD2HA0MXjl
 4JQGLaeac9k6RXAIOyIMVuVdN0aQFXmu/IkSW4cVt4PLV5vNMUZjOU9mDbZVRxE1aAUbOKKhh
 Gow7goU0b917s1UZUIeKMwGYHC5r0MHxHEOqjnBggcEdNuF3iAwf+apIO+kK5bhE5LrHb3bu2
 +exIA8g9SYfo7jBCr6zSgUqAPtMaVU0/VWwJ8/VnTeHWk6eX98QQV/aKc1oOGbmu6n
Subject: Re: [cocci] Influence of build configuration parameter
 =?UTF-8?Q?=E2=80=9C--enable-flambda=E2=80=9D?=
 on compilation of OCaml source files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1696
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/bac341fc-e0ad-4e0b-8ea9-69ce8a5ff791%40web.de>

> It turns out this happens because Fedora enables "flambda" in the
> OCaml compiler (ie. ./configure --enable-flambda).

How will the influence of such a build configuration parameter evolve further
for the compilation of OCaml source files?

Can it trigger adjustments for OCaml software packages?


> flambda is "a series of optimisation passes provided by the native
> code compilers as of OCaml 4.03" which "make it easier to write
> idiomatic OCaml code without incurring performance penalties".

Thanks for such background information.


> It's not enabled by default, which probably explains why this problem is
> not seen on Debian.

Will any corresponding program variations become more interesting?


> I will discuss with Fedora if we want to keep this option enabled or
> drop it.  It's not a show-stopper that Coccinelle takes a long time
> to compile, just a bit annoying.

Will corresponding software run time characteristics be checked and improved
any more?


> It doesn't seem to affect Coccinelle in any other way
> (eg. making it faster/slower at runtime) as far as I can tell.

Would anybody like to improve such comparisons in more detail?

Regards,
Markus
