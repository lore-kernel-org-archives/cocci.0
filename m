Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6B8C46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XMnSyAopBtZM7UnxvsJSFTxGz8SYXWVZC46qKrbdiew=;
  b=tynQVgSvgEgAvoCDdsM/Yw+N4aTh/+44R+iaOVA8tZUyckfnu0w3xyai
   PHQVYUA4a1DeevMZFB1ETL2uv5/deSEpl13+cO+nwEZbucu8CoO9jCXkH
   WgXilxoVD4KkuaVY3SDDntwARPQHZPrZBrSARIcC8JEIYGH2a6PhbCNYO
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144151793"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 18:14:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 903B7E0CCC; Wed, 27 Dec 2023 18:14:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DED77E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 18:14:46 +0100 (CET)
IronPort-SDR: 658c5b86_8MofoLXVVgL9e4iqTJEGPmEaEzeTn1oTy9FJjgh73iJFb7W
 1o16KBAUQI6OAxKmN8UnymU4TbFniCnRKtShFWA==
X-IPAS-Result: =?us-ascii?q?A0EnBQBuWoxlewMP49RaHQEBAQEJARIBBQUBQIFPgjl/U?=
 =?us-ascii?q?zIEC0iEU49BgXWBBYNmhzWHTIRrhASBaoEsPg8BAwENQQECBAEBAwQ3AYRHh?=
 =?us-ascii?q?zgCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASQYB?=
 =?us-ascii?q?g4QJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREmAS4BB?=
 =?us-ascii?q?QIRFQJeARICAQGCfIIrAQMxB644gTKBAYIKAQEGr1gfLCJWgWAJgRouiBsBh?=
 =?us-ascii?q?EWBIoNBgSEPgVVEgTwLgkB2g3yBBoMcgmiDZoU2BzKCHINPiiKHNH0FQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgzEKgQE/Dw4Rgj4iAj02GUiCWBUMN?=
 =?us-ascii?q?ARGdRAqBBQXgQ5uGxIeNxEQBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DbB8yCTwLB?=
 =?us-ascii?q?AwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOwISDAYGCV0mBw8JBCUDC?=
 =?us-ascii?q?AQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4Cpk17E4J2xQE0B?=
 =?us-ascii?q?4I0gWCBYQyfKwYTL4NuARKTJQ4GklQuh1CQTyCCMaYVgXojgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIIQrj0dANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZRX7dazlobT4UUBQusQHKrPw9L1zdoMgy1knxilNoNJuA66lfr
 OV7ZcmPHjP+VAssRAb6Le90cy7Kk80mqQb3WB8B8bGYOCEggWVxeNZgbcKqgeIc0DDH4VmpM
 NdmsZFaOHYMXg/q9rm6w+lFNsazMCA673Av5ak854gd2BXg7oL1XYBNu93KDwPeOHMaKBSKK
 ah
X-Talos-CUID: 9a23:5XA8WW0Ug7Hb294HldnjoLxfEO4mLiDg0m/qDBWkET5QULCUU2WJ5/Yx
X-Talos-MUID: 9a23:O8qRggii/GdTJKsf4WAOB8MpM/lNyL+0J1g2ys9YhdaCKwl1Gj6+pWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75417992"
X-MGA-submission: =?us-ascii?q?MDEfG3m3/5+TjX7xLfIFIUddgM+lQiQllF+Pd5?=
 =?us-ascii?q?e2VjMzE8BGsueyfKU/h1oWkVJ56yI3iI/Qe2tuK/IjhGvd3duCqZ08sb?=
 =?us-ascii?q?Nw2IYPjE6n8+TqdLReSaQgWxbcSkiGP5kqMxnUZ5eRGIcswWQlmgiTf4?=
 =?us-ascii?q?v4O9ACuKnYDAGAIANbF+qBiw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 18:14:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703697278; x=1704302078; i=markus.elfring@web.de;
	bh=GpcuCyxATDYo+y8qWGQqMQc37tbjB3AlTMTRMIvEPOg=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=MkQgF2PdPeb4ypVZSsKDqrPU+Veze5Oz9N2eXIEi06P49F74OFbSQUiPvNxxG5Z6
	 M4DNRnk5bXE3wz1R+xAzxsZf8VTz9o3M600UjVBzf1cSzCT545vWWnOPmpW4KxAtS
	 2JL5nhaxdESiI5H5j7I9q6/BDMv/4U0M90uoGSijVMlDZ0LHxITHpkfdYob7KstjX
	 1hOiZF0dHzBP4WwnhBLRV6llKriTF215ecvP05ch4rHtlC4Fs1IovYph2BjMkwuA7
	 hzn/jmZP3nmNuI3jsu7GqlJWbSvpO5xTW0CsWlW/3GnsjE0qVlouGpKaoVgQ16Lse
	 KumELOmaXRYljGRQYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1qkIjV0eix-00Zlk7; Wed, 27
 Dec 2023 18:14:38 +0100
Message-ID: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Date: Wed, 27 Dec 2023 18:14:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywgVd8MaOcVLjM73gdkwz4kyeQQSA41m881FmDgU9ofY/waJv/n
 8Urqhn92jhbNE5EbkJtgbn4AZAi6GECRo2pQxZHemQP3HEB3YxGVOezXjDrV+5429z7S8No
 5JLByAVO5u0wsb9Turp9PiAoAhXxVXPw52Bs1Wc308aHzu1AsFHQZduqlTiyFaXT6dRu9ER
 XwV3lNprphI9zsa/NRLvg==
UI-OutboundReport: notjunk:1;M01:P0:qKs6QAQkerE=;ywL5kkQ5xlIBBwIuCPT6iZSDLRV
 JXyjMT8OrugaEsT8jfszvAT2bvLeab3qu/aDXlDppnpK/r7QihoaUdl1mYgE8daxhp94pUmlN
 mWD6ynYeAkLuIBfDgaTMgleW//WAVCpx7wT0eitXa45oCJghIZOqEcFmgdBNddieu0cOV/jl4
 5RejWi8cAyytQGUinX8v7rS35OudqQq52+YSzPAyBq8VtMDJKEFWOEcOrHyTNlv9j5eBAUlUG
 VRlC18bKeht31Y4VDml2Jv4hlRdZ+Tb47BPnJl8locQKlsvALdaKZYQ8SWgmxnoMlRFcRQy9h
 Vf6bxsWaiJI3dj9EQIHUjbGoFQV67alja3EY3RFE5tssdCiGkGOUdKWJDp38qvO1dP8xyEX48
 0mIfUU6JsuL1BsuOfiHI0WV8kOqJjpPyiBqgUf4BhpBe38ztfrqUhEmLHJWyWP0wZU1j4021o
 yYeayGVLqIfSFonfB1Fmt/vwG18cjDLOgacu7s7qUWwOzdZc9SLT5oLSI5ojpmyo2bseO0Pda
 ywevtCS1+DjrQGhezp3ySO/7XeJpEtm/QuEzXgy9XUkgXkCusSUq554Qv6YANhHiQu9iunT5C
 0G23d3Lytb5NGaTevWqUSyObmnhteTh5H1CA1h0vPjVN2zaCjxrbCpX7oGePdlpAc7eYtDjLr
 astcyyaYJgmL3Qa8bb+Bg6GI279qUIaqp5GErrayrpiGQ85OVziiCAJQg1wzUk8AK7QNldRv+
 DUCPi0qJUZCUml55MzPykgOtQXj+79WWNypsJCaHfU5wj4sXMJn+9CBM4D4bfTgvZ0vt7eGFA
 O2SutnbA8wFEYXhxzljSI08p8/ZIw17H4wgTiFUeq7sAR4xTbqr74/2zSOeAtt6SYAAUdAkJm
 9xpo0jDVHdoOMXaq6g5aCDOyJsghUGwAWDwwo+/EzxUghcJqoGDx/9x0gHRzVeJC3sYgckY76
 2fIX66y5PM6GFHj/mZu+sr7gRwA=
Subject: [cocci] [PATCH 0/2] nvmet-fc: Adjustments for
 nvmet_fc_alloc_ls_iodlist()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1419
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/6b821c46-7248-4882-aa6b-0279803f4235%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 18:09:09 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  One function call less after error detection
  Improve a size determination

 drivers/nvme/target/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

=2D-
2.43.0

