Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5919DC47422
	for <cocci@archiver.kernel.org>; Fri, 26 Jan 2024 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ZI2Mwk4WsdSVTz0GjqMya3i0guxtGQrBEytwXv12jVc=;
  b=sEXoEF9B5EvaIlE5pISyxs1q/WDSV856a/SKQ3+HiC2ym+TTwzCcmzI3
   fmp2ZKuq0X0gt68Rrzu8NGVcT0/jPEHIkq8ZGiQlWUIdkyB1XgD3ocfxx
   3tn8IMKlpDPnHplyVkTDq4iEK6tn7NSf5HrPAkqbsOamDKHjXvwdlobnD
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
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148813934"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jan 2024 13:50:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09B0EE008A; Fri, 26 Jan 2024 13:50:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ED434E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jan 2024 13:50:36 +0100 (CET)
IronPort-SDR: 65b3aa9c_5qd/dkhSOmD1dgmp+hWvZx6orl5/lTmf3gIMrw5BsgNEYvn
 NevgpYmDSGF/7fYXuWdRtXs0Ot5vDgEpWeNqrHg==
X-IPAS-Result: =?us-ascii?q?A0ECEgCcqbNl/wwR49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?U8CgjcHdVYRIQQLSAiBRwKDAo9BgXWEa4FVjS+IcIFWgUA+DwEDAQ0UAQEGI?=
 =?us-ascii?q?QQBAgQBAQMDAQ2BfopAAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECgQYThWwNglUYgQyBHgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAg06ax0BAREnNAImAnMBAYJ8AYIqAQMxBw0Gt?=
 =?us-ascii?q?XqBMoEBggoBAQaBV0FOrHQfLCJWgWEDBoEaLgGIBxoBBWOJYQ+BVUSBPIJSg?=
 =?us-ascii?q?1ABAQKCK4MOgmiFXYEoh2JhgkcBhlSBUx0DgQVvGxAeNxEQEw0DCG4dAjE8A?=
 =?us-ascii?q?wUDBDIKEgwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCECwmAwMSSQIQFAM4AwMGA?=
 =?us-ascii?q?woxMFVBDFADaB8yCTwLBAwaAhsbDScjAixAAxEQAhYDIhYENBEJCyYDKgY3A?=
 =?us-ascii?q?hIMBgYGXSYHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iDSgQTRAMQgTpgAxkrH?=
 =?us-ascii?q?UACAQttPTUJCxsGPQKYNAGDH1l7lGGxfjQHgjSBYIFhDIh2gSOVGAYTL4Nyk?=
 =?us-ascii?q?zsOBpJZHpg2jW2VN4VKgWM9gVkzGiSDNk8DGQ+SGjOBC448QDUCCTACBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 GokG6uohqKd52VUj6cnc1E=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2VaVpKy4l8OiKeiUahiAKrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AhNh09GkKPu+//oKOSge1j6NxSG7XOXv74V36GBX?=
 =?us-ascii?q?mNX5Gd5S4CgaW1LtmvuM7zg=3D=3D?=
X-Talos-MUID: 9a23:SmXClAXLyDU22Qjq/DPAiSpcZIRV2o2jK2MMvbEkq5W0CzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148813926"
X-MGA-submission: =?us-ascii?q?MDHO3SHF+MoTOxw9H04yizqsX/bl2yWMWetQU9?=
 =?us-ascii?q?QGmIvq3z3ytC187LgF/9xPibECqR9dsqHsvX6rjiDRNF0YacWm4U2PdL?=
 =?us-ascii?q?TAnFAIS9gqQTDwWcylOCeKqia8Ejv5Woy0/tCnHrW0oDID4PjrjCM0ZQ?=
 =?us-ascii?q?ViJ+CPyK73r1slfqtsD4i9DA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:50:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706273427; x=1706878227; i=markus.elfring@web.de;
	bh=ZI2Mwk4WsdSVTz0GjqMya3i0guxtGQrBEytwXv12jVc=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=hSbzmgd2YZLx6+pIAJ9UdW4KrpNFoInXEQ/pF9BPMcFwVSkkigMvoDLhRmKM2E5a
	 a8rBJDmH2UzEKq82HbIPcAc0byGsQ0otNFYaHdGjTHjEhkDqZ9otgAWAs1izrXvAN
	 0b7kRHi1O+guXctTerNOFQJGVYUKO0g2pQO3Jinv9Efa/A0n8t231CpLlGyInJZJX
	 zVSnA3t7PcXPRaiuApFl7m5AlInHnZpLMSbNJpV/iMY1f1cT6tHbQlMBi/SaAvAfP
	 lWaALaX/DKOyEzFT7PsfgfdG34xr5xpWQeTLMP2V0F7ZUsquL1mdfF/pPUnbe1eJw
	 E4L3H82Rq+E+rv9Eeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Va-1qlB9n3GQi-00iNGO for
 <cocci@inria.fr>; Fri, 26 Jan 2024 13:50:27 +0100
Message-ID: <8a6c0b00-c65b-4c83-afd9-4023132a4183@web.de>
Date: Fri, 26 Jan 2024 13:50:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p72JWondy9X/2GcMZhPtTvpKt0K8istyyVrGUxLu/Cxugm+F7Dt
 S/iYhPUD9ze01AYYy3K0lXTO+8/OFwbtJXy6d0XwP/4ihj1H28ICj3+n2qLX1QAQAq91jMV
 I1f+MT6zqOJJuiPNYFpeH6DtBkBjFgUz8nx6tNDusn/+01rQnDCh1gWxGGDknDl08nCilFC
 noC8CNFeH+7ohqlU21I0A==
UI-OutboundReport: notjunk:1;M01:P0:ilNo+gfh+68=;58BzPo8ihQe57AgzpU0QBreDtsg
 1Fda9hEEIPxziAdPAYzb9O0OVAFOngDCzPgGVTURVWMmkIw8ujMhXfctCOMaTLuYs0XHUE229
 lmbUCNfOODIWYHNuK3mmdpX8yw3a0EwONvZ58UPGlSixQBlolxYHoXUmpJ4UDhl5E+XmUXPkH
 6jHcJRpc1+zKe2zgMjBr61oW1MK9q3izHFa+nyRRR+p0o41lofSqTbIy58pFSEmhYhJte71MS
 Vycowr2FCeZty2xn+09BCmsVzrFVEawDe/NRjfRH5tIx/aUFmpKNANVttYGWq9opCYULiPa+S
 ujwNjyAtUCN3aEpZdhol+LwE9fCOmlgfchXBgZxzTW34vP4MwcgDWnFtqykZWWe0NBPOmlzqB
 mI6D+LE9ogWP4mK8Hh6GkrUxWTQo/xjS8don+GQLuNXW5x7ULTjZpXMFlrs3gCOQ32VZaTq8W
 zneBEmGwjU70LbPpYsShlhGQn5nwPGo6wG1EqSvSC7cDj8uQtIqCYHW6MSjp8KhaaRPmRma7s
 INwuSP8yaPdX1ibPfexsBiUYe96eiEZPucz8rm7fcLMcQyrxe+mpwi4gs79eEq0Cbuh01knWe
 izDqnTfYdp404KD/7+FEG+ciZqmW+bWhBhGbzLzRsKMU64q53fzakVf28ya1SSYf+avDlt56G
 BhzdVwZi4LtbDfwjifqYvCDCx8tSR3stF3ojAsUvxpsNYzU961S4eI+66hUgdou3Y2gjX/+Rj
 3VbUY9yDlcWACz1WTg9lU0lBBkFM2dAOJoz4WMaloggm6h7ioqM0/mKoKMwnqcfFZlVosBPbK
 YdNh3Ughm7fj4+4KhqqsXgTHKzm1y6Q8czax0AK6MWyRYUxH9rpS3Qy+P+EozLGgiKwdPKNfy
 TTK+cNHrIHT9gm/mQOuAch/oR0BedtOoD0pkPYMrj9wR08FMTRZQo74ZuraqqGAfp8SQcRIe8
 iRLTVA==
Subject: [cocci] Clarification for input data of scripted SmPL constraints
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1489
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/8a6c0b00-c65b-4c83-afd9-4023132a4183%40web.de>

Hello,

Some information is provided for the usage of =E2=80=9Dscripted constraint=
s=E2=80=9D
by the means of the semantic patch language.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5fdb1a247d3374ac30a3e=
565b2cc5167aeefc4e5/docs/manual/cocci_syntax.tex#L582-605
https://github.com/coccinelle/coccinelle/blob/deb429dfae033e40aefc78729a58=
5b00ae82808c/docs/manual/cocci_syntax.tex#L582-L605

They tend to depend on a single input parameter.
But how does the software situation look like if you would like to use con=
tents
from multiple metavariables (which were hopefully matched in combination)
for advanced condition checks?

Regards,
Markus
