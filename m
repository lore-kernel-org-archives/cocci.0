Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199CAC48BEB
	for <cocci@archiver.kernel.org>; Wed, 21 Feb 2024 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=chV65aKs/qgXXwksm8tgmQycq3IIWxxJkISsN9EnUoI=;
  b=BlxWA5N5mzI2ahOVGHuhECU8KhfSCu1b/CXhuPfzW4yAsw37d/5fqgOK
   Ju0674md+cGkQzZskZyNzDIx1cHPWR3gAR1pudunBxpCvbgI2xVhVVTwI
   doIIrFFtCeFY06tYkYifawzCLaBdeyg405UuJ1UqluR896PVVZ8pWxmu1
   I=;
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
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="153097208"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Feb 2024 16:34:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 271D3E0CD7; Wed, 21 Feb 2024 16:34:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45B5DE008A
	for <cocci@sympa.inria.fr>; Wed, 21 Feb 2024 16:34:47 +0100 (CET)
IronPort-SDR: 65d61816_NmJdYnnteLIS8aQzxiYt41LYwykKu8/hsX5X3beeN6agDQZ
 OmRryKaW1HXGSBuivAsI9kSbJr7MrPEQoAy5Bxg==
X-IPAS-Result: =?us-ascii?q?A0HqBwCvF9ZlhwsR49RagQmBT4I5Yh1TMgQLSIRTj0SGY?=
 =?us-ascii?q?Ic3h06Ea4VbgUA+DwEDAQ1BAQIEAQEDBIILgnQCh2wCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxMEBw4FCyeFbA2CVRiBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQMDIx0BAREnDwsaAiYCAlYbAQGCf?=
 =?us-ascii?q?IIrAQMxB7A3gTKBAYIKAQEGgmesdB8sIlaBYQmBGi6IJgGKKycPgVVEgTyCU?=
 =?us-ascii?q?jE+hENNgw6CaIFAVoM7iH2KY4ZXVH8cA4EFBFwNGxAeNxEQBQ4NAwhuHQIxO?=
 =?us-ascii?q?gMFAwQyChIMCx8FVANDBkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4A?=
 =?us-ascii?q?wMGAwoxMFVBDFADZB8yCTwLBAwaAhsbDSQjAixAAxEQAhYDHRYEMBEJCyYDK?=
 =?us-ascii?q?gY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDEwcLB3iCCYE9BBNEAxCBN?=
 =?us-ascii?q?IonDIIIBgMZKx1AAgELbT01CQsbBiIBHQKjCMgnNAeCNIFggWEMnzgGEy+XM?=
 =?us-ascii?q?Q4Gkl8uh1aQVah3gWQ6gVwzGiSDNk8DGQ+OOYQUj0dCNTsCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jJ//bals5uqsu4csDauOEVka8rvpDfLy3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNWftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:1J7KRGBwQcFeCJT6E3lszlJFPpw9SCPE3niMI13nGHlCVITAHA==
X-Talos-MUID: 9a23:8G8LEQboa6wkp+BTkgDOvgpYF9pR2Yv0CnoSjpAB5se8DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="153097191"
X-MGA-submission: =?us-ascii?q?MDHl1Aif3Iuhoh3xlZ9EmFrYqveRgrCXxbkBIq?=
 =?us-ascii?q?r8B+RQXZNgXwvf1KPmhN2DWjpfKSZIVkY3lUyjlI7K/cuC3vH4D9gzBC?=
 =?us-ascii?q?pPKbtZ3nssICd6dGl6uzr8TV/Jb8jTRQDBnxdcje9gA4GtPnwJbZyUn4?=
 =?us-ascii?q?R3fX9tTDp0UACqbPzrA8N2oA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 16:34:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708529686; x=1709134486; i=markus.elfring@web.de;
	bh=chV65aKs/qgXXwksm8tgmQycq3IIWxxJkISsN9EnUoI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=lKjloF12T4OYbX3xLJPjyCXgXpDJBPCH9QO8gh80Ty5KfqWIqkpTmmJ839e/+kr7
	 XjVhOJcKfc11uIJjCpXJ3cECTUGtYqvs68wt5QQgc9HRzzaQJ8cVOWfVDiOubM09A
	 m3grPcqfLhgUoMSHBP26f1wTisa3VaCtAgeAy+5xW84yc3/ouHESnLCERynz2d/ia
	 hr8m3qdUDpi2qYJOFBSDOmdgccC+vFPuVTPXJE1JpjIyHRfx0X4LHujEOKICsQZPr
	 S3IZYPOB51681/BvsMT1MnV5Eb8ct7jspmcTSIzhfnsM9Vgvc2HBH4QC/0Juoi/nk
	 Mz8Le89DBXofuKyI/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdLK-1rMNhJ43US-00LLLh for
 <cocci@inria.fr>; Wed, 21 Feb 2024 16:34:46 +0100
Message-ID: <bba73344-5c59-4e1c-9a42-f85decb534a9@web.de>
Date: Wed, 21 Feb 2024 16:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
In-Reply-To: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qJOp/IxQE5rpucjKXCAsGZr5+V/Jps50SatYNhpRNRzlhPTEc30
 9s3z42qY1+yNYDnYN6By6JX1d2F2S1QDeZhcxWSiCAqV8y2o5urZWn5PM5cFf9Drue+brr9
 70B4VY1tLki0bJSZoyaV1ea//wd7nZH+dfZqd0/s0FYWlHSpajFlAc1HvnLHps1RExgch7z
 k+PXIw34c9htOu0MB09Eg==
UI-OutboundReport: notjunk:1;M01:P0:1F177N4EILw=;l3nB/gnR0aBMvKwOQr6YV2ipQFi
 3RHNKw1SmGaPKFbuXj6NaEj8E34krXTCWpb1x2sNcePkWcoNZYDJRldyBq22T3dJCat24V67u
 w5VN4+2pFJz/gO263zRJ/jv8IQnFNqFibO8OBXWzUJAqnpblwaZG9bWI0ym+b5kBng85kgWj/
 UdiwRLmep1et1rmBieEKrUL0cSCelgY90VSceep6Sk8dMR5svZafe9lnpn0aFap63WZtmKxcg
 qLSRjGV5Uv3Zg2njfp369PMtJNdUbqCVAZahx342OvZ9PMFTEGiVo0Lw6byIeyD/ApJYFRbnd
 8emdSxfLsvQPHi/vcQu2YNwsxyFUgk1OE/m7oKLTRmwNjuLMwfSNrT+AsoPlgS/QauXlYkzNQ
 t3jY5N6qhlX2ZmXeXGCrH2g40hIAyRR8zBPYAC0RaOWUhxja1bsQrZzkpJWNuOhPJJ8ZBax+t
 8FR8adIZwmrGnn2SnuWasl4rtQK5pqx8fYQ5kDxato891k4GvMG7g6RZeR0pcb3JxyQapn5R4
 1+H9R9VUdXEpZb3teQ/rCU4SUrNo1xWLKKYkAm4bMkIkguUYnDLhWelTZG0uP+jyHN4+KXE5z
 h9cJQiz1qJ0BhedHRRAdUHduBbJW0g473nMvAHMRD9X74xnV/G+wqeqbL5Sf0Y6enxvxSrIRK
 miJIC5LW4+B9kC9FTvtY9vkcRQXWk+FrpX7kV8okRKTgcJbqlS4NPD9K6uq3yVJjoCfIAe9UY
 EPa/bzccPWexcb7t2s0zZylbW9PTixF3QEAERr4JocxEnpTZnvrhG6IWl4FIOImrF+plD4SFz
 Sbl5TB8l6Rd9MU6k4iku9xsjh9wKG9TwcoZGf1oKNAOD0=
Subject: Re: [cocci] Fixing software for the movement of fwnode_handle_put()
 calls with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1592
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/bba73344-5c59-4e1c-9a42-f85decb534a9%40web.de>

=E2=80=A6
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch --=
timeout 123 --show-trying pmic_glink_altmode-excerpt2-20240220.c ../janito=
r/adjust_exception_handling_in_pmic_glink_altmode-20240220.cocci
> =E2=80=A6
> Fatal error: exception Coccinelle_modules.Common.Timeout
=E2=80=A6

The amount of source code within a function implementation (like for this =
test example)
obviously influences the software run time also for the shown transformati=
on attempt.
Thus the involved source code can be reduced for further software tests.
Finally, I could reproduce questionable software behaviour after a single
if statement (which contains a call of the function =E2=80=9Cdev_err_probe=
=E2=80=9D) was left over
behind three other if statements.


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch --ti=
meout 5 pmic_glink_altmode-excerpt3-20240220.c ../janitor/adjust_exception=
_handling_in_pmic_glink_altmode-20240220.cocci
=E2=80=A6
Fatal error: exception Coccinelle_modules.Common.Timeout
=E2=80=A6


Will observations of =E2=80=9Cexploding=E2=80=9D data processing run times=
 trigger any improvements
for the discussed development tool?

Regards,
Markus
