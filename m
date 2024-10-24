Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC34ACE8E6A
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HPzQUQvtjOwgW2eAJRjI2FSGXVBcxZOsFmZW30JkZOQ=;
  b=lJtCvGaXglezOshk/TJq8E9mvuO99PWVGJNZhfMrEhW9WTK6Q4a1JZMS
   RiGBE2f2NJ0G29uExs3UNnt9t47AstfIkVOYfrqVTmBy8Z1QT7RG9goYy
   fCuc+C7jrOeB0exljlggdcVRlU1jOZ9gVAaDU4c4bf15k/lAUpEdgqqBz
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190613442"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 19:31:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3E74E0D1C; Thu, 24 Oct 2024 19:31:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EFA9BE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 19:31:10 +0200 (CEST)
IronPort-SDR: 671a845e_Xy0JxRt4CPuyWBVLt2R/ZYK9gGfNxIW1UeXOUJbGFSd2+VA
 L+jOGw69pFSkUAGVOOCW0BGHXtZo3eAOUJKl0BA==
X-IPAS-Result: =?us-ascii?q?A0FtBQAGgxpn/xOg6VVagQmEFwd2WjMHCEiEVoNPjiKgE?=
 =?us-ascii?q?g8BAwENNQ8EAQEDAQOCDIJ0AookAh8GAQQ0EwECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQKBCggLhTVGDYJbO4IWLA1+AQEBAgEjFUYLCxoCJgICV?=
 =?us-ascii?q?hsBAYJ9AYJBIwMEsCqBMoEBgxzbF4FmBoEaLoVqgmIBimAXEBUGgg2BPA6CP?=
 =?us-ascii?q?Tg+hRCDDoJpBIYMSIghgi0aSYIUCJMiiFqJL1J7HANZIQIRAVUTFwsJBYk1C?=
 =?us-ascii?q?oMcgW4mhBGBMxIBg1+BZwlhiEKBDIE+gVkBgzhKg0yBYQU4SYJNak43Ag0CN?=
 =?us-ascii?q?4IkgQCCT4ElBAWDPIFCHUACAQttPTUJCxtDrAiBWUeDcyt7gU2TEJEooWmEJ?=
 =?us-ascii?q?IwWlS4GDwQvg3KTThSSeJh3o3qFJoF+JoFZTTQEgyJSCw4PkhvKREI1OwIHC?=
 =?us-ascii?q?wEBAwmSdYFLAQE?=
IronPort-PHdr: A9a23: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
 UPv
IronPort-Data: A9a23:ujqaxaKBxt3o7r23FE+R5JQlxSXFcZb7ZxGr2PjKsXjdYENS1jBSz
 GFKUD2DM6yOZTD3fY92aoiz8UwCu57TzdBrGgcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb8s9JIGjhMsf7a8Ekz5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuSSvK3a5ENnENBaody+suLFlv7
 qw9N2VYBvyDr7reLLOTUexwnoIjK9L3J8UUvTd9zlk1D952HNaZGP6MvIEAmm5h7ixNNa62i
 84xZTd1YRfoYBtIIVAZTpk52vqr7pX6W2QJ8AzM/vZsvAA/yiQy74jAE+TKKubbXN9ptWvfp
 j3201X2V0Ry2Nu3jGDtHmiXruTIlij6cJkDEaWxsP9smlyagGIJYCD6TnOgpOWhzE65QM5Eb
 UcTvDctxUQvyHGWohDGd0XQiBa5UtQ0ArK8vsVjgO1R4sI4Ijp1B1ToihZabcA+8s8xXiAxk
 FSO2c7qbdCqmKPAUmqTr994shvrURX570dbDcPHcefBy9rlp5o0gFTESZB+E8ZZS/XrTCroz
 WniQDcW3t0uYA1i60l/1VPBhCmrqN7CSUgo5W07m45jAhxRPOaYWmBj1bQXATus4mpUopltc
 UXoQ/Sj0d0=
IronPort-HdrOrdr: A9a23:fAQiZaCjEQ6ycdDlHegpsceALOsnbusQ8zAXPh9KJiC9I/b1qy
 nxppkmPEfP+U0ssQIb6Kq90ci7MDnhHPtOj7X5Uo3SJTUPJgOTXedfBOfZsl7d8k7Fh6NgPM
 VbAtBD4bTLZDAQ56eb3ODRKadm/DDtytHMuQ6q9QYLcegcUdAF0+4WMHf4LmRGAC19QbYpHp
 uV4cRK4xC6f24MU8i9Dn4ZG8DeutzijvvdEFI7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl55+kr+qwxnbnpiDuBtVt6ZXcI+l4dYyxY/suW3bRY8GTFcZcsoi5zXEISSeUmRMXeZ
 f30lMd1o9Img7slymO0GfQMk/boXATAjbZuCClqGqmrsrjSD0gDc1dwYpfbxvC8kIl+Mpxya
 RRwguixtNq5Lz77VfADvXzJmZXf3CP0AwfuP9Wi2YaXZoVabdXo4Ba9ERJEI0YFCa/7Iw8Cu
 FhAMzV+f4TKDqhHjvkl3gqxMbpUmU4Hx+ATERHssuJ0yJOlHQ8y0cD3sQQknoJ6Zp4QZhZ4O
 bPNLhuidh1P4crRLM4AP1ETdq8C2TLTx6JOGWOIU7/HKVCIH7Jo46f2sRA2AnnE6Z4vqfaWK
 6xJW+wmVRCC34GU/f+oqGj2iq9MVmAYQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ADNwu9WhY3ByLXkWLJ2tjdwxyxzJuSC370iz6GX+?=
 =?us-ascii?q?DMUFsebDMZGex4/NBjJ87?=
X-Talos-MUID: 9a23:IWzw+AbcVOMNqeBT9ADcqRJcK5dSsr20NGsg1pVZi+W1Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190613437"
X-MGA-submission: =?us-ascii?q?MDGNwnPRA8c40IPRFaaAKPVMhCy3X/N7iSN3wm?=
 =?us-ascii?q?UI+MBbH1UVWJAtbG3rD4gEC/c0+xA9OCAudgKpvLlwrecFPavpxWIFCe?=
 =?us-ascii?q?r9R6fcH3uA0vlwxM6kOtpNICwCCz1CzjvSY2pJvDBFpdUnGSCIY0Ac5c?=
 =?us-ascii?q?DldYfhMwRx+5MVx4m/pkkZhg=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 19:31:08 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t41fn-000000006vx-89hT
	for cocci@inria.fr;
	Thu, 24 Oct 2024 18:31:00 +0100
Message-ID: <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
Date: Thu, 24 Oct 2024 18:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1934
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/6534a8d0-78e8-48ef-b80c-a9fd3b80f562%40knosof.co.uk>

Julia,

> Just tried
> ... when exists
> on a couple of files that timed out after 600s.
> The reported time was 0.209s, so it's a lot faster!

For the linux-6.11.2 kernel

Processed 95,512 functions in (before being terminated)
real	1082m31.767s
user	1082m23.202s
sys	0m1.594s

After adding
... when exists

Processed  830,471 functions
real	83m54.085s
user	83m4.394s
sys	0m3.496s

Which is around 112 times faster

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

