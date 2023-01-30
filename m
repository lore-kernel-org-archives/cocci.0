Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33528C54EED
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=k1Yr8a6ZP6sWPCPt/IqhetK6kipkwuYIeZt2nLA3vMc=;
  b=p9srEi2ATI7iRecX0yS72Yu5LnsjKEwVmgcManwINFktkB+l4MntWaqv
   u6De5j9FoK5AJzcHSG/lpZlD2SEDCcm+Jxu46GGh7pWskzTS9yakp5s1/
   q5XIzTSPfT6nvDFVMbdvwysFaBTPqs2qAyivPZLgeH2g868sR5bgKieq2
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90030070"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 10:50:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9574CE7442; Mon, 30 Jan 2023 10:50:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7EBCAE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 10:50:15 +0100 (CET)
IronPort-SDR: 63d792d7_76DHzVAMLQ9qPZvC9mEQ16IOVqmMtQEiVj7B6KnR7uzu8u9
 MXcjkrEMh/02MLpwFpRikyLbdskPqfMi0meawLQ==
X-IPAS-Result: =?us-ascii?q?A0EABQA1kddjhwsR49RagQmBT4ItgV4uBAtFhE+RIoQrh?=
 =?us-ascii?q?yeHMohjgxY+DwEDAQ1BAQIEAQEDBIUAAoUlAh0HAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQECAgEjHQEBESYBBAsLGgImA?=
 =?us-ascii?q?gJXBgEMCAEBgnqCbgEDDiMHqUqBMoEBgggBAQacCR8sIlOBXgmBFC2MdYM2e?=
 =?us-ascii?q?icQgVVEgTyDAz6IHIJnkGOLCgqBOXeBJQ6BRoEPAgkCEXRAJQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Mgo/NQkCC0oQGxobB4EGKigVAwQEAwIGEwMiAg0oMRQEKRMNJyZpCQIDI?=
 =?us-ascii?q?l8FAwMEKC0JIB8HFREkPAdWNwEFAg8fNwYDCQMCH09wAi4REwUDCxUqRwQIN?=
 =?us-ascii?q?gUGHDYSAggPEg8GJkMOQjc0EwZcASkLDhEDUIFOBC9egQQGKSaiPVqjH599N?=
 =?us-ascii?q?AeCJoFSgVIMnncGEy6DZgESkwYOBpIcl08ggi2lRoF4JIFcMxokgzZPAxkPj?=
 =?us-ascii?q?jmEDJIcQDQ7AgcLAQEDCYVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:q1+Yqa1SjW42K9WsGanIHgqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90030057"
X-MGA-submission: =?us-ascii?q?MDEAh+9/gopJNoXODBTYo+kScPjUNujvICJBn0?=
 =?us-ascii?q?11J+LpHjm6GgVJqyp66EQDrt0kkZOku3m/K0Wmxw+7lSDkWpBGU0IAOs?=
 =?us-ascii?q?F/GSMNAu0I83jSoBJt/rrt4dnlfmQvGVb6uPP2DudeM2E5U3ECGoU9mT?=
 =?us-ascii?q?hhJxme2WHH43HEL4+jyd18Rg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:50:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1675072213; bh=k1Yr8a6ZP6sWPCPt/IqhetK6kipkwuYIeZt2nLA3vMc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PAbGO0r6o91Le5LLJjY+VH24BazVcMFD7zSeuLAY6juJDp0fLC4ZwdyrBj1TTPbAo
	 IAjaPuBuYhIrsbidSVqGNQPR9VlWxa7gtv9cmqOFJhcv/AfFmI+J0gSxYKlVdcs+tb
	 Gr0iYaZs3GRQTEQGxgguRkDoONNdgMnK951sMUnUBf0+q5iHGxpTj3DbSo3NaSPxsN
	 v/Je4LWBztN0rNVVQMOGyJEwdpNt/bqxZZafrrmeC5edmYgB4rEwa3AJJEOFIpPJPN
	 i1FGKEr+8JmLVPxS880gXTswLIiz1vzeXZ/4lMtXAv2o6JThKbfoIKf1mKZsrfmlFm
	 MG64LHXZN2N5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXVZ-1pURIE1KOB-009ck1; Mon, 30
 Jan 2023 10:50:13 +0100
Message-ID: <079efecb-91da-e111-1a28-2c883b69af7b@web.de>
Date: Mon, 30 Jan 2023 10:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Luca Coelho <luca@coelho.fi>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
 <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
 <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
 <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
 <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NDfzZ4gL7OldVeoXW7aGfmItHVlaNPSDnv/iLp2VAxnxKW7mgTa
 QHuaPfegIjY5ka5wHZpybD6tlquAEF4CEbmkde6omCYaDDJaVb55h1CK+0SwTkvb5Ju9MWL
 IQxIJTulUscxUao0R3gjWsjWiwI70g/IdnhERk9NNojQUtbGIokSXGrTe6XrXVYf3HnrQHh
 etvsccGWuCk5wFOFz6hWA==
UI-OutboundReport: notjunk:1;M01:P0:PyuM6njyJKQ=;lvZD9r6Wz0sIDeDMaxRZtJupAyz
 LQ7SY0V/Wb1edcn7GJBkC51F7kpkZdD3uZuEOfSaXJVhlm2PZq+QAT9Eit14BGokid7klHoks
 d+63D7wLRq9zgI11uZMdd3Y3K5cwTQw5+d1wTjEnty4PFMyvgPgRVFe1GjDjBojpYQwQjI1NQ
 Cdia66oTwcuFN7SvyaA8KL1um9FoxpykDD4GzdJGeabVCLx++hx9VHlYlhPk4Xcx1SwLX19wM
 FBHq2HgM5ZoO09CmkSPNEgBwafO6lVT1bT246SzX+ZHGr+1ppee32mBhLUvjLvaOLaJmzlrqG
 +jRUJFPb3rOPHoah0nCpiH5gbMYVjuVM3plqEVsTxqIF9D6QBhl/Oy+4d6jbfm+VK8xwsIkkH
 LnFECnzm7oWgWBDQZNlOKStq9sBAtUtrjGV8airb4WSRrf8WFkNQpWSh+sjUCIhNpsUtBuz56
 N/3Iku/5DG7KsdjiQKAhgFN2JI2nGiwRLfvjrGVvavLXzfmuIXqjPNqSWUfnOAFnUO2eXU3EN
 x8peyA++1gZqCs5pN0IbDezUjH5ZBy9eBZFA17aqTQBV/lSSPDzNnXU/F95RRAckZHUgpeUGP
 p91IwR4KLafxgviBPYTpghSvVyIF5WNAY/p8DSNzCYA0NsdknlH18VAjcndiO80RKwgsTFj+i
 /p+55R/PbXzY+h9RtWB3uyd3KLXrXH9qrolF20dGnSoJxwWuelDmc0RH531Z4kP8WZ6vmFky0
 Wmue2S0KE5GpbLr8G2SomXTaNRXX7ftLtiOBP/VXrgzj1+pjiL6+l8hyrJIzyZ7vvtdewDznT
 5+1c/M0zLJ5UbmUZGD7pXUPjbCKiVvKVlCjxJOs2hNALDKq7E9QXGbRFCHQJf9H0HCgInLfOy
 4UxHZm3LkAG/HmzEOJaSSvXbTXDOL+Ol8QRMJcmSneMp5yZ0kxaVHuKtO4Pdmsk0x3munduH7
 HceIuA==
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 849
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/079efecb-91da-e111-1a28-2c883b69af7b%40web.de>

> I don't think the problem is in the rule, since this works on an
> isolated version of the function and macro definitions.


Would update candidates be found by using the SmPL asterisk functionality?

Regards,
Markus

