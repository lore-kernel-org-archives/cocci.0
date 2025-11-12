Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8769CD3429
	for <cocci@archiver.kernel.org>; Wed, 12 Nov 2025 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=OFqSm89h8sNDV3YSFJHvJfgNEE/vfQLIl24ES28IqH8=;
  b=bWG/c14Ivf/r6rFKLUbScLQVU6n4JV3EEo8U0SKPVAfcL7MQmNebLJei
   flRhbbktGXXuwqOuPZvRneila+7JdJTQP4TXCwavD0rgooisvOnB9wu4x
   ezWikU/lMN5aqR0Jyx+hP2fNReK1V6a/nWBZ71t4AoBDnTOdW/gOYa4Hl
   A=;
X-CSE-ConnectionGUID: 5xvjpcGHQIOyfuissFVJJA==
X-CSE-MsgGUID: dNZhOrOyTUeSE0VoQjLSVA==
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
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="248828802"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2025 18:18:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2892E0B0D; Wed, 12 Nov 2025 18:18:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16723E0171
	for <cocci@sympa.inria.fr>; Wed, 12 Nov 2025 18:18:23 +0100 (CET)
X-CSE-ConnectionGUID: pLIjK6dbSpGjrMWLZAOBkQ==
X-CSE-MsgGUID: iDplNMT0QTyVgqWRv9VweA==
IronPort-SDR: 6914c15e_SAUN3q5mcc8OPcFA2VJ9x1ifx03evJuhkvhdzjFDlpTkPe7
 dTbgRjBbucVBH3XZqU9LXCp94sRxNbQYcUVU39A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EdBgCpwBRpewsR49RaHQEBAQEJARIBBQUBQIFQgkBlH?=
 =?us-ascii?q?QZYMwQLSQiETY9Thl+PEYh5g1ICDwEDAQ1KBAECBAEBAwMBggyPUQIeBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBQg4KMYZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAkdtHQEBESc0AiYCcwEBgn4BgiIBBhABAzYHDQavZ4EygQGCDAEBBoFYQ?=
 =?us-ascii?q?VDXdh8sIlmBZAMGgRwuhW6CShsBBW6KGg+BVUSBPAuCRzGDHwEDgiuDDoJpg?=
 =?us-ascii?q?iaBDoYnky+BShwDWSwBVRMXCwcFgWMDgQsyPDIdgSRBGHE9V4NJImgPBoESg?=
 =?us-ascii?q?1GJIQ+KRwIBC209NwkLGwY9lQuCAIFdGhMslXmzATQHgjiBZwWBXwyJCIEml?=
 =?us-ascii?q?T4GEy+XUg4GkwWIKpBcjgiVYIVZgX8jgVwzGiSDNk8DGQ+OIYQzgQu/FUI1A?=
 =?us-ascii?q?gkxAgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 sNmdw==
IronPort-Data: A9a23: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
 Pwhoofv5eURkAmoqSnB3ek=
IronPort-HdrOrdr: A9a23:WQ8rhazdQJYOBD1bLjEjKrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: 9a23:XhkBGm4NfyMcuR0sc9ss7Go1GON7fnfm1FjSOWqHLVRAb5eWcArF
X-Talos-MUID: 9a23:zCRDXQsBUBDpDwKxa82nhR16MOFN3/yXNFEznow5gdfVCzN9EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="248828788"
X-MGA-submission: =?us-ascii?q?MDHqap16y/FsljpnheWL+2JlrL50lbWOoHT9Er?=
 =?us-ascii?q?DzjrHZdNPf5+5ck2K4ZNbwDWmP8k6uwE4AAKD3M49qVWZaU+jXqkqetf?=
 =?us-ascii?q?lAHjoj1w8thsAyUt6yKaq8yjLD4WoXullnxdRjD9XqqgYnkRssbhKkgh?=
 =?us-ascii?q?rH7C/6HD2Bd+JE31FIejkdJQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:18:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762967902; x=1763572702; i=markus.elfring@web.de;
	bh=OFqSm89h8sNDV3YSFJHvJfgNEE/vfQLIl24ES28IqH8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qDaUYMOONvhoM4jinWDeHpNSu7DBshQUA2tXcyFQrwoLEMcpU0Hqrrnz6ivQ6NYV
	 7GcURVB4Utu5MGRAcZkQnMf/Ju9lJ3ONKbNZPzRgAngOcP+EWkSvMF+R6zQYoACkb
	 SxK/6zW4C7Sx4UgiaNjnjDWOglSfnNYNK6YHk1L6RvSws+VobuGxBK7SZ9wHM/MfA
	 SlM5g+zQ2M62ECERxIuKMQBd6S5L1BjAMUf9R3xD9yYHwFGLlZXRy+bjkpxjQWm2+
	 622RTmXC9/T716LqizNDj6OSG5aI2emAt1J7uNCdNckb8GJVYgREjhPG3GUSjh2ni
	 xgnYjDHxt8yybQJ9EQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pYS-1vGVzH3Zi2-00DQHQ for
 <cocci@inria.fr>; Wed, 12 Nov 2025 18:18:21 +0100
Message-ID: <a66f4836-8161-4d3e-b588-7990035ec436@web.de>
Date: Wed, 12 Nov 2025 18:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s3r0KII2n7+DSk/vAwXIAbdObupbQ/LcQGiouBzJrpWmYTEqzkx
 cn7cW/OInE5JK4pFfBZ9b+Cmb1WizwZkoGcGfxLdhZf/pyukj29L0FKtACAH+AbdZz0qNvy
 R9tbBHXRfWehbxDegaZuUNJtOrpcOPleTMn5ew5WeSO6L3rx1xh4CY6c+gWfK+zm7NujORg
 21INF2I6W1nrowHYyFW2g==
UI-OutboundReport: notjunk:1;M01:P0:huB7OWpJySY=;6fcRjV2pH6JbuAlvzFCcsybX/LH
 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
 a6WufR3Rb/n6XSzFat0+iYX2U3rEPbMzxFbtZw
Subject: [cocci] Reacting to negative source code search results with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3169
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/a66f4836-8161-4d3e-b588-7990035ec436%40web.de>

Hello,

I constructed the following SmPL script variant for further development co=
nsiderations.

@initialize:python@
@@
def my_notification1(id):
   print(f"The call =E2=80=9C{id}=E2=80=9D was found.");

def my_notification2():
   print("An undesirable function call was not found.");

@my_test_search1@
identifier action;
@@
 action(123);

@script:python reporting1@
id << searching.action;
@@
my_notification1(id)

@my_test_search2@
id << searching.action;
@@
 action(456);

@script:python reporting2 depends on ! my_test_search2@
@@
my_notification2()



Unfortunately, I am wondering about the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci test_not_finding_undesirable_function_call2.cocci
=E2=80=A6
meta: parse error:=20
  File "test_not_finding_undesirable_function_call2.cocci", line 20, colum=
n 0, charpos =3D 332
  around =3D 'id',
  whole content =3D id << my_test_search1.action;


The software documentation indicates that an exclamation mark (or not oper=
ator?)
should be usable for SmPL dependency specifications.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L81-103

Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
