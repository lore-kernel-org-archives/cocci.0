Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D05C30653
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2024 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ArVlq8wk7LDr2hdLgLiCDLuCa2jCT7k/pnlok+4f+cs=;
  b=gKFFVUjw/vAZWePasthk7av9XP5I3TsfnONHCYaPLAmIPwaD9AQNFAL1
   a5VGaVspteDUWo+MoYCUjvCpLoP92+18anrb5BX++wIaclymM3cg71XOv
   L8AvIzJ1ztbfmFno7vK7BahLxpnuHzOOPGV8ahygXKNbsHr8fMQYtkEnz
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174323585"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2024 16:32:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE567E0CCF; Sun,  7 Jul 2024 16:32:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5421E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jul 2024 16:32:33 +0200 (CEST)
IronPort-SDR: 668aa701_f+1u7TJOfHV4WHpCJcUVHKFOx+cH0zV5zeu7kRp0tKu4NAi
 2dIS+fSu5RHD2XsW2qS018BQftmc+1eOgDs8OCw==
X-IPAS-Result: =?us-ascii?q?A0GfFgDxpYpmhwsR49RagQmBT4JEYhpaMwQLSIRWj0iBd?=
 =?us-ascii?q?TCEO48KiHOBVoFAPg8BAwENOQgBAgQBAQMEgguCLkYCiRICHgcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmAYg?=
 =?us-ascii?q?RKBJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBEScPCxoCJgICV?=
 =?us-ascii?q?gYBCQsBAYJ8AYIvAQMOIwcNrVeBMoEBggwBAQbaWR8sIleBYwMGgRouiDEBh?=
 =?us-ascii?q?XyEQCcPgVVEgTwLgng+gmECgScQKYNbgmmWRIMRghYKiWcmC4x7VHscA1khE?=
 =?us-ascii?q?wFVExcLPh0CFgMbFAQwDwkLJikGOQISDAYGBlk0CQQjAwgEA0IDIHERAwQaB?=
 =?us-ascii?q?AsHd4FxgTQEE0QDgTeJbwyDLYF0J4QaCENsFYNrgWsMYYgBYoEPgT6BYgFLg?=
 =?us-ascii?q?n9KhFMdQAIBC209NQkLGwY9qX+EP3AiLYFuxEOBCTQHgjaBYYFiDIohlScGE?=
 =?us-ascii?q?y+XOg4GkmyYaSCNVpsVgW4JKoFcMxokgzZPAxkPjjqDYTPLP0E1OwIHCwEBA?=
 =?us-ascii?q?wmFRgEBgyY0gUoBAQ?=
IronPort-PHdr: A9a23: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
 EM6S/ZxrlvgnuTdklKPvzJRpzwNiI/Z5C1f
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hGqvDquTfaJ2oe8qSoQDete07skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:6U/Vj21pIBArqF0ZMCDec7xfBO43aH7x62vsJWypJiVKVKzIGFyf0fYx
X-Talos-MUID: 9a23:oF0vYwaURGFwJuBT6zXjjhpHBMdSyKmFDGAQur4BlZS2HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174323584"
X-MGA-submission: =?us-ascii?q?MDEz54L7TeBfXU84HUaQA/yuvBcNhq6aekZQYJ?=
 =?us-ascii?q?izxlvajRbyga4wLOLclDdR0o09HVtgciZPB10GGzOepsXqK5kiSIA06A?=
 =?us-ascii?q?J3kq88CPluD1lGphZd5bi3t7Zm6jWOQCrlvYhyZeXiSp9o2dnlBN8lEg?=
 =?us-ascii?q?NMepcVvFzpnTKfc4LiUUS+Kw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 16:32:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720362751; x=1720967551; i=markus.elfring@web.de;
	bh=ArVlq8wk7LDr2hdLgLiCDLuCa2jCT7k/pnlok+4f+cs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uXzhGGAeey1KEf7VLPGBXpsGNvY+YCI2bQlv90JJ4pB0vCPE81NrYUwHS6tuKrtL
	 lYGHt969EdDQnumIB+bgUgP9MlswQiriPTdWiBKIQLbiJxu9Nxy55QfpBIcUqi2+J
	 N4e0MQEDKPHHE8krMMJuF/VGo7mmS5YerHG3TfMvrvsb5lAjcy6U0Ns06TC24BpmN
	 BndbdNcC1mTPUpa5PbJinAP56flBXyuOASzHPERKEPgIxe2USV6948SEZQj3sNoFh
	 dZw9w7rCA5RpGURov9hsfiG7xAUgRfcogScNG2PpYOlcODCve+rUTi3IDZk1zxths
	 PZ8y1sMbgJOOtb2ftA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1sOYC61bdB-00DdF9; Sun, 07
 Jul 2024 16:32:31 +0200
Message-ID: <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
Date: Sun, 7 Jul 2024 16:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, cocci@inria.fr
References: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
 <ZoqY5GQlpKwZ3SEo@shikoro>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZoqY5GQlpKwZ3SEo@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YSPwDJKYbYwOk9HldHoIULF5uuksS9sttKTrgWjlkcii88wwrPj
 7+QO75tpX+PZdB/oEN4H2N3wOBnxptJHp1sdV4yKqsjWnqOzTZX+FXGOGhRwFDyFeNMCpfP
 O4LFUkMeiNVvrGM+UZdKFzYhh5PqYOEA0s1Sk9FvT4TRhnUVz8usMKW32Dwc8bIMX2VPmeQ
 OGUsBGM2iqUrPXkWKM+WQ==
UI-OutboundReport: notjunk:1;M01:P0:RjhxZWVafRc=;P+pCniJim0jq3UlE15d0fhO+4vr
 t1qLBuH5XcLdDG7jb81S0y4o3I/Z6NEy9wAOcWNyAWob3C0JQJnODAicEdKL0VuL339WfrlXa
 Slso970ZHsYc6hFbnSZ5GQZvqHHJ4wQkuMuTomyh9XI/yWtorAZTyh4apArBKOqHYEHS0V6sO
 5IffvKiD6HPNjKH1zwEiwWJcnawweG+SMl+Qnl2IUpI0R1DhpC/bslgkOP6Kmsmea3o1TTKx5
 fFLWoSO4PPM4dkA+JfzlAW6Ry0LUdEXM9MSkJH98vzJqWseYB1HXCd8CW8a2aZydku3vpZelw
 R40Y0fR/OgCm9Tx21VjaphIBshe+cYFM2pApldDBTZ4/ACzvQkJ2wDhv+vCfhW3b9WMylrwcn
 asUI2yntU03E+j00zCw3hb/SS1+BEsqAYeEj7QC+7r9wP+S7vmidynTKm7w20GWx1cVqUPayQ
 rfHpuRup51u0RuJ695pumbqrQId37+Eu7aVHBCIKXiB0ir7d6/7Lt1m2FwgBhdXDlNRPD7XmS
 a4MxTTknpz1z0nF0L8PzQODnENu+OCJ1ff5S7f4x5l1qTjrefHOY/96z78NP3s3X7Ov9jVfoJ
 b8YEmmmg8XsaWp87xO2XDHiXpyxC9ypQ11H/AgHzHGf3hXdOgBv+GVETWRviflkJvHqgQ0Zdd
 TpcxnkC2NIDTNFEvGwYyrFY8S9dEpYlS9sSEvddMmVnw8feLkmpAO22ngzX1eWgLSgnnx+gfr
 ktGz0CDXD99WMQmCMKR6vWhCjWqMgx7aHLdvOv/qTrfYTq0FNsxEFvaTdXW82gzoS+X1kViPC
 rMjG3F/sa8B/2qdCzw+r1Z7MEr9mwSwsTc9LF7pUl1P0U=
Subject: Re: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1803
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/1d7aa71d-be7e-4750-b1cd-c1ee34e877c3%40web.de>

>> @deletion@
>> @@
>>  return ...;
>>  }
>> -;
>
> How should coccinelle transfer this incomplete function body to an AST?

I hope that the support will grow also for advanced handling of abstract
syntax trees and semantic graphs.

Development interests grew somehow for programming languages like C++ and =
Rust
to some degree (for example).


>> Will the shown source code transformation approach ever become supporte=
d
>> by the Coccinelle software?
>
> Wrong tool. I suggest AWK for such changes.

This programming language is also powerful. But I guess that its support
is too limited so far for more desirable source code transformations.

Further improvements can eventually happen depending on corresponding
development resources.

See also another clarification approach:
Add a metavariable for the handling of source code
2018-05-23
https://github.com/coccinelle/coccinelle/issues/140

Regards,
Markus
