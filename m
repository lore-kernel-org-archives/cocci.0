Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D7CCFA13
	for <cocci@archiver.kernel.org>; Sun,  9 Nov 2025 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=yUle4rJiw0LHWdtZqE5ibylabRbipHb8EUAwStm1Qdw=;
  b=peYSrexVybEZxTAJrCJWQPNmet4IChp42/6nIZvrXRkQjMb8D1XXSRwx
   Ez2Kfa2icNHybyKOwC7TEMJwDUbHswBLoE6yV3U+GSernxSgZIH154DvN
   5OPBzURuBjD58aHNRTjNK+uTlDRlIN7R3QHZp704gW3DeSKryhNy3BAwb
   o=;
X-CSE-ConnectionGUID: 8Tic07eASe2I9PyNpkMbZA==
X-CSE-MsgGUID: GRtu1nn3Rxii7tF1ceOWqw==
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
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248358065"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2025 13:09:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D739E0B0D; Sun,  9 Nov 2025 13:09:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0D323E0171
	for <cocci@sympa.inria.fr>; Sun,  9 Nov 2025 13:09:03 +0100 (CET)
X-CSE-ConnectionGUID: 1So0zYHwQiCV8PY2mFC0tg==
X-CSE-MsgGUID: qNAzK7+NRHitEohIYoNjXQ==
IronPort-SDR: 6910845e_1X4aKUrHUe0eE4cIHGDloYDUqEr+WMs4/bicrqIqoGu01Js
 wpsvwqLA0lqDijP2DlrGs5kJp1UgQxMVEab8L0Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FbCwDagxBpeA4P49RagQmBUIJAZR0GWDMEC0mEVY9Tg?=
 =?us-ascii?q?nmDZo8RiHmDUgIPAQMBDUQKAQIEAQEDBDcBkSQCHgcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg06bR0BAREnNAImAnECAQGCfgGCIgEGEAEDNgcNrlaBMoEBg?=
 =?us-ascii?q?gwBAQaCadd2HywiWYFkAwaBHC6FboJKGwEFboQKhhAPgVVEgTyCUgEBL4VOg?=
 =?us-ascii?q?w6CRyKCJoEOhieCU5BOgUocA1ksAVUTFwsHBYFjA4ELbjIdgSRBGHE9V4NJI?=
 =?us-ascii?q?mgPBoESg1GIXkAPijACAQttPTcJCxsGPZR7hAoBK4INk2yzATQHgjiBZwWBX?=
 =?us-ascii?q?wyJCIEmlT4GEy+DcQGTYA4GkwWZBowOgXqVYIVZgX4kgVwzGiSDNhM8AxkPj?=
 =?us-ascii?q?i0WhBGEYLdeQjUCAQEBNwIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23: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
 Qzw
IronPort-HdrOrdr: A9a23:WMZI8Ko0eUQIA5L4Jp8NRd0aV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:6zeLkG5B7WcmntnkoNssrXUTQtIUUmLkzVzuc3eJU2NHY+WJRgrF
X-Talos-MUID: 9a23:0szKNgSGYP9CBW1rRXT1ohhwF5grxZ6OCVwglpUnis6iNxxJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248358055"
X-MGA-submission: =?us-ascii?q?MDHuB04W3FebZPGl3wwGngMVMcgpNEI/AzH4+J?=
 =?us-ascii?q?BYtiQ81C7fEeXfdumYQ7nQ002EVvvQUW8RspIuuwNLpJMBkpoQCgh7BE?=
 =?us-ascii?q?mOkuferG4w7q+lzv4y58sxRQ0K3XKIv4tVvN8TLdIRv3mX/qhXS1rIji?=
 =?us-ascii?q?e4vGQ72A+b2YApgBG5qcJlZQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 13:09:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762690141; x=1763294941; i=markus.elfring@web.de;
	bh=yUle4rJiw0LHWdtZqE5ibylabRbipHb8EUAwStm1Qdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SHXb4atsi7Glb8yCrWZqxoaW1MXFfJmhraFmKIyezzgv6CtOdgW0XuTbMQDaVsa3
	 m1umN4MZCCJkMIxNzBSf4HE+3nXep4DIamgHD8tyK28lvALAJ30GGZW9SJcscUe7q
	 T+6saX2bMmenhhVSO+mah5FL3H9rglbF87aOUGnd2TZZJFR58n4Jl20dxVsaleU3H
	 LAcBGNA+0Tp1jQ+PSPxDopgl3lOCaT/8YyIicsJme2gwNfT/Lms85ixM65JsHAla+
	 wNiYMTqy2guPCmjsYGi6MGv7LEiN2o/bY+M93d8n3tlUzaCZ7gKbXbkG5WmWL9jLy
	 bzg3XZh8QAgm7qN1Sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.232]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1vKpNf2Aaw-00CsDq for
 <cocci@inria.fr>; Sun, 09 Nov 2025 13:09:01 +0100
Message-ID: <f32da236-a8bf-4ff9-a18f-f8536ac5d5a3@web.de>
Date: Sun, 9 Nov 2025 13:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/LxWYiHdPji7l4x/wiNjPDTHu7SYZ8ZzbFiVmqH8QMr2JMnkRMK
 wdvWHsY/d66y0gsKGhcs7uILkTwLLDyX5ifpuKXal7N4VuRP6QqYq/A+dT7/gGWelZhqwar
 sDsHz8kgW9/KvJ3WmondBAUeRvUGTpwtCzW67cordil9tj7E9OQoceqZiJgJJc5Z/+y+JSc
 o4l4gePwyWWPe+dPP9L7Q==
UI-OutboundReport: notjunk:1;M01:P0:8qwu7KF4Bik=;YOOxDcb1P6iR7McU5ZoW5diQMij
 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
Subject: [cocci] Restricting information search for header files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3150
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/f32da236-a8bf-4ff9-a18f-f8536ac5d5a3%40web.de>

Hello,

I would like to extract some information also from header files.
It would be nice if a file search can be restricted accordingly.

Some information was provided for the clarification approach =E2=80=9CSour=
ce code
analysis for header files=E2=80=9D.
https://lore.kernel.org/cocci/alpine.DEB.2.10.1501071549410.3328@hadrien/

Did interests evolve any further also for such a development topic?

Regards,
Markus
