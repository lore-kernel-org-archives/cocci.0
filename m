Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7968C3DA49
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rlg7ywsuwxPA7OJmKIo0gKxPtJwyGADKnSRC0lIJf4o=;
  b=A02G+D76ZqYzo9c9fs18Qu2YXi0z3X8sYDkLLyVFXPj/QWpsgsushwqA
   eJkbWUV+Dui3CBMy+jG0rynIYHB1rNFrqr9X0H5olZ/DCQ6KyPU6p0Ngt
   fILbz8IhR8fYG1ciF4rZlvJynuxZmxUC7CJDv6uPzW70XYn6OKwS6gjKS
   c=;
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177106869"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 15:15:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 648B0E0141; Fri, 26 Jul 2024 15:15:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 024A5E013D
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 15:15:28 +0200 (CEST)
IronPort-SDR: 66a3a170_wOpIPsV5sNZdhzkKRA1iruyb7UQYE7jp8b6PZlionakqazG
 mFck7Jnz4GFtKDYks+S3ZJTml6b+Hk1T6io60Ow==
X-IPAS-Result: =?us-ascii?q?A0FtCAA1oKNmhwsR49RagQmBT4JEYhoGVDMEC0iEVo9Lh?=
 =?us-ascii?q?mCPC4h1gVaBQD4PAQMBDTsGAQIEAQEDBDiBFD+CLkEDAok8Ah4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAToHDjuFdQ2CZwEQg?=
 =?us-ascii?q?RKBJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpGJx0BAREmATQCJgJxAgEBgnwBg?=
 =?us-ascii?q?i8BAzEHDa0hgTKBAYIMAQEGgmfXch8sIleBYwMGgRouiCMaAQVriGl6Jw+BV?=
 =?us-ascii?q?USBPIJSgXQBgVsCAhiCE4MOgmmIHYonhyqDVnwmjU6BTxwDWSETAVUTFwsJA?=
 =?us-ascii?q?gUQiWCDLymBb4QbCIFCg2SBawxhiWeBPoFfg0FLhWlsHUACAQttPTUJCxsGP?=
 =?us-ascii?q?aImhHITLCKVR7I4NAeCNoFiBYFeDIkBgSSVKgYTL5c8DgaSbphtjAKBeJVEh?=
 =?us-ascii?q?VOBaQI2gVwzGiSDNhM8AxkPjjgCg2EzhGHHKkE1AjkCBwEKAQEDCYVGAQGDW?=
 =?us-ascii?q?oFKAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:c1HpDqGsDycyuBL4pLqEMMeALOsnbusQ8zAXPo5KOH5om7+j5q
 OTdZMgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2/h1AV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4pgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHSuQ6T9RZQpRoBUdAY0+6VMHfiLqX8KTMtOaYE
X-Talos-CUID: =?us-ascii?q?9a23=3AuIqgAmlEtSO1X7052z2yjxOXEqvXOSDfk3nyH02?=
 =?us-ascii?q?gNX1CE7zKbg++0pN9qdU7zg=3D=3D?=
X-Talos-MUID: 9a23:+T4qmwv+OFVroJzj9s2npRM5aPsr2IKSN0FdmpgApc+hOXRPEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="93027594"
X-MGA-submission: =?us-ascii?q?MDGVHk71PkG5tuB/8n77dUjAw7KspIPVWEj0o9?=
 =?us-ascii?q?/E8j9XW1dwbwHlDulaoS+SsMv4n3VAw5nymhP1Ac2MAnEM/PxrnAkYnm?=
 =?us-ascii?q?8cpXghgZITLM3OQ+VtETjzirdNxBR+580iovEqGSphzVRx0+nC4P/DRd?=
 =?us-ascii?q?KsWFyoDB6ggp5TDfawabRpQA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721999716; x=1722604516; i=markus.elfring@web.de;
	bh=rlg7ywsuwxPA7OJmKIo0gKxPtJwyGADKnSRC0lIJf4o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rdzH9RUpar22JlCInSvPjqnr4IPvddPM8iCeVU0x/0kQ6KLsKzBbAAOMyiifIi1u
	 cWxCdE6sN7yZklxeYjzPg4hyv/qplHNL9rsK2GpgA2uoIS1bv6IfcQZd3wH0LfE/R
	 Owv5Jq/SQiagjWHDlgP2OiqMJhUh7O4sDK07apKGFH8ew+Ay8YepiapWWo+6x57uo
	 0kSU0qF+mj4soL1X70X1cq2bcpYBF45er00qDJ8iAbCz9lG9Go51QvcZsS9GyhMSk
	 LGAQhUCYN1e0upe3vvmc2fxZiMIaHOIe5z49zmmrzZLL9UZuSNMnMuq4tzr2mVtis
	 zscAE593j0SwxPULow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml46w-1rsTii1Dpc-00lmAi; Fri, 26
 Jul 2024 15:15:16 +0200
Message-ID: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
Date: Fri, 26 Jul 2024 15:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
Cc: Chen Ni <nichen@iscas.ac.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TIjH2r/L5c9BF1NAACx5RqNG/GpOzwq9d1tfxYYF5SuOmJ1wfyO
 vnyqpV5Q9xdsaWo7RAp6z50homolDOPc1AYk9gV8Z1Vnikcwk8T/8XJc7wbhxv+5zhaN5Ud
 1JttleiZCvSpd3/By9a8kqrHHfH/EuTlOkp1PAIkLnwVH4LPYMUUZ8qQ5EQohv9RUsDU0h+
 Ha6lfQI0gMMd6krD2PR2Q==
UI-OutboundReport: notjunk:1;M01:P0:m9/3cMO46ZI=;H3ZHd/sIJQm7Y6c9AcMCBNs8/v1
 Otcdv8ytPLS/IarD/Ia5i0Q7qtBjiV8REFuuXpTO87iIMAjGRqMGZjdmtOMjvtdKSj76wTJVU
 TLKuNSplGfsqgd2Mt02MkiNe2HRP0yplo0jZLXBvWhFrgil1u70aVpWwzlX0GgmQuAuERPple
 lgY9o4CsaDcQbM/606kuzYqCPuINHkSPWIJZN1lRvRyp9dU1Yt+SL+znx4S602La71FIQ+gop
 YxmT/QNWRWX7TvHgXYB5d4qi1c458O0zQejuvtteP+p3Z1wNaKu5nIr6bJ5+20G0ctUuVIpx7
 /NiuYXgqAHs5DJZvYxippOIN9CEhCEC+1Q/nDZCCUX7OcmlXQsfRhW1Vs4V46nYOAdYuVrp4L
 pczcueRI+TpSC4EjySqOVvYI4JPv7Un7faguKmXmQShWoXaGWZef4SIzc/G/ANAQy3mmhTYJj
 UXPytUq8Tk/8fnKhXr7Bg4PeRR54nOjyZEVXBHxgddiB//hZ91cLYNyLqPARXJDHj2tgJRzBC
 fxXExokjq8MJrUpA6y/bekCny2u+jVZHgXgpb8tGu3X0/x9gfULwM/LZ6rjs6pJA2hKXTU1wZ
 Z/wrbD03QI06GZ40kc+bex78wo9h7BpAgIxAp/inHUJmdWVoUOeZxyHPLXtTRwtU/V5k3vXyZ
 A4oxMspK7Jx7SXqQlFG1AgUVka/Z9pRT0LuYWaDurbqnko0N7FCXcNl9d4uVqRAM9j1ugnypq
 DYljGT8a/MJfs2edwdLaS+mNG6b7tYu9Wb+ATxKQx93yw9IpZYYMh/qxxjGas91QHMy/kr0+v
 aOj2HKvmbAFYrmWbymISPYfg==
Subject: [cocci] How to fix a parse error for another SmPL script?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1814
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/959b8771-76a1-4cee-a7b1-2b391deb23cc%40web.de>

Hello,

A simple source code transformation was demonstrated.
https://lore.kernel.org/all/?q=3Dconvert%20comma%20to%20semicolon

Concrete patch example:
https://lore.kernel.org/linux-kernel/20240724020721.2389738-1-nichen@iscas=
.ac.cn/

Thus I constructed another tiny script variant for the semantic patch lang=
uage.


@adjustment@
assignment operator ao;
expression e, ex, te, tex;
@@
 <+...
 te ao e
-,
+;
 ...+>
 tex ao ex;


I stumbled on undesirable behaviour once more also with the software
combination =E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=9D.

Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci convert_comma_to_semicolon.cocci
=E2=80=A6
minus: parse error:
  File "convert_comma_to_semicolon.cocci", line 9, column 1, charpos =3D 9=
0
  around =3D '...+>',
  whole content =3D  ...+>


See also:
Get the non-optional nest construct completely working for SmPL
2017-08-18
https://github.com/coccinelle/coccinelle/issues/114

How can corresponding software components be improved?

Regards,
Markus
