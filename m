Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E23FC54E64
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2024 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=sxKbKQZCceW+/dLXdK8/PrsAHcow8dZEtQFKHetz18U=;
  b=WPkXXf8sI+YqFv81Bk2VXVB6jBm4UB4JLNpwY13e1mo5Nkkhn1wsQBO4
   DSG7td+nvOTHksZWzCA3j8YgOtZcnn1XY9lm7vQAla0t+ExSkIRb8OTcI
   UzzijH7z/sbQp2qx/1rjft0H0uviiB5g+4k65UaBCE6LKJb07it4p+l8V
   8=;
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
X-IronPort-AV: E=Sophos;i="6.07,152,1708383600"; 
   d="scan'208";a="158249184"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2024 10:02:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5218AE0AF6; Mon, 25 Mar 2024 10:02:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6CF39E0145
	for <cocci@sympa.inria.fr>; Mon, 25 Mar 2024 10:02:02 +0100 (CET)
IronPort-SDR: 66013d89_9eWdP0drdAFyB4QQZ5DtL7XvZuYzFhVm9dqoHoCKK6M95in
 vVn8ObOF7JrGplh0AgRBrFLhfDj6F+gFLBGyzZw==
X-IPAS-Result: =?us-ascii?q?A0GoDQA5PAFmhwsR49RagQmBT4I5fANTMgQLSAiBSAKDB?=
 =?us-ascii?q?I9FhmCBVY0xiHCBVoFAPg8BAwENPQQBAgQBAQMDAQ2ELIhNAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMTBAcOBQsnhWwNg?=
 =?us-ascii?q?mAYgQ6BJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06ax0BAREnNAImAnMBAYJ8AYIqAQMxBw0Gsk2BMoEBggoBAQaBWEFOr?=
 =?us-ascii?q?HUfLCJXgWEDBoEaLogMGgEFZYluD4FVRIE8glKDUAEBAgGCKoMOgmiFToEji?=
 =?us-ascii?q?lwBjRKGWYFTHAOBBW0bEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQAZIC?=
 =?us-ascii?q?wMCGgUDAwSBLQULGgIQLCgDAxJJAhAUAzgDAwYDCjEuT0EMUANnHxcaCTwLB?=
 =?us-ascii?q?AwaAhsUDSQjAiw+AwkKEAIWAx0WBDARCQsmAyoGNgISDAYGBlwgBw8JBCMDC?=
 =?us-ascii?q?AQDKyUDIHARAwQaBAsHdoM9BBNEAxA+dIoWgRSCK4IihDwIMgMZKx1AAgELb?=
 =?us-ascii?q?T01CQsbBiIeAqRAAYNFWSKCG5MkshY0B4I2gWAFgVwMiHuBJJUiBhMvlzYOB?=
 =?us-ascii?q?pJlmGKNc5VAhVCBZgE3gVwzGiSDNk8DGQ+OOYNhM4ELjjxCNQIJMAIHCwEBA?=
 =?us-ascii?q?wmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:l5nQja31kJvNf/iI7/bD5ft1kn2cJEfYwER7XKvMYLTBsI5bpzIDz
 jdOCmGPOaveYGH2f9B1YNyx/B4C7MOEz4U1GgM43Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn9hFaYDkpOs/jf8Eg14Kyo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW0DnmfJJE2sYBodC66VmKF1g+
 dMHCwlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGvqMvIYwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXI2cJ+Q/P+vVfD277xQdBj6PWC8jucOOxWZR6mEmih
 nDvxjGsav0dHIfDmWLeoi3EavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mSQRYP6eAKSjkWO5A9fSvNsPeEV9yK0n/+8DxmiOkAISTtIadoDvcAwRCA32
 lLhoz8PLWI/2FFyYSzAnop4vQ+P1T4pwXgqSQJscOfoy9zkvZ11kR/FCNpueEJUsjEXMWCrq
 9xphHFg71n2sSLt//jklbwgq2/xzqUltiZvum3qspuNt2uVnrKNaY2y8kT85v1dNoufRVTpl
 CFbwpHFtL1WU83SxXHlrAAx8FeBuKrt3Nr03gIHInXd327woifLkX14u2ogfxc1Wir6UWC3P
 xe7VfxtCG97Zyf6NfQnPOpd+uwryq7nDpz+W5jpgilmMvBMmPu81Hg2Pya4hjiz+GB1yP1XE
 cnDLK6EUyxGYYw5lmfeb7lGi9cDmHthrV4/sLigknxLJ5LFPi/NIVrEWXPSBt0EAFSs+luMr
 YkOa5rbo/idOcWnChTqHUcoBQhiBRAG6Vre8qS7r8bSfFQ0K3JrEPLL37IqdqpsmqkfxK+C/
 WiwVgUcgBDzjGHOY1fCIH1ySqLdbbAmp1ICPAsoIQmJ3Vonat2R96sxTcY8UoQm0+1B9sRKa
 cc5Vf+OOdlxbwjW2i88aMD9pbNydR7wigOpOTGkUQcFfJVhZlLo/4b6cjvW6SVUMCuTsPE6g
 ry/1zH0RYgIaBRiAf33NtOu7QKVlloMlN1iW3DnJoFoR3zt14xxOQndv+QSMehVDTninxy0j
 x23BzUcrsnz+74FysHD3/24nt34AtlAEVp/NEiFy7SPbA3x3HepmK1EW8a2JQHtbnv+ovieV
 L8E3sPHEaM1mXhRuNBBCJdt96U14uXvq5J8zghJGHbqbUyhOoh/I0upjNV+ialQ+oB34QeGe
 FqD2t1/C4W7PMnIFF0wJg18Ss+h0foSuCfZ7NVrAUHcyRJ0woG6UhRpD0HRsBBeEbp7C5N64
 OEDvMVN1RezpCB3Ofm7jwdV1V+2EFo+b4sduKsnXbDb0jgQ9gkaYLj3KDPH35WUWtAdbmgoO
 mC1gYTBtZR9x23DUSEBKlnQ78VghLAlmhND/HkdLXunx/vHgf4W2kVK0DIVFw568DRO49hRC
 ENKaXJnALqoxCh5ovRDU0SHORBzNDfA9mPfk1I2xXDkFW+2XWnzHUgBEOeq/nFB1VlDfzJer
 Yqq+Ey8XRnEJMjOjzYPA2h7oPneTPt0xA3IuOajO++nR5AaQz7UspWCVFoyiSnMIJ0O3RXch
 OxQ4uxPR7XxNncQr40FGoCq7+ksZy7eFlNSY8NK3f0vJn7dSgGQyDLVCkGWe+FxHdLo33K8K
 fRTIpNoa0zj+geI9isWFIwdEY9SxfQJ3ucPSpnvBGwBsoackAZXjYLtxnD+qVIvEvpTkpcbC
 4LOdji9PHSaqllKlkTs8sRVGGqKTuMVRQ/73ezvzuQtEqgHkeBzcHMd1qm/kGWVPTBGoTOVn
 lLnTI3Hw9Nyzb9Dm9PXLZxCIAGvO/bfaf+t8j3vg+9RbNjKD9jChzkVpnbjIQ5SG7kbAPZzq
 pigr//12xnjkIstcmWEhaSEKbZF1f+yUMVTLMjzCntQxgmGec305io863KKEoNInPxd9/uYa
 VOBMuXoTuEsWvBZ2HFxQApdGUxEC63IM4HRlRnkpPGIUhUgwQjLKe28zkDQbEZZSzQpPqPvA
 Qqlqtes4dFl9L53PiEmPM0/IZFEIw7EY5AEJu3B7WzSSiHih16ZobLtmCYx8TyBWDHODM/+5
 omDXRTkMgi7vKbT1txCrohupVstAW1ghfUrNFcokzKsZ+tW0EZdRQjcDXkHNn2Quin1yY2+e
 zzHKmcvYck4sfKobj2kiOkPnC/GbgDNBjs9DiMk9QWYZk9awaueVaB5+H4ID2heI1PeISLOF
 T3a0mL9NF69z/mFgArVCuOT2Y9a+x8R+p7EFY0RXSA/79byzIjmDEBcITc=
IronPort-HdrOrdr: A9a23:Hs9cpqOgnNrNFMBcT1T155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE7gr4Exob6LW90dq7MArhHP9OkMAs1NiZLW3bUQeTQr2KjrGSiwEIeReOkdK1vJ
 0IG8QQNDSaNzhHZLPBkWuF+qEbsbq6Gc6T5Nv2/jNId0VHeqtg5wB2BkKwCUttXjRLApI/Cd
 61+tdHjyDIQwVcUu2LQl0+G8TTrdzCk5zrJTQcAQQ81QWIhTS0rJbnDhmj2AsEWT8n+8ZuzY
 GFqX202kyQiYD09vbu7R6T032Qoqqg9jJ3Pr3CtiHSEESutu/nXvUiZ1TIhkFMnAjm0idQrD
 CLmWZqAy070QKtQom4zCGdoTXIwXIg7WTvxkSfhmamqcvlRCgiA84Eno5BdADFgnBQyO2Uf5
 g7rl5xmqAnfy8oph6NkuTgRlVvjA65sHAimekcgzhWVpYfcqZYqcga8FlOGJkNESrm4MR/ed
 Meev309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw8TxdAZnH0H6JUhIqM0kN
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbWPGebMT3cZdI60rL22u7KCZkOlZ+XkcYzvecPcb
 z6ISxliVI=
X-Talos-CUID: =?us-ascii?q?9a23=3ATnEgBWuleV8xMu0386woKwA66IseeSfa62j6DXS?=
 =?us-ascii?q?yU3cqWZSpZ1O/54Bdxp8=3D?=
X-Talos-MUID: 9a23:u1gFFwq949vCA4RnN7AezzhpBJhz2J+8M0oyqolXlM+LDwxiEg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,152,1708383600"; 
   d="scan'208";a="82995277"
X-MGA-submission: =?us-ascii?q?MDFpZdK9YW6wBP2+yCuE6voSiEIoUj+R2xzU4F?=
 =?us-ascii?q?lKQvSFuXChbwViz4jvUBbErmI9GtKFCzYoxheFNa2ucxwQfHszK28s1v?=
 =?us-ascii?q?uG62vyl9Dw0CjStpm+CihCgVn/Hfo74ZWnzqi7Xn3wCd8vj0qGwE+pVI?=
 =?us-ascii?q?lB8nipWVj75xBmTwxYhw5NmA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:02:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711357320; x=1711962120; i=markus.elfring@web.de;
	bh=sxKbKQZCceW+/dLXdK8/PrsAHcow8dZEtQFKHetz18U=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=j6pjP3kB7ZsbVJwz6a3afSNLK+dYsEG+HiFwPEKiDTC4t62GYENRVno3BxH/yo35
	 Nc+4wXYQ9AW7TGz8SgfGY+REJ402XwSwsd4G73dWXeWLxI2JMLxsFmVhdx8fdLiUk
	 h08cYQDpKjXicJWizqAu8tUCeDmfIBXmmUyamvdXAXIM8npRdBuVdVZLFETPnQVvL
	 4xlsVwDt+25EXPzRdG+hwkjAIYgDF+YeHq6qBpPVBCLeuvCqMbW2ub64WVqQ9Vsup
	 +4pmgsSE9LIOcyFT6l5UELXEXKcRfpRdiOUrbTu2AS/0C9A2Yg5YTLHUzsECTT+/C
	 vCENYrVbhLjPSXFcqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1seAnl1bPZ-00q7h4 for
 <cocci@inria.fr>; Mon, 25 Mar 2024 10:02:00 +0100
Message-ID: <d5250894-dab4-4729-8165-a9b70844c8d4@web.de>
Date: Mon, 25 Mar 2024 10:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:upaQm+QhwPW96JjTdqjsRFf/VsyBP3KQzP1eAIXRLy+ruMCZ/qK
 /O5xX1PN88tBWCNsq0/6STW5wNTbd5jr8+eEvNXda8odxaaoL0fwAIjjk9smF5DN66SboC9
 A81Rtq3NsXhuIq3jNI6eUbCUCRKALOqUGl21trXPxy9IYyFGrGPgJ8gSthiD5wuDSueseDw
 wnP/f2F2aonfJDRblPW6g==
UI-OutboundReport: notjunk:1;M01:P0:/U+JfR8w9ZM=;0mTj5y489lQQiAatOZcurbaT/vD
 iMgbnri2mOwNqUspYpNPIem+X6ed5wvWOxzrOnXk+v5VUCA82IKsGV6FDEm/Um9Sfgbv7dbr/
 11BiIIHz+Lax+fKwgSRcNrdHxH5pZQfP55haIHBk19REuqd7YlBGZpDsSr4GGLElW8tBpkWV6
 z2nrPKB0+aJB59r1NhRMMtA+banxJvfcuViZ4oGlfYErp9qSttwhCRrGbpsDe2RzFGQplZ5w4
 e3cDsqdsgtEXpna1QyGOjaZZfR9V00hLvycrOnd/2dnAdJGU4TRj6bIAKfm9IQW+HwbVo16jF
 enYmtjMF0VG6spNQNhvS2D6AD1eFRKEiJX+N1dwHYnfdjPsyHEw/svMktBkWMOznUn8RWyKE2
 y+/6eAwPXiexIRiSCU4iqDtBpzfSeWDD9bGAjBkOFlFa3INSCOIGl69e8OcUdCiRUOPxwUi8i
 2IBWc5ixdd0GRoDkWA5okk0v9HAZcSE8JoGAZoHh15iJv3dBCtJ2METyqgGZaA7zIz6Oe4rqQ
 Ge9VGbU/tuXknPl6QadThxPAZT/whh4yihH4HNqN/wGYFjt4ihJJgTI/kePTtJKoysPwJ3KIr
 TBd6xCOaKhioX8K8ilLwBeCASh9urh0I6H1C9y2rq9hX5xajrI5ZxcH/FExIfM/IScMUgJ4jT
 zxZ7nfbWQbdK52/geeh+Ym7y0Q338ZlYQjnzgRx9oUmqXHvh2FFfbr/nnXytcGisuo/Nrs83F
 RzyZXdX6uuQvd9tIZ/3LsUFBqBkW83Ttm9CGjM5yX0mnGIQKAPdTUIa0WB0gCf8sKlJuxvnN0
 5AhuBOZ6Hsw050l6kHADuBAs6QjuLe1y/Tc8JdDxADfIg=
Subject: [cocci] Improving support for argument lists with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1615
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/d5250894-dab4-4729-8165-a9b70844c8d4%40web.de>

Hello,

I got the impression that there are opportunities to improve the support f=
or
argument lists at some places.

Identifiers can occasionally be followed by parentheses in the source code=
.
Such a code combination can be interpreted in different ways.

* Function call

* Macro call

  See also:
  Improve support for handling arguments of function-like macros
  2024-03-14
  https://github.com/coccinelle/coccinelle/issues/362

  Compiler-specific extensions can be provided also as macros.
  The specification of attributes with arguments is a corresponding applic=
ation area,
  isn't it?
  https://en.cppreference.com/w/c/language/attributes

  https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/0011af1760e37caada1=
f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L461
  https://github.com/coccinelle/coccinelle/blob/0011af1760e37caada1f9d48e2=
c549bd519bf203/docs/manual/cocci_syntax.tex#L461


Regards,
Markus
