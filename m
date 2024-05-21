Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EF5C25B74
	for <cocci@archiver.kernel.org>; Tue, 21 May 2024 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=42/g5jjayaUJG6j++LHrDo/iyGUKStzYmR+cffr2z9g=;
  b=fjMx6+NlT7i9iFL9/LH03oS47W0ABAL2SFIYAHls+3PHmqJnbWIjm/4F
   ejcU+hqNzte3+M5RUrNLaqLVczwWlYZRtaaz5K8eXmK/D5YyObzHnnqWR
   VzeJlcoi/q5u7Qfo59coJGD/qLDM/vQCvDsIYq6x9T+mHVWT7il63eTUt
   I=;
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
X-IronPort-AV: E=Sophos;i="6.08,178,1712613600"; 
   d="scan'208";a="166700217"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2024 17:12:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2593CE0CCF; Tue, 21 May 2024 17:12:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E2C1E00B6
	for <cocci@sympa.inria.fr>; Tue, 21 May 2024 17:12:11 +0200 (CEST)
IronPort-SDR: 664cb9cb_LtbovM5kSHRqU6wFCwC1KUzRKrnvP/hLXPRyOYjWDQrGjvp
 F5frBXkizPb3ihXeUTa6sHKECIoJ+9WnPtfl4JQ==
X-IPAS-Result: =?us-ascii?q?A0GvBAAjuUxmhwMP49RagQmBT4JEfAZUMwQLSASEUo9Ig?=
 =?us-ascii?q?XWBQoMpjwiGQYIwgVaBQD4PAQMBDTQNAQIEAQEDBDgGCYNyiQwCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDgULJ4V0D?=
 =?us-ascii?q?YJgGIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06awQZAQERJzQCJgJxAgEBg?=
 =?us-ascii?q?nwBgi8BAzEHDa8bfzOBAYIMAQEGgmfXch8sIleBYwMGgRouiBQaAQVniVAnD?=
 =?us-ascii?q?4FVRIEVJ4JSgzIBBhcEGIITgw6CaYYLggMBjkaDJYInj1SBURwDWSETAVUTF?=
 =?us-ascii?q?ws+CRYCFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjAwgEA0IDIHERAwQaBAsHd?=
 =?us-ascii?q?YMlBBNEA4E3iXCDO4IehB4IQ4EBg3KBdg4ST4oOgUdIHUACAQttPTUJCxsGI?=
 =?us-ascii?q?h6kO4JUgg8Ygj2TJpB6oSA0B4I2gWAFgVwMiH2BJJUjBhMvhAWTMw4GkmiIN?=
 =?us-ascii?q?ZAtglSHJ4ICgXeVQoVRgWU6gUYPBzMaJIM2EgEMMAMZD446hBSEYcd6QTUCA?=
 =?us-ascii?q?QEBBjACBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
 VBB
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5+9Y2qrjouhSS9MQUekH0MQaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:8xDwpW1yjckmg343GaIpRLxfR/1mLSf80mvpIGCVLDlXFKKJbUebwfYx
X-Talos-MUID: 9a23:NVcZUARvc13ewE4IRXTQuQpMbu1HpJ21DV8Wic1alc2BETFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,178,1712613600"; 
   d="scan'208";a="166700202"
X-MGA-submission: =?us-ascii?q?MDEyXetxuxdNWe9RusTR1GzPJ9y08NV4mw4lfX?=
 =?us-ascii?q?lhdEbQ6nBd6VBa9lvA4HurPBmZ+Jh89wa4pfW+CfxKREyXOBXfPRvNaZ?=
 =?us-ascii?q?NEk/gMuNdoY9J4aAXAxPsu4fR9tlCuPb5ZPA6hIyYrkV+9b5o4nJq1IP?=
 =?us-ascii?q?lW/ZnhT1AmUvq/ow881ff91A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 17:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716304330; x=1716909130; i=markus.elfring@web.de;
	bh=42/g5jjayaUJG6j++LHrDo/iyGUKStzYmR+cffr2z9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J6woGdgEqeO1evDAUexJdGDWA91Q+Zycdpsiiz2ZrE45M80zurJctAFISFQWE1uV
	 ekQSLYg3fqCiL5so9YWPnKeRlQ/gNnLzn5OLSP+KNHzrXzMQGgkoEbg/uHoQuXKOz
	 FoH+X3OADRvdPBb3tH3EKB9yJpTm+4x4SyX2AtwZ+eHi/jTo1kgTX6437oZYnOu3j
	 u8awIVYcU2/KDqdes5q/z5lxHzV8fIUr666i7rZZi0dQmjsFXD2JVVi2L6B3EMt9K
	 Fx8MB5eT1KseBgrQ77RozWGKtrdAXf5l8W6Z3VPJvPzzXHL9V76+cdhJRS+nvkFcq
	 lZwEGUUFl+xrWdRunQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1rvC4E1SC4-00VQax for
 <cocci@inria.fr>; Tue, 21 May 2024 17:12:10 +0200
Message-ID: <550803c2-45e1-4baa-b316-156ccef51390@web.de>
Date: Tue, 21 May 2024 17:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0AhFb1RImGdfRi5uSjpTea6LZYep4jcb9ZmwrekLXX47F+asWUv
 3Q+QWgp3IpluvdPDhlTrMDBr4QCVQ/VRq+Pv06B35gT72Oo8XsZt0lgyADCVCqS0KLeB6sS
 bS2awQn/MTpNRKu1aS/S/qbbkGmQIkq8q//KGl2LMarm9xh+QFk4J72YVa9cU1ZTeob+shn
 t6ABw3J8QGGMGYYAdGbdQ==
UI-OutboundReport: notjunk:1;M01:P0:RRUY7cDZhbw=;YlrHVRmWJKC1iKWhGHPWV1NbhtQ
 GA9a5CYb4ZZyIOCBOF3G1oMdcmYb3wxESzuZGyn2A/BJaakJNByRaWFAXwp0uql/tNLewrKD/
 lLkW6Z3xmNLX7YiNJ6RSKU0WMZ3T9w3RBeopZPNsjRUw9xPFI3SVDP9QVyKHMEYJnRqIahMjl
 cRO51EMKBvsLiQ393DcfJfBrSSlaOP5aJvmVsQ/IqSBi8OKkAoD7Ou9MDAXlj2a5zU70bV+/w
 EsivYR6ODjWzsFDNH0TCSZt51Y+nUiIpAaCzAn6MN/F7B/DhQGAjNuo2vU+8wC4YpSsdy2MFO
 XsDxjd2tOGiLPALjyl7wtB0d3qU5hvbVOVye2EIFko1VfZq2Z0yNXL8yx7f46KblorqAjvQvr
 yFF2iX6yGyLxu1kSZcSlPBk/V9tWQTYw2IAkM4IBgOY5ik+KuKVYbhYBQlfXqVYK34WqKshvG
 5Zs72lFHDN40RYLVEpumh+Rr9d9zyq9ZNSgoP2ruISRqlBdGNBaLNftu2qaI6LlMM9raKX2TZ
 MA4ZECoVarAadBa7EKHc3pu6jxI6GZsvJiCMtQCnnSeS4AwYPrgqpREiJQB6Ns+kefKgqW3Uy
 4FZmbBZLXTNYTovwUaWj2PQQtRrzm4bhVgRRzDI1MI10kQV0Mj9k7pERQGr1jvkwDnWWXwIDl
 KP49YkCHHJsluOZiy7OnV4Ie6lYQDIoRBcbW44XyHOWsJJY+XQJmV9Eoy3Rsv7ln+tMpGL1AQ
 m/yH+iE5RjuCa/1w7zrVRXvLiBIS+1clK3elMeE47ph3k2K46yPW4vuC/ZCDeuLg7Hl2GNo8D
 EKyfOd1NGNJ9VgcvOfU0jb5SYN1TOO6enICzmzRX6uqP8=
Subject: [cocci] Determining the statement end according to a pointer
 dereference (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1746
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/550803c2-45e1-4baa-b316-156ccef51390%40web.de>

Hello,

A questionable source code combination can eventually be found also
with a tiny script for the semantic patch language like the following.

Update candidate:
platform/x86: ISST: Support partitioned systems
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c?h=next-20240521&id=9d1d36268f3d8276aefd1fad4e0a415dc8c36edd
https://lkml.org/lkml/2024/4/23/1417

See also:
[PATCH v2] platform/x86: ISST: fix use-after-free in tpmi_sst_dev_remove()
https://lore.kernel.org/lkml/20240517144946.289615-1-harshit.m.mogalapalli@oracle.com/


@usage@
expression context, ex;
identifier member;
@@
*kfree(context);
 ... when != context = ex
     when any
*(context)->member


A succinct search pattern can be easily expressed with an SmPL asterisk for
an involved pointer dereference.
You would probably like to achieve also a corresponding code transformation.
But I find it very challenging so far to determine the end of the statement
which contains the found dereference expression.
I would appreciate your advice.

Regards,
Markus
