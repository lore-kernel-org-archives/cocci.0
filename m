Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59614CF9C64
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ufTgdtwV7ObCZyF/Qek+Kk4XLOidizA0eJYF7MnXyS0=;
  b=ogA15m39ADU07QEDS7iz4z7asa1oacBoGO9m7YRsQ7c3tCVf2HsQU9TZ
   0W/z544+1F1TqeM+ogwoOk323G+AIcD+hHdOg2dnePKwPaSlTAB4QLdW1
   +tkvJ7dgP+cl3E78kBfu8lazVTrNQV+isuIPZwoZKjnfjUtdXsWjxSI/+
   8=;
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
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184412134"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 12:28:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54D3DE0133; Sun, 22 Sep 2024 12:28:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FD8CE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 12:28:08 +0200 (CEST)
IronPort-SDR: 66eff137_/bPXSfWJr3UyYsdEskxVdY4VLVX6i70H4IEPVYQF4W24tI1
 fp3VRmzvQr+qeprCzJN9FwbFSXVWWPNP7MDi4vw==
X-IPAS-Result: =?us-ascii?q?A0ExAACx8O9mhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDgVczBAtIhBo8iB2HMIF1MIQ7hzqHVIh2gVaBQD4PAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?HYKAooDAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAToHDjuFOwgyDYJjARCBFIEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRAEBA?=
 =?us-ascii?q?QIBDBcdAQERJwQLCQIaAiYCAlYGARQBAYJ9gjABAw4jB5gWnDeBMoEBggwBA?=
 =?us-ascii?q?QbaWh8sIleBYwmBGi4BiEoBhiKEOycPgVVEgTwLgkAHMT6EQ4NbgmmNIIRtg?=
 =?us-ascii?q?hCFVIQKJYhicJBmUnscA1khEwFVExcLCQWJOAqDHIFuJoQVCIErE4NfgWcJY?=
 =?us-ascii?q?YdnYoENgT6BWQFGgnNKg1AcgV0FOEmCUWtOPAINAjeCKiRqglqBLwQFg2odQ?=
 =?us-ascii?q?AIBC209NQkLGwY9rgKCP4FKggTFF4EKNAeCN4FjgWMMn1IGEy+DcpNMDgaSc?=
 =?us-ascii?q?5h2Iqh7gWc6gVwzGiSDNk8DGQ+MaYE4GYQUxkxBNTsCBwEKAQEDCYVGAQGGP?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:n8jCuK1f8FaQd2yzijFlkwqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:kb7O9m/LemrFu3DSys6Vv1QRCOc1Ulnt9yqODW7pLGRNFIyMSXbFrQ==
X-Talos-MUID: 9a23:tN0ozgrVD1VqdNsR1bEezxNNHtd40ZX/Mx4Mgckoi5OnEy1vMDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="97030808"
X-MGA-submission: =?us-ascii?q?MDFVUK4RkAqIvIEdK4HgKsnWehbi6nzLiEZMxF?=
 =?us-ascii?q?zgQX+XLyvgMg1ozSado28a9QFUe99Ok+QmUelNs709cuTj0fcsrTgd4y?=
 =?us-ascii?q?zyJc+aFqq25dt3Jw0AVkJSCMN30Z1qYuqiZsXzAroqXaXrj5RmZxmbAi?=
 =?us-ascii?q?3Ak/vCiKJew22u579UScw8kw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 12:28:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727000886; x=1727605686; i=markus.elfring@web.de;
	bh=ufTgdtwV7ObCZyF/Qek+Kk4XLOidizA0eJYF7MnXyS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b/fmuoqb4ADdzldzQ82lc2nqTlcb+C/bFbxLyx5GfPXgcaiQ6+dtx0nDFPligFHq
	 bzoP7GbQ0ugH/bTA8h4HQY3g71JByOH4Y1p1kPolg+BWLflDaShBbJYXlfiqd80Sr
	 /5M8I4dy+wbVQ5dKdtwhUQHG6hCSrYpQtmljhfUKRfFSEb3C3v6Ec9xhLMz7X10bI
	 FdVcSXvdv8i/IisxRPvBpZYoAyo8aF+6VWoW+a/r7eIIGLe3kOHg3+rY9vYAgHfKR
	 BmhHpWZBAp/31n5d85l7wP3HbkMMDP6zUIyfs2qHuU6XOdwU9Uo5Y4uiDuDXlHkHj
	 Txl6VShKlWGLrNxOAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8Bw1-1svsSD24Gp-00Ah0a; Sun, 22
 Sep 2024 12:28:06 +0200
Message-ID: <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
Date: Sun, 22 Sep 2024 12:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
 <b1872e36-154b-477f-907a-7fc98b301931@web.de>
 <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
 <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lHavT68DQK8syu758ijX0SMpndj5HOOyKXAC68GZI2HwpH8SLKo
 etw/phC1ksordZHlgMtwQnAwb/eH7iB2+hgu5dBhNSK1mkKmrFxD4lAtdLkDHHskkz9wwzy
 gZ9/EyWTbok7EpOG+IY+i54XidSd6q/dvCibc9/3vMkpJzFkWLgzVwIbOci2s6zw08fKdJG
 2Hm5KrmAAXu6xp2lA9FvQ==
UI-OutboundReport: notjunk:1;M01:P0:SICd4504cfc=;qNKI8LkdHsUNk+ZjqNobav/esLW
 ZftH4258+izwgYAb//j7AfL5OV5m6ny2W8q9DRHG06pS8tFiyIrh5UDESq5DXlbwFlLhblpQu
 +DCEKWofJkIU+Hi+MBhUtGzvxX1EuvbueerFT1wZEEAQYu/TmIJ0eDCzViPc1qBS7K+KViVYO
 OPZXx/4TJjYsOpzAVFwOAKKqm0e4BZPxraut+09qLnmelJ5GIdtVpecznPqxfC1Ez8fkBXf7i
 sv84RYSvu+vxHGukOjwAzxmRc9btEjN88wgc+G+ychnMzQeJ4Z9WERYM8QvFajkZ19fLvoQj3
 Or4OHHNV/HO340S7/NHUz8PYHnWBASwcp5BT8IDGUUrbuqGjEpl41UBrA7+jbVZp4ZlS/jb5m
 Jr6vnO4u6fDoRFfCDNLu/orgXQtGyzeQy6vToXDpiWbcO95HmZ9ko4ESC0DmokAD9krtSU+km
 d9lK923HgfMuT3cwpjxNun0f8wYk/FW3QanQHdZq6nGdPshzLYyRWKjvjrqWbhNo70vZMg4ou
 oT8+T0tMZwyXv+xKTKe/PRE8QgZCw1lfNSCcRhMsqi0xSZKzXcS1O2g4AbxEFpDbMcN/J/STT
 ACnb2spovHphndtu3EnwXiz4d5rKshP8UokTJDunNwX3TUBgR4PEDxFXSK+GFfvRz68RSDc01
 p5GV1hPcQ0PJc1zynyH/v4oQu2EqBIkdyubi1Md0GncjfBwfRlN8vVSTjsIT6h6QyejFc1eTN
 igvhRpupX4wKMfz7dgyPOhMaOHBJSbFJcXGIejzLfjrJlpeWI5MyQ2kfx77cIbbPPNAEPhq/v
 lCUjOXLMEdhNYrPmy8K108Qw==
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1878
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/5073d921-72a6-4992-97bf-36a7b792b7c5%40web.de>

> How do you expect Coccinelle to figure out what is the right value for r=
c2?

One variable should usually store the desired return values.


> The only match is in the declaration, but any int variable
> declaration satisfies that.

I would like to increase case distinctions accordingly.
Variables like =E2=80=9Ci=E2=80=9D and =E2=80=9Cj=E2=80=9D are obviously u=
sed in some for loops (for example).
How should such control flow properties be restricted by the means of
the semantic patch language?

Regards,
Markus
