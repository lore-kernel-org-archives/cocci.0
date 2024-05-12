Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E2C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vtoc2wvqPieNP6nxxXXy7EEZmkW1SBey0SIaCZVclDw=;
  b=McZ3q5Lfc4bnfh2fUjTsP0Gs2v9FaDw5AmVbi5n9Aom7LDI/U1tri8Yx
   ut3xkEWL6e+m4Pe8xm4X2MFpqlDMupxQWHWJCVJpxMfTlWuuakGDg/3gC
   i6BjNWQ8OgWsX9h33UrV70CCyBJLICWd2HWuprEC3RP+k0haGslt3/EbD
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165232190"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 10:33:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5F7BE0AF1; Sun, 12 May 2024 10:33:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AC887E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 10:33:22 +0200 (CEST)
IronPort-SDR: 66407ed2_3oRffz2e3Wnn9/l4Bp0cFZQ36NQCrjXGAfx2ilpcLqCqBlp
 faMjk8cMigXEY+jvEDvvHf0NbNfhrlgEFtiWWGA==
X-IPAS-Result: =?us-ascii?q?A0GvBADWfUBmhwMP49RagQmEE4EAVDMEC0iEVo9IgXUwh?=
 =?us-ascii?q?DuHOYdPiHGDFj4PAQMBDUEBAgQBAQMEgguCagoCiD0CHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZwEQgQ6BJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECASMdAQERJwQLCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgnyCMAEDDiMHslOBMoEBggwBAQbaWR8sIleBYwmBGi6ILgGFfIRAJw+BV?=
 =?us-ascii?q?USBPIJSMT6EQ4NbgmmaHIdSiGdUfRwDWTIBVRMXCz4JFgIWAxsUBDAPCQsmK?=
 =?us-ascii?q?gY2AhIMBgYGWSAWCQQjAwgEAxA0AyBxEQMEGgQLB3WBdoE1BBNEA4E4iXUMg?=
 =?us-ascii?q?y+BdSmEHQhDbBWDdYF3DmGDWIROZoEnHUACAQttPTUJCxsGIgEdqDfHaDQHg?=
 =?us-ascii?q?jaBYIFhDJ9EBhMvlzgOBpJomGIgqGeBfCOBXDMaJE+CZ08DGQ+OOoQUyyZBN?=
 =?us-ascii?q?TsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:/GNO76CQpbI37OXlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:8ennUmEql0ilQNidqmJV3lUYOvwvdkbcj2b8HEDnMWA0c6WKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ALaTiZg3OCfysseSvxHPPiV8lczUjs7WzEGc0sZk?=
 =?us-ascii?q?9huKdbSo3GwzA0Wy7a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165232189"
X-MGA-submission: =?us-ascii?q?MDEgT7JZFQZMxaPy+cR9T8LBlvDtIzt5aPmozd?=
 =?us-ascii?q?c1UAnH7fL5sRK3AJVJKpPsCiC3y07Y2t1AwOl1m3GQi166UdfGeahb6/?=
 =?us-ascii?q?92sQeQk+mSPu9WFsjSTdQTxBoUpbC09hE5LiwtG/haR2kSggi9mvoq+z?=
 =?us-ascii?q?gvtwVAp5W3En2ZyPS/zNo+Pw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 10:33:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715502801; x=1716107601; i=markus.elfring@web.de;
	bh=vtoc2wvqPieNP6nxxXXy7EEZmkW1SBey0SIaCZVclDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wfDXm+7S9Lbg2QarFKJICSQzGVQbPusn5uOqJi5xwTjdSiulQZ/nB3KHWuDva+g7
	 XPZJiZEDBRWuvzSNhJHESA5cPAbq2U4SDFiqhlUSY1HAiKklD7gEyEObcUE0J+sVc
	 IEVRbfvvl3Nca+pPOso48tdi9xfqETU7YmmiSE3TJA1fMmmkgYCM8N6MqImTdF9g5
	 yskQV2AziDhCo2s+ExHksgg3KpLwyCWr4UQiFCxW8S/IEBLDnByt+5pvu+bQr0Q9A
	 sZRUBjjkjtKqHMWuYD2+WBZHze3LBFIIqpHexostI9fGaC4JW4U/RtOHioaZJ3afu
	 uajdSDye5bmww3NZyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1sV8dm1W5j-00yIb4; Sun, 12
 May 2024 10:33:21 +0200
Message-ID: <3db2d501-d95d-40c7-8ac1-1ce8c3bd9340@web.de>
Date: Sun, 12 May 2024 10:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
 <bac7cb07-aac0-4fb2-b524-3f53f8109a68@web.de>
 <alpine.DEB.2.22.394.2405121009430.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405121009430.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U8tF3rtOMELHi8tTGaZGPtJXDq+HQSZB3G+8CkRzYlV7zznD7Tm
 IkwHDotNxnBNqAmPXpVLUwriKXgL7zKad1V1WihIjPukpQB0agZkDGvzK9YMfBiU4fj94Ds
 f7ZEM7YgGhD6qWPnR+QbIWMpYijH8bZriw2jIpMtyvAbB+/OqO8Zoi3FOMiFmbCyqNL4+wh
 VXIhMri68Bo2xLulThBPg==
UI-OutboundReport: notjunk:1;M01:P0:GIKlJQyKwJg=;Ree0YIgl9D+aIDh7DGRpnsfr/hB
 8yRFLikyo9zR9YmUrlSWTmqx2Lmzq2sowzLmPaJBde5LESDoU2RYJEP2WrW2+qK6SPjfiPK3e
 hweWcVOd0ZOjWSTf5ZbWLNp4IupJXh4UCQtQ6d3E21Uuu+zcshqTADr98kkSfSjFYvlLRR7a3
 JUhIyZK+VyRFkDzhsa77cGihwbioB69O+APhxdyLKdFunVvF3Ay+M60IQn2XmYyqOomyRTt7z
 AfWrjQikCUsExbrRa04EYSHQfJTfFsxO78/tAV4bf7lIz8AO05BufF9QQNZk8RBt4+LjYDfly
 RKUYQyRGQyVivLnJl1K5ad46tb+XQK0S6lt0fnMGsCtTrCiZHTOkdZj6rRS2zKe3DQaZ42bOq
 gCxOsyuMagDRP+LyefWFNHPjciV6j0EuffN/Xt4Cnqsllkwyk4BdLgdROPlO1ptCVD+sYe8eo
 0NVNDzjm9STvQLUTHcGJnFKYCk1pY15U9iQFC0ZEc2KKv2FevELMoqZl6LLm23eBhetJ/Qpf5
 V/Hf/i6sRoj/gEXRsP2bxxBogPt6gAmyi4J9ey4BlOMfnYFGIiYKC9TtrC+ViSGAUhPpfElto
 cnHtChy120CwM9xeuPB7eCpsLekKRS3Vubpw/Gl3HOoTMvI8Tewuxy1/ZN4Mv12zkup6EzuDa
 t1wKNmx8j018VbvTd+xz7qTeoA59m2G8y5zRcIE0Nt2Xesl7je3eaqHyx1RBvTPtCXE4tgVp2
 +LOyH24ri0Z8xkXG1eGj8B5jdDVY7XFpngB3+O7IQ8ZUDT3Hp+GrgChQZkPxVCEQwogGbXS+u
 r1wSqyHwZpRU1NPufMUaVEGXZt979pbsLUhN9a6C0HLPI=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1726
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/3db2d501-d95d-40c7-8ac1-1ce8c3bd9340%40web.de>

>>> Probably you should start with ... when !=3D my_action(...) to be sure=
 to
>>> get the first one.
>>
>> I would expect that only the first function call should be matched by
>> the initial SmPL search pattern (without an extra when constraint).
>
> Why would you expect that?

I expect here that specific source code starts a known statement list.


> Coccinelle looks through your function and matches the pattern anywhere =
it can.

Can this software distinguish also better statement sequences accordingly?


> The matches are independent of each other.

* They can occasionally occur in different scopes.

* Statement sequences (which include discussed repetitions) should be =E2=
=80=9Cinterrupted=E2=80=9D
  by other source code.

Regards,
Markus
