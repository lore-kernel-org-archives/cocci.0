Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760CD105F7A6
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nMLIhvBNZsHOnuR75zTbcGUIgl1S6Zw1UVJfhE6+FDk=;
  b=mrpeclPEhtlfEtlIA5XSPDRYxAbfAO3RSJ0sAl2/5eNlktU8gYiS2BmC
   GWa9qS1paaHJBE8/VGhc1nEnKycld9mNYk42RAfodeIp0wkUyTzhq32lZ
   c9VuCS0zMTd6ugMGutjjS0A/zSy/2vujdnldNLp/quNgLyNOhCi6DObna
   A=;
X-CSE-ConnectionGUID: nYwTs/WtSZi7jJfh/hFrSA==
X-CSE-MsgGUID: oJfqoaB3TgmtnEQUaeuprQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267685770"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 14:51:22 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 31F1381DCA; Fri, 13 Mar 2026 14:51:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 202BC81DC5
	for <cocci@sympa.inria.fr>; Fri, 13 Mar 2026 14:51:13 +0100 (CET)
X-CSE-ConnectionGUID: rtrTI8uwQ5i9DfXe4YwRUw==
X-CSE-MsgGUID: HXqJpZAQQXuv4TNp0nKixg==
IronPort-SDR: 69b41651_0ckVnZ9hVfua/lScbDWODW1v9bpb9VvO/tXU570yjzgDQvH
 mhc7D0mKDt6TzZHvXFoUX+tKvm7rEFGQLRAQW8Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E7CgAjFbRpgA4P49RaDnuBUoI/aB9eNAQLSQiEUI9Tg?=
 =?us-ascii?q?iSEO48RjA49Ag8BAwENSgQBAgQBAQMDAYUAAo0jAh4HAQQ1BQ0BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJGUJO?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAj0KR?=
 =?us-ascii?q?AEBAQIBIx0BAREmAQQLCxoCGA4CAlYGFQEBgn4BgiIBBhABAw8nBw0GsTuBM?=
 =?us-ascii?q?oEBggwBAQaBRgIQQdhLHywiWYFnAwaBHy+FboJlAYpuJw+BVUSBPIJSMT6CY?=
 =?us-ascii?q?QEBAgGFOIJHIoImgQ6TKVJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0PC?=
 =?us-ascii?q?BQfWBsHBRIhKoFEeIIBD4ZqeQMuXhoOIgI5XIEGCgFSBYItAiICAQttPTcJC?=
 =?us-ascii?q?xsEPY5vPYMVLQErlVqRW4IgnyU0B4I4gWeBZAyKLpU/BhMvg3EBk2AOkwuZB?=
 =?us-ascii?q?o4JmziCACKBXDMaJIM2TwMZD5JUgQuDVYohuXZFMgIJMQIHCwEBAwmFRgEBj?=
 =?us-ascii?q?FaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A3wUVY=
IronPort-HdrOrdr: A9a23:JxMYc67LTJY8wJrFIwPXwOLXdLJyesId70hD6qkXc20xTiX4rb
 HNoB1/73SftN9/YhwdcK+7Sc69qB/nmaKdg7NxAV7SZniEhILAFugL0WKF+VLd8kbFltK1u5
 0PT0F2MqyIMbB84PyKhjWQApI829GM8qCui6PCyXVgSmhRGsVd0zs=
X-Talos-CUID: 9a23:VSSnmm2NRQTZH0wl8lWTr7xfANw/TlyN0Wjpfk7pJWhZReGkVmWt5/Yx
X-Talos-MUID: 9a23:IpRoAAmTKoqGXFFombWPdnpCBN5K+5aHMXk9jItah++cbSpTOieS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267685739"
X-MGA-submission: =?us-ascii?q?MDEm/UMNHtr/sPwlEpwUIuY9ml89yHDrsmsUXh?=
 =?us-ascii?q?h3lNZwDOqTd2RtC+904F3LzFdb/BOdQmZuq+lHzWl5FdZJnaeU8C4e3e?=
 =?us-ascii?q?dyco0q/MedikoXF/irqXhRi9DQBHTklqYPKAhYcVSVpFM7yuI4+7u0MV?=
 =?us-ascii?q?Hen0dBMMez+QyLcbyJmj+N+Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 14:51:12 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1wFOuR3yMm-00UdS9; Fri, 13
 Mar 2026 14:51:11 +0100
Message-ID: <d0a8a18c-d885-4b01-a023-d31338c0d19e@web.de>
Date: Fri, 13 Mar 2026 14:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alice Lee <Alice.Lee@ist.ac.at>
References: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VOfUpOh3rb0qla8UdMLBgl28SQAqjWmeK6lEIiopccngSYaw8Yh
 s9APA0CiY1iLDUQ5/j430rlD+PMKRBcmr9S4ptF5ZPutsqogC4CCkE7syLiZqrwsBt0wp1C
 JCyBNkyRwIqi0uw1f9IuF8bW1Pm2rY8XTydMhgAxxyLSNidubU6ErHn8jD0etMrS6xaCWY5
 U3JAQIMPRKTyRES8KT6WA==
UI-OutboundReport: notjunk:1;M01:P0:D0EFOMy4Un8=;XRe6RcCLhaPuxAjMePbtFtFnUAn
 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
Subject: Re: [cocci] Python script interacting with non-matching files?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3426
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/HNOrx_tdOr_lRotSPr0R9Q>

> Similarly, can a python script tell that parsing failed for a particular file?

The available programming interfaces are probably improvable.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270ebdf0a9bd6be0a6ce53b/docs/manual/spatch_options.tex#L72-73

An other parsing technology can eventually be also more helpful.
https://en.wikipedia.org/wiki/Comparison_of_parser_generators

Regards,
Markus
