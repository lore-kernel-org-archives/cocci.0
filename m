Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EB5CEBF8C
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=g87Wa8qwPUGwo2tFCpxQqbLKDI6a/y3vu+y+grPtq/A=;
  b=SwePwKZB17fj0Mg2NTo2+tU7TGkFA++ekV9O8HpVIRCdXUS9EcBohs2M
   LztsyoKCgp/138wPV+VSWB/Zj6K0U9Bm4YQZYrlouNQ6OBH85RVCtiPqE
   JRdpRtmn8WUc9+vaN5bb5YNLqJVLk6jSozk2uo3iC4Keza/FMEjjcEYS+
   I=;
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
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185478662"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 11:31:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D11AE0CD1; Fri, 27 Sep 2024 11:31:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 28E32E0035
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 11:31:09 +0200 (CEST)
IronPort-SDR: 66f67b5d_zzPg50o1LpeRp6a2uETW+H1Ucg1p/KaAgXOfJCAkpNuEfeX
 4z1UDVYCyhOQ/vKe2Kz+amwu3OO3pW1Zw5xBsqQ==
X-IPAS-Result: =?us-ascii?q?A0FNXgBGevZm/wQP49RagQmBUYJCB1sbBlQTIAQLSAglh?=
 =?us-ascii?q?CmPTYF1gm0BgX2PDoh2gxY+DwEDAQ07BgECBAEBAwEDQ4EGgy+BAYkQAh4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBCggLhS9GDUoBA?=
 =?us-ascii?q?QQLAYFqLnkbdDACAQEBAQEBAQEBAQEBAQEBAQEBFwINOm0dAQERJzQCJgJNJ?=
 =?us-ascii?q?gEBgn0Bgi8BAzEHDQawOoEygQGCDAEBBoJn13MfLCJXgWMDBoEaLogxGgEFb?=
 =?us-ascii?q?YRkhS4PgVVEgTyGCxcEgiuDDoJpkg2CEIhiigBwkSyBTRwDWSETAVUTFwsJB?=
 =?us-ascii?q?Yk4gyaCFIQWCIE+g1+BZwlgiVaBPoFZgzpKhUeBBoJRa048Ag0CN4IogQ6CX?=
 =?us-ascii?q?IEnBAWDUnYdQAIBC209NQkLGwY9q3MpgVtIhAKCd5J1skI0B4I3gWQFgV4Mi?=
 =?us-ascii?q?QOBJJUrBhMvg3ITkzkOBpJzhiCSVoJWiyWVToVUNYFJJoFZMxokgzZSCw4Pk?=
 =?us-ascii?q?hszvXVBNQIBOAIHAQoBAQMJAYFVg3ABAYF6gQ2DOoFLAQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23:U/JWzK0yfpbcuuJ8OvbD5cdwkn2cJEfYwER7XKvMYLTBsI5bp2cCz
 WtOCG+BaKyJMWeje4p/bYnn8h5SvsODydcxQFRs3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8glaYDkpOs/jf8EI146yr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW1Xgms4xBxobAa4F2M1XPzxl5
 axFIT9YO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMube03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmI2AE9wLL+PdfD2771TQoiunDKN3pJfuuFdt2w32Fr
 W+B4DGsav0dHJnFodafyVqngeTEnAvgSYcKHfu58ORriRud3AQu5AY+UFymvb+mh0T4V983x
 1EoxxfCZJMarCSDJuQRlTXiyJIplkd0twZ4ewH71O2M9kYQywOeG3RCUTNLLtAr3CPzqfrGy
 XfR9+4FxxQ22FFWdZ5Z3qiZp3W+NED56EccMDQcQ1JtD8bL+ekOY9GmcjqnOLG4hJv5FFkcB
 txMQDcW390usCLA60l3EZ0rTd5hSlglgzPZPjnqY18=
IronPort-HdrOrdr: A9a23:e5scO6BiAUcKnVflHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:lkYqo23c62g+2P/dmBK+ZLxfNMx8SSLWl1rsAFKaIkZXFZaFGQKZ9/Yx
X-Talos-MUID: 9a23:wUWQBAqIAfLpmX+E8u0ezyhabZ05zbypNB8qtcUYmJS/KCd9fCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185478655"
X-MGA-submission: =?us-ascii?q?MDEMObQO4yaQAPMwibEZZUNSdirQ8+V4v4dEve?=
 =?us-ascii?q?F4jfMm633JKtbdbyMSPYrGpxpeL+JLfR4L0nF1N8tJfzuBC/GnjpjhL7?=
 =?us-ascii?q?fKvdBXTDp5YlRn8nIWiTDRayvSVv4l5/jK2xcbuEBV7Xu/aX5Tdhmtud?=
 =?us-ascii?q?PkpiLMRAuGxLJN/QIei7O0OA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:31:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727429457; x=1728034257; i=markus.elfring@web.de;
	bh=g87Wa8qwPUGwo2tFCpxQqbLKDI6a/y3vu+y+grPtq/A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FsyR4eYuRFYydSIjhE2NIRiMpSesQq5+sh5ON+R6KvzHUXVGbgZUzQKu21yHRHYt
	 /3jDQoZMZHihmmz85gKGxbiwBdRYNyAf6XQeHGklNKuRTHOEgwtOqf4Ovu1cJN7YV
	 2772B+O1G8P2Tr3fb+3bKVAmGB8BIwAjd4KVwW3hTE9jJgaJYYIVGmA9ZmTh2Km0I
	 iTn7I7iP5qvXm+HRg0LOHpHHExCpsNcp/S5Cmvf40bfEHTTAs7h+1xgfjXnjja3mT
	 LM/pUZA0gUY2bQE09RwEOiuo765jEvNB6clkkwdyNnuyz+gMrUgrixg2Qs7ldiCLm
	 riY70DZzNezN0NLEug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1spQDC2Kmp-000abM for
 <cocci@inria.fr>; Fri, 27 Sep 2024 11:30:57 +0200
Message-ID: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
Date: Fri, 27 Sep 2024 11:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:702g3/2KdkflOLm8P6qMcqC+5J6QHyVojClbtIn7osOK5iwLph/
 wCePglpLf5r1OfRSBfnl3VlSkTo4DntaH7w3CcbaB/lJTBdk8XvhwGCvZkx5FzfLMwI6xbd
 XMQNGnminrutOt1QLuOANmTAr+R3NkRhKrA5hT97K/XI/FW8Tq2tCVfd14HdgKzHZ45Uhx0
 fBAi8YQnpz2nZwZU3aiRw==
UI-OutboundReport: notjunk:1;M01:P0:wZcRGR4/NUs=;norq3lU+2CPc0Ne4wVNDVDghaWl
 ZH2kxigjUL9ifI+SKmAaLA1lXpUelEX+8uO6FCkM6ZZSGfRCc9n/3+hqI+WJsOLlXidmZo/7A
 mDKKprjCBFuzU/LrTDmTuj668EIut3eW7bewMRPltFdsQVM1vrdIJUIv8QpytIFDwFu/BDrNW
 YTOZpYwNb/VbAxMcR5aKri1ctBLLz5vctKnm+hONa56ndg2andnaHE/X1pr/eLNrY8eo9J3qA
 rSTXZgQDHF3Ento1ZIoQOdpBdg1mBbdzyJdQfL2s9YcW4dcQ8o9WE+ef4rIclRA1IoKnYDE0n
 jil539iTxY6fzDoqw6GJd2Tf2aZwvTN2npEJ4aWZJhhsSvdk4I0oaDWsg0Ga7E48H9vH3MPjo
 JvsIwX1HaBlfg4U52HRnd0sz5TP9o9T05ANyiDkQX23X/BMEig9NDmPbntnvaGMsM7ZIv03m1
 i1qKIcIe8GNdVFfdivmjf0JtXol2aRoGpVOHCyADPULVE7zEpxKtpEKEVYOE6oiocdnv3n7Sq
 kj3g0BdWDpO6NEETlPL0b09+c+rzHpZT0/mmdE4aEqlAHAvQycXULh7WgHi4C82Sol0kwdmqV
 GJFGAwTA2wwsJDs9babTt0aKf5RwUcqPwQdzFrhb/Kbahe2ZDCq3DFbpLbTS+94VyhVAQYybq
 hwP7MWm4YLv2s5/H2ejtgMkt/dK/j+rpYy2TFzAfrI7bDDPofPFGIve9fSISolp//FqtwIutc
 rgtmsHd2TSCazZnaVVJsUzNmbbZHjPO47bBIaUACAnHQaVVow7f3sDjKGMZySfO/oerlKLnZu
 XE5ZSRXPaZ5iXW+mqpHgnPyg==
Subject: [cocci] Searching compound statements without =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?if=E2=80=9D?= filter (by SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1889
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/12bd8d0a-d066-4fd7-a7ee-99209f18a613%40web.de>

Hello,

A function implementation like =E2=80=9Cfree_one=E2=80=9D was identified a=
s another update candidate.
https://elixir.bootlin.com/linux/v6.11/source/kernel/bpf/memalloc.c#L253

Questionable source code can be pointed out by a script variant for
the semantic patch language like the following.


@display2@
expression x;
@@
 {
 <+...
 if (...)
 {
 ...
*   kfree(x);
*   return;
 }
 ...+>
 kfree(x);
 }


May I expect that such a search approach should also work without the extr=
a
SmPL filter =E2=80=9Cif (...)=E2=80=9D?

Regards,
Markus
