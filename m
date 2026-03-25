Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79773106B518
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/yhnbAe0HQgwYnGTOCl4dIjP0IQ28L1+8R7wsLPwk/s=;
  b=WuZ5zXVTs8NvuiAUqh1QIbg7Eflogy93Pj+O8R25EhGCqsNlOp8Fzx00
   V8R7QsKXEzxXTYX1ARWeNzW5R9DTAAPOaIh646ZNM8e6IB9LlyTeMuyv9
   UM0m5fmy3nX8m4EHVi+SQF3ZuoOOwCwohwgSpPHvoxsd6bAO0mFlIBHYa
   I=;
X-CSE-ConnectionGUID: DRfFkRF8TSSar2t9gijhzw==
X-CSE-MsgGUID: 7i6iAhanTLiYhbwfvG34+A==
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
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269435879"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 13:24:31 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B1652821D8; Wed, 25 Mar 2026 13:24:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5E32081881
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 13:24:28 +0100 (CET)
X-CSE-ConnectionGUID: YXlUEtMQTueOt5D6aiwarw==
X-CSE-MsgGUID: sZx8R+4iRu2HH52mZJmtmw==
IronPort-SDR: 69c3d3fc_9G+06kX8sH4QzlwQytOhz1fpKfqWnsL6+vhpGK1DQRHoSwH
 czdFFqm2U0utIwP5ECFhcL56o759CweCq1Os8Aw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EqBABF0sNpfk7ASNlaHgEBCxIMghKCP2h9NAQLSYRYj?=
 =?us-ascii?q?1OCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDBIR3CQKNJAIeBwEENQUNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDhIphk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCGA4CAlYGARQBA?=
 =?us-ascii?q?YJ+giMBBhABAw8nB7APgTKBAYIMAQEG2mQfLCJZgWcJgR8vhW6CZgGGMIQ/J?=
 =?us-ascii?q?w+BVUSBPIJSMT6IHoJpgiaBDpF1UngcA1ksAVUTFwsHBYEjQwMqLy0jDzwFL?=
 =?us-ascii?q?R2BIyEdFxUfWBsHBRIhKoEnD4ZleQMuXhoOIgI5XEo+CgFSBYIdAmxJAgELb?=
 =?us-ascii?q?T03CQsbBD2NSjOEc4EAo3qBNqFFNAeCOIFngWQMn20GEy+DcQGTYA6TC5kGI?=
 =?us-ascii?q?qkfggAigVwzGiSDNk8DGQ+OIYQzyGxFMj0CBwIHDQMLhUQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 UNg/A==
IronPort-Data: A9a23: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
 P0hoYfs5egRndiJTPkk3OneYw==
IronPort-HdrOrdr: A9a23:Vv0MS6puZZ2fqMzbOCz7VIEaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AI1l2pmqukudAorZa4D6WJzPmUfEVdkDw0FLpH1K?=
 =?us-ascii?q?1Lno0ZOOcSECZ4rwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AHyovdA7Ke8Q6BFUskDQadzPBxoxz0bT+MgNRkK8?=
 =?us-ascii?q?b4emkaHZ1CRWYkDGoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269435861"
X-MGA-submission: =?us-ascii?q?MDGLomiB49AP4wWT94KoCxxBLtanLzHHI8zXKl?=
 =?us-ascii?q?RXnt7/HtzVPEJvaYKXtFhnOoeYhLxc+toLFO0XiDMu/b/muYtnsw1wcu?=
 =?us-ascii?q?aGYrwmauUTH1yESjiU6n3ygDyqy6F/FbJ34KoIATOH/E52QsDY03kXDa?=
 =?us-ascii?q?+vaHv/+lrA2ncqQpjDyOGpBQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:24:27 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8T7K-1w9kzq3xkO-001yiX; Wed, 25
 Mar 2026 13:24:26 +0100
Message-ID: <090df01f-290f-4b9a-95dd-c76399e6fc6c@web.de>
Date: Wed, 25 Mar 2026 13:24:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <1f5a4f0b-ed5e-4e16-a39d-f1289b7a50aa@web.de>
 <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pbj8E8dRsMLPbMegcYITW9dca3CDrnvtfvVwPjBpVRUbRrf0Y2Q
 CtKT8XSr+Dm7x4evhOjW/MTwKDZj/0W7c4i5T5uy9xLdNkONiq5/jiBB+aIiJ3Lmin+XV+Q
 Mg3ozz2E8fv6Hys6Penmp/cOPNtfOvcKumsoqxQ7OZJ8rBLE77eubGo9RQe7P7uNlEj4JS9
 dfaQN9X5nzIU9yI2nLJbw==
UI-OutboundReport: notjunk:1;M01:P0:T0gVNpkz+yA=;fjletSCV5BqBzSM6lSplTmkESVC
 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
 W2MQ5lsr0jB
Subject: Re: [cocci] Searching for function calls with known parameters (by
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3453
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/85ZpE7_gW1Ox4bHvFGxBvw>

> I still have no idea what you are asking about.  What is the connection
> between a function call being placed at the beginning of a function and
> the number of parameters that that function call requires?

Do you see possibilities to extend an SmPL script (like the following)?

@display@
identifier call, input, name;
type t;
@@
 name(t* input)
 {
*call(input);
 ...
 }


Regards,
Markus
