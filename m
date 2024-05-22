Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0122FC25B77
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=1zKYuwkMQDQcqf9k3Fc7tNCWmyrfg2IQY4G12rGZTwY=;
  b=BkUubgtvaaisGGDkiVrWyP9wf/Rv4lcGa4Vdxj7Ocm25aFH+xQG8QEUX
   KCZKO3U/d2mNN0XBdfL0rLgzhPSjZ2oQohMdB9jqEU1+OY+pVepb6GWZp
   EhBEuk9i7oU1L0TE3us4e1EAqZcT7sFajqNCt+Fxh7DqS7LPlPcvOz61D
   U=;
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
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166869725"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 13:20:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D3EBE0CCE; Wed, 22 May 2024 13:20:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E51F8E00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 13:20:46 +0200 (CEST)
IronPort-SDR: 664dd50d_20RP+JqdbHofSZO3tuu8xBmI111UxwQUWfHN/r3c62vsh0Q
 MEo1xm+khDl+4rNSXbG0I6eBtgjHgXMw7E4g7Fg==
X-IPAS-Result: =?us-ascii?q?A0GfCACf1E1mhwQP49RagQmBUYJCgQJUMwQLSIRWkT2BB?=
 =?us-ascii?q?YNmhzmHT4hxgxY+DwEDAQ1BAQIEAQEDBIR2iE8CHgcBBDUFDQECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhUYuDYJgGIEOgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdrHQEBESc0AiYCcwEBgnyCMAEDMQeveIEyg?=
 =?us-ascii?q?QGCDAEBBoJn13IfLCJXgWMJgRoviBMaAQVng2yGCw+BVUSBPIJShX+DDoJpi?=
 =?us-ascii?q?A4BkWuISgOJaYFRHANZIRMBVRMXCz4JFgIWAxsUBDAPCQsmKgY5AhIMBgYGW?=
 =?us-ascii?q?TQJBCMDCAQDEDIDIHERAwQaBAsHdYMlBBNEA4E3iXCDO4IehB4IQ4EBg3KBd?=
 =?us-ascii?q?g5hig6BR4EWHUACAQttPTUJCxsGIh6rM5QSsho0B4I2gWAFgVwMiH2WRwYTL?=
 =?us-ascii?q?4NyAZNGDgaSaJhjoziFUoF9IoFcMxokgzZPAxkPjXgBQYQUy35BNTsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23:ahEnCRB2tVEUeJDyF+8hUyQUs0gY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua88ygWXAc6DtrptsKn/jePJYS863d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWgDexe61+I
 RS5oAneqsUbgZZpJ7osxBfOvnZHdONayH9yK16Ugxjy+Nq78oR58yRXtfIh9spAXrv/cq8lU
 7FWDykoPn4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Ximi7
 7tuRRT1hioLKyI1/WfKgcF2kalVog+upwZnzoDXbo+aO/RxcL3dc90HWWVPUd1cVzBYAo6mc
 4cDE/QNMOReooLgp1UOtxy+BQy0Ce3o0DBInHz23bAh0+88Hg/G2AIgH8gPsHTSo9X+KaAfX
 +evw6nSzjXDcuhW1S3y5ojMfBAhu/CMXbR/ccfKx0ggCRjKgk+NpoP7Jj6Y0PkGvGeH4eR6T
 +2vl3InpB9rojip3sohlpfEi4MXx17K+yh0zpo5KN2lREB0f9OpDoVcuS+eOodrXs8sTHxlt
 SU5x7AYt5C1czQHxpsoyhPddvCKbpSF7xT+X+iSOTd1nGxpdK+hixqo70Ss1O/xWtOp3FtKt
 CZIncHAu3QC2hDJ5MWLV+Fx80S/1TqV0w3e6udJKl0qmKrfNp4h2aIwmYQJsUreHy/3mVv5g
 beKekgi5+Om8f7oYq/8qZ+ZL4J0ih/xMqApmsGnBOQ4NRUOX3SB9eWyyrLs5lf1T6hUgfEuk
 6nZto7VJdgDq6KnHgNZzJwv5wihAzqkytgUgHkKIEhKdR6fiojmIVDOIPT2DfelhFSslS9my
 ffcMb37AZXNM2PDnK3uc7Z55U5c0gszzdZQ559PBLAOPun8VlXsu9PGFhM5NRe7zP79CNphz
 oMeRX6PAqiBPa/PqVOI/P4gI/GQZI8JvzbwM+Qq5/nygnAlmF8QZrKp3JsSaHCgBPtqOUSZY
 Xz2gtcAC2gGpAQ+TPa5wGGFBDVUbH2zd6M6/DAyToy8XqnZQYX4pbWb3zqgVrBSaHpHDF/ER
 VLhbYaZQLEhbCyII8luuiMJX/6tRtlyhlmVqAbmxu8/faLv8SoCuMe7vDAUz+jalBVpsCdxE
 9zYyGaVCWd9gmIPQTYymqF5u010jFmZguBjm/INM9tV6rtSVxsic4bGxrlfAsrxRxmHU9OHU
 legTf25DDt3Qt9ii8QWbRNFEs65xgvGwzLsBrYUk7KRA5lh16vG3GXqYet5xWzH0qYJkFQsB
 MdCZiW9nqAq0Q/VCsbSllmB0aancaNJxCnW6GKK1naDpmldVxNsF7rIVzYTayM6tPzf4UXPB
 /+rALUjaU5azNKab7BNcpvvhElHQ/HqPJLfZXiwkiG+H0TAwLTEd4fsd2gHuUeVQEEZjwAe+
 2qHPgkiF2+gpWzZFjlnCVPoZQvl7+B/rHqxSkJ8wRuNagVt0L+8+xhdgvL5Kbtb+7seuzo67
 RhwEky82d3+FNeK4QZsPe1dbd47/FZbxDfBrQUudpekLq1kmhsfa1Et5hmojU8oTNwd15R5y
 RFihBB/Iq+Zzl5bIjaR3JSrf6bSNnG35xe3LajfxlDZ1t+SvKYJ8vUx7Vv572TLXgIv9Wtq1
 95N3j6S/JLPWUA3WIjyT11x2hx0vbDcbQEi6omS2XAmYszW+nfSnskkAuco0EPqWt5FM76fU
 iL2HdcbAceGN+Eg3VSkJEFhXqga5Os/OMWocOGD0aigMbN7nT6oum9A5Zh0zkOG8ycUpvfg5
 58e2LnY2wKGU2y5l1K9qoXsnpgCYzgOH225wCyiBYhLZ6Q0c5xZQWupJsS2wJ15ifuPEzZ9/
 USgGkhA9cunYxuUYHTi0AcW2UlfrXG8mCS+xiB5iHlz9/DZhnaRhb2/MkZPM3UDXGR4iFbwP
 YW46rJSFFOlaQQkjlrt5Er3wbRauLUqKmDSRUlSeC2lZ2pmU6a2qv+De5sVsclu638IFr3hJ
 wzJL9y16wEX2C7iAWZEkTUydjXx/478gwQ/k2WFanB6sHvef8h0gxbZ/t3VA/BLjV9kDGF1j
 yfaAl+kMpyn59KRwt3mu/q9Snnne5ldayjtwqufuSH96WAgUnjd17ij38bqFwQ3y3qx8tBwV
 jjT6jv4bJPq0auSLu9tOEVlTgyZiYIyCsR1lY0+g4sV0H4Ri8CO/HYJpmz0NM1SxaP0aHdeD
 S5O2dPe5xLpnVFyNn/cjZysTW2Tm4EyArvyKnNTwC826NpGTbuZ/KAR1zUguUK29ErYM/16g
 ytb1vYkrnIXy+hbvQ0w0mCNDLcIAkBCMWrzmh7O493bzu0fbTSqdqWskUB5gNaqAfedrwsaV
 Huxc8UnGjJsq85kOk/I0zuq44foIZ/batd21FXcmkXFiPVJbZkqnf0QnWw+MGTx5DsuzOtzm
 xVq2dvSUJGvDWJr8er5BxdZMmawfMYP4nT2ir4YmM+K3oepF5EnGzMRXZKuQ+j6WDQV/e/qM
 QqDClhe4j+SBKbfEAmD6Uxns2OHEpalMGuSLWUYytMqTQeUJUhWigQZFDsgmZtxGgevzc3nO
 EB3g1JZrkb/sQdJw/l0OgPXV2DCuEG3Zz1yRJXeZBta4wde5lvEZMyT6uUgekMQtpalrQGLN
 imaf1ESVDtPABbbQQm+eOX9gLuIu/KVDee/MfbUNLCHqOgFEuyN2YrqyYx+uTCFKsSIOHBmS
 fw9wEtKG35jSKG7030CTTIakyXVYouVvhC5r2dSp9q87e+tdQbh/4qJBJNNPN8p9x380sLhf
 6aAwT10LzpVzMZG3XjT1L0Wx0IfkQlrcCSxV6sNv2jBQeiD/80fRw5eYCR1OsxS6qs61QQYI
 s/XhOT+0btgh+I0AVNIPbQEst6kb4oGLjPlXLsoLFmGPvKKKG+SqykWSaa7VKEWk+he8RG96
 27zLg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rISKt6sr+mDzK6es0Bz6un1O7skDVNV00zEX/kB9WHVpm7+j5q
 OTdZMgpHjJYVcqKRUdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHRuQ6T9RZQpRoBUdAH0+6VMHfjLqX8KTMtOaYE
X-Talos-CUID: =?us-ascii?q?9a23=3A+E//jGjv+ndiKt50TpaUzP0bDjJuc3zk/kjWCn2?=
 =?us-ascii?q?CVjxRTqekV37JyqZ+nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AULobRgwU1bTnDwM0PDpO3zbchRiaqI7/B1g0gJ8?=
 =?us-ascii?q?ggNerPh0rCwi+kxGFQrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="87668837"
X-MGA-submission: =?us-ascii?q?MDFdS9/D0BmUVY+x2KKg9CQXgWMMaK6L0veono?=
 =?us-ascii?q?bnVTYWyRtpTWy2ybEzdtJPYGpkjiGLiFWEtEOS+6lIKoErWPF8dcSAo9?=
 =?us-ascii?q?G3WVaQeD8UVG7+SvJxzof+48+VrrN8ZbB0eZ4BBACENh9iZgJgRvmlV4?=
 =?us-ascii?q?b5hduDBBSbsOfWOjtfmeRadw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 13:20:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716376844; x=1716981644; i=markus.elfring@web.de;
	bh=1zKYuwkMQDQcqf9k3Fc7tNCWmyrfg2IQY4G12rGZTwY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wxd7QIhvbaTuMogY6DS/cQcrmKS+CtcrfWdkre0wUEBkvuX1rflPT2WPNI5QYYuD
	 O3C7ULfPDDYQE9NCbm1hrOhMu5ts9YglYmNYprBnNawuZTvVAp8ifWIOu0gAMfmoR
	 3cbZKaMG+MF6yvnxUT///eOEqPKF/QOv7O3CNBDVImbCL6GDgNGKyZ2JjAP3a0YAj
	 HS8b7YHyyNadif97dz3NscaqxwDL53ZCTJHDavwcXXdtoQpYFkDA2pg4G7HaH9CoS
	 UtIBPSfiPRdQCwsEL38xwz7S4JV8on0lJkoXDxrJfh900VO6mtcX8SBvPIuLs6oCo
	 jCGqxF8Y8hPllCvRlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mdf89-1siWg10Qs5-00ZUaR for
 <cocci@inria.fr>; Wed, 22 May 2024 13:20:44 +0200
Message-ID: <df6f58cc-67f5-42b2-8f43-f77e54a200d0@web.de>
Date: Wed, 22 May 2024 13:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:scJhJzAPok8Wu62FATPiLdbVF74TOukUtIbAVhTzBebTZlfS5yM
 2kZ4ZKv0mqCc6h5qjdE2vmuUfjqCGhy7COesWFhVT9gfDnqBCkRnvCN+W607xLKd9uB9esb
 P5jGtLK5qJeVDqVnPlAxeVhFysjObP/iJcEt+GpAtZsq6tWf284EFK74BMtG/dBysOf5Tlh
 ozESdqW0TAa1Ime1FP0Mw==
UI-OutboundReport: notjunk:1;M01:P0:71mhDVJkkeo=;Ux3CHFUcgA7q1+ePDG3M1DuQpth
 EW/ThX7GL96XU9ByPNAnsmr+c7cNF/lo3d2A5d4HYF2bChxauaGDOmS5ZVDmaf8uhuMBWleUN
 LDihVXnYnhsznoW5SMM8Yz1Opg+6bCAellbllCu5F8lE296smRqiHgVa/M95TuNejtB7v0ahp
 zMUZZPWtlOsHh4dUp3VkNbe46DUQkEB1AqlvyC93ApDTPQtBuHvnYZa9vl915e/WH/PIfBr1j
 Prl3CUqI42CYsj9NqBKlCv45/lgIBSSCfDZ6dGR6eTgLnBryNmqTaofuKzpM0EcI/jYC9PLnh
 y/uzrrxjuMC0x84pTB5p8o8Nj1LSlI/L+VMu8gdmCauWMAzDNm/kURRKXilM0Ix8AOcjxLSqx
 apcPxKCKByYhQndtHDqBAFxPJ7CustiSJM23Bo/0HqOQtXIxoDnthlYNsSGMUt2j9b7znOhbb
 H3H2Dxu2BZL19i68DgJMrb9F6A6gA4XLZgTJNhl1fUeZhyIQe99kcdD68JCBhLHMbkJ8yz68s
 Qu4a0l5HB+xDpEZ+D5Xfc2Ta5iVeAPRctEIBgcNsOy52BqCFzgOQM/b2MfJE+drJblguyTOPm
 BipqT5zlcJXdgbHVn0a1mxjRv9VfFUPhH+NKVUhBiF1JH83jtkznG6KEzdyu6Jmknuati4tl+
 SGxk2a1De4cEEVc3Iz1xT2/THVEuRcmILosr43juYNY+4aVBJmLusZe1k1WgWy9ERgeVJNIYe
 NLMRYNx/FgB6Y85BeMW9jtVQfDnZ5g7gI3pCNgluAILtT1HZygrDxJXho1CSveNRnb6cfUqk6
 D+hKfapkrhfBmtrOUPEA5NGhVmOxFtDkL9TTCoQw2LDdo=
Subject: [cocci] Specifying program parameters within SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1750
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/df6f58cc-67f5-42b2-8f43-f77e54a200d0%40web.de>

Hello,

Several parameters can be passed to the program =E2=80=9Cspatch=E2=80=9D.
Which of them can be directly specified in scripts of the semantic patch l=
anguage?

Regards,
Markus
