Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D1EC54E64
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2024 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wnImtG+sdDKBz8p7D19dYtETLPhG0zAbUWwRFg9QZU4=;
  b=RFG79tZoz+eVHx88Ohw570wrA+o/1ohozoJDKGOvYs6H8e2xyeMIRHau
   AKLOS4wPCx/mI6tANHvIfnoYirUDBT7fjXrVzU4VuARFGv00LxI1bpKLi
   4rRPWr9uUX65N7yKnVVq4rWKB61UHdy8q7WJyjDyXNCX6a8M1hcxfk9Tz
   A=;
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
X-IronPort-AV: E=Sophos;i="6.07,153,1708383600"; 
   d="scan'208";a="158294672"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2024 12:55:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B2A7E0149; Mon, 25 Mar 2024 12:55:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2153BE0145
	for <cocci@sympa.inria.fr>; Mon, 25 Mar 2024 12:55:45 +0100 (CET)
IronPort-SDR: 6601663f_7OAjcyYf4sgKHdkGDPro+8AxczbH73FMB9aWvWdnf9VVurE
 buOfEEf+DW3OgvAqOCSfTgl6xkqBwGv98/l2Oyw==
X-IPAS-Result: =?us-ascii?q?A0HdAADrZAFmhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4fANTMgQLSIRWkTotA4Q7jwaIcIFWgUA+DwEDAQ07BgECBAEBA?=
 =?us-ascii?q?wQ4gVOCLkYCiAUCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBIxMEBw4FCyeFbA2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCDTpCAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ8AYIqAQMOIwcNsjGBM?=
 =?us-ascii?q?oEBggoBAQavXB8sIleBYQMGgRouAYglAYV1hDwnD4FVRIE8glIxPoJhAgKBX?=
 =?us-ascii?q?oNbgmiCF4M3kzSCa4lMVH8cA4EFBFwNGxAeNxEQEw0DCG4dAjE6AwUDBDIKE?=
 =?us-ascii?q?gwLHwVUA0AGSAsDAhoFAwMEgS0FCxoCEBoGDCgDAxJJAhAUAzgDAwYDCjEuT?=
 =?us-ascii?q?0EMUANnHzEJPAsEDBoCGxQNJCMCLD4DCQoQAhYDHRYEMBEJCyYDKgY2AhIMB?=
 =?us-ascii?q?gYGXCAHDwkEIwMIBAMrJQMgcBEDBBoECwd2ggCBPQQTRAMQPnSKFgyBCIIrg?=
 =?us-ascii?q?XkphDwIAy8DGSsdQAIBC209NQkLGwYiAR0CpEABg18/IAKBPF0CxTo0B4I2g?=
 =?us-ascii?q?WCBYQyKH5UiBhMvhAWMfIY1DgaSZZhiII1TmxCBawMwgVwzGiSDNhM8AxkPj?=
 =?us-ascii?q?iAZg2Ezj0dCNTsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:IY0pT6nMCC04YKTr834NMZgLhfbpDfLA3DAbv31ZSRFFG/Fw9/
 rEoB19726QtN9xYgBDpTnuAsO9qB/nmKKdpLN+AV7AZniEhILLFu5fBOLZqlXd8m/Fl9K1vp
 0BT0EKMqyXMbEMt7ec3ODXKbodKaG8gcSVrNab9G11RQVmL4lr8gd+DW+gYzRLbTgDPoAhHJ
 6QovJaqyatPVQbB/7LfUUtbqz5vcTCkJ+jWxIcGBI9gTP+9Q+A2frBChCd01MkXylSxKpKyx
 m+rzDE
X-Talos-CUID: =?us-ascii?q?9a23=3ARE48nGidP0YncrL6If9mDII9wzJuS13zyXruEVa?=
 =?us-ascii?q?BNEVwC6POcke0or1uup87?=
X-Talos-MUID: 9a23:NbqB+gXX8xhZsDvq/BPjhxdPHZZP2IjwB0A8vZEJsOCDMSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,153,1708383600"; 
   d="scan'208";a="83017427"
X-MGA-submission: =?us-ascii?q?MDGjctGPSLwzkEzgaieIxW6J2Lz0sAeicDLQqV?=
 =?us-ascii?q?kWEOopxEEX2mre0sWo/T6AXDbQhAAdHmLerL5kut6pfnt6EpE5PGKQLu?=
 =?us-ascii?q?vjaIWleZjZRvQRYBnoDDF+TDz8LusNTIkE8PKF2sa32kJ8T0GNM8Xqu2?=
 =?us-ascii?q?ZzZJQ8okk2wVbf4cgTlSr1ww=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:55:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711367743; x=1711972543; i=markus.elfring@web.de;
	bh=wnImtG+sdDKBz8p7D19dYtETLPhG0zAbUWwRFg9QZU4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=XSE6vyr8zDmrKkcR9dc0OC9pLqQnPNbwhm93KbzseCEp32uEx4tnsx5lFMNZLDKb
	 8OUEowo0JolEVyCgQ6xwOQ8q720KYBmpRmgGkO4il6KM0EQqfAN/bZcG/iW2Psm5h
	 5BWl6NyZ2NovNRx9/Hd97gUpl4MBPi7otU3HGbyOf1n4dE2NYP64zngFm2TNVFoJp
	 xGCupS1LOgonhDfEzEATpe906/+5wBF2CPOWpgfe7po/EiVozitFNyQIiN+yDZCfX
	 UzYBXwILvg8NVfrBBMg9mET6T0nX6xGJfqAbSBnLt7EqrGI9bMhyNktdZIP/gYRke
	 zLhGXchYLw+CuSIfuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1skpQ21e0z-00wXGo; Mon, 25
 Mar 2024 12:55:43 +0100
Message-ID: <bd02498e-a97c-443f-b2b7-a77e932079c7@web.de>
Date: Mon, 25 Mar 2024 12:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d5250894-dab4-4729-8165-a9b70844c8d4@web.de>
 <9f199353-3997-858-3858-893848adbf9d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9f199353-3997-858-3858-893848adbf9d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwfU9NLJvGfFXzUQfMtsAZQ4sxIXmGI5waUSJmbqcpQ22JRuWoY
 uYdWZXbB2jq1/w+LHvyrjQCQJQjx0rjrFar7KYXV9JAR60EttnvAjTOTialO2eKe1YVw1/+
 86eGQKobuo8qmjZN5vl/ldgTTXvtutavfONdiu986ZrS5UL1xvH/Lt2ObhN+pT7GhqD0Q8n
 d3DmKUYnuRG+qvIlu9p8w==
UI-OutboundReport: notjunk:1;M01:P0:EaZoehJCT5E=;XTJGefBwFNbaJ9r/3EhH83EXhh7
 fBheXM3/X4tteBtslftTMt8+IFpDO5oSXbCaMWsNJLG+bYcb6DHIZ1HSGEX4S7Od9QsaQPGy6
 zuH+zFrN2vBLtWCYOHRTOH686BZNMKtrLQl9Q7ZzcCUmzHBdn5hmffyYyhJ0qpCxdeKqLcURY
 NwAOTGTQWXtmo8GjKCSlDVQtM866yqFfYAfVRJWb5IqzdFlJDAGjFzXgFRfWqWVeKyZI+dsdb
 UOUXTvEpzcVKqkDyyJt77650HNg/0Iiyku09rixP8TXyX5UCKAkM5MhqjKYQUmNKT9VTcYxNG
 LXeXPeP7GZZ2+NfJ4PlIH14RiW/lmY4lylQ229NgUQw05jj+f7ZAPBbdINDciTQYxVDs9+cp1
 8EZcj2GCNt9r3mXZcowrYmgcZPMpWE3YfnpzNm54hviWOJyjx/FDk/bwnai9HMmmhqJI+Q4+E
 ipwBisK0dAUxfVsY0K8Xxdu8TyyyOYNittpHmtoOVqN3bh/+WSgCkhE1IdW4Cn71ltVRGWSn+
 +oqDit+wq43FQL3ay67XLGo3DLDi6vbnO9BnvAWWeElQlI61Y0ShjPLHc4uEJNs+2M/9bm42n
 Lgci5w0BsmPnROQ+eXbXEdVBDB5HOSKVMmfC+kQNg/j031YiiCTyko0ZEtwnUsbOIrAcDTZcy
 MlnDLKcd+2v0Hab+TkDwxB2PfsUr/8w2ximI6iUHx2DpAwTl4GVa9pXmQWRpH3O3E8YrWpjdX
 6N77JKaDcmvn/ryEUlyJR2EO98yBixS3SW1wUtfaU7HCybD6cPDCFsoKxzyxoqBXfMIpkElfQ
 T3VccejjfHBNQcd6PUgPa4s5/0DFMJrRZjB//vNut5xaM=
Subject: Re: [cocci] Improving support for argument lists with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1617
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/bd02498e-a97c-443f-b2b7-a77e932079c7%40web.de>

=E2=80=A6
>> Identifiers can occasionally be followed by parentheses in the source c=
ode.
>> Such a code combination can be interpreted in different ways.
=E2=80=A6
>>   Improve support for handling arguments of function-like macros
>>   2024-03-14
>>   https://github.com/coccinelle/coccinelle/issues/362
=E2=80=A6
> If you have a specific question, please say what it is,

Please take another look at information in known issue trackers.

How many programming interfaces can be shared by the Coccinelle software f=
or
data processing according to macro calls and handling of attributes with a=
rguments?

See also another related clarification approach (from yesterday):
Fix a parse error for the addition of a special variable declaration
https://github.com/coccinelle/coccinelle/issues/363#issuecomment-201679426=
6


>                                                         and don't expect
> that I wuill try to infer it from a collection of links.

Would any more developers get into the mood to add ideas accordingly?

Regards,
Markus
