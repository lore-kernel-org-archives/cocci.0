Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9348C25B7A
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5sVhVm4OgNuLPDTDrqcvGk9ocMqD2VuXt2rOM1UazoE=;
  b=dbjzwxLVyeRj6ZrlMjYBQHAIm2DqzxGCVs2aejmtBB9foVXeDQTznAO0
   bQEICPbj9y9wlxQC/qD5gtrGmqtAx0YvQf5B9kJwaeeTnBU5N09njTrrt
   ZiPTNh7+hS/DONjX2FDXuE87mLU9dsC3XGhdMAYE8Ixw7HRyoTeTzcF+/
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
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166909900"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 15:56:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A48D6E0CCE; Wed, 22 May 2024 15:56:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A9FEE00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 15:55:57 +0200 (CEST)
IronPort-SDR: 664df96d_/nZjKGz0ReKLI7V4Omt/UlhkDuV4Ml8lbDdEjoG2k5+ZrvA
 Q2qFavzNkYJqRob09Xrzbhg/UCsafPrjtnMh7hg==
X-IPAS-Result: =?us-ascii?q?A0HTFAD7+E1mhwMP49RagQmEE3wGVDMEC0gIJYQpj0iBd?=
 =?us-ascii?q?YRrjwiMBz4PAQMBDTsGAQIEAQEDAQM4BoELQoIuRgJrh1kCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOBQsnhXQNgmAYd?=
 =?us-ascii?q?xd0MAIBAQEBAQEBAQEBAQEBAQEBAQEXAg06QgIBAyMEGQEBEScPCxoCJgICV?=
 =?us-ascii?q?hsBAYJ8AYIvAQMxBw0Gr2x/M4EBggwBAQaCZ9dyHywiV4FjAwaBGi6ILgGKP?=
 =?us-ascii?q?CcPgVVEgTyCUjE+gmECAoFeTYMOgmmWVYMlgieQD1R9HANZIRMBVRMXCz4JF?=
 =?us-ascii?q?gIWAxsUBDAPCQsmKgY5AhIMBgYGWTQJBCMDCAQDQgMgcREDBBoECwd1gXGBN?=
 =?us-ascii?q?AQTRAOBN4lwDIMvgXUphB4IQ2wVg3KBdg4ST4NQhS6BEIFHgRYdQAIBC209N?=
 =?us-ascii?q?QkLGwYiAR2kZ4M6gUEiLIFvxUA0B4I2gWCBYQyKIZUjBhMvlzkOBpJoiDWQL?=
 =?us-ascii?q?o12mxSBfCOBXDMaJIM2TwMZD446g2EzzARBNQIBATcCBwEKAQEDCYVGAQGDW?=
 =?us-ascii?q?oFIAQE?=
IronPort-PHdr: A9a23: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
 d1UbE5H6LGdv3swvw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:u3nfa6NYjlGZE8BcTh+jsMiBIKoaSvp037BZ7TEUdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwIk80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3A9/ROBmvS+ZJYCFfebnzQClsS6It9dHzS4yb1AHb?=
 =?us-ascii?q?jIkx5RK2nR3vJ54prxp8=3D?=
X-Talos-MUID: 9a23:h3MpYAiFMLhpmF5kb8ak+MMpNcRHzKeqD04xjpABlNmVFjNZMBijg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166909870"
X-MGA-submission: =?us-ascii?q?MDHN7EZskX9kMvAtzIwLNv8Tp2c8oMzfCmdZmw?=
 =?us-ascii?q?xcdp9LcZid6aV7XCMLvX3166fk4w/E5LCSCndPhFuGi6mmw6iphBA2Sm?=
 =?us-ascii?q?hsH2UcY3Wt0lVTcrXc6Bz8uW4y3K72Qfs9W6V8z3727G359bmSATb5jO?=
 =?us-ascii?q?Wz5GDCCBYyrr/uU10U8CI1Vg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716386156; x=1716990956; i=markus.elfring@web.de;
	bh=5sVhVm4OgNuLPDTDrqcvGk9ocMqD2VuXt2rOM1UazoE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D1qJSQSb9zDIGM8yzyQHGkTSl/uhnwSNVMO+NVupvd7A7vrSt2kfbv4ILHmINJuc
	 PfsPcBKLzuxuXps3ywg6gW4o6EFEwtk8tG37iFnGj9XxdgPBUWXoVQgdhZddEehjR
	 C9sHEknLwlimqXLeAJV55xoAYHdjs9Eu368WuUFu9acHoHwb9Xejoi/vpC+9e2o8o
	 nw5+ayqYL8IbuHvF68mdZqKtI7fB6IVlWOKqvlZT8uBAlpu6GuLk1YBV+2oDsAe6H
	 5cvrD1cXEh6qfK1AUGVSLuOARrgY+RcJ6Tzi8hN54DG6w7a08QmOtybQZ9egGssIP
	 G3Jr6JFS6tEFqpb/aQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgzaT-1sjdxp26Af-00hBjD for
 <cocci@inria.fr>; Wed, 22 May 2024 15:55:56 +0200
Message-ID: <4c2812f7-d54d-412b-ac79-c650ceedcecd@web.de>
Date: Wed, 22 May 2024 15:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <550803c2-45e1-4baa-b316-156ccef51390@web.de>
Content-Language: en-GB
In-Reply-To: <550803c2-45e1-4baa-b316-156ccef51390@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d9Rk9v5AA2pImHEX04Nj9HLMF/4EHmLh4OX4RHThVfeNx7WbSbF
 oIg8APjdK/6vl7taUhDMtvkMHQNohq1qd5Jvk+cj+vjJ59xpC0OEvh5Ypi1GlVPymvaZwPR
 X3/f98zNGoQDGtxOwG/YrDhLV/BQjL1mM8v6g2FE6rECQJpusUC2TnjrQ3AB3TIPwZ7LjS6
 Ct9TCi0Lwq4ZteuSz3y+Q==
UI-OutboundReport: notjunk:1;M01:P0:Zy8cEhaRI78=;cVHTQqqAulrC1e6M58ig2npMxKj
 LZsUOGMazZUO7w/iqRQ9lBQNXT277RfcmkalBT7u+9PRAX4cNWUTV1JZfi14acSVauQ3g11Rz
 02gYtTyUQKd8IPY6zonxL+cZcCq5p24FgFuuQXC9zIvEnbHcIN5l1SloFV7nzjbdqXMXu8wCI
 XBk0uSjEZWPEr7VRGWAeaX3y1fT8G9xBmsTMWab5ULU5TAyT/0ZiH389LRVZfi6jgtlmz1Jk/
 gVgfDSLLRFydWYpV5PU72WTXYd99HK5b8dLT1UIzGiAflBv8Es9BNK6t0EAVoahWW0xlRTG+X
 jWajzDqHb0LvYBlGv3latFmWXLxwVEliP89okVEwSrosE5E3CIhhlFjeQOVMkNWlu+/n8S69s
 4pUOjswUfwWLKPFj4A3iKt/tWmufD49yD2oAj3MYvc1qhPM6IYiI4f9BAZUxcsGVfIYQ7Jebj
 a0mH4vzGLo0pLByLUPnlmF3wKiG+KkKT6QA7ukSaDYmaYZadnh/e/gDKG0cLDQzvEjx8mNdXf
 gtWsbtuhV32vDhXOYDzN7Uc3R4e518NZ6hZVsVxfbXRPrXTuw762GqSg8gLdehJzd3aqnhurI
 cHtNvSrXHcOxjN35j6dl7+DkErbUt5onblVajM/Fg0+zCA+3yu06wBLvXTlz8v6uFCXMaXSeo
 Lu4GfVSz8x7F1e5lGDWMueDUotixCNMYi2WfbItj3Yw77caXIXZkSZHAAvwvmdBs2Z9RgOxGd
 1on8CM0O0+NN0fZ4HXoRIGNNdfyy7NfXcPiy6c3Y6Oi6m1CvDck+sTPeuozDkJHQY1UFvz/2U
 nPBnj2m6I9h1SjmKhc0l0XlE55ymCG/3EX1JdvRYKYBP4=
Subject: Re: [cocci] Analysing statement sequences in consistent ways (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1752
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/4c2812f7-d54d-412b-ac79-c650ceedcecd%40web.de>

> @usage@
> expression context, ex;
> identifier member;
> @@
> *kfree(context);
>  ... when !=3D context =3D ex
>      when any
> *(context)->member

The small size of such a script for the semantic patch language is helpful
for the clarification of data processing consequences.
Unfortunately, this source code search approach is still too simple.
It can generate diff outputs which need to be interpreted as false positiv=
es.

Example:
https://elixir.bootlin.com/linux/v6.9.1/source/drivers/ata/libata-core.c#L=
5941
=E2=80=A6
@@ -5897,12 +5897,9 @@ int ata_host_register(struct ata_host *h
 	 * allocation time.
 	 */
 	for (i =3D host->n_ports; host->ports[i]; i++)
-		kfree(host->ports[i]);

 	/* give ports names and add SCSI hosts */
 	for (i =3D 0; i < host->n_ports; i++) {
-		host->ports[i]->print_id =3D atomic_inc_return(&ata_print_id);
-		host->ports[i]->local_port_no =3D i + 1;
 	}
=E2=80=A6


I guess that such a test case points known software limitations
and remaining development challenges out.

See also:
Support source code scopes
2023-10-23
https://github.com/coccinelle/coccinelle/issues/322

Regards,
Markus
