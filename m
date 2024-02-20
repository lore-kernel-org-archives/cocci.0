Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E17C48BC3
	for <cocci@archiver.kernel.org>; Tue, 20 Feb 2024 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ABzZwh7rjGo5dzlH2QsHbFbyU23+Ot1S+tVigtafRnk=;
  b=E1vxXLZVo+klFhOQn/E6hulZsh77aukD4CqXiVisfmMHVcrGcdoGHJjE
   cBbTIqPqPAvAUG9omC24/S0C88b4EGkJ0jyzAsgOAEvs4/O2d5iLMxuDl
   u7mZ0YIpfg6H/X3Kju3TLZ+IpvS80OwmvSCGuQ53GnEt+zG9ASb6fizZ3
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
X-IronPort-AV: E=Sophos;i="6.06,174,1705359600"; 
   d="scan'208";a="152918672"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Feb 2024 16:56:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0A5DAE00B7; Tue, 20 Feb 2024 16:56:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6A88DE008A
	for <cocci@sympa.inria.fr>; Tue, 20 Feb 2024 16:56:16 +0100 (CET)
IronPort-SDR: 65d4cb9f_4sGDRZm9sZ6k5leSzaho5Y/3jcLobg+9fi8hG26wDILH4WW
 qsuuD0rndn4grw9SU7fquj0z2tbCxJApNO6t1HA==
X-IPAS-Result: =?us-ascii?q?A0HtBADhytRlhwwR49RaHgEBCxIMQIQIgVIyBAtIhFOPR?=
 =?us-ascii?q?IF1MIQ7hzeHToRrhxs+DwEDAQ1BAQIEAQEDBIILgnQCh2QCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CVRiBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQQECAgEjBBkBAREnBAsLGgImAgJWG?=
 =?us-ascii?q?wEBgnyCKwEDDiMHr3t/M4EBggoBAQaCZ6x0HywiVoFhCYEaLogmAYorJw+BV?=
 =?us-ascii?q?USBPAuCeD6EQ02DDoJoghiDO4h+kRVUfx0DgQUEWg0bEB43ERAFDg0DCG4dA?=
 =?us-ascii?q?jE6AwUDBDIKEgwLHwVUA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUA?=
 =?us-ascii?q?zgDAwYDCjEwVUEMUANkHzIJPA8MGgIbGw0kIwIsQAMREAIWAx0WBDIRCQsmA?=
 =?us-ascii?q?yoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd6ggmBPQQTRAMQg?=
 =?us-ascii?q?TSFOIRsDIFcAxkrHUACAQttPTUJCxsGIx0CpW4vxHE0B4I0gWCBYQyfOAYTL?=
 =?us-ascii?q?5cxDgaSXy6HVpBVqHeBeyOBXDMaJIM2TwMZD44gGYQUj0dCNTsCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8/UKB6D2UaJUojvlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBHhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOktK1vp
 0BT0ERMqyUMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:E+1yOWD4hE5kNRn6Ewxcr1MNCOcBTmf69ErLKkWDF2JEc7LAHA==
X-Talos-MUID: 9a23:QiPs4wgjYP+mv0RnZseyBMMpDftaz72eK2A3rZQhtYq9FhVuAQ2npWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,174,1705359600"; 
   d="scan'208";a="80161439"
X-MGA-submission: =?us-ascii?q?MDGjyAILaq1XWYPe7jZeTlrBJVBdI9GDNBoZUs?=
 =?us-ascii?q?TKff7aO15wKpcbEEp2gQbG4pMk6tuoGJhUmmPu9EgCFchtNJ7S7GAQ23?=
 =?us-ascii?q?FksSBAB1Lz9GVN1pvMzhgprHHY27L06vlesXHG2M+vbUZ+A4uzxBetz4?=
 =?us-ascii?q?fFhB4/gqVUQgX1BFjAfI4TjA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:56:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708444574; x=1709049374; i=markus.elfring@web.de;
	bh=5ivcBJVdRNxYRFap2EKWudt3S4JMmIwEtO4oDQvAaTk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=hdy7JeiPb8+ujjN6Bzm4DEscTAEzZ9tjs0vwXz+ArUm4ZG63b4yx1gFGAXnpDnfN
	 L1ayloxybXPBEAuxyBibrw7UlesPGX4u58BQKwfL7rFAyElWcaG5m2Hu5H88/X0yj
	 pB6USymsKs/gsbz9H/rZPeapQ6hfglg3TWzu72JhQoxKmp+4GyNC3W6NpXPn5dCBd
	 ggSMl1dm0EHGmmYKndPklTc+a7muKlxBVFhmpBBHIXzk2qzFTubUjepaLkLAoSm6A
	 nJTJIgdSJYP7LXcjs9L64trqw+sut6KIQq3G99doDRodH2zhk3vFm2PIuM/c8SDo7
	 6xofE9ig4lAczFbmNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1rjeHU2EP4-00GCWI for
 <cocci@inria.fr>; Tue, 20 Feb 2024 16:56:14 +0100
Message-ID: <3ec2c347-6772-4ed4-b294-2741b1bd6c32@web.de>
Date: Tue, 20 Feb 2024 16:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
In-Reply-To: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ME7u/FNQslE8bxY5iQLXh0wxlMqEPgDzTPxQSyxeQRbtsns76jz
 dfQ9vAb3mC1t4rwWHMJsbT/XXsTn+i+6Ui/bSa3hfcLgTmBb2DoX8SFT4p3kpUwS75ZuTpU
 F9p3B4e4W6VS44v8BrcnFfqg5SuNz9QCWRGmnvKEJn6huTC2bdDRXLA8Vyyfw8PZZX/IjNf
 eNrkSO7jsXyHIhm+R3j3A==
UI-OutboundReport: notjunk:1;M01:P0:mxzYmBGrnxs=;+/FUyv/bPi7bxtFbOAxh+rrbmR9
 TE5YGWoH8SLVcHKm0TMlYvxR8VqKDA7owc8zETbZLhYHfi6GIg3vkxJzfCYwRnfqd6AWnav6I
 oU9RHRfTAYrMTSeBHMjLVk9bCJtKo7POxmYnmjpSaU2gKXLNBpxAXldPQAVnY9GXe39xkktSd
 BHV2d5J0ek4M4KnMC8140OnxzT+mx5OtVoZOSnAlqLy42lL09AjFh+9z8X1zvS6drYNTT/Wxg
 vxYbj0xIBQ6fyucJ3z0LZpkK46DtlOQl1wVoENIkdWnjA/XvZkDOTXI2XTcB2Wqdx8w2rI+p8
 IjQX1yuJKHPKVH1jD0TvQ1S25L7yr0tVjNRnMK1gsGQGesovLf3CkJiBrmjdmPwU8bQV8Qewi
 Fv53EGzklc6QzK9BFqfqn0UEopc41BgKV3Kep9tdGKK2SWI1TdDFiC54/pz48jifL1TaIg4YS
 wjXPWsLe0j4LjMdvUUur9fOifw2/wPytLWNazX1GWBrW844UYwt/WS0DzNMwPeWXFdtqdb7Gg
 QPmWF6wtmsQ+UfC9Lru4DfGMnVAnqYL52g8D79JzzpDZk/Fpqlon6T34yAIZ4tpTALswslurI
 JNSQjsTzVLl7uL66VGmKGY+ItQiH9c9JvZZ6Vk+kZyUV/vf4cUI9MnPP5pFeTsegf9UHFRVjD
 x5XMV1FWwy0PBCeVw599s5MnOIDtvg7a9KjnYIzWoNm8HNh47UtyefSlimfI6Awei8syckj3C
 8tsnDtF3jltQZ/XUSuLx3hcLnj1fpmNszvRE3yKCb4OR6gbYFOpPBQcnxBq6y5XDQpiDGAj/9
 jV43ds1as7KS8iw83u3eKkdtdcA4cy2wvSqlTSsLV/Fuw=
Subject: Re: [cocci] Moving fwnode_handle_put() calls to a single place with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1590
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/3ec2c347-6772-4ed4-b294-2741b1bd6c32%40web.de>

> I would like to achieve another known source code transformation
> also together with the software combination =E2=80=9CCoccinelle 1.1.1-00=
739-g68c580f1=E2=80=9D
> for the implementation of a function like =E2=80=9Cpmic_glink_altmode_pr=
obe=E2=80=9D.

It seems that the following script variant for the semantic patch language
can work as expected.


@replacement@
constant c;
@@
 <+...
 if (...)
 {
    ... when !=3D ret
-   fwnode_handle_put(fwnode);
(
+   ret =3D
-   return
(          dev_err_probe(...)
|          - c
)   ;
|
-   return ret;
)
+   goto put_fwnode;
 }
 ...+>
 return PTR_ERR_OR_ZERO(altmode->client);
+
+put_fwnode:
+fwnode_handle_put(fwnode);
+return ret;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20240220 && time spatch drivers/soc/qcom/pmic_glink_altmode.c =E2=80=
=A6/Projekte/Coccinelle/janitor/adjust_exception_handling_in_pmic_glink_al=
tmode-2-20240220.cocci
=E2=80=A6
real    0m18,382s
user    0m17,132s
sys     0m0,230s


Regards,
Markus
