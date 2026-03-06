Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E44F0180A
	for <cocci@archiver.kernel.org>; Fri,  6 Mar 2026 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rzf9jnCMxPokTSzDGAr06ct2LHBcjWF2ppuV1+riqnM=;
  b=Lje8U6BpCEfJcsGVd4lV0Qow+kIBKGdgQRPhUFSBB85kDWWM3xkZQzdQ
   nP2EiVQFjy2C0J4pbF06GF76arFaFbWytFrXLWihN9acsshcAGXqUh7TQ
   effuIMO34KzQU8+DuwkKvN9n6/sFmi2jmBiPO7opK8g7X6wmM8+TCu3O1
   4=;
X-CSE-ConnectionGUID: v9G/1eguRju43lLYgoWpPg==
X-CSE-MsgGUID: hgT9hfP5S+i/i8QGFD/Jxw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; 
   d="scan'208";a="266524248"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2026 09:26:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EBE2C8153A; Fri,  6 Mar 2026 09:26:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 864C181531
	for <cocci@sympa.inria.fr>; Fri,  6 Mar 2026 09:26:20 +0100 (CET)
X-CSE-ConnectionGUID: lTxM94lrQwe+7xx1up7biQ==
X-CSE-MsgGUID: s0uDZ6SgROKa2hnOA3uIMA==
IronPort-SDR: 69aa8fac_6rGwaonEgucSHpgI0/hVLLQxtPMjdO/maj/f/40EjbKGIT7
 BvXH+crhEdNcCQpdXTOH0U5VuPXtj8GYuI/EC4A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EaAwD/jappgAwR49RagQmBUIJBaH00BAtJhFiPU4Zfh?=
 =?us-ascii?q?zyHVYxLAg8BAwENTgECBAEBAwSFAAKNIAIeBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHRAIBAyMdAQERJgEPCw4MAhgOAgJWBhUBAYJ+giMBBhABAzYHq?=
 =?us-ascii?q?yeBMoEBggwBAQbaZB8sIlmBZwkVgQouhW+CZQGKbicPgVVEgRUnC4J4Pogeg?=
 =?us-ascii?q?mmCJoEOi3uHKFJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFB9YGwcFE?=
 =?us-ascii?q?iEqgWl4ggEPhmp5Ay54DiICOlxKPgoBWgWCGQIBC209NwkLGwQ9jm4+zGg0B?=
 =?us-ascii?q?4I4gWeBZAyfbQYTL5dSDpMLLodlkHOpQYF+JIFcMxokgzZPAxkPji0WhBHIH?=
 =?us-ascii?q?kUyPAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A3wUVY=
IronPort-HdrOrdr: A9a23:sxcJz6xuTSJgo43nfPhQKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3ASGqu2mm47Td7jMXLRuwhK+s6e8PXOXnh3FKBf0u?=
 =?us-ascii?q?iMHlkC+KFWQaN4PxukvM7zg=3D=3D?=
X-Talos-MUID: 9a23:ShJhWwQ5PC6zqbCeRXT33CxOBplT7J6JK0lXkZMhkpKZFAlZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; 
   d="scan'208";a="140580679"
X-MGA-submission: =?us-ascii?q?MDE6mvHSfY+lSA+lmb2uDIR2qcd0b8AU5qrMif?=
 =?us-ascii?q?PPFiuX0pHr+YHqzrMOnNSJR8RtYr+Joh+M4I9kfUZKf0yGXGT2fO4MLC?=
 =?us-ascii?q?dpiRVY9us96+9EDEQyjJUHuRKnihuDr/XeQhKW9X6XAkoR+RSghLvxtg?=
 =?us-ascii?q?1Z/qPBXtkJhER0mKHXonQ7aA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 09:26:19 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBRn-1vUsSV34Ev-00aJZ7; Fri, 06
 Mar 2026 09:26:18 +0100
Message-ID: <6fcc334c-7524-497e-9edd-01ebbdc29f8e@web.de>
Date: Fri, 6 Mar 2026 09:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>
References: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K45Z8LBKUwvkmCBfNjZJNft/3+FUswDN1HAJFPgMp74k9rfIMea
 LyHQMuDfa5rBSUROou/+fFFHeZ8vzsOnLPnXcNShaMXiBBT4nv7jvSKjLG7J91ET+oXbisI
 hGJv2dZARfB1FP23hi3a0SweZg+Z6NgmgwyFCw3JYLMSbCOxaMG2KgzS0yZ3A8tP533ROfH
 eqFiPxDbG9YoNEsV+jSzA==
UI-OutboundReport: notjunk:1;M01:P0:8YsDcaS1yOk=;tvwAJfRJjYH+eJzTPNRPQ/4+2Ea
 SyQj0KOn/2uxos+7IV1TmsSYz/VhHzyEpdIAdUIBhgxZbssvNIrd6uFxvhvJ3krQviu1oHprA
 l2tb4Dg/FW+YcDD3MOFBUP7AQo8jzIffCXmdIAz8i/o35xK8jGNsSxcxZRiXajRn33t3v75va
 AIR2STc9LNBNlsit5/3SiCPPyj++POZLxlamxZI11CKJPaH6T+8b9eDC/vgff18EjGLXXdPbG
 bjIZO45uNswGWIKbQeafzJBafHTDJjN1QcPtAdjaXW3AxsD0nzFFEOIFJtJf7xGZ1y2m4Lgtl
 uXTjFKk0LEDgLaGeFzy24iAhbQUQ6UuUl09woQKabp/tFX/W4GRn0LowLYNulc8Ua/XZGqyHv
 EApoTKAff0TAIQ4Zqo07+tRJ4WewjV21nbcOjNQr42VhL8qDwHiPfaAK4+OxXCpkWXdbQHoZG
 gEbJUZ+nEPc7W8cXDhPjQ6Z7NJaANn1saerl8ztnahUP0HDY00rlW3kWztjqd+iPmJhvTDpyj
 MUIZLunumJZKlti9d/JSBfjCxdb/UMJUa+tlLlf2RIu1DnJcuU1if2nDDIwsS2kuvdzqeyGBI
 zfvKzqurJzMv9uCJH5+6GNkF1zbTxIVa1BgzsqfMm3ydoLYU2vqGNATjwVMDSsrQRTGaFEurh
 qPra62+877g9b8B1fqqZP+LJsgUe78qTMPY6K1yGheAdt9P0LidrxPp+LtlXSl6wfx1+ayxSq
 vKlVNw3tuPjkb95MRAbtzvi9a8E2CxAa0nsALkFDTyAUmRFV1uCFjsUF2PYjfROJEyZWfI9yY
 IFYLqlRVZFqJxQiLPUA5xeCsjMBIz92lfzQsmrzTRZFrnsqMijFx1hRaMmAKu7j7pvNMb+cQt
 YYvie4C8TqLfZFmqXfZZTfqDGsihYGlTWUzqeD8BjwEDLMD92rC+6lr3YeNzsALaUrYiBqvPK
 CJC2i0a+XvZ6znrg5N0+B7hDU/7+YOQHTtDrZsN64ebVPE9dvpp0jCc9LQlKDo1W743ZD3Atj
 hovXHGr1ZpJD3puDIQlLcDHvAmAP+wTkf3AvrvM8vkvnAQnyNsYmgSw7f8as5eIp9K/Gx8YoM
 qqGkmzWJ+6iSLgMeML2TB4wFY4ISHeR4L2HttSEDrjOHmWs4oAsjmTVVJyudXaJFbj8QCaJF1
 y8rASDW1bvbB0VVnTzZ5ZxBvRHTKrxtLL4RrNDN7oDpaphr/+ZkJbWKqqaReHyms7NQVb7xyz
 NRjegfYC+wJ+0vbctJCEs558sjleomZooiL7CbsSx28ygLoRKlPJXlhespSZLc6w4nuBlx52s
 cazFPAjbaa5KqRe6xRMuHbQoDEodUneNefAcvoQrctv5rTLmpWfdmuaWLZDZnMKnShGsj9YKW
 Uf9HBRAR5N+QyecI+ItVMquIlB3bIJnn1r+NxPMISwv7DrbPFlS66eHYKCzoFpHMk+Y+u4SkN
 3uhp2UollXTirNlMTJvdNa8qVS6yuG4nsNzKx29enE5G21iNJrRk0fEOZXI9EiHCmWezXhfbA
 lqA7b6Xx1i4UyTvUafnobvisVC/WJuflmxYjglQxPICBLtfu9ThqXn4/ss1zqTcCM786+ZVMd
 P9f3/sRBY2yA3w+FdE1hqQJXMIVXC6gQgMwHbXb6+RvjYctBEX2q/xdKwFYOguScdfXg7sdWS
 kgyzTxmI6FJVwCLITeXYjWZZwneXKOkFmMpSR2MF5eaCIQG3bsSZMftfftERRGgEbN481DJ2N
 FK19vsMUB/sPUqsMeYNXKUGkcmZtU0yVb6GPfrVkptmKEKCNrjZ7UdMxXWd3Z4cZxZ6OYFu2/
 aRvuLTe8IQaFswqYtE+Xydc6sUo/bQRJnE6fqlXMBRURUhu/ayt9TxhV45nwDGshGSTDOAxac
 ZCBhmlCQBG3IuqmUaiPxoaWMwFN3n04M8z05hyUETc+LyqS8I6nGapT2+eEroMf9zicjYf1z+
 FUaEBlqT9wDMPNCATJDtML8D6/aO+pULVSKS3HHwQavrkgNU9dAIQjaroXR7WlxIr0Hkz6KS2
 0cKEuuKUN4dct6bqosmxnXRVLXSiO+biGCZhjQpZw42ni0Qw1Ny7CzKD+bUKnBUdYd9bqmwjU
 MYvtQfjfjh5w/do/Pa+3mDSrfJfcNN4lOM9yLqPo8hnPRzGzvZJAxPAgcxmaKGUYxM72qphMQ
 Fz7rmiHC5fJcBjMIndsVhjRGEqILvqtx/y5QPe8UaeS2iT9zdav5uBkvYbMeUk4qRrD6lKnRY
 ojKsnIs+t/HYFIUr9J6zOUXk4jp71u2IwYdZpF+n2pvFXoQ/6epEfGdy9UIFPNjUscNqzmPRL
 2a+t2Rk7NQmXnVxMH0+E7+Lw3ufv/ItRXK7XeRcdAb4iJBUbmIiOUOPewXVIh6l3CG5xtMiFW
 rfAV0MVFMCmMXz9SpLse1Bw4ehBQhf9oTWmL4n15e2qKg8DWlva4XhySJYuxa6xiEa9Y+rOjw
 eBpdj5iLglIFV9Gkj+Ca+O/NO5Veduuvcs4oZtt/wE975Kkte2UKhTDKjr4MRFm51OVdmCmqx
 BGd0Fyz0tjhnY1nyXj6SEyfh2qPJchoB2W+7Pj1XhGrwoWpi9aB/87r5VuX1VaWTUbZctzFBh
 M3mS62CwI/poPAK14waj5EmjgPiRChUZq4Y3r3/t1/+Nor+4luX4KkDdFcvKm9c3YrvKFirIw
 pYICdeWGLZaFL4St41gsHK0DK+mKH5MxiOh0NONhLDV0GzMPfIgTAMlbSssV6D1FP7NPjkQb7
 yfIqi/NNdcHXaP4/YHplw6R0rA49GGuzh0sZqTlHrYqSDp7wBEUW9Hd07ZWy04/OYNoPh/J4X
 sXHwy2SyoL9PbfT9mebjJkuafIAhagOBBXojmTavJ9EuUgE3trGE41gdeoc6bifz6qOZaOkuy
 8io8XQnqWcM/FJvCJthQK3jmG6+aVaYSiND91+tDuAwDFfVHvbhwsj1XU9PQvFSBZoWbiw40C
 Yawr/aD4miXQn1SgYKaZs4e9NRu6djFtW3wXIU0pOmG7FVi+3gNcWFlPImO4+C/h1Ztjf2pX7
 GugZhmgkBJHYmH1A1glkhmmEK2GuFfyKASDAPBTjQtJz6ZAxjtxTzjNcXwmhuy/UlfjPVosx7
 6KijVotg5NdKB8TACUnu6NiEv5s4wa2DMHZ06fHcQeKnCWd5lt51q0UoUYYEC26vR3RwsGsA0
 5ceUGJdCzrcHEAj+wIOurqELRBprDACN4l5P+0edRerd9caMRN6iUZS1L/jmujG6k06i8F1qy
 xJAzy2ox7twUAY/hf0PdTj+5TPkYs+hOEfeDfYqe8YH98NWv5i5mcbAnqR+JEdvCeaSvxGsN7
 /KOkwHPMYJUz63eqRH5LUo24DQXvOzmuL8UTPJ6uoqyZ3B6FjJnLjPRwLkT/D36I4GPf7NimU
 c7U5JgGWwu6driBA96MEbhUpj9hy7f6Xg/qCwtIBv2mx3hFa4930mrp3qmV6bAPAKZAL0puKu
 J4XQBOuwyHoBKhDJnFkw/KMn8Cfk/HEzbxJ/4dEGl8j127J0PMf30egK8KGghHXm+hq8DeF9v
 m0UHBXl3aJ/TaP2yzDv1GVPVVA23b5vRgpVg3vQUnxElzcrQ+3mT8stc9qAYzZ9WLuVw+Y1uZ
 421AHEpCOaLqwkqm/ZfM9ucGobbTsuYe/McuQWWdrGHuKfpxiR6Jh3Je88CXhLKMZA40y0+dS
 35/Xm4bmktG+t1MyR+u+xbBFUMf1LgRPI08JQ4LuKGatVg7xLvK+K+6ui6i8VtzsFaGhyOJAX
 UDK1akPI3pbKqcnMeFUGguLY7XmsigofI7lTUOuR3FLpTQfV6hZKThACdrpI1TtFEvwFSYlmW
 mZ9c9HKB9NAw2fqrLEto8JJjxgBneTaL4Br5xG+hv61D20ouQgb/8uxp5RJxf7sWVPoMMzMLK
 PL1VydaxxFbS2ZTJwHsmtyxfjFlH0FjWN7YM5em87P3ZsEbAmD1VPaY/0UROc3Y3PVg0Gjh/u
 ifb6YnIm6WyPzVB8Xb6yfcfOyAeJIAR5UXFycI5qpOVUZt4qiOd5rQ96j00LVmsavuxp9JiQc
 qpxdrltmVeele/gc8BIXHilt1iJA5RokuI5IqdV+fEEhNgHpvPuTJhfEAlyfc9QLP4rnl9ZNK
 VntV6ct1I/sxMWDfV+siPUmj7hEHvw3iEPvzB5Cj5YnVHrKAA86153kCVm+y4fswoxOlM5GcF
 m/piDKBgBMhMTGm12Im/+QpGG9Hpys9wLgxa83mJ5gcKaGngi6yDnjlM/7LKFNJms+WHxMiDp
 6qdmLA1mcEbICiOgI0mOGimVsh/trDEyvZtkgtEy42CdcD/pCPMYeifdlJdsZ7Ku9HOS03xN0
 rrI8ZzmZ6rSBdJK1SjaJYz6V8xI/8HysGprTRs60StghViSY3coY+KM8J7qstDdfD/4TV1r9+
 8FnYnOEZtxRLBoflzMlxHbSIYE2DM2OuhwZgEXY4EYj5zu9DzKyDbdzvhQmI1Su2gM/m8OXlK
 AokSeSqR0IkO5BaA0Roc+uLZ5Cqg2ET4MMWL+lJayAZuyI4zBTZJoW1/cqcVWZzX/9R2qenu4
 5lTi6BgTn1S9/aniQHetGSnafFrgB5uoufJQ9FlDh7X2szOMFC1wdR8K9YrPKgXsXdrNz8opk
 9+lcfVcrtYiA47IwGazgn0GS0OzIngEDdeW9shvYtXD/i8WJgXWvauUcsJC+p3Fwfch8uRjHn
 IEysDHwC9BJKLr71NjRgm1V5DQSuXXytdBrtCmULZVTBYl8Kgo/KINQ7C7TQLv2vFKNEJKZCO
 5xgR7oW/Ro1MhT9DeuRWpIFa9tMmvRRknB6rEAow7IlGeijVGskprAsKSYu/n+3NjvGFjcXV9
 tFdIXFq6V24GEKAE5Lfd0xCLE9RXaSnefxsMJWlPp8SWCjl4O/2oLvtpvOuRcHZFlXr0PGc9z
 GRjexKOvDYVT5OWa8X8YkBjqD8hFBDu91OoNgWr2KcwXlgzpgIppwMANVOtlacocWM5ojjz4H
 GVrs0WW1b1WJ6QgajuTpW4Vd61feW000rkgvQfqCePvs4U/OAwHQNZPGSiVShr3HIp6JHqRQz
 wteztboUVMEPQ8Rg8rb3vKQxNRGl1IR1+u77v+5nHrpWFqGS360phsN3cmEo6lEtQKZ4UWIud
 cDIL7t14Yq2UEOjzQ=
Subject: Re: [cocci] [RFC] Coccinelle: Use IS_ERR_OR_NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3325
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/x7yq2wCc6kKSv634FSC-2w>

=E2=80=A6
> +@p1 depends on patch@
> +expression E;
> +@@
> +(
> +-	E !=3D NULL && !IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	E =3D=3D NULL || IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	!IS_ERR(E) && E !=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +|
> +-	IS_ERR(E) || E =3D=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +)
=E2=80=A6

Did you get confused with the negation of any code items?

Would you get further development ideas from an SmPL code variant
like the following?

@replacements@
expression e;
@@
(
-IS_ERR(e) || e =3D=3D NULL
+IS_ERR_OR_NULL(e)
|
-e =3D=3D NULL || IS_ERR(e)
+IS_ERR_OR_NULL(e)
|
-!IS_ERR(e) && e !=3D NULL
+!IS_ERR_OR_NULL(e)
|
-e !=3D NULL && !IS_ERR(e)
+!IS_ERR_OR_NULL(e)
)


Regards,
Markus
