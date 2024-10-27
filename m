Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4B0D1356D
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cYjICQTh0228BKKk2/zh7tn4TkKvinw9ps+oPc00314=;
  b=cJPu67Sc4z+n3OEuHKWTM3UZaJ5IynjvTnI8jMQMIadrjL2KCag/7+Kv
   NShKAehi1zj30vNRH3EoFDpF4uzZ0Zj3dcVKBYS4tjVG9pnWmaX2HezMh
   kbSIbzwOGmvQr+/EwDNaJJDuyvOlWqYw2a3+fyX9z6TaoQlcqs7SZABnz
   0=;
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190927656"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 17:40:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 714C6E0D1D; Sun, 27 Oct 2024 17:40:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5ABAFE00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 17:40:45 +0100 (CET)
IronPort-SDR: 671e6d0d_a/ciqxPlSFHfhtOYIQN+BjPBkRdwxOLibntnsdoPZ8xuuct
 FD5Tf22yEqYlo3uRU+Q30w4WzBhW5nZiCwx+q+g==
X-IPAS-Result: =?us-ascii?q?A0FgAADVax5n/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDB1sbWjMEC0gthCmPTYF0LYQ+jw+IdYFWgX4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDAQOBSYM3AneJMAIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAoEKCAuFNUYNgmIBgQkbdAEBAQEBAQEBAQIBAQEiAgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CDTpEAgEDIwQZAQERJgEPCxoCJgICVgYBFAEBgn0Bgi8BAzEHDQavM?=
 =?us-ascii?q?X8zgQGCDAEBBtpbHywiV4FjAwaBGi4BhWmCYgGGJINCeicPgVVEgTyCUjE+g?=
 =?us-ascii?q?mEEgV6DW4JpgmOHZiWIN2qRQVJ7HANZMgFVExcLBwWBMDIwA4R1W3+BO4FTA?=
 =?us-ascii?q?UaCZkqDSByBRQU4SYJNaks6Ag0CN4IkJFmCUIElBAWDOoI5HUACAQttPTUJC?=
 =?us-ascii?q?xsGPZpqe0eCRhmBFSwggTqBIMU+NAeCOIFlgWMMiieVLgYTL4QEkzsOBjKSR?=
 =?us-ascii?q?ph3Io1clROGEIFoATuBWTMaJIM2UgsOD44hg3ozzBBCNQIBOAIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYsxgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:nJ/V7647A9twywEeWLW6bgxRtPnGchMFZxGqfqrLsTDasY5as4F+v
 jdNXG/VP/vbYjTwf9txPYni9ExX7MeHzYQwTAY5rn89Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtawr414rZ8Ekz5ayo52tB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj6+ljB2ozJqAcw+xQB05fx
 cwBdwEhdSnW0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/HtacGeOTtIUeg2dYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8QPN9PBovTWKpOB3+LjXNNzYe/CPecZYvUuk5
 V/ixmWiLA5PYbRzzhLAqBpAnNTnmSrkUYYWPK+58/RwiRuSwHYSAVsYTzOTqv6ygU+WQMNaM
 0VS+yw0rKF0+lbDZsfyVhiyoXOelgwdXtBKGqs77huMw+za+W6k6nMsSzlcdJo5ucVwSTFCO
 kK1ou4FzAdH6NW9IU9xPJ/Nxd8fEXF9wbMqDcPFcecE3zUniIQ0kw6JUdtpVqK45jEw9fcc3
 BjSxBXSRZ1K5SLI60l/1U/KiXSgq/AliyYrsx7PUDvNAhxRPeaYik/B1bQfxelNJsCVQzFte
 ZTCd9e2tIgzMH1GqMBBrCjh0l1kCzZp/QAwWWJSIqQ=
IronPort-HdrOrdr: A9a23:Dvpiw61uNBDQtT2uYGhJ1AqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AHhZAaWowKBWt+I3T5j6ELsnmUdwoeVbY11rUGkW?=
 =?us-ascii?q?fD0l4eI2MFm6845oxxg=3D=3D?=
X-Talos-MUID: 9a23:BezHjAkTXSjnTzNhqfo9dnpiDsNu7qWCDXwOnLYLh4q5ERVxYBmC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190927651"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDHo7FeOBe95XOQwZEhVRaPru4wxSQf9g8GSwR?=
 =?us-ascii?q?A3gD6PEpvPMDbYz60TL9xP3egmKOY9VYnw1e6Vrt7KGegNLFH5ddEoVK?=
 =?us-ascii?q?wcg9jyt18F/ODJ1oDCfoXRLEj7RramxTGd0M2TEmprTAzbVl+nlQjiUp?=
 =?us-ascii?q?jnowqZQdn9+PzMDwYVF2gFBA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 17:40:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730047234; x=1730652034; i=markus.elfring@web.de;
	bh=cYjICQTh0228BKKk2/zh7tn4TkKvinw9ps+oPc00314=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t0sKIpbaB5FuHxKrnyRdNxMODujB3qlE3fh9BQGNU/wGD3MtY33ZizRgqG7YCAAU
	 GXdioSqL3Njx4eWKtlHbmNXnwYBoOMv/ppdCf7nqBSlOPtX3FIthWcemThU+/zctl
	 x+lzw3tXuKmJFGcvKWW5LiNsCZJ0EtaQnpUyVhv+BkwvnWgwjzKuAjsy2Yzsormsa
	 tohliBji1IMLSzdO21xufRWN7FUZF/NUVFcOtGVVmqnjDcmHsMitJwZ3TNHgSMR4W
	 8uTkZTo21dWU2Ny/ghJMsPyae92yEWM3JZbPCzfH6if1nN4XUZRXlO1K6Y4YwsryQ
	 gc/QS4RuWLkrOMmJbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1tJsJU0WiY-00YyE4; Sun, 27
 Oct 2024 17:40:34 +0100
Message-ID: <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
Date: Sun, 27 Oct 2024 17:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/J5OOFThfpJboCq6Wp2YwbJ1wxHFqSHUGtevTD5TfZ8GdlmgFqo
 Yvn9blRuP9f4osg/rsSVOk5L2ld/s5bp0ic2i6Q7KLsE71IqYXR7Fb4b1mJ712cJ4i6VLpG
 sqap9/DjSZE2J6ZBky5W18WWqQkaW9TNMAMDkunA2Yj90lQVSWI2BNZKMRJfOwxiW7zB3Yo
 RkVrNEOSeUuw6odgcMt3Q==
UI-OutboundReport: notjunk:1;M01:P0:rx4YNFg4nnU=;8K7b1CZ6pFV/rMsPr18deeL9aDG
 3hh24q7qN1aT6lm7btMFjlHi36bxZrhjT9JekKhuiLxrg5iWsHh5pcgCYW6SphAAGSoDJhoTN
 qxGfBHgEjfblAxPh29rgApQweMVwO+8SfVq47ZPZR/buk7wwRSp0BI5BOlFLbMBAULR+G+axf
 1C3WbMmdt/SCbNVdHzlV8SuzhVRsn+14ZLGMU6xDIh53j2VGGl9q+GVxP/HEuUHZYobftTWVk
 JNY2MJKyIeHmPWYXifhTRRqoxf/C4u9KrIIyb4Z8iZ0DEX/Nl+YO8io5Y2bkQS5Jq5rlaouyN
 +gDd2/HSiW0Jz/y/3a5YXOS6NMvYF7VM7Z1qDQI8j6xpI2wGMLXyFz4tefzGw3bCJRhnMA4kB
 +onF3YXebEZ4uhQAX7R1sLTQAbn6MzxVyTBio7zUMx0wmwGL/b+Cx1ESVYL3DNkO9HR17DLbd
 LWy49zikN9Uoo6Y0VHIqaP3qm6W3W/d06a0zgm42fc1h6/+UYDTKtrWv06ds5GwgjOXamY2vn
 DQzpe7tG4i0xNVWZukpMhVYulZh+fKugMt2pkhaywjOzMPE5D/DJHGwmPtbp1d9OPm5yHl+Zh
 Yt8hqMWUFaEbm9MN2ENZc0hDnAfvEwebC9VUm6WL82Fews9gxehy/7h4MwlD7wUZ0hQP5LFC1
 JV+xDGycT2p3uK7L3LKZnCdR4nmCftJPU2jbUABCJ8Bfik+owTa8VZd52ergAX3y6gPdDObFV
 SY9147fsldPICk21oRyn/VsY0+nab3tCv8I+q4q46HIHpNmn/M0xZXe/ghy83B8yb3hIcaPFG
 PmxfY51hIWHjofwgm1m+GE8w==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1946
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/80d4b3c8-f29d-466e-b9e2-15f2c78a2f74%40web.de>

=E2=80=A6
> If you could make a semantic patch that doesn't involve 30-some lines of
> python code and would provide a minimal test case, then I could try to
> understand if you are concerned about the same issue.
Can you find another example helpful for achieving a better understanding?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_function_=
implementations4.cocci arch/sh/drivers/pci/common.c
=E2=80=A6
-> duplicate data
file:
arch/sh/drivers/pci/common.c
function:
early_read_config_dword
line:
36
=E2=80=A6


https://elixir.bootlin.com/linux/v6.12-rc4/source/arch/sh/drivers/pci/comm=
on.c#L33 :
=E2=80=A6
#define EARLY_PCI_OP(rw, size, type)					\
int __init early_##rw##_config_##size(struct pci_channel *hose,		\
	int top_bus, int bus, int devfn, int offset, type value)	\
{									\
	return pci_##rw##_config_##size(				\
		fake_pci_dev(hose, top_bus, bus, devfn),		\
		offset, value);						\
}

EARLY_PCI_OP(read, byte, u8 *)
EARLY_PCI_OP(read, word, u16 *)
EARLY_PCI_OP(read, dword, u32 *)
EARLY_PCI_OP(write, byte, u8)
EARLY_PCI_OP(write, word, u16)
EARLY_PCI_OP(write, dword, u32)
=E2=80=A6


Regards,
Markus
