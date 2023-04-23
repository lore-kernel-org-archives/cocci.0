Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E5C77B76
	for <cocci@archiver.kernel.org>; Sun, 23 Apr 2023 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qKbcidpSPJ7xjDAG/AOF5cBF48T6MlnxM8LfWrbPBfg=;
  b=mLe1nLuLnidvz5fEvXJi6kXdUlbbxwzls2vxUD3bY3lQRZSFAMKtJp78
   FRuMcqvZGjevthpXgg1G2E2OC8sVJnP79KvUIaKou1fmUI4g0MZ9DYYcy
   kKfJOTZ3yzsWfPmBh/c0uPr8y9YPlFhR1JnpgZo6YxZN6PlaW33StWq2b
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,220,1677538800"; 
   d="scan'208";a="104421349"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2023 10:10:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8E30E0269; Sun, 23 Apr 2023 10:10:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 66DB3E019E
	for <cocci@sympa.inria.fr>; Sun, 23 Apr 2023 10:10:08 +0200 (CEST)
IronPort-SDR: 6444e7e0_2sTkrrSMp2uyhZJLB0TjMLOT6JwsxxedHYOfzN24e1Micsc
 4rlib56K++wkEJGfhiipJzKIr7O/f2JkDPTCFHw==
X-IPAS-Result: =?us-ascii?q?A0GhAACJ50RkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFOPEIF2MYQwhy6HPowAPg8BAwENQQECBAEBAwSCC?=
 =?us-ascii?q?4JqCgKFPAIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc+AQICASMdAQERJgEPCxoCJgICVwYNCAEBgnqCKAEDDiMHqyKBMoEBg?=
 =?us-ascii?q?ggBAQacDR8sIlSBXgmBFC0BkFZ6Jw+BVUSBPIJTMT6ERINbgmeWGIEzdIEng?=
 =?us-ascii?q?TKBBAIJAhFrgRAIaIF0QAINZAsOcIFFgxcEAhQ0DgwWBUIlBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PTUJCx8GRAIfgWwEL1h3CgYBJSSaf2zDWDQHgiuBVoFZDJ8NBhMvg2qTH?=
 =?us-ascii?q?w4GkiWXeKgggXkkgVwzGiSDNk8DGQ+OIBkeg26PSD80PQIHCwEBAwmFRgEBh?=
 =?us-ascii?q?X0BAQ?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDTd+dsFB04jENFQef9K
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:z1bF3q+sGRHvVV/M/BRuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A5ADIwGlaeNetiGK2qPFctcpdAWDXOXTY7iaXCGq?=
 =?us-ascii?q?YM0xWE4DLdnSa2fhnrOM7zg=3D=3D?=
X-Talos-MUID: 9a23:39tuQwoJEl2zWzFJNEYezwM7c8ZZyPWLNGsmy6del5WbDA1+JjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,220,1677538800"; 
   d="scan'208";a="104421342"
X-MGA-submission: =?us-ascii?q?MDH+Za/MTslw0Pa0SfOgN5yfNBaYM1eXzJDucw?=
 =?us-ascii?q?fBD/rtewizzZCIf6nXMSaqfcDARkXjO7Kk3PqZGaRr7aJ7romwKUyezD?=
 =?us-ascii?q?LUgA7qBWxaDXctUvcopDgqvWLajd32J8IDnhxKzcCKblBpZmfpfzbRWC?=
 =?us-ascii?q?PeVrQ5pRMwySwE9otOkqUDEA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 10:10:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682237407; i=markus.elfring@web.de;
	bh=qKbcidpSPJ7xjDAG/AOF5cBF48T6MlnxM8LfWrbPBfg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=REw5kU7CKc6MRGh0Muo/ko5ypc2xIaBiXyxSR/FIKIMvV5inX0+TymjKpzlW4lfYP
	 83q2ZhVFgFw+SZiEZHmXCVbD9nITzGbB3+IfR6mu4fJOv/hnjoNDhKBzWPhIr65eCs
	 XBR9gXOFQpo0AvXbkA2bdt8sBc2Ts+V0z/05cuPBhKUssCX/SPZxLK70QdoBdHdnm3
	 n4XYgTx/n4vrt3/kIUdZUGAsRQqKtMUF0pTk9btpXmiMZ82DL4PeFBx+7VjMzJawih
	 lgQTAZcKds74AaOBbr4/DCnHUJNIh+ZH9TU8hD4f1jxGs4/ovSpIplQRbCd2fRON9h
	 TZn2R3+0fgo9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPdl-1pdWDG1u1x-00MC2d; Sun, 23
 Apr 2023 10:10:07 +0200
Message-ID: <017973b6-893e-578a-becd-bfc17a700e42@web.de>
Date: Sun, 23 Apr 2023 10:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
 <alpine.DEB.2.22.394.2304221724070.2766@hadrien>
 <dfed0b6a-5b20-3b06-9afc-69e808cb0c3b@web.de>
 <alpine.DEB.2.22.394.2304230939260.2765@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304230939260.2765@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:shS4kEl2juuAVPXs8I69m+htU06TCU8NfdCx2ogc4mGtOLEpmik
 E/XKyG2aosiiMgF63Wp87HHu7o14tVizFJWcGV5V+jqiF+HdHW+PoxnPZwexZmn42Y6qKgf
 Ij/kFaH1weV0IXlshAAmmv7O5GM0tGXil4pL2JMQcGYZfQ13q/78JPetQe6LMRAaX57ia02
 BdADwDd/sELe23dqjoqGQ==
UI-OutboundReport: notjunk:1;M01:P0:adVle4EPBtE=;fkYeLRCtWyn2A+4bVtwHn0qQ+u4
 C8mKDOYV7PmU9ENsCw/q2A48Mr2BmeM3Syokos/ergfDCpUtAvHXykKfJ2Msa2z+D9oKxjmwP
 wFlpDo0kbb+hw5NGn0+91Xd7FM3+CbhBcA5cC1THL0HtU1PI/cBIJgnBLYCTcYsB6/fYW7ymv
 0aj/PNgznLiplkArA8JdxIU/IKIwwgedfND+2DzF1w5XkWk7YCuy7bnPqZm8iwk1k7mLUmCfP
 IS0FBLA7vDYf3RG4ySo1nZnihYfYiorlUUATj+tY+Vz0aF2gSwYofgSCfPeg+hlnAswbaEeE7
 9UNBilRckA+0sDlmT5TB8wZYTxfCi7Q6iu8R1m/y84KzX0xBSl/mcQTd40qoXumXCYaSzgXMo
 oS3VnsVEovrd7rmgUun+NSEgdw/9qi592lQw+oZ9X/AEgCPJimhDN0hquEuK/qIB6azdpyn41
 HuJT9JgJ/+g89yjUkDm+A0XfWq7EiKJyp/fePDBSzedzpOJwTIkWvgCDBDusBwUrtdcFDIOfS
 k+MDlplUHnVnFaTRy+iTMAuurfTlHqJmC7+4MbX6hYHmuW8jlBnxNsX1mlwWaw3cPrv9hC9mX
 5CUdix+3zguzM2oaJjJWZodJ4Aa8s6UOpZa11qchxa3nNGMIOkTiZFJzMoy8kC4eUQ2OmdYGb
 sC0DDWUP0274MsJ9m2eEI2Gw9hsVB4WA0KiFrSMfhjgpQjIRT6xtOxRn/n264b/SkoOHPcUvn
 b/c2zQOJuQhMhKNDsvLhkqEj9TsRj476byT+SxAMjr1vDA6b5iflTgudHcOzyHJQ0oG3lZCg0
 W8lYI+ssKaUIeVnW03zAkCggvkxqz9DJAVKqXs/J5aJVAiRXJFNc6/BUJhTnFIFtFYfUFMsAi
 KNBt+ZFhrBrFmrAu3v4AaPqgRdCvi3oIJ7yLvSsZdDBx+tJ9BqX4m365+eVoRZyjvQpsEVKK2
 g3BIqocqqy20qGfhEjCAdbaInek=
Subject: Re: [cocci] Checking selected contents from metavariables by SmPL
 scripting rules
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1126
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/017973b6-893e-578a-becd-bfc17a700e42%40web.de>

>> Will such a data presentation trigger further software evolution?
>
> Thank you for presenting the problem in a much more understandable way.
> I will take a look.

Thanks for such a positive feedback.

I became curious how this look will evolve further after you got frightene=
d
by a bit of Python code.

Which software components would be responsible for the addition of
space characters according to a data representation (by Python objects)?

Regards,
Markus
