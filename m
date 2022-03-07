Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D6C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 21:10:18 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24874389"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 22:10:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1855E00D9; Mon,  7 Mar 2022 22:10:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD1A4E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 22:10:12 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: KNRyHzpplRyRM/j1+CMINyDLy1wrrcsQ6ByQyPF5W9D0HrFoaF/Nm1/Xir4unem5ncAXh/plO6
 LbcvYni0IPIRPJiiy8+vVC41EfIazvQelthchC+y0wCGW7RkFwG9hYt7FyqKjyZyN4PdGBgjzc
 cH6BO0WAJfM+ZWVxLyznZ0Cv/JiM84g1ORBOXdqAoPd2YGpfNta9bOdP7TnBKe9yvknW/MXJnA
 5fywN5q9/PKvgEgGCo5qXCskf3veWZP8NoC2H6o46IB/bx9cRTzAfcspgxEOxmHEEeaC74ncGs
 QnVOBkMdJgTdwY16OHZilqpR
X-IPAS-Result: =?us-ascii?q?A0AnAgCtcyZihwQP49RaHQEBAQEJARIBBQUBQIFaAoIma?=
 =?us-ascii?q?WwrBAtEhFSOc4F3MYsjhxaMIgsBAwENPgECBAEBhH4JAoQfAh0HAQQ1BQ0BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKBw4QBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNgjUpAYNkAQICASMVCAEBESYBDwsaAiYCAlcGDQgBAYMAg?=
 =?us-ascii?q?mUBAw0lrgaBMYEBgggBAQaESB8sIlKBWwmBECwBjkcnEIFVRIE8DIJHMD6HX?=
 =?us-ascii?q?4JlllGBA6RFnkA0B4ISgTqBQAueCwYULoNhAZJWDgaRXpZVpnmBeYF9MxokT?=
 =?us-ascii?q?4JpTgECAQINAQICAwECAQIJAQECjh0ZHoNuiixANDgCBgsBAQMJhUcBAYwmA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 J7DmfCrQAo=
IronPort-Data: A9a23:wi6iNakBtTkeVjTyIi70VqPo5gyRIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJLCz+POK2OYGWje9sibIjgoEhT78CDy9JlTANkqHpnRltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+5KHYzdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1zlZiuahd3EZf9wuI5d0VWOC9EZPZvreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlQKEzra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6Div4MIg2tr1psm8fD2e
 /RGeBZ9Zgr5QzZwGAsoBaouhPqsvyyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjajkePcOWzT6t4HOpjPXG2yL9QoMbUrOinsOGm3WWwXEPTgIbXx23rJFVl3JSRfphC
 0gK2TpwgpIDrkqPaoXzdBOC+SWt60t0t8VrL8U27wSEy6zx6gmfB3QZQjMpVOHKpPPaVhR3j
 gPSxY+B6ShH7+3MGSj1GqK88GvqURX5O1PucgcoYGPpCfHGp4cvhxjGU8wL/EWd04OpQGmYL
 9yiligzhrMXhMgHkp219FTV6w9AS7DMSRMpoBraVCSp42uVhbJJhaT4tDA3Dt4Zcu51q2VtW
 lBZyqByC8hQV/mweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBknehs3bJlbKWexO
 xCP0e+02HO1FCT6BUOQS9LpY/nGMYC7SrwJq9iJMosVPcYZmPGvpno+OBX4M5/RfLgEyPxjZ
 87CL65A/F5DR/0vzTyqSv0b3KNjzy9W+I8gbcCT8vhT6pLHPCT9Ye5dbjOmN7llhIvZ/lm92
 4sBZqOilkQHOMWjM3K/2dNCfTgicyNhbbio8JM/SwJ2ClE7cI3XI6SNmuxJlk0Mt/g9q9okC
 VnmAh4IkAek3CafQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPuK6js/UScYUZZ74i+LAxxPJ4V
 adXZMiKRPhCE2yV9zMYZJj7jYpjaBXy2VPQZXX4OmBncs4yXRHN9//lYhDrqnsEAB23gs1i8
 beu4QXWHMgYTAN4AceKM/+ilgvjvXUUlO9ocVHPJ91fJBfl/IRwdX7ug/VxL8xVcUfPwT6T1
 gC3BxYEpLCR8tFvr4ST3fiJ9t77HfF/E0xWG3jgwYy3bSSKrHC+xYJgUfqTeW6PXm3D+JKkO
 bdfwcb6PaBVh11NqYd9T+1mwK9itdvio7hWklZtEHnRNg35D7R9Pj+Z0MMJuqAUnu1Vvg6/W
 0Su/NhGOOzVaZ2/TwNLfFIoPraZyPUZujjO9vBrck/00y9A+ubVW0tlORTR2jdWK6F4Md9+z
 Op96tQa7Rez1kgjPtqc13kG8mORMjofXq9hupxDWN3njQ8iy1djZ53AC3aqsc/VNIgWahEnc
 m2Oma7Pp7VA3U6cIXA9Inj627YPj5o5vh0XnkQJIE6Em4aei/I6tPGLHe/bkuiIItR7P+NP1
 qxDMkpoOeOR8j0uiMUrs6VA3e1eLEXxx6Az4wJheK7lo42ASWHHamEwUQpI1F5M6HpSJ1C34
 5nBoFsIkl/WkAXZwSY4H0JowxAmoRqd6SWa8P2a8w+581XWrNYrbmJCpYbFlvc/Pf4MuQ==
IronPort-HdrOrdr: A9a23:+EuK+qobWoQUYQBBQq2wfSIaV5oPeYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24874383"
X-MGA-submission: =?us-ascii?q?MDFM1iCUSO3eMJcYV5eZmJkf7gqvGrDlZLYFJp?=
 =?us-ascii?q?c7lexfZFpTMgbmHVo7l7VY2JYBEtmgurerQXqAIWkw1ccpe7gV5W7GRH?=
 =?us-ascii?q?SPRXEUykivwxRu1+1zZNO5dWqTrYHhObyVosGSmuEVZWaKpub6jz2ggf?=
 =?us-ascii?q?JyWdlYBq00gqsgD2tElKSFxA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 22:10:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646687411;
	bh=7ZlirTp14m7o6K5z1fmODvAwtX44EQp8ABH2nXC99GU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=gF3fbz0mcMkc9yXCdBcdQsD4KPhrMuWKmKaxnQ4ijI0BWfSfUC1O9+/A4cBpcPCPu
	 VksmFFVa5pdRXIg7OU0gA+jzQV88xcFcvp2gsP7KrDVWCpquIFmHtFRd/57GygcXMC
	 7S0MWvKLgzWyFuVRfDTAztfrht3acxiV1I8osAfA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.71.136]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9IOZ-1nUL1I1p1L-006Jpo; Mon, 07
 Mar 2022 22:10:11 +0100
Message-ID: <73ca810a-98bc-25db-5202-2ae7305b83fc@web.de>
Date: Mon, 7 Mar 2022 22:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net>
 <alpine.DEB.2.22.394.2203072147580.3091@hadrien>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203072147580.3091@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AVBhuBSgKZtJRDKGif9QslxuW+k+E76CDX4Irz3AnrIGZkjHt7T
 J4ignbAI3ljEFeaUGsQIvXzTK2/XSmDhJOrx1OJmoWundWfQoePETpa3/LncFqNAXaHIsui
 0zcns/naIvXgSdFwr6sZhWZssEN6OjrsYm9hggSC53dFxlOqsgr+9eZ/hRwHsfogvZu8zo3
 GfpuU3rj9vwcogFjFb5og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x6zlswGqWhY=:eZI6YHv97FahyS0A+jh3hF
 u+hNH08vxwHrCVN6DG2XrMglkeHUu6lyf1LYYIACMoY2QuoLvJiZuhmS38I98cRBHE1/FfwVQ
 1Tn4fWpjW3dzhI8J4kNCcDqAwuRfibmhKeGoO1puzNfqUNz2xBhDzDdbwLCJI6nk2QcHWIXb2
 X6q6QPSf1qKD8mlggAORjV7wGOBLZboa6d6MemYt1zdCR5dK6MjcZ2KKOwKVaa/gKsNwsZ9FO
 Mdovyf8fiqWT605oJUgNideRnuDyqkF2ZB3RL2/2NsofA+xWMxtIWS6mMY/YKxwmjXWDl1q6E
 zG8L8z3KS7WvxBtKpOC0D8hOKjf+YucVHs70nGLn43Y+gktJzgR1cSRKMFglmPt9cxrcUGCFJ
 UO0WQqx7/FwSkmu+crgpu2BKFWJaf7SOcaNU9LC8rdGuOokuSeufgf6sE+mLN3y6ZgjkIc/zy
 cFyFFnhSOnUFHXgW3/fP40Mz+iWxfzRuiqGsxUNaFzLcH3uquD/Sx0+aSb6jhNcaZw8ghe8mh
 XLKyt9PfHpMNPtMlYXHUc04Toe/m6cyTLCQKg09TW9b5N+3NaXL7ra0Bj9bRdJ8k1y4b8y3GN
 VqiGREoV6XaNiya/yowlxSBDOD/HYNKCE3h2aLIoV8SwHDmq47wiJahJp91ESMCXvgYFCDYTX
 Jtz+sf4kM4r9KOjt2aJoNSbumJNDWyc0D8yhlmlfOz9XXGeeAb4UG5VsoJbXwKIKUusxoJ+AH
 TN2TLZfw7HaFqtb73b0LdMF2iPR1YlSAsoTOmMlwSvMbru0pdo23zgojjpiGOTR/j41bqG+/J
 UIied/z82I9VvyOTHrLe/u8TWAhvcSy04wnOVaDQJTZjrEVfyqR/dW0rxs5bm/KGW1kikthkv
 hvn1OzaESDFm1bcNokYTkZRFCGim7ABcQBOEwLPmbx+a0Q8P+I/cutDehZYAA9Nkl5xYhHnTz
 +b7LXB7+4hyrEVR/O5+3Ccpp9eRsplFOjVfevf4m7TjYolVj1stcixdrkWT1nvxUBM9VO2nE9
 NskFyje5nkePfqQjGBmBSmNIFzEBA6ArePJp5kv2N8wNaZCHqj++tHRJ/dcumKoR7DAVROBag
 lnlFbiVnGyA2R0=
Subject: Re: [cocci] Does SmPL for functions with prototype disjunctions
 need to be complete?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 184
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/73ca810a-98bc-25db-5202-2ae7305b83fc%40web.de>


>> It means there must be a longer SmPL, which is ok, but for my own
>> curiosity: is there a shorter form?
> It might be possible to put a disjunction around only the parameter list,
> ie inside the parentheses.


How useful would such an SmPL code variant be here actually?

Regards,
Markus

