Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3266EB64D7
	for <cocci@archiver.kernel.org>; Fri, 23 Jun 2023 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Oh8kvykMHq+IqhiDZ25UAgfRzsM1q7P4+cS8dG6/mkQ=;
  b=nJDfgxrYWqbfuLBVRc0OPghHdaH6FyXBg8ywHdBwbJek4IHglnQJB33n
   khZttW+8TGUu/Hn9N4p4P/volrcN3h9PnLr0EDpzuQXiERpQYzqRs3Y24
   Dm1kSTsnH4TDkf3F3R9N6MX/IXJo2reC/hnE+jICFnhAh7bG9hKdW/+Lo
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="114419688"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2023 17:28:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2ABF8E0A90; Fri, 23 Jun 2023 17:28:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 49964E0157
	for <cocci@sympa.inria.fr>; Fri, 23 Jun 2023 17:28:08 +0200 (CEST)
IronPort-SDR: 6495ba07_Fkxwuklwv84kldT818zDkjkvznTxgtJwuubfkoQ4RckHwQZ
 dsXIb07EgRnS77UNcwUYmmdD1Ao+JqxsLMt1KHw==
X-IPAS-Result: =?us-ascii?q?A0GyAABzuJVkhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIydQNTMAQLRwOET4gdiQcxhDaOd4RohASBVoFAPg8BAwENPQQBAgQBAQMEg?=
 =?us-ascii?q?UsBgm1GAoYGAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAg06PwECAgEjBBkBAREmAQQLCxoCJgICVwYBDAgBAYJ6AYInAQMOIwcNr?=
 =?us-ascii?q?0J/M4EBgggBAQavUh8sIlWBXwMGgRUtAY0vAYM5eicPgVVEgTyDBD6CSxcEG?=
 =?us-ascii?q?IUhgmeLJQ4MgmiDNIIxB4wBgShvgR6BIHoCCQIRZ4EICF+BckACDVQLC2OBH?=
 =?us-ascii?q?FI6gUYCAhEnExQFTngbAwcDgQcQLwcELwkWCQYJGBgXJQZRBy0kCRMVQQSDW?=
 =?us-ascii?q?AqBDD8VDhGCWSs2PxtRgmglBA4DGSsdQAIBC3A9NQYDCx8GQgIpgVcwVnAKJ?=
 =?us-ascii?q?CSgTgODI4EjGIFNpCygWTUHgjCBW4FdDIoTlQkGEy+DbgESjGwDhiUOBpIvL?=
 =?us-ascii?q?oc6jzx2II07ml6BYzqBXDMaJIM2TwMZD44gGYQOhGGKZz80AgEBCywCBwsBA?=
 =?us-ascii?q?QMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
 nPgJJvnII5VOoCpgyRf
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:Q542AKjkwZg3BEstfH1e+21IEXBQXvkji2hC6mlwRA09TyX4ra
 GTdZEgviMc5wx/ZJhNo6HiBED/ewKnyXcF2+cs1N6ZNWGLhILCFuFfBOXZsl/d8lXFh5dgPV
 AMSdkZNDWNZ2IK6PoTqGGDeerJirG8nZxBBIzlvhNQpWgBUdAG0++YYjzraXGfI2F9dOIEKK
 Y=
X-Talos-CUID: 9a23:D7UGB214wEVVS36gGkt9arxfJMx1UCD09lHpP2ijEXdubbykFkCV5/Yx
X-Talos-MUID: 9a23:3oB1jgunQU6CqSRUyM2ngjJfDPxluL2XDxoigIgmuu6maB15JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="114419636"
X-MGA-submission: =?us-ascii?q?MDESUcsgwva5/TdRKebh1+F5xiQpk6RJniDJCU?=
 =?us-ascii?q?ktnFgHuRdAVbJJU4sNU+UexuGR1ADHi/RkO8F4vm0VFEV24wUEPe705U?=
 =?us-ascii?q?3Xug66fsv6M5YD8ouPNp2kNmt0Jqn+NUxdTuw3GI9QXmHiqTxyiw82of?=
 =?us-ascii?q?r/4S2fjLh2Nj4fanF4+NtzuA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 17:28:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687534080; x=1688138880; i=markus.elfring@web.de;
 bh=Oh8kvykMHq+IqhiDZ25UAgfRzsM1q7P4+cS8dG6/mkQ=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=LNCiLqRS9LXgzQzLF6eNlutChnnymVRb0WSZID5qrSc1nyWU1fIgMfstz6VZQjOEPQqGINo
 JnzVMurEsR26UhVJWNNFpNMs3oEdQDF3zO0EsnWu6R0DkGcDBJfn+zsxD2CY5LFgz1NCdmrq9
 ZVJxfTs41fRGfMF1UV9WPNxwPIgU+XT08GS5qD4guX/8d7chCif6uIkCq/UmGzYbjHXGaAFCJ
 gb5BpnY5bOTKrmWwB6VJQEPQ9Oa0KDjAGVyOxrAWaa9SUSRRoupqken9xHifghsgzP/0VnvvR
 v7TQZ7fr5uOQH0zwa1OdWTLZ1Kvz/wVdDpqKnV41n5tEQEKY3HWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1qU7851oET-00HkMy; Fri, 23
 Jun 2023 17:28:00 +0200
Message-ID: <63d3a5d6-f0be-2d42-419c-b60664222c85@web.de>
Date: Fri, 23 Jun 2023 17:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Zhang Shurong <zhang_shurong@foxmail.com>,
 linux1394-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9iWI8+sBDmB8SgjDMTJYj0D2js2TICm8bf7TSAbJVF7qoYeAJB/
 uVIdqbSi3VQA1V13yzWF1RZsEXJUuFCSuLcYpVYahcCHrmzhIDQaw8QIXnGip4lLXckmWTQ
 SLD+z3SczQHPlM7LdDo+jp60D4r7LAtcyRPqQZJur6iDvzvgVMX3OgvUR+W6XRSEqfBmLUK
 QhWWGGAXZbfRSSu3udKjQ==
UI-OutboundReport: notjunk:1;M01:P0:O6Xkmc9d1uA=;BBXf+m9vP+c+hDDYxE4VIZ6gj73
 WAqRPUu9elZGKBI3lj+yXi2Upia1DtyoGPbKx6hJX9k4SMy+Sb3hFSjOxEDj0/EjWvPqP3xJN
 Kbblc3aSMQ9A00TYIbMCUkPA6+LyVRDM5OUUwJaItlG+ufnmqGfRcaCS740dv4/7Gu/KaQ7fd
 k8o990CwgkE2T2go29e+U0zvrA0TKjnuS1Y96UDXDl713Smjrkq2KayQI1TsSlVFkYlgZJpnN
 igR2IM2XGj7jhirAufhT84g9wJQX7n5Zgb5Wn1J6Z9MZYHnQ/exH2RMdjSqB7rM6hNAGoq5k5
 yMQwf+ABCyybmSjRe2u065VRcACNUE5SCPAQqMvPdBhXv9xifPlL9ndSt72sGakf9i9lW91c1
 weA2gHZBo/m0ekwn8HPhuco61XQJTJld20INEmgTWzGn+SOe2KGX28w+gU/ELZuCE+O+Owc5b
 gx13d3fSDzA3gBdkoWH1ClT+GED0SgQh+UhDbfrCR5fRwxU+QdHG1nbWMrzHdFIL7/9oRadj+
 2KSlF2s2+JTK2Z7k/INcdcpk7QXLPGq1PvYpsfzwGcz56lhubJ8U0dYOijiS1DXfGurJNgznV
 x9UQTd+UiWnZ9pMcNsI1a+xfHKMz6dA8zuo5Irfk8OmORGp974ij0p0aTV5Vl9Ny3kcLVzvG+
 O5qFimfATsdKl8vDrxDl3Bo4JaJDZlXs4Aua4AVBg7+iuJN50QEcZAMeqZaBLTUZrS/ARPCM3
 PgsCVqW55YqGuJcaXGDSeVn9Ru/fM0rdfadM11dLrJMeHZaejoL4YvhNjlX7SNcH8r6cO6O8d
 zqyhhtEoEdwJ08+KRUGEFMSuj+F+BW9yyQI5qCnZkJZua8mRvTw3E170toGsu/KvsGz+zONvE
 VV9tF25FdTTTPXxGHE3MX1c3BCT+JUiFhw/e0jQPr2lIs9j9cGri6VI2rkPhqnrTzrXjFDXUs
 wnOT+A==
Subject: Re: [cocci] [PATCH] firewire: net: fix use after free in
 fwnet_finish_incoming_packet()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1209
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/63d3a5d6-f0be-2d42-419c-b60664222c85%40web.de>

> The netif_rx() function frees the skb so we can't dereference it to
> save the skb->len.

Please add an imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc7#n94

Regards,
Markus
