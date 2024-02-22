Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56A7C48BF8
	for <cocci@archiver.kernel.org>; Thu, 22 Feb 2024 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=eHFaGz8Kb+i+AldNsD85T+drTJbZtlO41cFTZVP2+Oo=;
  b=pcCiRra1rKxQ0HEtuU52CSW8TYvkw9mKqxILfDp9U66KgOcHAY4ft7mf
   Gx2PWUcVRu9SBXX68W6BK2a+CKsDEUUgNxK54uVS8/g5ROTzDPhNWrHaI
   MD2axh6DaDVYpK8rmzB4aq0IzhL7LPkH2YIuyvj5HxIuxh/Ni7dq5ZZDc
   g=;
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
X-IronPort-AV: E=Sophos;i="6.06,177,1705359600"; 
   d="scan'208";a="153190908"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2024 10:06:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79183E0CD5; Thu, 22 Feb 2024 10:06:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C34EE008A
	for <cocci@sympa.inria.fr>; Thu, 22 Feb 2024 10:06:07 +0100 (CET)
IronPort-SDR: 65d70e7e_GB82aKfo3WuMU4wekhGEoecqXddPi9P6A7tNS7VIgz0esfY
 rWYYIrpO4J2+1/SIChb/SWdpz2SwM2cw7lXzpiw==
X-IPAS-Result: =?us-ascii?q?A0FHBQB0Dddlhk7ASNlagQmECHwDUzIEC0iBT4MEj0SBd?=
 =?us-ascii?q?S2EPoFVjTCIcIMWPg8BAwENOwYBAgQBAQMEDSoBgVOKYgIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASEZBw4QJ4VsDYJVGIEOg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEXAg06ah0BAREnNAImAnECAQGCfAGCKgEDM?=
 =?us-ascii?q?QcNBq9zgTKBAYIKAQEGgmesdR8sIlaBYQMGgRouiAwaAQVliWgPgVVEgTyGB?=
 =?us-ascii?q?AeCRoMOgmiCFoM7gSaIOIJCAYc/hmyBUxwDgQVrGxAeNxEQEw0DCG4dAjE6A?=
 =?us-ascii?q?wUDBDIKEgwLHwVUA0MGSQsDAhoFAwMEgTAFDRoCECwmAwMSSQIQFAM4AwMGA?=
 =?us-ascii?q?woxMFVBDFADZB8yCTwPDBoCGxsNJCMCLEADERACFgMdFgQwEQkLJgMqBjYCE?=
 =?us-ascii?q?gwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeINGBBNEAxCBNIongi0DG?=
 =?us-ascii?q?SsdQAIBC209NQkLGwYiHgKfRQGDTy8QgQBFDJNvH5MNnn40B4I0gWAFgVwMi?=
 =?us-ascii?q?HiBI5UdBhMvlzEOBpJgmFmLeIF3lT2FTIF7I4FcMxokgzYSDTADGQ+OOYQUh?=
 =?us-ascii?q?GGKZkI1AgE4AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4zfKq61RG3lxg+FE39kqzQqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:Y1hhBW1mMgN2YamaqqVqUbxfK50UQ1PB7WvpDmC3JTs3a5m5Unu25/Yx
X-Talos-MUID: 9a23:Mo6zPwbpW3ZYWeBTqw6yuSBzGsZU4JulWGY0lLsa4cWbDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,177,1705359600"; 
   d="scan'208";a="153190890"
X-MGA-submission: =?us-ascii?q?MDEsQs9rYIi0Fly6nzpOc3vsHY6rn9iecA+neN?=
 =?us-ascii?q?cqLW6vZbOY4ydSJiPmWlIgrNsiqPmabIYVXaxPOtLbR2e5xJjhtaiK0r?=
 =?us-ascii?q?fi0D+dSv1OkzseFqeqjc1pRn7NIrSejAxsUxibF+BlpFFmQPQ/VoSY0N?=
 =?us-ascii?q?1CQrmE987SUprPZH9oWyJthQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708592765; x=1709197565; i=markus.elfring@web.de;
	bh=IrHTgC706g0zDtzIm9dAPSTzikzO5K0XdAva0+321gQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=oVQWFxoJP4milvQqurnZyT9OikWlSnmA5WwKYY67f9jj5O2Tr/OSbogPyI5RZyjQ
	 /RVPrSK/4939OmBHOOwunLOy9/zSxjbIXrP3HUmeVZE5hrOcTtMkcpkdfDS2cpi8u
	 Ptbwm7DbmdOWZAP+K+XuaHEsUHwO2ET+1DVNuu7sg+jhSNVHYDQ9cyypoxlbcfj43
	 N7gKg0yQ25pUukEkLnmFLpbXt7CDGdgR0jdmcqNIwYvuLs/kxiWW5MWxxedz7zmVC
	 gn2eCEOWbS8+JW4/whKaDAkTAt7ntE1CSwBkvcie+jI2+bRhEXUaARkv6OYCtl/Eu
	 AzAk7Lxw3gDGQmm34w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1r0S123JML-00gz8P for
 <cocci@inria.fr>; Thu, 22 Feb 2024 10:06:05 +0100
Message-ID: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
Date: Thu, 22 Feb 2024 10:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ebg+zZwpCUj9+DczZ3zxhc+xFBVJ99WyxOnzWt1/HWNLzw3C+vv
 37zX0LvaXUVuPzVD9/Db34zaHXnNI5eKheHT9RcsYAbC4Hgt6EpYI68IIjZ+iOlTD2eu2Nq
 4Fu4PI65nQSQ4SDFzRDOORIfri8Ux0CMWgp3bDF9XbOLKQMsS41mfFfDFmQYkBknJ8iVjUe
 gKklZZ2rhedKkr4ttk7tg==
UI-OutboundReport: notjunk:1;M01:P0:pzhw/USC/g8=;tQ47UCv+nv/T5CLa5cLEb2KF8Tf
 K9KghQ1EPbnw4JSDeBYzTiiRFALZ7JDAaXrv8HN10+kOi2YvsI34L8bJt40ZtjjEAqtRvfrcQ
 /noekWGp2pGrL9nNhGO+lcEyXJiKgskoUC63VZI8c6nYea90oupYIcToZ2LQLIqKPGdp0FyVl
 c5uJqesD29vLOHKexMdfTR9hJZ9doaxTQ/UyUYzXU/xm5xoQ/GoSAlqjqXO2n+vOUS2vBGGru
 qVz/EQGdvU+rJQbxnd49i9FMjzStKyB5z/pEHit1YFxyHF8tmCbKcqcNQ9ivQmPEBAsBoE8Bz
 BdybvyJHFUv34qiyK6lWVz5phg9m1EdVVZtyYMRDRkiWfxmWaa38o/pBHJwnTzah+uEMVj+qA
 mGV8LPEZrkt2zK1FYcVZ1U1P07u6YvwmIUm7GftJo/qWBXdEAwJ7G0w2ZGnctJ5dZlO+3NWYd
 tNSw7tTUyrlf/ovcn1VP9UJE3/gHT79z0PweVVCvVJg7oSE7DLQeQLfOBDMFLd2i2ADP5GaSA
 HSUa/DanGqrMQsY93m0WzbcHOd4zpz2KPvJyIy0rawhwbkaF9oJ+0j94LXdzluaZJCcilIKkP
 PXoRfzOvbf3MeTYS7yGSDWz7YAFQq6BS0rnrLTdN6atU8iTT+wxqN8UHvyZ7B++oZ5VfZThlY
 yL9apDDHECB3ww54W4Hfrxg0IvFLY7qvSmf20w6ZwDhCnaO9K5Mxp15Jw6MzRmC3GgNRt0OhB
 XoKGlEUFoukcepHz8aoO+zcDFOlZ/89F5Q3HmeHvwOcqchCYVGV3j0peBw2gaGye/WKiqwoI3
 YKSM5fOgfD7T1hu9qm3pne9suw2hfACwy5xf4yr2OZlyk=
Subject: [cocci] Detecting misused expressions with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1593
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a%40web.de>

Hello,

I noticed another contribution by Dan Carpenter.

[PATCH 1/2] iio: adc: ti-ads1298: Fix error code in probe()
https://lore.kernel.org/lkml/5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.m=
ountain/
https://lkml.org/lkml/2024/2/22/175


I became curious how good such a known source code search pattern
could be expressed by the means of the semantic patch language
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0073=
9-g68c580f1=E2=80=9D
for the implementation of a function like =E2=80=9Cads1298_probe=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/dr=
ivers/iio/adc/ti-ads1298.c

Unfortunately, I stumble on the following test result for another
small SmPL script.


@find@
expression e;
position p;
@@
 if (IS_ERR(e))
 {
    if@p (PTR_ERR(e) !=3D -ENODEV)
    {
       ... when !=3D e
       ;
    }
    ...
 }

@display@
position find.p;
@@
 if@p (...)
 {
*     ...
      ;
 }


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci show_questionable_PTR_ERR_usage.cocci
=E2=80=A6
No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* cod=
e, or you have a failed dependency.  If the problem is not clear, try --de=
bug-parse-cocci.


I observed that help information is displayed instead of a corresponding
representation of debug data if I try the mentioned program parameter out.

Will there any further software improvements become possible?

Regards,
Markus
