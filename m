Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72478C83F26
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FRAbTTst32sWqoH9BmYPiIo5O2BJ/0ACQsaQy0aL15U=;
  b=F2u1nPql6d5zqEw9aBuSlXezdaWZIia2N5vJFw40ZOF+AQjArO6FXCaK
   Oz/5qjnEtby0jnr2PksjADnMVp70lQCWIgLXD2JkvbCYyyPTc2Ow+q/fF
   WsHA5gxEnwf7mOTe9y+WWTXaa4lfNl1cVuaNn2B69MIeGMDRjZJ/5aV9Q
   4=;
X-CSE-ConnectionGUID: CKa32hJpTXCo6NrDvRHnTA==
X-CSE-MsgGUID: C817wrE+SJyljZcSRxreYw==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233025533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 18:18:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 21B50E0C55; Thu, 24 Jul 2025 18:18:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1654AE0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 18:18:20 +0200 (CEST)
X-CSE-ConnectionGUID: SvrQtOBlRLeojsIavP+72Q==
X-CSE-MsgGUID: R+jAcEmTS3ePuQCh3KZ0gg==
IronPort-SDR: 68825ccb_vf/aICc5NN9li4+X4/IxdjqP2y9cUAP7WO5nxviKCGqzMGP
 AY+te30COw/x2rL6MW9QzZOkUs34BrMfp7c6tBw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWAACHW4Jog07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgQZUMwQLSYRViByHNIIkhDuHPJBOgVWBfQIPAQMBD?=
 =?us-ascii?q?U4BAgQBAQMEggyCdAKMFwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEhGQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?kdEAQEBAgEjBBkBAREmAQQLCxoCJgICVgYBFAEBgn6CIgEGEAEDDiQHtkV/M?=
 =?us-ascii?q?4EBggwBAQbaXh8sIlmBZAmBGy4BhWyCZAGGJ4NCeicPgVVEgTwLgQmBbz6EQ?=
 =?us-ascii?q?4NbgmmCJoEWg2WNBogyUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNg?=
 =?us-ascii?q?Q6EKCtPgiJ1gXlBGT+DUx4GbQ8GgRgaSgICAgUCQ0WBSEACAQttPTcJCxsGP?=
 =?us-ascii?q?ZMWhwAplkauYoEKNAeCOIFngWQMn2sGEy+XUg4GkwWZBiKjToVRgWg6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIQwNCYQRvzBBNTwCBwEKAQEDCYVGAQGKMYFLAQE?=
IronPort-PHdr: A9a23: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
 AYUh6z1J8IfO9+js6SNQkZ3lsLGFhiJNe0=
IronPort-Data: A9a23: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
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:X6bd860y82rIC7CDRX/MUQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:ZUjLFmy+ubcpH645NM/EBgUvBNocblr3yE30Lki6EkdgVoXWFgWprfY=
X-Talos-MUID: 9a23:+nnfVQmhcCu6Y6l/GfPAdnpYd8VB6ImrNHtWnK0bguKEbg9CYziS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="122135623"
X-MGA-submission: =?us-ascii?q?MDGFsGXcPDbHF5PFJV88MaiwrDcgwjxfFN5jqQ?=
 =?us-ascii?q?ophk0JpPeO9IGTs+pvfOj73QeG0Va1zgn74jnbW8S1mzzhXVUWcXH1cQ?=
 =?us-ascii?q?2Rzurm47aBvk8omGICJ1x+U2NW34/FWCiFh8AhFcstcBQzE9HaxCMCDk?=
 =?us-ascii?q?E6e8YLx4PxAX8Eh6mim0IgXg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 18:18:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753373897; x=1753978697; i=markus.elfring@web.de;
	bh=FRAbTTst32sWqoH9BmYPiIo5O2BJ/0ACQsaQy0aL15U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J0neGcK/WWvYj+311qbb78aarsMdPlRnis3oVkqGHF4ivQU5F+OvkcRq1KtwyJt/
	 lkeDfoxJFqQbfzocUmG182h73uPSjqUcDBYjPI9HQKySrQMY/MwYhmObkQCrIWMXi
	 yLB+6ml3FdIwnTFwktlDlhqyrcAtlso8bKngii17/r6IcgXrohBSQHEAHI29SIgcB
	 JudzDs8jCjLOPEdYiDwGACaYAMI21yMctGaUlSt71Pt01ds74rn9hbIQcC0bpyWF5
	 ACRENVPaOEPBthTlTRogLqxaGFwTZnKOARVVKkblpLCdvIl7MPmhZE6e66vTBzgHE
	 gr8Nhv5Nrbs0sTpsXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1ur68b3BXQ-0036Mc; Thu, 24
 Jul 2025 18:18:17 +0200
Message-ID: <a374542e-3ace-4e02-8715-d15ed9afbab1@web.de>
Date: Thu, 24 Jul 2025 18:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qz+1JlN6QNz4ErCfgUJVJxHXLdmon4ADyJeKnkxgCkv6G6nz9Dk
 8f8FFlkWq5I+2OJP90jqoWjouXuQTjmGiXNuYcL8FU/hEVrVkk+lNBVFP6p42tlNZnnZIbL
 7F/sSq2RdmR9h4kgqaJsf39B9EWFESOe4kHrFF6RO1JGinlVrNyOk+BXowwDS23DvX7ICgN
 0LBtDQyDnWHHSGVq6cIcQ==
UI-OutboundReport: notjunk:1;M01:P0:YVxyX4Q3FxU=;Z4ei8C6EfCRwWdSoBBLcJC3O5XO
 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
 vl0zoVlAobcH+4y/9untcxJuIS5K5oF7/Eu
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2914
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/a374542e-3ace-4e02-8715-d15ed9afbab1%40web.de>

> I would think you should do:
>=20
> @r exists@
> expression x, y;
> position p1,p2,p3,p4;
> @@
> mutex_lock(x);@p1
>  ...
> mutex_lock(y);@p2
> ...
> mutex_unlock(x);@p3
>  ...
> mutex_unlock(y);@p4
>=20
> And then use a python rule to print p1, p2, p3, p4.  That way you will k=
eep
> the different matches separated.

Will the following source code search approach trigger more helpful
development considerations?


@find@
expression x, y;
position l1, l2, ul1, ul2;
@@
 mutex_lock@l1(x);
 ...
 mutex_lock@l2(y);
 <+...
 mutex_unlock@ul1(x);
 ...
 mutex_unlock@ul2(y);
 ...+>

@display@
expression find.x, find.y;
position find.l1, find.l2;
@@
*mutex_lock@l1(x);
 ...
*mutex_lock@l2(y);


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch --no-loops ../janitor/show_questionable_unlock_call_order3.cocci qc_a=
udio_offload-handle_uaudio_stream_req-excerpt-20250722.c
=E2=80=A6
@@ -70,7 +70,6 @@ static void handle_uaudio_stream_req(str
                goto response;
        }
=20
-       mutex_lock(&chip->mutex);
        if (req_msg->enable) {
                if (info_idx < 0 || chip->system_suspend || subs->opened) =
{
                        ret =3D -EBUSY;
@@ -103,7 +102,6 @@ static void handle_uaudio_stream_req(str
                        ret =3D prepare_qmi_response(subs, req_msg, &resp,
                                                   info_idx);
                if (ret < 0) {
-                       mutex_lock(&chip->mutex);
                        subs->opened =3D 0;
                        mutex_unlock(&chip->mutex);
                }
@@ -136,7 +134,6 @@ static void handle_uaudio_stream_req(str
                }
=20
                disable_audio_stream(subs);
-               mutex_lock(&chip->mutex);
                subs->opened =3D 0;
                mutex_unlock(&chip->mutex);
        }

real    0m0,197s
user    0m0,172s
sys     0m0,024s


Regards,
Markus
