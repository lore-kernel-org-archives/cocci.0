Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B92C3DA7A
	for <cocci@archiver.kernel.org>; Sun, 25 Dec 2022 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FnL0XTLESfUr1zBfL6lHIGwippJO8Tgisdq/UTGAhfA=;
  b=YmWASivSlEnETQyNKwRnd6AMEav+9a4vOBZdJSdb6oVnzuIgvA0wQCvG
   97AjM45k3Ck5Tyz2JIvd1S1IcUVTIE2cw+qJ37mOETUfWS99r1IYrwjUd
   nK6Rd6dG9k3utKClgvc69EOXDOq932Lw0O8L1B5c0xpaNXcwxM74N73k+
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,273,1665439200"; 
   d="scan'208";a="85013918"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2022 17:42:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F384E0145; Sun, 25 Dec 2022 17:42:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A3812E0128
	for <cocci@sympa.inria.fr>; Sun, 25 Dec 2022 17:42:38 +0100 (CET)
IronPort-SDR: 63a87d7e_qZekbrqJVhWt0WQH8WR1KPWJlTYaI3k8PexxT1ggh9ZmMyv
 gXeZa6of6nxnz/aFgyNMjXjKf99vEKcdD6owDhQ==
X-IPAS-Result: =?us-ascii?q?A0EqBgCmfKhjhwMP49RagQmDfIEHVi4EC0WET4NPiyuGU?=
 =?us-ascii?q?45WiGKDFj4PAQMBDT0EAQIEAQEDAQIBgguIBAIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI4IhlkgQcBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDToYO?=
 =?us-ascii?q?2YdAQERJzQCJgJsCAEBgnoBgm0BAzEHDLBWgTKBAYIIAQEGgQY6AYEimSUfL?=
 =?us-ascii?q?CJTgV4DBoEULIc7HliESoRPEIFVRIE8glODUAEDgUxfgwqCZ45mgwCGTW2BP?=
 =?us-ascii?q?XyBJw5hJQQOAxkrHUACAQttCkE1CQ5LKxobB4EKKigVAwQEAwIGEwMiAg0oM?=
 =?us-ascii?q?RQEKRMNJyZrCQIDImYDAwQoLQkhHwcmJjwHVjcFAwIPHzcGAwkDAh9PcAIuE?=
 =?us-ascii?q?RUFAwsVKkcECDYFBlISAggPEg8sQw5CNzYTBoEHCw4TA1CBTgSBDX8KV5prg?=
 =?us-ascii?q?nlhIGCUO69nNAeCIoFPgVAMiFWBIpR4BhMulnYOBpIal0aNRpR6OYUFgXkjg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OOYQMgQuDG4YGQDQCCTACBwEKAQEDCYVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:ZWWmla3lS+pwCJQiB2bdGAqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,273,1665439200"; 
   d="scan'208";a="85013917"
X-MGA-submission: =?us-ascii?q?MDESD8AVZ6TXtXzVM9R8FugclTn6UKLE6Un44K?=
 =?us-ascii?q?9+bqIysmth+agd2Xz92QBsH8jGc2lKXs2eDtDrfAzoTSkASmGLG11rtc?=
 =?us-ascii?q?cbVxtXq8Z6PJKZgEhYtWCNYgDg9vTcNMeMWnRA8lD/VgfUSX0T1EymLE?=
 =?us-ascii?q?xhGxl0wZxqfQ6NnIQnsJwC1g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 17:42:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671986557; bh=FnL0XTLESfUr1zBfL6lHIGwippJO8Tgisdq/UTGAhfA=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=vUTlPdD6Mvzz9xFZo/vIEQPLzFfkiJMr/tbP6Q/vjLs8CyWQKA96Kq/mnV0bwhKEQ
	 yrb+KGnXeErBaHLorDqB3IjtlhK/gKfwR/07c08tVzSPWryak+aGDY5rn4/FtKV1yQ
	 hnfGsSK4Ilh0UxKDvlQSHoG0IL8aCFqml+oh2XImSAiMhMlTXxMfj+DjV3vsFndYzU
	 e68nlIw/oP2aB9Z70K27jVBBzYobFzpC1Vh+8QSNk/lWAGIB8JurWm8YPRFg9rw7s+
	 QKlUdZoW3OHhrcPeXmpHqVJEnCul2hVIl4TNfN9cHElt2VLYlY5CSXlb78TUh0/6g3
	 eXAZL0UcOw2/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMXx5-1pSw4g2A0l-00JKqI for
 <cocci@inria.fr>; Sun, 25 Dec 2022 17:42:37 +0100
Message-ID: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
Date: Sun, 25 Dec 2022 17:42:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MzQKjkVwaCn8YWy/6BEdQR2fE2WcgFxd6LzUGfr2IYNayRWfx/6
 LNhO2dEfNeJb9AjVUfmFU1a3npUQSDBEXo00qPIobbPoKpnuo3cB+1AeCyGhkU28BCV8fy3
 cIzgY0ZfENfoGZj1BCQdowqCtLe2FJBTB3J5q9rvtAseu77OfYYcArKSETC5tdZPmJmwp2Y
 udn+QtbmKYF+NhPG3aj0g==
UI-OutboundReport: notjunk:1;M01:P0:mhLVrL5McCM=;+xKfGXjhSCUodRUzH+KA731rscC
 U2maKcWaUkDnqjb126O2zjZRMamSLsjB3BQrOHKsjhQTXrlS4KkRbBrwFBKRBKkArpo3OLVyb
 m6jlp5aqeWgww7qfsLUBWhWKaO4HqpMvYpmysBp2oCWmGHP7AstBwXpAs0BFLagKrCYXsneNy
 KDlnKBRCVfaSY3gOrgbwnevCPHXq+ob/8+UfdBAFGLxkvj4rZRz1WDdCzXm4Oy7mtrLGd21OX
 qzIvgViwVL0sApoDuOETC+PTWbrF27lXAIBkRnFxeayVosuDuCPigoZ2MkX+HN57rna7P4JbX
 +2XEMYMcUpiT7VpnsMhcSaNFaFyNHlM1ZcdS2cjntJ8J3VxwkC+6sEf0FSYvVvKzMXVSWUpMn
 DexbZy8ym/cCBQLy19fDZf2DR7OK9LM650xfgqNZvHJJVPJyQUlSIMW1z9VSNLa2mWfqQmP78
 BK4ZA9VTehkud1su6XDQjEUz+in1PWD+ElC1nAmcGTxaDLeMcQPXuFWwKzUNv4m+zjmZ+2oja
 o3eNffBvaG3VNYuxV0M7mNOvtwcvokh18PnVUnz/qQk7m2EfB38Y1nXowZZIivLvgCzQg73Sm
 jSKcyLX6WEkHR0UDRLfppc4ZxFX4vn/owvyovD8jOSnAvhIx6DOIglstF2yqjPQ+9jgZz5Lfw
 H9YxWAnrE7+N78SryneNkpT0acdQkseVovdxhpPYY3RAAN4wWBbqamizs1Cq7iXxBSJog+3Aa
 xqRlwTk9HjOCBpdo10IrMEE8X8euGv7MHtiLu5Ac1xAbfd8VlSguhlTfnUBZiC+lt4C+6zKBT
 OHhB5Ajw49Ln7AnBSAI34x4utMt0h0azjCMsye3C3vX+4T7UDCA68lL0NLjwrkmkjnRgwCt9p
 abx8msumAKOBWI05dT7iSwnVzLiHfwI6HCy4UsWwhD4MjR7yEx3S9g3dkiWGUX09juMd6TJG/
 AzEeUPDkrrZDuIXSBZT4NuGoYoI=
Subject: [cocci] Transforming source code according to the usage of a
 predicate
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 784
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/7da2d07d-c1fb-1a58-8b57-3d1248f70c87%40web.de>

Hello,

I noticed a suggestion in another issue tracker.

2022-11-25
Detect if/else branches that only differ by condition variable
https://trac.cppcheck.net/ticket/11402


I tried to construct a script variant for the semantic patch language
(software combination =E2=80=9CCoccinelle 1.1.1=E2=80=9D) accordingly.


@replacement disable neg_if, drop_else@
bool active;
expression call;
@@
=C2=A0<+...
(
-if (active) {
=C2=A0=C2=A0=C2=A0 call(active, ...);
-} else {
-=C2=A0=C2=A0 call(!active, ...);
-}
|
-if (active) {
=C2=A0=C2=A0=C2=A0 call(..., active);
-} else {
-=C2=A0=C2=A0 call(..., !active);
-}
)
=C2=A0...+>



I hoped that an isomorphism can take care of special compound statements.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15a=
f39865329c2fe23460d/standard.iso#L523

Unfortunately, I stumbled on information like the following.


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi cppcheck-11402-suggestion2-20221225.cocci
=E2=80=A6
warning: iso braces4 does not match the code below on line 7
=E2=80=A6


Will the chances grow to simplify and improve the shown SmPL code any furt=
her?

Regards,
Markus

