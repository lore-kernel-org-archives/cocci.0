Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C33C4828F
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WbfYFLseznGjR8u1Nwgcut38trYJETLXPxIRjNt/pAE=;
  b=GydaMVKMcbek2l5crbnvVT/dzcjrwrOFdUrn5MdDjv0MHF0Un/ficdhS
   Z8EI8P6MGLOi7kEpVT1wBW3tz2zBzDwzniX/jt9bfW4PN2z7OUkYvXx5Y
   oL7MYGWK+qSiMNH1LmTAfPmAqvusc6hj6ywFJGb6hx/D1j0hV5CJaIFjk
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150901979"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 10:13:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB5E3E0CD8; Thu,  8 Feb 2024 10:13:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 350F7E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 10:13:04 +0100 (CET)
IronPort-SDR: 65c49b1f_bWqY3T7fAyAencYu2IV7NuSOs/7eUelYUIvu9qVAiPBC85h
 2Z9HGhSO3BRvX/ng6QSOlJNPYvkzwPCarFM7L3w==
X-IPAS-Result: =?us-ascii?q?A0GcAgDimcRlhw4P49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FOPRYIlhDuHN4dOiHCBVoFAPg8BAwENQQECBAEBAwSEfwKHVwIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CX?=
 =?us-ascii?q?AEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREnDwsaAh8HA?=
 =?us-ascii?q?gJWBgEUAQGCfIIrAQMOIwe5I4EygQGCCgEBBq9aHywiVoFhCYEaLogmAYVuC?=
 =?us-ascii?q?YQyJw+BVUSBPAuCeD6IHoJonQxUfx0DgQUEWg0bEB43ERAFDg0DCG4dAjE6A?=
 =?us-ascii?q?wUDBDIKEgwLHwVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDA?=
 =?us-ascii?q?wYDCjEwVUEMUANkHzIJPA8MGgIbGw0nIwIsQAMREAIWAx0WBDIRCQsmAyoGN?=
 =?us-ascii?q?gISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxQHCwd4ggmBPgQTRAMQgTSFP?=
 =?us-ascii?q?oMRAxkrHUACAQttPTUJCxsGPQKeWoFVNoEwxl80B4I0gWCBYQyfNwYTL5cuD?=
 =?us-ascii?q?gaSXphXIKhXgWM6gVwzGiSDNk8DGQ+OIBkfg3WPR0I1OwIHCwEBAwmFRgEBg?=
 =?us-ascii?q?1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:R4KIH6AECGVuo1vlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:Aw9wOWwkOpwl+Vr4kJd9BgUIRfoaSy3G1E3wPlL/B1RgV5GNQFSprfY=
X-Talos-MUID: 9a23:kaoE3gv4rF9PQGzFfs2npCxbLu1Hvr2SVWMJgbM35ePaNg5/EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150901961"
X-MGA-submission: =?us-ascii?q?MDEgi+UNtOuGBIi4zlOqxePS0ddUZFFj93A5xy?=
 =?us-ascii?q?KyH8qQZ5pyOdqDdyQuL3+GKTWl282RUGNZ1yC/dRS95dvzXGOhlog4pW?=
 =?us-ascii?q?E4V4kn4u0J4TYkRbbEKCm9B5niAejNPlYQdSlC9q//1hL0mUEDUdck0+?=
 =?us-ascii?q?GsEyZXu7Bcm1fjKn3hj+tXXg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:13:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707383583; x=1707988383; i=markus.elfring@web.de;
	bh=qkrziuaHZ2fJTvEEJV2/gkQzhuTkeHneoKPwZ3nCNXs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=jzMgj4dKVXRbN2mq3CKAvPsUdZjCBuOdB4pgCP80jtCoYc5CYtyzYwGtUbpzHMc2
	 ontpO72s0hWlBE1PtXXYLVM2tWaasuilfoPSvLTloVtEJyafNTf3cIZeDhw8AX8PO
	 8wqKiZUtR/cdGoTpCVdKbz1LoQm+GqPd3CEIi7kSk4pkCMrU8KGGRws439QBnt99O
	 rIm9etOaTAbe1YTDSrixLTSMaSWA2jx954gSZuk6B9z2RPnDuMoPN03fzWMb8uFsU
	 gVKjbIzzmqe3KSlFOjrUJZXd1xAW0hiT/XQEL0fPv69LcZBFhkAjPB9I1gFr5wQnT
	 Ot0/YKFk1+Ki8KbKlQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPUE-1rAFEr1Px4-00kudA; Thu, 08
 Feb 2024 10:13:03 +0100
Message-ID: <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
Date: Thu, 8 Feb 2024 10:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
 <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
 <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M7cL9YHHZDSWqpBBUO19Jg5K1m/A94uBs3VZHH/i4dC/yAtv2CE
 9DAWlvzL0fD9pPY36kou1vme2hUgRejue8yj4i8FdjhXBtspnnNX1YX+lzblsEtNenkM0n1
 CgFAD/nwase15N2tyHk7Sdv8Gvw3xRmaWu58/RYwv4iUr/NjQMdo8j1CeXidGSqTyoSuCn2
 Mx8Kx5QEAnU6any84IfvA==
UI-OutboundReport: notjunk:1;M01:P0:sbTwuCxn1eM=;mjYbS12ydE9sOf4T9kN1GrlDpce
 fK+b+T2S4HA3laVdzT7uUhtS02AIqVhbI+Iq6I+cVqpSmZQ0bDV8+EHe0Vprzpde7n2UDrs9d
 wVUb31xpZ3qMftF/3D40yZvQTtT1xqPB4vt2gXkXxpJyLHexi4WvBZ/MwrHnbw2CAI2vSUTrY
 BZ45X2Ccn6gtz08JaxWnvZBJrQilrSLRu37c1clRSIQG9TQFgtmwwWVISyH4GK/6CegBtRBKV
 1G4ajSAU7WaRPgWEAZ5PYi0jwLmJxovGRIHohXRwN2CiT/pWh9Z5ERQXeH5k6itvCicQYw+8G
 ZgsVGfd7YJiZMoCdi6tN64ry8ks5GhbHQmsLwgnewEc0SumkLXa00J/xufHOucgyKc0hNVLGO
 m99TlRtDXqDtRGXJ1AUpoT//IUdPpRvlwBlP9AZhlJT5NGmNbpdVVzdfyOV82iUUwspflNvDH
 2SkSRWlDXEme1DB+S5YQwzYdWPNkUViAVlGTPUICGR9AZutMfDtGa0R16ou/3VZsC+kOVwvwU
 YGzfO5Gxo+F3wnpvkg+ipwY/dXUQXu4dDLqKftoMXOTyXUilsOhs2f1D0zOM5cz/xsbQ/w5Ly
 zo6nIeDiMvlbBkdoF058CTAWWkzB8ujFM5jjmFmQXSWEsSR/0i0UVPnewBPaaCkAE9PvppFV2
 LN6L3vDmCXE8pYziTBGoRN8Kr+B3I+4oFie6R2bPQLgM9iMLTqP9dyphIxHvYM7XmEeVVGdGu
 2I71xVVTGAY/yqBTTqALBwekA8Q2ZuSujoKc3FnN0QU6ghz1bc7UhXud+7QIhyO2avhCr34NN
 eucAzAIoNLiKa/jTd0/wS3ewnaDqnBacwEjHafggn5Gws=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1512
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/d983ec62-2e0e-4102-bddc-4c420a75601b%40web.de>

>> Will development interests grow accordingly?
>
> I don't really understand what you are asking about, but there are files
> iteration.cocci and python_iteration.cocci in the demos directory.

Will the understanding improve also together with a script variant
(like the following) for the semantic patch language?


@find disable decl_init@
expression action;
identifier var;
position call_pos, declaration_pos;
type t;
@@
 t * var@declaration_pos;
 ... when !=3D var
     when any
 action@call_pos(..., &var, ...)

@further_usage disable decl_init@
expression find.action;
identifier find.var;
position find.call_pos, find.declaration_pos;
type find.t;
@@
 t * var@declaration_pos;
 ... when !=3D var
     when any
 action@call_pos(..., &var, ...)
 <+... var ...+>

@display depends on !further_usage disable decl_init@
expression find.action;
identifier find.var;
position find.call_pos, find.declaration_pos;
type find.t;
@@
*t * var@declaration_pos;
 ... when !=3D var
     when any
*action@call_pos(..., &var, ...)


Regards,
Markus
