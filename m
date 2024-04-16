Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B69DC05024
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZM/Kn+8UkuIqH7dSUrgkALqX2sFZu1tAf9iAD/x7XuM=;
  b=L7GmC6vwLrPzt+ZGRzkzQczE6Tx4yn4jpOSYPDbs6R1Taw4ISf6Ss8sc
   v0GqjK8sCNyc/Hb22fMsWshyfyeW3qblDlhfPSRnZr6vEMoEkXhyqV6s/
   +1XvPshOKag3gBkyzTgwNQxmRFgpuoaK0t6n3+Ixh2N/cui8bnr6SanuH
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ellerman.id.au
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161851074"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6ED6E0D5E; Tue, 16 Apr 2024 14:14:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CAA03E00B7
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 13:11:27 +0200 (CEST)
IronPort-SDR: 661e5cde_/qs8BY2rQpHkqtopWQZ9b5Iv/QF4kSYKK1FkZgcR741buwu
 elMvD5lQCBCQOVkb57zpG6i89a3Lnwxe/scqNnQ==
X-IPAS-Result: =?us-ascii?q?A0EYAAAmWx5mkExKa5ZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF+AwEBAQsBgkN8VTQHCEiNUohsAxacHIFqgWoPAQMBDTsGAQIEAQEDA?=
 =?us-ascii?q?QOBSwGDMwKIGgIfBgEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBAQEgHhAOJ4VtDYJnATNrgSUBAQEBAQEBAQEBAQEBHQINfAEBA?=
 =?us-ascii?q?QIBQAEBKgoDAQ8LIQwZDwFGBgESgwABgisDDiMCErUxgQGCCgEBBtskIleBY?=
 =?us-ascii?q?QMGgUgBiC0BhXyDRnonGz+BToEVgyo+g3yBBoYEhyGIbluCAYNPgVCDcYYjV?=
 =?us-ascii?q?H0cA1kyAVUTIgsEDBoCGxQNJCMCKT4DCQoQAhYDHRQEMBEJCyYDKgY2AhIMB?=
 =?us-ascii?q?gYGWyAWCQQjAwgEA1ADIHARAwQaBAsHdYF8gT0EE0QDEIEyBooPDIF9gQwCB?=
 =?us-ascii?q?SEpgU4pgSmDCUtxgR0Cgn2BYANEHUADC209NQYOGymeJgGDfD9GgR+TQx1Ck?=
 =?us-ascii?q?nGfOYQdjA6VOTOEBaYvmGIggjSJKYF3mxGBeiSBXE0fGYJuAQEyTwMZD44gG?=
 =?us-ascii?q?YIbhlqKKAGGaDQyAjkCBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23:myl1ix0YNM8PJ4+lsmDOjgwyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaOo6wy0RSQBc3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNZwhEniexbLFyI
 Rm5sAndqtQdjJd/JKo21hbGrXxEdvhMy29vOVydgQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WSin4
 qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXHdNUtpNWyBEBI63c
 okBAPcbPetAr4fzuUUDowa8CgmiCu3hyTBHiWPt0K0mz+gsCx3K0BA8E94StnnfsdX7NL0VU
 eCw1KTGyjTDYO9W2Tjn9ofIdg0qr/6IXbJ0b8XR00wvGBnDjl6NroHlOiuV2foWvmeF6+pgU
 fygi3Qiqw5rpDij3MYshZTTio0P11DJ7CN0y5s6KtOkUkB0e8KkEIdOuCGAMYt7Wt0vTn90t
 Cs4xLALtoC2cTUKxZkmyRDSd/OKfYaI7B7+VeudPDZ1inxkdbyxmRq+7Uetx+38W8Sp0FhHs
 yhInsXKu3sQ2RLT7c2HReF8/kenwTuP0AHS6uVeLk8vjqrXMZkhwqQ/lpcVrE/NHTf2lV3rg
 KKWakko4PWk5/jlb7n8pJKROJV4hwP/P6koh8eyH+A4MhUVX2iH5+u8zqDt/Uz4QbpUlvA6j
 q/Uu43AK8sBvK62GQpV354j6xmhCzem18wVnXYdI1JDZR2IlYzpO1/ULPD/DPa/h06jnyxwx
 /zcOb3hGJrNImDCkLfnY7l991ZRxBczwNxD/Z5YF60NLfDpVkLzu9HUFB00Pg2sz+biEtp91
 4ceWWyVAq+eNaPfqVqI5voxLOSXeoAVvDL9JOY/5/7rl3A5n0URfai00pcNcn+4A+xqI0OCb
 nX0mNcODX8KvhYiTOztkFCOTCZfZ2yuUKIk+jE7FIWmAJ/fSYCqnLOOwCa7E4ZNZmFGD1CMC
 W3ne5+FW/cKciKSI9VuniYKVbi7GMcd0kSLvRX51qEvA+7a4Cweutq38dFv5PDI0zw2+yZ1C
 cu1zGyHCW15yCdAQz4wwbBnuUc4xlqd+ax5mOBDU9tB4/pDSUE9L5GYh+93Edb/XkfDd9GIV
 FG8Wf24DjwrCNE82dkDZwB6Adrmxlrq2SenGL9dtKGODYZ80eTilTClLsBwxm3Gkqo8ilA8a
 shCL2urguh47QeFQ8bik1+YjLqtbaQRlArA7mCShT6FvFtZSxJ3SaXIG3QSfEzHhd/i6VnFU
 qfoBKlxdkML78ecJ6ZMIvuvxW9PQ72rbNLXfW+8nSG2QwyBwZuIbYz3ayMc1iCbA08BxURb2
 3eNNQ86Dzzpm2PRAz1oXQbpe0Lj/uh4gHy+R04wiQqNahsy+aCy/0swhPecQv4Xlp8AvCo7r
 jxyVAK4x9/+Bt6EqhBkdaMaYN976UoRhjGRjBB0IpH1d/MqvVUZaQki+hq2j32fa61FmMku9
 zYxyRZqbLmfyBVHfi+Z2pb5PvvWLHPz9Vahcf2ewUnQhfCR/KpH8/EksxP7pgj8E1Iv23hj1
 9RP1nKaoJTGSgMPAtrqSkhizxFhvPnBZzUloYbd1HliK66x5zra1vokAO8o0BOpeZFePOWNC
 Vy6CNUUUvCnM/digF21dlQEMeRVobYzJN+jfuCa1bSDM+9mkDuigyJA8oR02FnK8DBzIgLR9
 7ACxfzQng6OVjOnyUykrtiygodcIzcbAmu4zyHgQo9XfKx7O4gRWy+oJIWsy9NyioSIOTYQ/
 UO/B14AxM6ieAaDJ1370wpK0E0LoHuh0SKmxj1wmjsto+KRxivLi+jlcRMGPCZMSgwAxR/pO
 YWcgtQeUVKtZg5vlRfj7Fu7j6lXqaJjLnXCFF9Sdnu+JGVjX62s87uaNpcSsNVx6XoRD7j6P
 g7JL9y16wEX2C7iAWZEkTUydjXx/478gwQ/k2WFanB6sHvef8h0gxbZ/t3VA/BLjV9kDGF1j
 yfaAl+kMpyn59KRwt3Gqu2WWmalW4dWeC+tzI/GvTbxtggISVWv2uu+nNHqC11w1Df2/9RuU
 SjSqR/6JIjnka2ne7EvbgxjA1ny7NB/E4d1n94rhZ0e7nMdg42c4XsNlWqb3cxz4avldzJNQ
 DcKx4WQ+w35wAh4KWrPwYvlV3Kby88nZt+gY2pQ1Dhvp8xNDa6V6vRDk04X6hK9tQ/5bPx5k
 y0YwP1o6XJcivxBtAc2zyqbC6wfBgEBYHSqzkzXqY/i6voJLG+0OaC9zk9/gcysANTg6klHV
 XD1d41jVS5848NjMU7dhXj664XqYt7VPpoYshyZlQuFjvAAcc9p0KNS2mw4ZSSi4y5AqaZzl
 xFl0JCksZLSLmxs+Pn8GRtELnjuYNtV/DjxjKFYl8LQ3oa1H5wnFC9YOfmgBf+uDj8Wsuzqc
 giUFzhp4HKDFJLSGQuS8kJvqTTOH9aiKjvEQRtRhcUnXxSbKEFF1UoRRDgSk5o9Gxqvzcqnc
 Us/7y1btRbo7xBLzOxvLRz2VGzS8RypZjkDQ5+aNBNK7wtG6hSwU4TW/qdpEipf5JHksB2VJ
 znReVFTFW9QEB/MFxX5M7Kp/9WF7+WIGr/0Ma7VebvXzI4WH/aQmcD2j9Mgpm7TcJrTeCY8R
 /wjhBgZASglSZWFw21dEX5PxXiUMZzAqRmyqCN6o5rtqq3mUWeNrcOOE+UAa4k3p0Ln3f/bZ
 bTK3n8rJD8AjsFenjfJ0ORNhQdIzXs3LH/2QfJZ7HGoLuqYm7cJXURHM38hZZcQt/BmjFEfY
 5eF2Ij42LAqgPM4UgVPBFK40sCxOZ5Qezr7bQuBWxjNbtHkbXXK25+lO//kEO9eh70M5UXi4
 GzKQR25dFxvjhHRXgu0eaFJhSCfZ1lFvZ2lNw1qES7lRc7nbRuyNJl2iyc3yPs6nCGCOWkZO
 Dl6O0RDy9/YpTtfmel6Endd42BNIuCCly+d4a/fOJIfu+AtBT573+5X+3U1zbJJ4ToMHaEt3
 nKK8Zgx/xf5zKGG0V8FGFJWpyxOhZ6XsEkqIqjf+pRaGD7F8B8L8WSMGkEKqt9iWZXkv6Fdz
 MSKlbqmcWoatYuMoo1DW46LdpHiUjJpKxfiFT/KARFQSDeqMTqanElBiLSJ8WXTqJEmq5/qk
 Z5IS7lBVVVzGOlJbyYtVNEEPppzWSsp1LCBi8tdr3+moTHcQMFXpJXOULSTDbPmNXzK6NsML
 wtN2r7+IYkJY8fj3Fd+b1BhgInQM0XZW9xEpiMnaR0wqU9Wtn9kQSdgviCtIhPo63gVG/mum
 xcwgQYreuUh+gDn5FIvL0bLri89wwEh3M/oijeLfHvtPb+9CMtIXjHsuRF7YfaZC05lKBe/l
 kt+OHLYSqJN2vF+IHtzhlaUuIMTS6cBFesdOEBWmq3ROKtNsxwUqz35lxUbvbeXWMc6zFlwI
 8b+9SseiVluYtBnK6HdfvgTl1VZ48DG9i6wiLJrnFdCdRdRqDvAInRS4R4FP+F+dXjztu10t
 V7bwmEFIjFXEaF65KszqSZfc6yB13yyieIbdhLga7THffnL4zqazJDaGV4+2BEGmkQcr7In3
 55rclLIBRp3l/3IT1JWa4yYTGMdJ8tKqiqJIX7X4+vGmconZ9fkTLG6H7XE3E77qk+gGAszG
 o0KqMUNWJCxghiwxSbPI7cDxRwp6kLsNlGMBu8PfwiEwm5vSySXwZtz0JNYLzdbAGk7ODjlv
 t7q
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GtgTzqg7byv8VVbiOgoGsaDvzHBQX1l13DAbv31ZSRFFG/FwyP
 rOoB1L73HJYWgqN03IwerwQpVpQRvnhPpICPoqTMqftWjdySGVxeRZhrcKrAeQYxEWmtQtt5
 uIEJIOReEYb2IK9voSiTPQe7pBsbq6GcuT9IDjJgJWPHhXgtZbnmFE42igYyhLrQ99b6bR9q
 Dw2uN34x6bPVgHZMWyAXcIG8LZocfQqZ7gaRkaQzY69Qinl1qTmfHHOind+i1bfyJEwL8k/2
 SAuRf+/L+fv/ayzQKZ/3PP7q5RhMDqxrJ4dYKxY4kuW3TRYzSTFcdcso65zXIISSaUmRMXee
 z30lcd1gJImjfsly+O0FzQMkLboUoTAjfZuCClaD3Y0IDErXsBert8bY41SGqm12Mw+N57y6
 5FxGSfqt5eCg7Bhj3045zSWwhtjVfcmwtqrQc/tQ0pbWIlUs4mkaUPuEdOVJsQFiPz744qVO
 FoEcHH/f5TNVeXdWrQsGVjyMGlGi1bJGbMfmES/siOlzRGlnFwyEUVgMQZg3cb7Zo4D51J/f
 7NPKhknKxHCsUWcaV+DuEcRtbfMB2EfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPIcFyZMj8a
 6xJG+wdVRCDn4GJff+rqGjqCq9MFlVdQ6duf1j2w==
X-Talos-CUID: 9a23:gEH/bm3UB3IOJCDFJYiAiLxfEOcVQnfWi3LpKEqzNmdOT7DEVg+c5/Yx
X-Talos-MUID: 9a23:0wjgYwoQs7ILth7aPQYezzBEEd9juqGPMmwq0s1b4OOeNgAveCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="84944082"
X-MGA-submission: =?us-ascii?q?MDEdsJMm/stOwWENaFs6mjcnNVkfzbMNd7o/1T?=
 =?us-ascii?q?8OscvS/3uztYc8xYglsXVaularmWO218wbU7I2DCyv4edg+KK29m+/CH?=
 =?us-ascii?q?LUP0RhvinzITt7BdUwA7J767g/UxCyMTVIXxGyYOZbdMao2ZwXn5yVQ6?=
 =?us-ascii?q?bNQD6+3KJ9e9HYR5FhGE5hBw=3D=3D?=
Received: from gandalf.ozlabs.org ([150.107.74.76])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:11:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713265877;
	bh=ZM/Kn+8UkuIqH7dSUrgkALqX2sFZu1tAf9iAD/x7XuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LTB6+F04dq0c2A9vGjdft01NvBtN7BE1s7hBFglEQeOgGLMZ8lhGSvwhgamz3zdUw
	 3LOFOGAE8/69f5wjWDrFwFeywpUpkxUOsNTUPdSBqDxlizHom70fy+HGtKeWzbOmZE
	 8ubI3+yDLj3N/2MnNLCuoA4+Aq8ZuD2XB8lHJavB2F/v4AgKxIuU7J4aUnkE/18pi5
	 y2cVry8DRgTrqzpXW05YnuQ2MoPsb+3UECVYNA3zp20sf3yGFp6RARvbtTBUET+zd4
	 8qw/x/HqneNONDno8GHtmrjjMlSabWz9T+pHjLGZ/DGvvazDUjzYg3oKs5SvnFWbUD
	 T9duxh5ZTeljA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJhDg5c14z4wd3;
	Tue, 16 Apr 2024 21:11:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
In-Reply-To: <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de>
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de>
Date: Tue, 16 Apr 2024 21:11:15 +1000
Message-ID: <87plupbm0c.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Michael Ellerman <mpe@ellerman.id.au>
X-Loop: cocci@inria.fr
X-Sequence: 1660
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/87plupbm0c.fsf%40mail.lhotse>

Markus Elfring <Markus.Elfring@web.de> writes:
>> A few update suggestions were taken into account
>> from static source code analysis.
>>
>> Markus Elfring (2):
>
> I would appreciate a bit more information about the reasons
> why this patch series was rejected.
>
>
>>   One function call less in vas_window_alloc() after error detection
>
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1f1c21cf-c34c-418c-b00c-8e6474f12612@web.de/

It introduced a new goto and label to avoid a kfree(NULL) call, but
kfree() explicitly accepts NULL and handles it. So it complicates the
source code for no gain.

>>   Return directly after a failed kasprintf() in map_paste_region()
>
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/f46f04bc-613c-4e98-b602-4c5120556b09@web.de/

Basically the same reasoning. And it also changes the function from
having two return paths (success and error), to three.

cheers
