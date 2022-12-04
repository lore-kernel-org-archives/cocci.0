Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46EFC47089
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8pWAw6rrp1VnDvzk3z3zIAgUxSTUt/yZSwSa0QqTL5o=;
  b=u5jXjjyhzD64U+gX3OEGqANYxKIfL9fbdN3cev0LcLdU0IWK8rbPcxY3
   Ze3upUc4Mq6DLvGvDZGiMXRdWzhj2iZoHU1x/mC+yYbskGSOndlBNN4mi
   0EyrLqLqyvbYwbtPsprj8nsUUSAqEE1MnfZ83rpwf0/KrShma3qdx7xS6
   8=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81596375"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 15:12:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2021DE01D1; Sun,  4 Dec 2022 15:12:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 780D0E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 15:12:14 +0100 (CET)
IronPort-SDR: 638caabd_fTOP16eRD6SVROscazz1i2WkQdsv9dIpPUzssJKR0jQlYEX
 qpvhojsnzkcwoAC/XYRlIvzhTugMbH+nztgjcRQ==
X-IPAS-Result: =?us-ascii?q?A0HHAgDVqYxjh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLYFbLgQLRYRPjneCKIQrhyKHMIhigxY+DwEDAQ1BAQIEAQEDBIR+AoUPA?=
 =?us-ascii?q?h0HAQRHAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGAsXB?=
 =?us-ascii?q?w4QBSKFaA2CNSkBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0BA?=
 =?us-ascii?q?gIBIx0BAREmAQQLCxoCJgICVwYBCQMIAQGCeoJuAQMOIweuY4EygQGCCAEBB?=
 =?us-ascii?q?pwHHywiU4FeCYEULIxohDAnEIFVRIE8gwM+iBuCZ4xSihsOYiUEDgMZKx1AA?=
 =?us-ascii?q?gELOzIKQzUJAhFMKxwbB4EMKigVAwQEAwIGEwMiAg0oMRQEKRMNKydvCQIDI?=
 =?us-ascii?q?mEFAwMEKCwDCSEfBxURJDwHVjcBBAMCDyA4BgMJAwIiVHMCLhEVBQMLFSUIB?=
 =?us-ascii?q?UkECDkFBlMSAgoRAxIPBiZFDkg+ORYGJ0EBMA4OEwNdgWkEM2aBCwovLpt9G?=
 =?us-ascii?q?YJKSKItn2Y0B4IfgU2BUAyeaQYTLoNlAZMKDgaSFpc/IKdaghyBXDMaJIM2T?=
 =?us-ascii?q?wMZD44gGYQMiixANDsCBwsBAQMJhUcBAYRWAQE?=
IronPort-PHdr: A9a23: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
 oUDQPlXWQ5tfs4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bkoKtqMPJG9b+sBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41670841"
X-MGA-submission: =?us-ascii?q?MDGcPAJUMR1IikyxCkoI2Y0HbXYWEURRcfXAuY?=
 =?us-ascii?q?+DoZtEmBAwX1f4LmSNZtQ1HbKRt9rkYIXhJ8eOiZrPGTOFwRWqQF0HGq?=
 =?us-ascii?q?lvITtzQt4uVAl2Ef3c5n9CjPvcLjTuVRJcw84de/f0cuFXmyZ5YUvl3R?=
 =?us-ascii?q?69dcT1cyAIf3bOtO4MW8gpBg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 15:12:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1670163132; bh=8pWAw6rrp1VnDvzk3z3zIAgUxSTUt/yZSwSa0QqTL5o=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=gIbHMf8waPOGquiIuONwhIe3CC6GuxPlqhoDkXHZjAZRLdhdK5Emor/gil9Ch+8ZM
	 b5y3Kk7pA7rJDLkSmVw+xenEFjao9NDs4oEBvvFcdhpaopDESAMNBrHIwq4prvDQkI
	 BCnrgi2F5Hp/N8plgrnmKDlBrL9nvTY1CcDF5BtvnfEnAZPgUIiHHY8/dHrlSPDK0S
	 pUv0YpLSeaa6/tNJApdxykBdGQyRP0hvCkT118ymM4rs1CJGfrGCuFHq/BwQ9qA7Gd
	 +S5br+zmGW1brfGL+pfVcHT58W0bwwI/C1udOCgwu3DF6tKZMLOqpNf6byn4z9vLjW
	 5IR7rEt4vaucA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1pJmFZ3Ter-00I6EF; Sun, 04
 Dec 2022 15:12:12 +0100
Message-ID: <579b8cb5-f08a-df16-567c-71c1eca4a617@web.de>
Date: Sun, 4 Dec 2022 15:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
 <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de>
 <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
 <alpine.DEB.2.22.394.2212041501550.3337@hadrien>
Cc: "Derek M. Jones" <derek@knosof.co.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2212041501550.3337@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:leTHWcGV8gHGcUjphtHprMR0ifspF21y5bg/APPaB37grriUFNu
 g7VkuBemOA67vnPDcPorbsbB4d1GJhwoEu/gZXvLW1iK6RCpHq/B11P5eexyKJjwX7mkyp1
 oiyOuq9zKZUN6Jvr1fcPB4NRHqDDRigjF8qMhS+MutUKCFUnKN20LxB2Q6VGRZAree08Crq
 GrgtfgFq8x0bwweH1ynEQ==
UI-OutboundReport: notjunk:1;M01:P0:+SEkmPvbOJM=;rW2Rr8AaDisw26Jt/ON8mFSY9l3
 VjAcYI0XFiWHLj/T/SP3de4sfRPaGA9vm/oJ7RXgUYF35kO6rtwI35XZBB02cpEEZWju6SCye
 rbrG438t1PrqE3zQNeq4uV65L3wyW3o96TcOVNG2AswiSDYh19MTrv8lIwg3UOwURGMwYatqg
 p5QZ8X0r1O//7kgEO4Ad7RK7r2exxdJdRdVrC2ZInCT/E6YxpYltr5ISBlQXDNn7PoHPlmWEP
 4xHA/pxQhZqkjslDr/0L9YeiVsbe7B/1vgjmF4Ye3vcmmHxpQzpKT4UJbdQOn16BWPPLl30Ko
 hpaF1ZIyQjPFmUG1t33cAhoZqhCznwvT1PcGVxWKSYW2T4BklfAon0vdDFyCVKRdqbbCQpPh4
 kpVR+1Tw2bFlGnW+RfvBwTOeFfuWKKmG0fJ/yOXhrc8Cq0Pfm36YrATuQT7U5myVw1HcoAAlu
 PNLxR8U3P1GrMER2+fr2mIWKfPQI55nap+gWeNiOdcv2ribaiw3fLiC5BebSsYyRjloFtNKb8
 nXbwYRs4y1Q1emdj0dcyRmdTCBHdBkgTbQv8Re6f7zgC7J2blDuOAtqIdXnoAPQjgYEuAY05M
 FGjRXfNnWeKIEhJZ4FsJlRCDhTRh2TVw/qwW2acgFtRQhWX62SVypufjPb6bCJl3FzUwB3lLK
 10D2Gv1G+8Tca3050Z3Xodly9zCI70gUU1IgdydElrRgjPgIwe8fm4/UNsTf5yafAoQYARVUH
 tI7K/zACsNhvVcUbsAnZOdlOiOBqu6YjOqNMZz7zo0fjgDBAuy57ZiOBP3kw5yMp05nTIx3AA
 Q5aiK6sguROKeqxhygmfnGQnLkIUuQbiY8jOpgxyjSjAruWEp8X/2FcWNtuCaglUD+Iz/PYzk
 eiujghL52P1NSM2DWSKInd4AmZkBbUK4fZLfwENY+/lMxCfroUcAIPx1y91fhW7HzmWeGDSR6
 rxFtpw==
Subject: Re: [cocci] Clarification for SmPL search techniques
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 770
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/579b8cb5-f08a-df16-567c-71c1eca4a617%40web.de>

>> I think a lot more people would use Coccinelle if it had
>> more documentation.
> If you write something that you think others would find helpful,


Some information sources grew through the years.


> feel free to send it along, and we can add it to the web page.

How much will further progress in the discussed area depend on advanced
knowledge transfer from known core developers?

Regards,
Markus
