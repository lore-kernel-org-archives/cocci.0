Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2CEC76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=siJvlZuNQ5js6dtFygFeF5jPQ7GTNKHdUhotD7EiZyc=;
  b=CalO1edKK1oSdZjc4af+rcy/tuCP0mhZK41cE5qAjPW2qF7Qhy/jy8uS
   L12sF3tm1O4+7hd4ENXEQ/xHPACYMTN1QsV3CNsP+RMGQkTY9YNi945K3
   sP2mfBItNtek9reOIweIyQ7uITo4wmfhYPrCvnIC5NOZyleCLJKZhx3Jq
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99564216"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 17:55:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 092A9E0D41; Tue, 28 Mar 2023 17:55:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5CBDBE0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 17:55:14 +0200 (CEST)
IronPort-SDR: 64230de1_TZ1BKixFz74hDQ4NEKWZ/32080S9m6TEPab6o0S0x0iagNQ
 +zgcAjazNDOqRmtwPuyBBz6OT4lmFiz03KNqaSQ==
X-IPAS-Result: =?us-ascii?q?A0EXBADFDCNkhwQP49RaHQEBAQEJARIBBQUBQIFPgi6BS?=
 =?us-ascii?q?y8EC0aEU5EBhGCHLIc6iGmDFj4PAQMBDUEBAgQBAQMEgguILgIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoD?=
 =?us-ascii?q?YI3IhlkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1NmHQEBESc0AiYCY?=
 =?us-ascii?q?AwIAQGCeoIoAQMxB69CgTKBAYIIAQEGgmOZJx8sIlOBXgmBFC2HSB5YhEeEV?=
 =?us-ascii?q?w+BVUSBPIJMN4Rsg26CZ4EMgR2HVYQhikVqgTRzgSAOgT2BBAIJAhFrgRIIa?=
 =?us-ascii?q?4F8QAINZAsOcYFKAoJQJQQOAxkrHUACAQt1PzUJCyAGWGsCLBETBQMLFSpHB?=
 =?us-ascii?q?Ag5Bk8RAggPEg8sRA5CNzQTBoEGCw4RA1CBRwSBDXwKUZ1UgQ6VTR+SIZ4ON?=
 =?us-ascii?q?AeCKIFVgVkMiGqWIgYTLpcIDgaSI5dqIKI4hUKBeiOBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?YQMj0g/NDsCBwEKAQEDCYVGAQGDI4JYAQE?=
IronPort-PHdr: A9a23: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
 2AUm6Jlq7qN8WVHj/85F2ETthJY
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:5LnPcqvxXQbcUQ0TcvI/tOuQ7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99564212"
X-MGA-submission: =?us-ascii?q?MDFytpKYv1/dqMLHtBieYo327NSGWxXULU5cry?=
 =?us-ascii?q?FmMACO/JjLHGQPSqo6I/OkVSszz+1BDeiI97YRy7D7jehuRu+tI46uqZ?=
 =?us-ascii?q?9YVnvoWrrba3mtvliStrEgu7RMGNOB6lO95dtbihQW0RdRBSiGMWqVMU?=
 =?us-ascii?q?N5EcTq+UwgzcEsfW92cj5nwQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:55:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680018913; i=markus.elfring@web.de;
	bh=vCmsH3KPdLyoeuflnxZzTWb+Gs6FGe+3eLb9ddymLaA=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=VmTzyjQrn5rcmA/A/Z2s44jdzTevYFmY7KdpuAv/CdhNsGvxmXlYXZ1RVKt4z3Y4U
	 irxjQ4H9dbgue3z4N477GdGkdZJZi4SOI+PRNp516g4jei9USwoZKbp4kUO/83v2e5
	 ujDWfLzjiDQsrlwWisQwUKDIyEdCUYFiGQYUHgP29MBHNKB+UZljyVTmbq6CHA5Fru
	 Bpi2TNDiH5hmmg26euR0rNU+kbjSJQWIEF8D5PVYIewQNgbXgFxuAs3stW6CHwlp34
	 ASEQAWLc8V+l6KBKIWk4X8qqUkXknFQPXI5GJudYC9CiPmxcu/aQohLe/wtAhQKE48
	 pbE3K2edGT8MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1qa6XI2KZF-00tTIA; Tue, 28
 Mar 2023 17:55:13 +0200
Message-ID: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Date: Tue, 28 Mar 2023 17:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vMdJ/9psgFoKcJyE34mL47FDJz7g+Fvlw9zILUSIHdG3nToYV3E
 EPg3v6sCPQWmZruzI5/oyhhQ6tQGlNd0SieNBnpfH8+KAV/g58pz61J63G6N0r4GTH+GW2Y
 Hja9ADD11XP/ZKDrBj3WfHfJ4lZ5FP1p5vCJlyoZkTEGLJ3qmdU3e6RXEJWXuV2ZfVZvboY
 +acjCwLgrzSYP8Cid41OQ==
UI-OutboundReport: notjunk:1;M01:P0:wlEIJs8gV+Q=;pZSXmPocaCwpSVE7IMr8lvGIqk+
 qMX9b19KtIeleVOK1KLmLnhllC8GcaIx3zhhtkYpyEDnPnAEKs6ftGSqW03dyVmaMqozT7V1I
 Au6lkB+j348SBozeeW2Z/oSQnY3aybMDTEWdq1rq6QuOi28CrACwUlnqPfgK0GWrK9F2yvqJo
 cwHRJA7MJUI0XxvjDnx4H004UUL6MkddEDW1ftKIhjTxHz8S9CwLKqhwr4lof0fii6+mKA7/k
 X3Y0XA6eE3yQLXKg5wO68j+M9zLSD0vpq5vkIDk8qccm8wIxdwA9OjWaTIWT2660IETCggvwk
 Wdx8c/JAaa0Fmx80reUS45YdszUNzMmpQjGC1OUfWK3w0Y0HbuWm0tebxr9VgB0LwxMg1KVa2
 mW+MooJEPk/ugwnVc7zr94KXWIzCeAoNXfQQFv5hW5fpPS6AfN+ZB7rvtG1Q+9YixE8UradU+
 jaaFqGYnD3L5WMLkftPG+axpTdH1CYDZ01d1nJlOMir2UcEDzP+rcqfhfbucV3GFQtGYa0oC5
 BQ8C6XGQMnO9zEv5G5M4LGcEU2Gi9N+0jEkglY9HcT47EPiqnrLX+aV9h09Ae/qse6ZfeNVBa
 QKpHjebSQzTeF133u6jsoxac3h4P8cyvxDtosMjMSDzd/86O3LCetm0mkmjNZqjP3bKkFuYO1
 q6geaR/q1zzWfZX1B8g3nvkbVvR6SRsoSP+D/x8EaisyuhdAaYVrhET+0Mu2z4W/7SA9DhbE3
 3IniiF52b/EtkgDHKMFBRYd9AOhWpz+2JkUm5LTMsLQ3rqZHO4r1Kct8P7AFHjoZfsnwnURYB
 hpKa4QhEukY4Cogm/XESrLKiXhXVuJBFmEsoRJTRblBzIww3aNmrdTflYpgf7hS0dM2iWguAR
 FgEnp8/6LgA7oAXO0prqNy3U3ZoSGAloJ11eON6Ld3J7uacqEp+rohO5R
Subject: [cocci] Reconsidering kfree() calls for null pointers (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 969
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/6cbcf640-55e5-2f11-4a09-716fe681c0d2%40web.de>

Hello,

I tried the following SmPL script out also on the source files from
the software =E2=80=9CLinux next-20230324=E2=80=9D.

@display@
expression call, storage;
identifier target;
@@
*storage =3D call(...);
*if (!storage)
    goto target;
 ...
*target:
*kfree(storage)


119 source files were found where a check was performed for a failed funct=
ion call
and a kfree() call is immediately performed for the same variable.
Thus a null pointer is probably passed at these source code places.
I imagine that such code should be reconsidered once more and improved acc=
ordingly.

How do you think about to achieve any adjustments in this design direction=
?

Regards,
Markus
